; REQUIRES: mlir-translate
; RUN: not llrwt --rules add_zero %s 2>&1 | filecheck %s
;
; Input rejected by `mlir-translate` exits 1 with the tool diagnostic.

this is not valid LLVM IR

; CHECK: mlir-translate
