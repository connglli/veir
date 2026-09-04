; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules de-morgan-or-to-and %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; de-morgan-or-to-and

define i32 @test_i32(i32 %a, i32 %b) {
  %na = xor i32 %a, -1
  %nb = xor i32 %b, -1
  %either = or i32 %na, %nb
  %r = xor i32 %either, -1
  ret i32 %r
}

define i32 @test_i32_disjoint(i32 %a, i32 %b) {
  %na = xor i32 %a, -1
  %nb = xor i32 %b, -1
  %either = or disjoint i32 %na, %nb
  %r = xor i32 %either, -1
  ret i32 %r
}

define i64 @test_i64(i64 %a, i64 %b) {
  %na = xor i64 %a, -1
  %nb = xor i64 %b, -1
  %either = or disjoint i64 %na, %nb
  %r = xor i64 %either, -1
  ret i64 %r
}

define i128 @test_i128(i128 %a, i128 %b) {
  %na = xor i128 %a, -1
  %nb = xor i128 %b, -1
  %either = or disjoint i128 %na, %nb
  %r = xor i128 %either, -1
  ret i128 %r
}

define i8 @test_i8(i8 %a, i8 %b) {
  %na = xor i8 %a, -1
  %nb = xor i8 %b, -1
  %either = or disjoint i8 %na, %nb
  %r = xor i8 %either, -1
  ret i8 %r
}

define i7 @test_i7(i7 %a, i7 %b) {
  %na = xor i7 %a, -1
  %nb = xor i7 %b, -1
  %either = or disjoint i7 %na, %nb
  %r = xor i7 %either, -1
  ret i7 %r
}

define i3 @test_i3(i3 %a, i3 %b) {
  %na = xor i3 %a, -1
  %nb = xor i3 %b, -1
  %either = or disjoint i3 %na, %nb
  %r = xor i3 %either, -1
  ret i3 %r
}

define i2 @test_i2(i2 %a, i2 %b) {
  %na = xor i2 %a, -1
  %nb = xor i2 %b, -1
  %either = or i2 %na, %nb
  %r = xor i2 %either, -1
  ret i2 %r
}

define i2 @test_i2_disjoint(i2 %a, i2 %b) {
  %na = xor i2 %a, -1
  %nb = xor i2 %b, -1
  %either = or disjoint i2 %na, %nb
  %r = xor i2 %either, -1
  ret i2 %r
}

define i1 @test_i1(i1 %a, i1 %b) {
  %na = xor i1 %a, -1
  %nb = xor i1 %b, -1
  %either = or i1 %na, %nb
  %r = xor i1 %either, -1
  ret i1 %r
}

define i1 @test_i1_disjoint(i1 %a, i1 %b) {
  %na = xor i1 %a, -1
  %nb = xor i1 %b, -1
  %either = or disjoint i1 %na, %nb
  %r = xor i1 %either, -1
  ret i1 %r
}

; CHECK: 11 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
