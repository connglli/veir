; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules muli-two-to-addi %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; muli-two-to-addi

define i32 @test_i32(i32 %x) {
  %r = mul i32 %x, 2
  ret i32 %r
}

define i32 @test_i32_nsw(i32 %x) {
  %r = mul nsw i32 %x, 2
  ret i32 %r
}

define i32 @test_i32_nuw(i32 %x) {
  %r = mul nuw i32 %x, 2
  ret i32 %r
}

define i32 @test_i32_nsw_nuw(i32 %x) {
  %r = mul nsw nuw i32 %x, 2
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %r = mul nsw nuw i64 %x, 2
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %r = mul nsw nuw i128 %x, 2
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %r = mul nsw nuw i8 %x, 2
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %r = mul nsw nuw i7 %x, 2
  ret i7 %r
}

define i3 @test_i3_nsw(i3 %x) {
  %r = mul nsw i3 %x, 2
  ret i3 %r
}

define i3 @test_i3_nuw(i3 %x) {
  %r = mul nuw i3 %x, 2
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %r = mul i2 %x, 2
  ret i2 %r
}

define i2 @test_i2_nuw(i2 %x) {
  %r = mul nuw i2 %x, 2
  ret i2 %r
}

define i2 @test_i2_nsw(i2 %x) {
  %r = mul nsw i2 %x, 2
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %r = mul i1 %x, 2
  ret i1 %r
}

define i1 @test_i1_nuw(i1 %x) {
  %r = mul nuw i1 %x, 2
  ret i1 %r
}

define i32 @test_chained(i32 %x) {
  %m1 = mul i32 %x, 2
  %m2 = mul i32 %m1, 2
  ret i32 %m2
}

; CHECK: 16 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
