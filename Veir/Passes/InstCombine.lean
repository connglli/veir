module

public import Veir.Pass
public import Veir.PatternRewriter.Basic
public import Veir.PatternRewriter.Semantics
import Veir.Passes.Matching

namespace Veir

/-!
  #Instcombine pass

  This file contains a (very) partial implementation of the instcombine pass, which performs
  simple peephole optimizations on the IR, such as folding constants or simplifying arithmetic.
-/

/-! ## Pattern Rewrites -/

/-- Rewrites `x * 2` to `x + x`. -/
def mulITwoToAddi_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, properties) := matchMuli op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 2 then
    return (ctx, none)
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.add #[lhs.getType! ctx.raw] #[lhs, lhs]
    #[] #[] properties none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def mulITwoToAddi (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite mulITwoToAddi_local rewriter op opInBounds

/-- Rewrites `x * 0` to `0`. -/
def mulIZeroToCst_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchMuli op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 0 then
    return (ctx, none)
  let .integerType type := (lhs.getType! ctx.raw).val
    | return (ctx, none)
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk 0 type))
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[lhs.getType! ctx.raw] #[]
    #[] #[] cstProp none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def mulIZeroToCst (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite mulIZeroToCst_local rewriter op opInBounds

/-- Rewrites `x + 0` to `x`. -/
def addiZeroToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchAddi op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 0 then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def addiZeroToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite addiZeroToX_local rewriter op opInBounds

/-- Rewrites `x * 1` to `x`. -/
def mulIOneToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchMuli op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 1 then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def mulIOneToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite mulIOneToX_local rewriter op opInBounds

/-- Rewrites `x - 0` to `x`. -/
def subiZeroToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchSubi op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 0 then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def subiZeroToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite subiZeroToX_local rewriter op opInBounds

/-- Rewrites `x - x` to `0`. -/
def subiSelfToZero_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchSubi op ctx.raw
    | return (ctx, none)
  if lhs ≠ rhs then
    return (ctx, none)
  let .integerType type := (lhs.getType! ctx.raw).val
    | return (ctx, none)
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk 0 type))
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[lhs.getType! ctx.raw] #[]
    #[] #[] cstProp none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def subiSelfToZero (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite subiSelfToZero_local rewriter op opInBounds

/-- Rewrites `x & x` to `x`. -/
def andiSelfToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs) := matchAndi op ctx.raw
    | return (ctx, none)
  if lhs ≠ rhs then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def andiSelfToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite andiSelfToX_local rewriter op opInBounds

/-- Rewrites `x & 0` to `0`. -/
def andiZeroToZero_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs) := matchAndi op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 0 then
    return (ctx, none)
  let .integerType type := (lhs.getType! ctx.raw).val
    | return (ctx, none)
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk 0 type))
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[lhs.getType! ctx.raw] #[]
    #[] #[] cstProp none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def andiZeroToZero (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite andiZeroToZero_local rewriter op opInBounds

/-- Rewrites `x & -1` to `x`. -/
def andiAllOnesToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs) := matchAndi op ctx.raw
    | return (ctx, none)
  unless (matchConstantAllOnes rhs ctx.raw).isSome do
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def andiAllOnesToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite andiAllOnesToX_local rewriter op opInBounds

/-- Rewrites `x & ~x` to `0`. -/
def andiNotSelfToZero_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs) := matchAndi op ctx.raw
    | return (ctx, none)
  let ok : Bool :=
    match matchNot rhs ctx.raw with
    | some v => decide (v = lhs)
    | none =>
      match matchNot lhs ctx.raw with
      | some v => decide (v = rhs)
      | none => false
  unless ok do
    return (ctx, none)
  let .integerType type := (lhs.getType! ctx.raw).val
    | return (ctx, none)
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk 0 type))
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[lhs.getType! ctx.raw] #[]
    #[] #[] cstProp none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def andiNotSelfToZero (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite andiNotSelfToZero_local rewriter op opInBounds

/-- Rewrites `x | 0` to `x`. -/
def oriZeroToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchOri op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 0 then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def oriZeroToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite oriZeroToX_local rewriter op opInBounds

/-- Rewrites `x | x` to `x`. -/
def oriSelfToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchOri op ctx.raw
    | return (ctx, none)
  if lhs ≠ rhs then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def oriSelfToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite oriSelfToX_local rewriter op opInBounds

/-- Rewrites `x | -1` to `-1`. -/
def oriAllOnesToAllOnes_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchOri op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ -1 then
    return (ctx, none)
  let .integerType type := (lhs.getType! ctx.raw).val
    | return (ctx, none)
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk (-1) type))
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[lhs.getType! ctx.raw] #[]
    #[] #[] cstProp none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def oriAllOnesToAllOnes (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite oriAllOnesToAllOnes_local rewriter op opInBounds

