; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules shl-zero-to-x %s | filecheck %s

define i32 @test(i32 %a) {
  %r = shl i32 %a, 0
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: shl i32
; CHECK: ret i32
