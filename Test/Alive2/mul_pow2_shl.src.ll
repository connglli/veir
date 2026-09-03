; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules mul_pow2_shl %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; mul_pow2_shl

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

; CHECK: 11 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