/-- Rewrites `x + (0 - x)` to `0`. -/
def addiNegSelfToZero_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchAddi op ctx.raw
    | return (ctx, none)
  let isNegOf (v w : ValuePtr) : Bool :=
    match v with
    | .opResult r =>
      match matchSubi r.op ctx.raw with
      | some (z, x, _) =>
        match matchConstantIntVal z ctx.raw with
        | some cst => cst.value == 0 && decide (x = w)
        | none => false
      | none => false
    | _ => false
  unless isNegOf rhs lhs || isNegOf lhs rhs do
    return (ctx, none)
  let .integerType type := (lhs.getType! ctx.raw).val
    | return (ctx, none)
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk 0 type))
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[lhs.getType! ctx.raw] #[]
    #[] #[] cstProp none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def addiNegSelfToZero (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite addiNegSelfToZero_local rewriter op opInBounds

/-- Rewrites `x << 0` to `x`. -/
def shlZeroToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchShl op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 0 then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def shlZeroToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite shlZeroToX_local rewriter op opInBounds

/-- Rewrites `x >> 0` to `x`. -/
def lshrZeroToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchLshr op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 0 then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def lshrZeroToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite lshrZeroToX_local rewriter op opInBounds

/-- Rewrites `x >>a 0` to `x`. -/
def ashrZeroToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchAshr op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 0 then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def ashrZeroToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite ashrZeroToX_local rewriter op opInBounds

/-- Rewrites `x ^ 0` to `x`. -/
def xoriZeroToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs) := matchXori op ctx.raw
    | return (ctx, none)
  let some cst := matchConstantIntVal rhs ctx.raw
    | return (ctx, none)
  if cst.value ≠ 0 then
    return (ctx, none)
  some (ctx, some (#[], #[lhs]))

def xoriZeroToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite xoriZeroToX_local rewriter op opInBounds

/-- Rewrites `x ^ x` to `0`. -/
def xoriSelfToZero_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs) := matchXori op ctx.raw
    | return (ctx, none)
  if lhs ≠ rhs then
    return (ctx, none)
  let .integerType type := (lhs.getType! ctx.raw).val
    | return (ctx, none)
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk 0 type))
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[lhs.getType! ctx.raw] #[]
    #[] #[] cstProp none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def xoriSelfToZero (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite xoriSelfToZero_local rewriter op opInBounds

