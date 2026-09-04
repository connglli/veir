; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules subi-zero-to-x %s | filecheck %s

define i32 @test(i32 %a) {
  %r = sub i32 %a, 0
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: sub i32
; CHECK: ret i32
