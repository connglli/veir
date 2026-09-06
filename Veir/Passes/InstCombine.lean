module

public import Veir.Pass
public import Veir.PatternRewriter.Basic
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
  let .integerType type := (lhs.getType! ctx.raw).val
    | return (ctx, none)
  if type.bitwidth ≤ 1 then
    return (ctx, none)
  let addProps : NswNuwProperties := {
    nsw := properties.nsw && 2 < type.bitwidth
    nuw := properties.nuw
  }
  let (ctx, newOp) ← WfRewriter.createOp! ctx Llvm.add #[lhs.getType! ctx.raw] #[lhs, lhs]
    #[] #[] addProps none
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

/-! ## Additional arithmetic rewrites -/

/-- True when `n` is a positive power of two. -/
private def natIsPow2 (n : Nat) : Bool :=
  n != 0 && 2 ^ (Nat.log2 n) == n

/-- Wrap `v` into the signed range of an `w`-bit integer type for constant creation. -/
private def wrapToBitwidth (v : Int) (w : Nat) : Int :=
  if w == 0 then 0
  else
    let m : Int := Int.ofNat (2 ^ w)
    let r := v % m
    let rPos := if r < 0 then r + m else r
    let half : Int := Int.ofNat (2 ^ (w - 1))
    if rPos >= half then rPos - m else rPos

