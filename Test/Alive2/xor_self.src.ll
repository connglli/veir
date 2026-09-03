; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules xor_self %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; xor_self

define i32 @test_i32(i32 %x) {
  %r = xor i32 %x, %x
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %r = xor i64 %x, %x
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %r = xor i128 %x, %x
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %r = xor i8 %x, %x
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %r = xor i7 %x, %x
  ret i7 %r
}

define i3 @test_i3(i3 %x) {
  %r = xor i3 %x, %x
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %r = xor i2 %x, %x
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %r = xor i1 %x, %x
  ret i1 %r
}

; CHECK: 8 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
