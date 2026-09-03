; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules sub_zero %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; sub_zero

define i32 @test_i32(i32 %x) {
  %r = sub i32 %x, 0
  ret i32 %r
}

define i32 @test_i32_nsw(i32 %x) {
  %r = sub nsw i32 %x, 0
  ret i32 %r
}

define i32 @test_i32_nuw(i32 %x) {
  %r = sub nuw i32 %x, 0
  ret i32 %r
}

define i32 @test_i32_nsw_nuw(i32 %x) {
  %r = sub nsw nuw i32 %x, 0
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %r = sub nsw nuw i64 %x, 0
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %r = sub nsw nuw i128 %x, 0
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %r = sub nsw nuw i8 %x, 0
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %r = sub nsw nuw i7 %x, 0
  ret i7 %r
}

define i3 @test_i3(i3 %x) {
  %r = sub nsw nuw i3 %x, 0
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %r = sub i2 %x, 0
  ret i2 %r
}

define i2 @test_i2_nsw(i2 %x) {
  %r = sub nsw i2 %x, 0
  ret i2 %r
}

define i2 @test_i2_nuw(i2 %x) {
  %r = sub nuw i2 %x, 0
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %r = sub i1 %x, 0
  ret i1 %r
}

define i1 @test_i1_nsw(i1 %x) {
  %r = sub nsw i1 %x, 0
  ret i1 %r
}

define i1 @test_i1_nuw(i1 %x) {
  %r = sub nuw i1 %x, 0
  ret i1 %r
}

define i32 @test_chained(i32 %x) {
  %s1 = sub i32 %x, 0
  %s2 = sub i32 %s1, 0
  ret i32 %s2
}

; CHECK: Transformation seems to be correct!
