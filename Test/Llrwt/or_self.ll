; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules ori-self-to-x %s | filecheck %s

define i32 @test(i32 %a) {
  %r = or i32 %a, %a
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: or i32
; CHECK: ret i32
