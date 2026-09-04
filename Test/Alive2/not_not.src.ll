; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules not-not-to-x %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; not-not-to-x

define i32 @test_i32(i32 %x) {
  %n1 = xor i32 %x, -1
  %r = xor i32 %n1, -1
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %n1 = xor i64 %x, -1
  %r = xor i64 %n1, -1
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %n1 = xor i128 %x, -1
  %r = xor i128 %n1, -1
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %n1 = xor i8 %x, -1
  %r = xor i8 %n1, -1
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %n1 = xor i7 %x, -1
  %r = xor i7 %n1, -1
  ret i7 %r
}

define i3 @test_i3(i3 %x) {
  %n1 = xor i3 %x, -1
  %r = xor i3 %n1, -1
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %n1 = xor i2 %x, -1
  %r = xor i2 %n1, -1
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %n1 = xor i1 %x, -1
  %r = xor i1 %n1, -1
  ret i1 %r
}

define i32 @test_quad_not(i32 %x) {
  %n1 = xor i32 %x, -1
  %n2 = xor i32 %n1, -1
  %n3 = xor i32 %n2, -1
  %n4 = xor i32 %n3, -1
  ret i32 %n4
}

; CHECK: 9 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
