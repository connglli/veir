import Veir.Parser.MlirParser
import Veir.Printer
import Veir.Panic
import Veir.Passes.InstCombine

open Veir.Parser
open Veir.Parser.ParserError
open Veir

/-- Command-line arguments. -/
structure LlrwtArgs where
  input : Option String := none
  rules : List String := []
  output : Option String := none
  listRules : Bool := false
  showVersion : Bool := false
  allowUnregisteredDialect : Bool := true
  mlirTranslate : String := "mlir-translate"
  mlirOpt : String := "mlir-opt"
  maxIterations : Option Nat := none
  debug : Bool := false

def llrwtUsage : String :=
  "Usage: llrwt [--rules <r1,r2,...>] <input.ll> [-o <output.ll>]\n" ++
  "  <input.ll> may be '-' for stdin.\n" ++
  "  --rules <csv>              Comma-separated rule IDs (default: all).\n" ++
  "  -o, --output <file>        Output path (default: stdout).\n" ++
  "  --list-rules               List rule IDs and exit.\n" ++
  "  --version                  Print version and exit.\n" ++
  "  --allow-unregistered-dialect / --no-allow-unregistered-dialect (default: true).\n" ++
  "  --mlir-translate PATH      Translator binary.\n" ++
  "  --mlir-opt PATH            Optimizer binary.\n" ++
  "  --max-iterations N         Fixpoint bound.\n" ++
  "  --debug                    Print intermediate MLIR."

/-- Split `--flag=value` into flag and value. -/
private def splitEq (s : String) : String × Option String :=
  match s.splitOn "=" with
  | [k, v] => (k, some v)
  | _ => (s, none)

/-- Take a flag value from `--flag=value` or the next argument. -/
private def takeValue (eqVal : Option String) (rest : List String) (flag : String) :
    Except String (String × List String) :=
  match eqVal with
  | some v => pure (v, rest)
  | none =>
    match rest with
    | v :: t => pure (v, t)
    | [] => throw s!"Missing value for '{flag}'."

