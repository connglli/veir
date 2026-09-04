// RUN: veir-opt %s '-p=apply-patterns{muli-two-to-addi}' | filecheck %s --check-prefix=SELECTED
// RUN: veir-opt %s '-p=apply-patterns{addi-zero-to-x}' | filecheck %s --check-prefix=UNSELECTED
// RUN: veir-opt %s '-p=apply-patterns{muli-pow2-to-shl}' | filecheck %s --check-prefix=POW2

"builtin.module"() ({
  "func.func"() <{function_type = () -> (), sym_name = "main"}> ({
    ^bb0():
      %two = "llvm.mlir.constant"() <{ "value" = 2 : i32 }> : () -> i32
      %x = "test.test"() : () -> i32
      %mul_two = "llvm.mul"(%x, %two) : (i32, i32) -> i32
      "test.test"(%mul_two) : (i32) -> ()
      "func.return"() : () -> ()
  }) : () -> ()
}) : () -> ()

// The muli-two-to-addi is selected, so the optimization triggered

// SELECTED:     %[[X:.*]] = "test.test"() : () -> i32
// SELECTED-NEXT: %[[ADD:.*]] = "llvm.add"(%[[X]], %[[X]]) : (i32, i32) -> i32
// SELECTED-NEXT: "test.test"(%[[ADD]]) : (i32) -> ()
// SELECTED-NOT: "llvm.mul"

// The muli-two-to-addi is unselected, so the optimization did not trigger

// UNSELECTED:     %[[TWO:.*]] = "llvm.mlir.constant"() <{"value" = 2 : i32}> : () -> i32
// UNSELECTED-NEXT: %[[X:.*]] = "test.test"() : () -> i32
// UNSELECTED-NEXT: %[[MUL:.*]] = "llvm.mul"(%[[X]], %[[TWO]]) : (i32, i32) -> i32
// UNSELECTED-NEXT: "test.test"(%[[MUL]]) : (i32) -> ()

// Only muli-pow2-to-shl is selected, so `mul x, 2` becomes `shl x, 1`

// POW2:        %[[X:.*]] = "test.test"() : () -> i32
// POW2-NEXT:   %[[K:.*]] = "llvm.mlir.constant"() <{"value" = 1 : i32}> : () -> i32
// POW2-NEXT:   %[[SHL:.*]] = "llvm.shl"(%[[X]], %[[K]]) : (i32, i32) -> i32
// POW2-NEXT:   "test.test"(%[[SHL]]) : (i32) -> ()
// POW2-NOT:    "llvm.mul"
