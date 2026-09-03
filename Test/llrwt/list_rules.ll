; RUN: llrwt --list-rules | filecheck %s

; CHECK: add_neg_self
; CHECK: add_zero
; CHECK: and_all_ones
; CHECK: and_not_self
; CHECK: and_self
; CHECK: and_zero
; CHECK: ashr_zero
; CHECK: demorgan_and
; CHECK: demorgan_or
; CHECK: lshr_zero
; CHECK: mul_one
; CHECK: mul_two
; CHECK: mul_zero
; CHECK: not_not
; CHECK: or_all_ones
; CHECK: or_self
; CHECK: or_zero
; CHECK: shl_zero
; CHECK: sub_self
; CHECK: sub_zero
; CHECK: xor_self
; CHECK: xor_zero
