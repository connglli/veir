; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules and_zero %s | filecheck %s

define i32 @test(i32 %a) {
  %r = and i32 %a, 0
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: and i32
; CHECK: ret i32 0
