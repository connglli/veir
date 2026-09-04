module

public import Veir.Pass
public import Veir.PatternRewriter.Basic

import all Veir.Passes.InstCombine

namespace Veir

/-!
  # Apply patterns pass

  Applies a command-line-selected set of peephole rewrite patterns. Each pattern is
  exposed as a boolean pass option and is disabled by default, so a pipeline can
  request exactly the desired rewrites, for example:

  `apply-patterns{muli-two-to-addi addi-zero-to-x}`

  This is the single source of truth for selectable peephole pattern names:
  `Veir.Passes.InstCombine` defines the rewrites, and this module assigns them
  their command-line names (also used by the `llrwt` tool's `--rules` flag).
-/

/-- A peephole pattern selectable through `ApplyPatternsPass` (and `llrwt --rules`). -/
public structure SelectablePattern where
  /-- Command-line name of the pattern. -/
  name : String
  /-- Human-readable description of the rewrite. -/
  description : String
  /-- The rewrite itself. -/
  pattern : RewritePattern OpCode

/-- The peephole patterns selectable through `ApplyPatternsPass`. -/
public def applyPatterns : List SelectablePattern := [
  { name := "muli-two-to-addi", description := "x * 2 => x + x", pattern := mulITwoToAddi },
  { name := "muli-zero-to-cst", description := "x * 0 => 0", pattern := mulIZeroToCst },
  { name := "muli-one-to-x", description := "x * 1 => x", pattern := mulIOneToX },
  { name := "addi-zero-to-x", description := "x + 0 => x", pattern := addiZeroToX },
  { name := "addi-neg-self-to-zero", description := "x + (0 - x) => 0", pattern := addiNegSelfToZero },
  { name := "subi-zero-to-x", description := "x - 0 => x", pattern := subiZeroToX },
  { name := "subi-self-to-zero", description := "x - x => 0", pattern := subiSelfToZero },
  { name := "andi-self-to-x", description := "x & x => x", pattern := andiSelfToX },
  { name := "andi-zero-to-zero", description := "x & 0 => 0", pattern := andiZeroToZero },
  { name := "andi-all-ones-to-x", description := "x & -1 => x", pattern := andiAllOnesToX },
  { name := "andi-not-self-to-zero", description := "x & ~x => 0", pattern := andiNotSelfToZero },
  { name := "ori-zero-to-x", description := "x | 0 => x", pattern := oriZeroToX },
  { name := "ori-self-to-x", description := "x | x => x", pattern := oriSelfToX },
  { name := "ori-all-ones-to-all-ones", description := "x | -1 => -1", pattern := oriAllOnesToAllOnes },
  { name := "xori-zero-to-x", description := "x ^ 0 => x", pattern := xoriZeroToX },
  { name := "xori-self-to-zero", description := "x ^ x => 0", pattern := xoriSelfToZero },
  { name := "shl-zero-to-x", description := "x << 0 => x", pattern := shlZeroToX },
  { name := "lshr-zero-to-x", description := "x >> 0 => x", pattern := lshrZeroToX },
  { name := "ashr-zero-to-x", description := "x >>a 0 => x", pattern := ashrZeroToX },
  { name := "not-not-to-x", description := "~~x => x", pattern := notNotToX },
  { name := "de-morgan-and-to-or", description := "~(~a & ~b) => a | b", pattern := deMorganAndToOr },
  { name := "de-morgan-or-to-and", description := "~(~a | ~b) => a & b", pattern := deMorganOrToAnd },
  { name := "subi-zext-to-add-sext", description := "x - zext i1 b => x + sext i1 b",
    pattern := subZextToAddSext },
  { name := "muli-pow2-to-shl", description := "x * 2^k => x << k", pattern := mulPow2ToShl },
  { name := "addi-mul-factor", description := "(x*C1) + (x*C2) => x*(C1+C2)", pattern := addMulFactor },
  { name := "subi-sdiv-mul-to-srem",
    description := "x - ((x sdiv C)*C + y) => (x srem C) - y", pattern := sdivMulToSrem }
]

def ApplyPatternsPass.impl (options : PassOptions) (ctx : WfIRContext OpCode)
    (op : OperationPtr) (_ : op.InBounds ctx.raw) :
    ExceptT String IO (WfIRContext OpCode) := do
  let patterns := applyPatterns.foldl (init := #[]) fun selected entry =>
    if (options.get? entry.name).getD false then selected.push entry.pattern else selected
  let pattern := RewritePattern.GreedyRewritePattern patterns
  match RewritePattern.applyInContext pattern ctx with
  | none => throw "Error while applying pattern rewrites"
  | some ctx => pure ctx

public def ApplyPatternsPass : Pass OpCode :=
  { name := "apply-patterns"
    description := "Apply a selected set of peephole rewrite patterns."
    options := .ofList (applyPatterns.map fun entry =>
      (entry.name, { description := s!"Enable the '{entry.name}' rewrite pattern ({entry.description})." }))
    run := ApplyPatternsPass.impl }

end Veir
