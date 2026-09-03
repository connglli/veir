; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules not_not %s | filecheck %s

define i32 @test(i32 %a) {
  %n1 = xor i32 %a, -1
  %r = xor i32 %n1, -1
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: xor i32
; CHECK: ret i32