/-- Rewrites `~~x` to `x`. -/
def notNotToX_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some outerNotted := matchNot (op.getResult 0) ctx.raw
    | return (ctx, none)
  let some inner := matchNot outerNotted ctx.raw
    | return (ctx, none)
  some (ctx, some (#[], #[inner]))

def notNotToX (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite notNotToX_local rewriter op opInBounds

/-- Rewrites `~(~a & ~b)` to `a | b` (DeMorgan). -/
/- TODO: the precondition should be strengthened by some hasOneUse() checks -/
def deMorganAndToOr_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some andVal := matchNot (op.getResult 0) ctx.raw
    | return (ctx, none)
  let .opResult andResPtr := andVal
    | return (ctx, none)
  let some (andL, andR) := matchAndi andResPtr.op ctx.raw
    | return (ctx, none)
  let some a := matchNot andL ctx.raw
    | return (ctx, none)
  let some b := matchNot andR ctx.raw
    | return (ctx, none)
  let resultType := a.getType! ctx.raw
  let orProps : DisjointProperties := { disjoint := false }
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.or #[resultType] #[a, b]
    #[] #[] orProps none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def deMorganAndToOr (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite deMorganAndToOr_local rewriter op opInBounds

/-- Rewrites `~(~a | ~b)` to `a & b` (DeMorgan). -/
/- TODO: the precondition should be strengthened by some hasOneUse() checks -/
def deMorganOrToAnd_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some orVal := matchNot (op.getResult 0) ctx.raw
    | return (ctx, none)
  let .opResult orResPtr := orVal
    | return (ctx, none)
  let some (orL, orR, _) := matchOri orResPtr.op ctx.raw
    | return (ctx, none)
  let some a := matchNot orL ctx.raw
    | return (ctx, none)
  let some b := matchNot orR ctx.raw
    | return (ctx, none)
  let resultType := a.getType! ctx.raw
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.and #[resultType] #[a, b]
    #[] #[] () none
  some (ctx, some (#[newOp], #[newOp.getResult 0]))

def deMorganOrToAnd (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite deMorganOrToAnd_local rewriter op opInBounds

/-! ## Rule registry -/

/-- A rewrite rule with its soundness proof. -/
public structure VerifiedRule where
  name : String
  description : String
  pattern : LocalRewritePattern OpCode
  sound : pattern.Sound

/-- Default `instcombine` pass rules, in execution order. -/
public def orderedInstCombineRuleNames : List String :=
  ["mul_two", "mul_zero", "mul_one",
   "add_zero",
   "sub_zero", "sub_self",
   "and_self", "and_zero",
   "or_zero", "or_self",
   "xor_zero", "xor_self",
   "not_not", "demorgan_and", "demorgan_or"]

set_option warn.sorry false in
/-- Rules indexed by name. -/
public def ruleRegistry : Std.HashMap String VerifiedRule :=
  let entries : List VerifiedRule :=
    [{ name := "mul_two", description := "x * 2 => x + x", pattern := mulITwoToAddi_local, sound := sorry },
     { name := "mul_zero", description := "x * 0 => 0", pattern := mulIZeroToCst_local, sound := sorry },
     { name := "mul_one", description := "x * 1 => x", pattern := mulIOneToX_local, sound := sorry },
     { name := "add_zero", description := "x + 0 => x", pattern := addiZeroToX_local, sound := sorry },
     { name := "add_neg_self", description := "x + (-x) => 0", pattern := addiNegSelfToZero_local, sound := sorry },
     { name := "sub_zero", description := "x - 0 => x", pattern := subiZeroToX_local, sound := sorry },
     { name := "sub_self", description := "x - x => 0", pattern := subiSelfToZero_local, sound := sorry },
     { name := "and_self", description := "x & x => x", pattern := andiSelfToX_local, sound := sorry },
     { name := "and_zero", description := "x & 0 => 0", pattern := andiZeroToZero_local, sound := sorry },
     { name := "and_all_ones", description := "x & -1 => x", pattern := andiAllOnesToX_local, sound := sorry },
     { name := "and_not_self", description := "x & ~x => 0", pattern := andiNotSelfToZero_local, sound := sorry },
     { name := "or_zero", description := "x | 0 => x", pattern := oriZeroToX_local, sound := sorry },
     { name := "or_self", description := "x | x => x", pattern := oriSelfToX_local, sound := sorry },
     { name := "or_all_ones", description := "x | -1 => -1", pattern := oriAllOnesToAllOnes_local, sound := sorry },
     { name := "xor_zero", description := "x ^ 0 => x", pattern := xoriZeroToX_local, sound := sorry },
     { name := "xor_self", description := "x ^ x => 0", pattern := xoriSelfToZero_local, sound := sorry },
     { name := "shl_zero", description := "x << 0 => x", pattern := shlZeroToX_local, sound := sorry },
     { name := "lshr_zero", description := "x >> 0 => x", pattern := lshrZeroToX_local, sound := sorry },
     { name := "ashr_zero", description := "x >>a 0 => x", pattern := ashrZeroToX_local, sound := sorry },
     { name := "not_not", description := "~~x => x", pattern := notNotToX_local, sound := sorry },
     { name := "demorgan_and", description := "~(~a & ~b) => a | b", pattern := deMorganAndToOr_local, sound := sorry },
     { name := "demorgan_or", description := "~(~a | ~b) => a & b", pattern := deMorganOrToAnd_local, sound := sorry }]
  entries.foldl (fun m r => m.insert r.name r) (Std.HashMap.emptyWithCapacity entries.length)

/-- Registered patterns in execution order. -/
public def allInstCombinePatterns : Array (RewritePattern OpCode) :=
  orderedInstCombineRuleNames.toArray.filterMap fun name =>
    (ruleRegistry.get? name).map fun rule => RewritePattern.fromLocalRewrite rule.pattern

/-- Run selected rules. -/
public def runInstCombineRules (ruleNames : List String) (ctx : WfIRContext OpCode) :
    Except String (WfIRContext OpCode) := do
  let mut selected := #[]
  for name in ruleNames do
    match ruleRegistry.get? name with
    | some rule => selected := selected.push (RewritePattern.fromLocalRewrite rule.pattern)
    | none => throw s!"Unknown rewrite rule: '{name}'."
  if selected.isEmpty then
    return ctx
  let pattern := RewritePattern.GreedyRewritePattern selected
  match RewritePattern.applyInContext pattern ctx with
  | some newCtx => pure newCtx
  | none => throw "Error while executing pattern rewriter worklist"

def InstCombinePass.impl (ctx : WfIRContext OpCode) (op : OperationPtr) (_ : op.InBounds ctx.raw) :
    ExceptT String IO (WfIRContext OpCode) := do
  let pattern := RewritePattern.GreedyRewritePattern allInstCombinePatterns
  match RewritePattern.applyInContext pattern ctx with
  | none => throw "Error while applying pattern rewrites"
  | some ctx => pure ctx

public def InstCombinePass : Pass OpCode :=
  { name := "instcombine"
    description :=
      "Combine instructions into more efficient forms, e.g., fold constants or simplify llvmmetic."
    run := fun _ => InstCombinePass.impl }