/-- Rewrites `x - zext i1 b` to `x + sext i1 b`. -/
def subZextToAddSext_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (x, zextVal, subProps) := matchSubi op ctx.raw
    | return (ctx, none)
  let .opResult zextRes := zextVal
    | return (ctx, none)
  let some (b, _) := matchZext zextRes.op ctx.raw
    | return (ctx, none)
  let .integerType destTy := (x.getType! ctx.raw).val
    | return (ctx, none)
  if destTy.bitwidth ≤ 1 then
    return (ctx, none)
  let .integerType srcTy := (b.getType! ctx.raw).val
    | return (ctx, none)
  if srcTy.bitwidth != 1 then
    return (ctx, none)
  let destType := x.getType! ctx.raw
  let (ctx, sextOp) ← WfRewriter.createOp! ctx Llvm.sext #[destType] #[b]
    #[] #[] () none
  let addProps : NswNuwProperties := { nsw := subProps.nsw, nuw := false }
  let (ctx, addOp) ← WfRewriter.createOp! ctx Llvm.add #[destType]
    #[x, sextOp.getResult 0] #[] #[] addProps none
  some (ctx, some (#[sextOp, addOp], #[addOp.getResult 0]))

def subZextToAddSext (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite subZextToAddSext_local rewriter op opInBounds

/-- Rewrites `x * 2^k` to `x << k`. -/
def mulPow2ToShl_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, mulProps) := matchMuli op ctx.raw
    | return (ctx, none)
  let (x, cst) : ValuePtr × IntegerAttr ←
    match matchConstantIntVal rhs ctx.raw with
    | some c => pure (lhs, c)
    | none =>
      match matchConstantIntVal lhs ctx.raw with
      | some c => pure (rhs, c)
      | none => return (ctx, none)
  if cst.value ≤ 1 then
    return (ctx, none)
  let n := cst.value.toNat
  unless natIsPow2 n do
    return (ctx, none)
  let k := Nat.log2 n
  let .integerType ty := (x.getType! ctx.raw).val
    | return (ctx, none)
  if k >= ty.bitwidth then
    return (ctx, none)
  let destType := x.getType! ctx.raw
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk (Int.ofNat k) ty))
  let (ctx, kOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[destType] #[]
    #[] #[] cstProp none
  let shlProps : NswNuwProperties := { nsw := mulProps.nsw, nuw := mulProps.nuw }
  let (ctx, shlOp) ← WfRewriter.createOp! ctx Llvm.shl #[destType]
    #[x, kOp.getResult 0] #[] #[] shlProps none
  some (ctx, some (#[kOp, shlOp], #[shlOp.getResult 0]))

def mulPow2ToShl (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite mulPow2ToShl_local rewriter op opInBounds

/-- Extract `(base, coeff)` with `v = base * coeff`: `mul` gives its constant,
`shl` gives `2^k`, anything else gives `(v, 1)`. The flag reports `mul`/`shl`. -/
private def extractMulBaseCoeff (v : ValuePtr) (ctx : IRContext OpCode) :
    (ValuePtr × Int × Bool) :=
  match v with
  | .opResult r =>
    match matchMuli r.op ctx with
    | some (a, b, _) =>
      match matchConstantIntVal b ctx with
      | some c => (a, c.value, true)
      | none =>
        match matchConstantIntVal a ctx with
        | some c => (b, c.value, true)
        | none =>
          match matchShl r.op ctx with
          | some (a', kVal, _) =>
            match matchConstantIntVal kVal ctx with
            | some k =>
              if k.value < 0 then (v, 1, false)
              else
                match (a'.getType! ctx).val with
                | .integerType ty =>
                  if k.value.toNat >= ty.bitwidth then (v, 1, false)
                  else (a', Int.ofNat (2 ^ k.value.toNat), true)
                | _ => (v, 1, false)
            | none => (v, 1, false)
          | none => (v, 1, false)
    | none =>
      match matchShl r.op ctx with
      | some (a, kVal, _) =>
        match matchConstantIntVal kVal ctx with
        | some k =>
          if k.value < 0 then (v, 1, false)
          else
            match (a.getType! ctx).val with
            | .integerType ty =>
              if k.value.toNat >= ty.bitwidth then (v, 1, false)
              else (a, Int.ofNat (2 ^ k.value.toNat), true)
            | _ => (v, 1, false)
        | none => (v, 1, false)
      | none => (v, 1, false)
  | _ => (v, 1, false)

/-- Rewrites `(x*C1) + (x*C2)` to `x*(C1+C2)`, treating `x<<k` as `x*2^k`. -/
def addMulFactor_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (lhs, rhs, _) := matchAddi op ctx.raw
    | return (ctx, none)
  let (baseL, cL, isMulL) := extractMulBaseCoeff lhs ctx.raw
  let (baseR, cR, isMulR) := extractMulBaseCoeff rhs ctx.raw
  unless isMulL || isMulR do
    return (ctx, none)
  if baseL != baseR then
    return (ctx, none)
  if cL == 1 && cR == 1 then
    return (ctx, none)
  let .integerType ty := (lhs.getType! ctx.raw).val
    | return (ctx, none)
  let sum := wrapToBitwidth (cL + cR) ty.bitwidth
  let destType := lhs.getType! ctx.raw
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk sum ty))
  let (ctx, sumOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[destType] #[]
    #[] #[] cstProp none
  let mulProps : NswNuwProperties := { nsw := false, nuw := false }
  let (ctx, mulOp) ← WfRewriter.createOp! ctx Llvm.mul #[destType]
    #[baseL, sumOp.getResult 0] #[] #[] mulProps none
  some (ctx, some (#[sumOp, mulOp], #[mulOp.getResult 0]))

def addMulFactor (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite addMulFactor_local rewriter op opInBounds

/-- Rewrites `x - ((x sdiv C)*C + y)` to `(x srem C) - y` (either `add` order).
Note: the new `sub` drops the source `nsw`/`nuw` flags. Keeping them is
unsound: intermediate wrapping can absorb an overflow in the source while the
target overflows (e.g. `sub nsw i2 %x, %a` with `%a` wrapped), making the
target more poisonous than the source. -/
def sdivMulToSrem_local (ctx : WfIRContext OpCode) (op : OperationPtr) :
    Option (WfIRContext OpCode × Option (Array OperationPtr × Array ValuePtr)) := do
  let some (x, addVal, _) := matchSubi op ctx.raw
    | return (ctx, none)
  let .opResult addRes := addVal
    | return (ctx, none)
  let some (addL, addR, _) := matchAddi addRes.op ctx.raw
    | return (ctx, none)
  let tryOrder (mulCand y : ValuePtr) :
      Option (ValuePtr × ValuePtr × IntegerAttr) := do
    let .opResult mulRes := mulCand | none
    let some (sdivVal, c2Val, _) := matchMuli mulRes.op ctx.raw | none
    let sdivCand : ValuePtr :=
      if (matchConstantIntVal c2Val ctx.raw).isSome then sdivVal else c2Val
    let cVal : ValuePtr :=
      if (matchConstantIntVal c2Val ctx.raw).isSome then c2Val else sdivVal
    let some c2 := matchConstantIntVal cVal ctx.raw | none
    guard (c2.value != 0 && c2.value != -1)
    let .opResult sdivRes := sdivCand | none
    let some (x2, c1Val, _) := matchSdiv sdivRes.op ctx.raw | none
    let some c1 := matchConstantIntVal c1Val ctx.raw | none
    guard (c1.value == c2.value)
    guard (x2 == x)
    some (x2, y, c1)
  let some (x2, y, c1) :=
      tryOrder addL addR <|> tryOrder addR addL
    | return (ctx, none)
  let .integerType ty := (x.getType! ctx.raw).val
    | return (ctx, none)
  let destType := x.getType! ctx.raw
  let cstProp := LLVMConstantProperties.mk (.integer (IntegerAttr.mk c1.value ty))
  let (ctx, cOp) ← WfRewriter.createOp! ctx Llvm.mlir__constant #[destType] #[]
    #[] #[] cstProp none
  let (ctx, sremOp) ← WfRewriter.createOp! ctx Llvm.srem #[destType]
    #[x2, cOp.getResult 0] #[] #[] () none
  let subProps : NswNuwProperties := { nsw := false, nuw := false }
  let (ctx, subOp) ← WfRewriter.createOp! ctx Llvm.sub #[destType]
    #[sremOp.getResult 0, y] #[] #[] subProps none
  some (ctx, some (#[cOp, sremOp, subOp], #[subOp.getResult 0]))

def sdivMulToSrem (rewriter : PatternRewriter OpCode) (op : OperationPtr)
    (opInBounds : op.InBounds rewriter.ctx.raw) : Option (PatternRewriter OpCode) :=
  RewritePattern.fromLocalRewrite sdivMulToSrem_local rewriter op opInBounds

/-! ## Pass patterns -/

/-- The `instcombine` patterns, in execution order.

This is the legacy default set; the full set of individually selectable
patterns lives in `Veir.Passes.ApplyPatterns` (also used by `llrwt`). -/
public def instCombinePatterns : Array (RewritePattern OpCode) :=
  #[mulITwoToAddi, mulIZeroToCst, mulIOneToX,
    addiZeroToX,
    subiZeroToX, subiSelfToZero,
    andiSelfToX, andiZeroToZero,
    oriZeroToX, oriSelfToX,
    xoriZeroToX, xoriSelfToZero,
    notNotToX, deMorganAndToOr, deMorganOrToAnd]

def InstCombinePass.impl (ctx : WfIRContext OpCode) (op : OperationPtr) (_ : op.InBounds ctx.raw) :
    ExceptT String IO (WfIRContext OpCode) := do
  let pattern := RewritePattern.GreedyRewritePattern instCombinePatterns
  match RewritePattern.applyInContext pattern ctx with
  | none => throw "Error while applying pattern rewrites"
  | some ctx => pure ctx

public def InstCombinePass : Pass OpCode :=
  { name := "instcombine"
    description :=
      "Combine instructions into more efficient forms, e.g., fold constants or simplify llvmmetic."
    run := fun _ => InstCombinePass.impl }
