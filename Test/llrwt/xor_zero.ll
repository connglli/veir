; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules xor_zero %s | filecheck %s

define i32 @test(i32 %a) {
  %r = xor i32 %a, 0
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: xor i32
; CHECK: ret i32
