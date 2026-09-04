; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules de-morgan-or-to-and %s | filecheck %s

define i32 @test(i32 %a, i32 %b) {
  %na = xor i32 %a, -1
  %nb = xor i32 %b, -1
  %either = or i32 %na, %nb
  %r = xor i32 %either, -1
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: xor i32
; CHECK-NOT: or i32
; CHECK: and i32
; CHECK: ret i32
