; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules demorgan_and %s | filecheck %s

define i32 @test(i32 %a, i32 %b) {
  %na = xor i32 %a, -1
  %nb = xor i32 %b, -1
  %both = and i32 %na, %nb
  %r = xor i32 %both, -1
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: xor i32
; CHECK-NOT: and i32
; CHECK: or i32
; CHECK: ret i32