partial def parseLlrwtArgs (args : List String) : Except String LlrwtArgs := do
  let mut cfg : LlrwtArgs := {}
  let mut positional : List String := []
  let mut rest := args
  while !rest.isEmpty do
    let arg := rest.head!
    rest := rest.tail!
    let (flag, eqVal) := splitEq arg
    if flag == "--rules" then
      let (csv, rest') ← takeValue eqVal rest "--rules"
      rest := rest'
      cfg := { cfg with rules := csv.splitOn "," |>.map (·.trimAscii.toString) |>.filter (· != "") }
    else if flag == "-o" || flag == "--output" then
      let (v, rest') ← takeValue eqVal rest arg
      rest := rest'
      cfg := { cfg with output := some v }
    else if flag == "--list-rules" then
      cfg := { cfg with listRules := true }
    else if flag == "--version" then
      cfg := { cfg with showVersion := true }
    else if flag == "--allow-unregistered-dialect" then
      match eqVal with
      | none => cfg := { cfg with allowUnregisteredDialect := true }
      | some "true" => cfg := { cfg with allowUnregisteredDialect := true }
      | some "false" => cfg := { cfg with allowUnregisteredDialect := false }
      | some v => throw s!"Invalid value '{v}' for '--allow-unregistered-dialect'."
    else if flag == "--no-allow-unregistered-dialect" then
      cfg := { cfg with allowUnregisteredDialect := false }
    else if flag == "--mlir-translate" then
      let (v, rest') ← takeValue eqVal rest "--mlir-translate"
      rest := rest'
      cfg := { cfg with mlirTranslate := v }
    else if flag == "--mlir-opt" then
      let (v, rest') ← takeValue eqVal rest "--mlir-opt"
      rest := rest'
      cfg := { cfg with mlirOpt := v }
    else if flag == "--max-iterations" then
      let (v, rest') ← takeValue eqVal rest "--max-iterations"
      rest := rest'
      match v.toNat? with
      | some n => cfg := { cfg with maxIterations := some n }
      | none => throw s!"Invalid value '{v}' for '--max-iterations'."
    else if flag == "--debug" then
      cfg := { cfg with debug := true }
    else if flag == "-h" || flag == "--help" then
      throw llrwtUsage
    else if arg.startsWith "-" then
      throw s!"Unrecognized flag '{arg}'.\n{llrwtUsage}"
    else
      positional := positional ++ [arg]
  if positional.length > 1 then
    throw s!"Expected at most one input file.\n{llrwtUsage}"
  if let some p := positional.head? then
    if p != "-" then cfg := { cfg with input := some p }
  return cfg

/-- Report a missing external tool. -/
private def missingTool (cmd : String) (overrideFlag : String) : IO α := do
  IO.eprintln s!"Error: '{cmd}' not found. Install it or pass {overrideFlag} PATH."
  IO.Process.exit 2

/-- Run an external MLIR tool, feeding `input` on stdin. -/
private def runMlirTool (cmd : String) (args : Array String) (input : String)
    (overrideFlag : String) : IO String := do
  let out ← try IO.Process.output { cmd, args } (some input)
    catch _ => missingTool cmd overrideFlag
  if out.exitCode != 0 then
    if out.stderr.startsWith "could not execute" then
      return ← missingTool cmd overrideFlag
    IO.eprintln s!"Error: '{cmd}' failed:\n{out.stderr}"
    IO.Process.exit 1
  return out.stdout

private def readInputText (input : Option String) : IO String := do
  match input with
  | none => return String.fromUTF8! (← IO.FS.Stream.readBinToEnd (← IO.getStdin))
  | some path => try return ← IO.FS.readFile path catch e =>
      IO.eprintln s!"Error reading file '{path}': {e}"
      IO.Process.exit 1

private def parseVeir (text : String) (inputName : String)
    (allowUnregisteredDialect : Bool) : IO (WfIRContext OpCode × OperationPtr) := do
  let bytes := text.toUTF8
  let some (ctx, _) := WfIRContext.create OpCode
    | IO.eprintln "Error: failed to create IR context"; IO.Process.exit 1
  match ParserState.fromInput bytes with
  | .error err => IO.eprintln (err.format inputName bytes); IO.Process.exit 1
  | .ok parser =>
    let state := MlirParserState.fromContext ctx allowUnregisteredDialect
    match parseTopLevelOp.run state parser with
    | .ok (op, state, _) => return (state.ctx, op)
    | .error err => IO.eprintln (err.format inputName bytes); IO.Process.exit 1

/-- A `!N = ...` metadata definition line, returning `!N`. -/
private def metadataDefId (line : String) : Option String := do
  let t := line.trimAscii.toString
  guard (t.startsWith "!")
  let digits := ((t.drop 1).takeWhile Char.isDigit).toString
  guard (!digits.isEmpty)
  guard (((t.drop (1 + digits.length)).trimAscii.toString).startsWith "=")
  return s!"!{digits}"

/-- True if `line` mentions `id` outside a longer `!NM` ID. -/
private def refersTo (line id : String) : Bool :=
  let parts := line.splitOn id
  if parts.length <= 1 then false
  else parts.tail!.any fun next =>
    match next.toList with
    | [] => true
    | c :: _ => !c.isDigit

/-- Drop exporter-default header lines and orphaned metadata. -/
def cleanLlvmOutput (text : String) : String := Id.run do
  let isHeader (l : String) : Bool :=
    let t := l.trimAscii.toString
    t.startsWith "; ModuleID =" || t.startsWith "source_filename =" ||
      t.startsWith "!llvm.module.flags ="
  let mut kept := (text.splitOn "\n").filter (!isHeader ·)
  let mut done := false
  while !done do
    let next := kept.filter fun l =>
      match metadataDefId l with
      | none => true
      | some id => (kept.filter (· != l)).any (refersTo · id)
    done := next.length == kept.length
    kept := next
  "\n".intercalate (kept.dropWhile fun l => (l.trimAscii.toString).isEmpty)

def main (args : List String) : IO Unit := do
  enableExitOnPanic
  let cfg ← match parseLlrwtArgs args with
    | .ok cfg => pure cfg
    | .error msg => IO.eprintln s!"Error: {msg}"; IO.Process.exit 2
  if cfg.showVersion then
    IO.println "llrwt 0.1.0 (VeIR 0.1.0)"
    return
  if cfg.listRules then
    let entries := ruleRegistry.toList.toArray.qsort (·.1 < ·.1)
    for (name, rule) in entries do
      IO.println s!"{name} - {rule.description}"
    return
  let rules := if cfg.rules.isEmpty then ruleRegistry.toList.map (·.1) else cfg.rules
  for name in rules do
    unless ruleRegistry.contains name do
      IO.eprintln s!"Error: unknown rewrite rule: '{name}'."
      IO.Process.exit 2
  let inputText ← readInputText cfg.input
  let inputName := cfg.input.getD "<stdin>"
  let mlirRaw ← runMlirTool cfg.mlirTranslate #["--import-llvm"] inputText "--mlir-translate"
  let genericMlir ← runMlirTool cfg.mlirOpt
    #["--mlir-print-op-generic", "--mlir-print-local-scope"] mlirRaw "--mlir-opt"
  if cfg.debug then
    IO.eprintln s!"[llrwt] generic input:\n{genericMlir}"
    if let some n := cfg.maxIterations then
      IO.eprintln s!"[llrwt] max-iterations: {n}"
  let (ctx, op) ← parseVeir genericMlir inputName cfg.allowUnregisteredDialect
  let newCtx ← match runInstCombineRules rules ctx with
    | .ok c => pure c
    | .error msg => IO.eprintln s!"Error: {msg}"; IO.Process.exit 1
  if let .error msg := newCtx.verify op then
    IO.eprintln s!"Error verifying rewritten program: {msg}"
    IO.Process.exit 1
  let (printed, _) ← IO.FS.withIsolatedStreams (Veir.Printer.printOperation newCtx.raw op) false
  if cfg.debug then
    IO.eprintln s!"[llrwt] rewritten MLIR:\n{printed}"
  let llvmOut ← cleanLlvmOutput <$> runMlirTool cfg.mlirTranslate #["--mlir-to-llvmir"] printed "--mlir-translate"
  match cfg.output with
  | none => IO.print llvmOut
  | some path => try IO.FS.writeFile path llvmOut catch e =>
      IO.eprintln s!"Error writing file '{path}': {e}"
      IO.Process.exit 1
