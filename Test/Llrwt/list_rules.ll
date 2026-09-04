; RUN: llrwt --list-rules | filecheck %s

; CHECK: addi-mul-factor
; CHECK: addi-neg-self-to-zero
; CHECK: addi-zero-to-x
; CHECK: andi-all-ones-to-x
; CHECK: andi-not-self-to-zero
; CHECK: andi-self-to-x
; CHECK: andi-zero-to-zero
; CHECK: ashr-zero-to-x
; CHECK: de-morgan-and-to-or
; CHECK: de-morgan-or-to-and
; CHECK: lshr-zero-to-x
; CHECK: muli-one-to-x
; CHECK: muli-pow2-to-shl
; CHECK: muli-two-to-addi
; CHECK: muli-zero-to-cst
; CHECK: not-not-to-x
; CHECK: ori-all-ones-to-all-ones
; CHECK: ori-self-to-x
; CHECK: ori-zero-to-x
; CHECK: shl-zero-to-x
; CHECK: subi-sdiv-mul-to-srem
; CHECK: subi-self-to-zero
; CHECK: subi-zero-to-x
; CHECK: subi-zext-to-add-sext
; CHECK: xori-self-to-zero
; CHECK: xori-zero-to-x
