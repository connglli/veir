; RUN: llrwt --list-rules | filecheck %s

; CHECK: add_zero
; CHECK: and_self
; CHECK: and_zero
; CHECK: demorgan_and
; CHECK: demorgan_or
; CHECK: mul_one
; CHECK: mul_two
; CHECK: mul_zero
; CHECK: not_not
; CHECK: or_self
; CHECK: or_zero
; CHECK: sub_self
; CHECK: sub_zero
; CHECK: xor_self
; CHECK: xor_zero
