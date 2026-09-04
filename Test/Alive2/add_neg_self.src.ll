; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules addi-neg-self-to-zero %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; addi-neg-self-to-zero

define i32 @test_i32(i32 %x) {
  %neg = sub i32 0, %x
  %r = add i32 %x, %neg
  ret i32 %r
}

define i32 @test_i32_commuted(i32 %x) {
  %neg = sub i32 0, %x
  %r = add i32 %neg, %x
  ret i32 %r
}

define i32 @test_i32_nsw(i32 %x) {
  %neg = sub nsw i32 0, %x
  %r = add nsw i32 %x, %neg
  ret i32 %r
}

define i32 @test_i32_mixed(i32 %x) {
  %neg = sub nsw i32 0, %x
  %r = add i32 %x, %neg
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %neg = sub nsw i64 0, %x
  %r = add nsw i64 %x, %neg
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %neg = sub nsw i128 0, %x
  %r = add nsw i128 %x, %neg
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %neg = sub nsw i8 0, %x
  %r = add nsw i8 %x, %neg
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %neg = sub nsw i7 0, %x
  %r = add nsw i7 %x, %neg
  ret i7 %r
}

define i3 @test_i3(i3 %x) {
  %neg = sub nsw i3 0, %x
  %r = add nsw i3 %x, %neg
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %neg = sub i2 0, %x
  %r = add i2 %x, %neg
  ret i2 %r
}

define i2 @test_i2_commuted(i2 %x) {
  %neg = sub i2 0, %x
  %r = add i2 %neg, %x
  ret i2 %r
}

define i2 @test_i2_nsw(i2 %x) {
  %neg = sub nsw i2 0, %x
  %r = add nsw i2 %x, %neg
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %neg = sub i1 0, %x
  %r = add i1 %x, %neg
  ret i1 %r
}

define i1 @test_i1_commuted(i1 %x) {
  %neg = sub i1 0, %x
  %r = add i1 %neg, %x
  ret i1 %r
}

; CHECK: 14 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
