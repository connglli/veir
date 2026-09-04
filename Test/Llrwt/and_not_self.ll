; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules andi-not-self-to-zero %s | filecheck %s

define i32 @test(i32 %a) {
  %na = xor i32 %a, -1
  %r = and i32 %a, %na
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: and i32
; CHECK: ret i32 0
