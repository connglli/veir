; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules and_zero %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; and_zero

define i32 @test_i32(i32 %x) {
  %r = and i32 %x, 0
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %r = and i64 %x, 0
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %r = and i128 %x, 0
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %r = and i8 %x, 0
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %r = and i7 %x, 0
  ret i7 %r
}

define i3 @test_i3(i3 %x) {
  %r = and i3 %x, 0
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %r = and i2 %x, 0
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %r = and i1 %x, 0
  ret i1 %r
}

; CHECK: Transformation seems to be correct!
