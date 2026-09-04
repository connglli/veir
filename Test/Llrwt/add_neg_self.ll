; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules addi-neg-self-to-zero %s | filecheck %s

define i32 @test(i32 %a) {
  %neg = sub i32 0, %a
  %r = add i32 %a, %neg
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: sub i32
; CHECK-NOT: add i32
; CHECK: ret i32 0
