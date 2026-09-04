; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules andi-not-self-to-zero %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; andi-not-self-to-zero

define i32 @test_i32(i32 %x) {
  %nx = xor i32 %x, -1
  %r = and i32 %x, %nx
  ret i32 %r
}

define i32 @test_i32_commuted(i32 %x) {
  %nx = xor i32 %x, -1
  %r = and i32 %nx, %x
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %nx = xor i64 %x, -1
  %r = and i64 %x, %nx
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %nx = xor i128 %x, -1
  %r = and i128 %x, %nx
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %nx = xor i8 %x, -1
  %r = and i8 %x, %nx
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %nx = xor i7 %x, -1
  %r = and i7 %x, %nx
  ret i7 %r
}

define i3 @test_i3(i3 %x) {
  %nx = xor i3 %x, -1
  %r = and i3 %x, %nx
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %nx = xor i2 %x, -1
  %r = and i2 %x, %nx
  ret i2 %r
}

define i2 @test_i2_commuted(i2 %x) {
  %nx = xor i2 %x, -1
  %r = and i2 %nx, %x
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %nx = xor i1 %x, -1
  %r = and i1 %x, %nx
  ret i1 %r
}

define i1 @test_i1_commuted(i1 %x) {
  %nx = xor i1 %x, -1
  %r = and i1 %nx, %x
  ret i1 %r
}

; CHECK: 11 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
