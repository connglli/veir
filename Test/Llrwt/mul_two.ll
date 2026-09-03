; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules mul_two %s | filecheck %s

define i32 @test(i32 %a) {
  %r = mul i32 %a, 2
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: mul i32
; CHECK: add i32
; CHECK: ret i32
