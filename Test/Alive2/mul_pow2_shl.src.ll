; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules muli-pow2-to-shl %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; muli-pow2-to-shl

define i32 @test_i32_4(i32 %x) {
  %r = mul i32 %x, 4
  ret i32 %r
}

define i32 @test_i32_8(i32 %x) {
  %r = mul i32 %x, 8
  ret i32 %r
}

define i32 @test_i32_nsw_4(i32 %x) {
  %r = mul nsw i32 %x, 4
  ret i32 %r
}

define i32 @test_i32_nuw_4(i32 %x) {
  %r = mul nuw i32 %x, 4
  ret i32 %r
}

define i64 @test_i64_16(i64 %x) {
  %r = mul i64 %x, 16
  ret i64 %r
}

define i64 @test_i64_nsw_nuw_4(i64 %x) {
  %r = mul nsw nuw i64 %x, 4
  ret i64 %r
}

define i8 @test_i8_4(i8 %x) {
  %r = mul i8 %x, 4
  ret i8 %r
}

define i3 @test_i3_2(i3 %x) {
  %r = mul i3 %x, 2
  ret i3 %r
}

define i3 @test_i3_nsw_preserve(i3 %x) {
  %r = mul nsw i3 %x, 2
  ret i3 %r
}

define i8 @test_i8_nsw_nuw_preserve(i8 %x) {
  %r = mul nsw nuw i8 %x, 64
  ret i8 %r
}

define i32 @test_i32_lhs(i32 %x) {
  %r = mul i32 16, %x
  ret i32 %r
}

define i2 @test_i2_2_none(i2 %x) {
  %r = mul i2 %x, 2
  ret i2 %r
}

define i2 @test_i2_2_nsw(i2 %x) {
  %r = mul nsw i2 %x, 2
  ret i2 %r
}

define i2 @test_i2_2_nuw(i2 %x) {
  %r = mul nuw i2 %x, 2
  ret i2 %r
}

define i2 @test_i2_2_nsw_nuw(i2 %x) {
  %r = mul nsw nuw i2 %x, 2
  ret i2 %r
}

define i3 @test_i3_2_nuw(i3 %x) {
  %r = mul nuw i3 %x, 2
  ret i3 %r
}

define i3 @test_i3_2_nsw_nuw(i3 %x) {
  %r = mul nsw nuw i3 %x, 2
  ret i3 %r
}

define i32 @test_i32_4_nsw_nuw(i32 %x) {
  %r = mul nsw nuw i32 %x, 4
  ret i32 %r
}

define i64 @test_i64_16_nsw(i64 %x) {
  %r = mul nsw i64 %x, 16
  ret i64 %r
}

define i64 @test_i64_16_nuw(i64 %x) {
  %r = mul nuw i64 %x, 16
  ret i64 %r
}

define i64 @test_i64_16_nsw_nuw(i64 %x) {
  %r = mul nsw nuw i64 %x, 16
  ret i64 %r
}

define i1 @test_i1_1_none(i1 %x) {
  %r = mul i1 %x, 1
  ret i1 %r
}

define i1 @test_i1_1_nsw_nuw(i1 %x) {
  %r = mul nsw nuw i1 %x, 1
  ret i1 %r
}

define i32 @test_i32_maxk(i32 %x) {
  %r = mul i32 %x, 1073741824
  ret i32 %r
}

define i32 @test_i32_maxk_nsw_nuw(i32 %x) {
  %r = mul nsw nuw i32 %x, 1073741824
  ret i32 %r
}

define i64 @test_i64_maxk(i64 %x) {
  %r = mul i64 %x, 4611686018427387904
  ret i64 %r
}

define i64 @test_i64_maxk_nsw_nuw(i64 %x) {
  %r = mul nsw nuw i64 %x, 4611686018427387904
  ret i64 %r
}

define i2 @test_i2_lhs(i2 %x) {
  %r = mul i2 2, %x
  ret i2 %r
}

define i3 @test_i3_lhs(i3 %x) {
  %r = mul i3 2, %x
  ret i3 %r
}

define i64 @test_i64_lhs(i64 %x) {
  %r = mul i64 16, %x
  ret i64 %r
}

define i32 @test_i32_lhs_nsw_nuw(i32 %x) {
  %r = mul nsw nuw i32 16, %x
  ret i32 %r
}

define i32 @test_i32_neg4_nofire(i32 %x) {
  %r = mul i32 %x, -4
  ret i32 %r
}


; CHECK: 32 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
