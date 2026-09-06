; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules subi-sdiv-mul-to-srem %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; subi-sdiv-mul-to-srem

define i64 @test_i64(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_comm(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %y, %m
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_2(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 2
  %m = mul i64 %q, 2
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i32 @test_i32(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i64 @test_i64_flags(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i3 @test_i3(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i8 @test_i8_neg(i8 %x, i8 %y) {
  %q = sdiv i8 %x, -4
  %m = mul i8 %q, -4
  %a = add i8 %m, %y
  %r = sub i8 %x, %a
  ret i8 %r
}

define i64 @test_i64_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_lhs(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 4, %q
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i2 @test_i2_sub_none_add_none_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_none_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_none_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_none_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_none_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_none_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_none_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_none_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nuw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nuw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nuw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nuw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nuw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nuw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nuw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nuw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_nuw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_nuw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_nuw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_nuw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_nuw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_nuw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_nuw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_none_add_nsw_nuw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_none_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_none_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_none_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_none_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_none_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_none_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_none_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_none_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nuw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nuw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nuw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nuw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nuw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nuw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nuw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nuw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_nuw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_nuw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_nuw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_nuw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_nuw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_nuw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_nuw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_add_nsw_nuw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_none_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_none_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_none_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_none_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_none_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_none_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_none_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_none_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nuw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nuw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nuw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nuw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nuw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nuw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nuw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nuw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_nuw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_nuw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_nuw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_nuw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_nuw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_nuw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_nuw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nuw_add_nsw_nuw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_none_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_none_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_none_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_none_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_none_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_none_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_none_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_none_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nuw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nuw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nuw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nuw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nuw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nuw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nuw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nuw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_nuw_mul_none(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_nuw_mul_none_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_nuw_mul_nsw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_nuw_mul_nsw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_nuw_mul_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_nuw_mul_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_nuw_mul_nsw_nuw(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_sub_nsw_nuw_add_nsw_nuw_mul_nsw_nuw_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_addcomm(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %y, %m
  %r = sub i2 %x, %a

  ret i2 %r
}

define i2 @test_i2_addcomm_allflags(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 %q, -2
  %a = add nsw nuw i2 %y, %m
  %r = sub nsw nuw i2 %x, %a

  ret i2 %r
}

define i2 @test_i2_mulswap(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 -2, %q
  %a = add i2 %m, %y
  %r = sub i2 %x, %a

  ret i2 %r
}

define i2 @test_i2_mulswap_allflags(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 -2, %q
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a

  ret i2 %r
}

define i2 @test_i2_bothswap(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul i2 -2, %q
  %a = add i2 %y, %m
  %r = sub i2 %x, %a

  ret i2 %r
}

define i2 @test_i2_bothswap_allflags(i2 %x, i2 %y) {
  %q = sdiv i2 %x, -2
  %m = mul nsw nuw i2 -2, %q
  %a = add nsw nuw i2 %y, %m
  %r = sub nsw nuw i2 %x, %a

  ret i2 %r
}

define i3 @test_i3_sub_none_add_none_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_none_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_none_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_none_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_none_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_none_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_none_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nuw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nuw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nuw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nuw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nuw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nuw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nuw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nuw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_nuw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_nuw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_nuw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_nuw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_nuw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_nuw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_nuw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_none_add_nsw_nuw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_none_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_none_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_none_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_none_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_none_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_none_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_none_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_none_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nuw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nuw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nuw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nuw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nuw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nuw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nuw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nuw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_nuw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_nuw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_nuw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_nuw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_nuw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_nuw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_nuw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_add_nsw_nuw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_none_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_none_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_none_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_none_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_none_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_none_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_none_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_none_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nuw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nuw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nuw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nuw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nuw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nuw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nuw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nuw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_nuw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_nuw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_nuw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_nuw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_nuw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_nuw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_nuw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nuw_add_nsw_nuw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_none_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_none_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_none_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_none_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_none_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_none_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_none_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_none_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nuw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nuw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nuw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nuw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nuw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nuw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nuw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nuw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_nuw_mul_none(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_nuw_mul_none_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_nuw_mul_nsw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_nuw_mul_nsw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_nuw_mul_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_nuw_mul_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_nuw_mul_nsw_nuw(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_sub_nsw_nuw_add_nsw_nuw_mul_nsw_nuw_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_addcomm(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %y, %m
  %r = sub i3 %x, %a

  ret i3 %r
}

define i3 @test_i3_addcomm_allflags(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 %q, 2
  %a = add nsw nuw i3 %y, %m
  %r = sub nsw nuw i3 %x, %a

  ret i3 %r
}

define i3 @test_i3_mulswap(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 2, %q
  %a = add i3 %m, %y
  %r = sub i3 %x, %a

  ret i3 %r
}

define i3 @test_i3_mulswap_allflags(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 2, %q
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a

  ret i3 %r
}

define i3 @test_i3_bothswap(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 2, %q
  %a = add i3 %y, %m
  %r = sub i3 %x, %a

  ret i3 %r
}

define i3 @test_i3_bothswap_allflags(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul nsw nuw i3 2, %q
  %a = add nsw nuw i3 %y, %m
  %r = sub nsw nuw i3 %x, %a

  ret i3 %r
}

define i32 @test_i32_sub_none_add_none_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_none_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_none_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_none_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_none_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_none_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_none_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nuw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nuw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nuw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nuw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nuw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nuw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nuw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nuw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_nuw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_nuw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_nuw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_nuw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_nuw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_nuw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_nuw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_none_add_nsw_nuw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_none_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_none_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_none_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_none_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_none_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_none_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_none_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_none_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nuw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nuw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nuw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nuw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nuw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nuw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nuw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nuw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_nuw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_nuw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_nuw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_nuw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_nuw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_nuw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_nuw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_add_nsw_nuw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_none_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_none_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_none_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_none_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_none_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_none_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_none_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_none_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nuw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nuw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nuw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nuw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nuw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nuw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nuw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nuw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_nuw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_nuw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_nuw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_nuw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_nuw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_nuw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_nuw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nuw_add_nsw_nuw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_none_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_none_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_none_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_none_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_none_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_none_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_none_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_none_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nuw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nuw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nuw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nuw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nuw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nuw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nuw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nuw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_nuw_mul_none(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_nuw_mul_none_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_nuw_mul_nsw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_nuw_mul_nsw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_nuw_mul_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_nuw_mul_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_nuw_mul_nsw_nuw(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_sub_nsw_nuw_add_nsw_nuw_mul_nsw_nuw_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_addcomm(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %y, %m
  %r = sub i32 %x, %a

  ret i32 %r
}

define i32 @test_i32_addcomm_allflags(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 %q, 4
  %a = add nsw nuw i32 %y, %m
  %r = sub nsw nuw i32 %x, %a

  ret i32 %r
}

define i32 @test_i32_mulswap(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 4, %q
  %a = add i32 %m, %y
  %r = sub i32 %x, %a

  ret i32 %r
}

define i32 @test_i32_mulswap_allflags(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 4, %q
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a

  ret i32 %r
}

define i32 @test_i32_bothswap(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 4, %q
  %a = add i32 %y, %m
  %r = sub i32 %x, %a

  ret i32 %r
}

define i32 @test_i32_bothswap_allflags(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul nsw nuw i32 4, %q
  %a = add nsw nuw i32 %y, %m
  %r = sub nsw nuw i32 %x, %a

  ret i32 %r
}

define i64 @test_i64_sub_none_add_none_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_none_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_none_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_none_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_none_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_none_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nuw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nuw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nuw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nuw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nuw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nuw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nuw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nuw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_nuw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_nuw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_nuw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_nuw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_nuw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_nuw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_nuw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_none_add_nsw_nuw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_none_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_none_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_none_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_none_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_none_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_none_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_none_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_none_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nuw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nuw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nuw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nuw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nuw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nuw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nuw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nuw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_nuw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_nuw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_nuw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_nuw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_nuw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_nuw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_nuw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_add_nsw_nuw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_none_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_none_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_none_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_none_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_none_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_none_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_none_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_none_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nuw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nuw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nuw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nuw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nuw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nuw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nuw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nuw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_nuw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_nuw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_nuw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_nuw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_nuw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_nuw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_nuw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nuw_add_nsw_nuw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_none_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_none_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_none_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_none_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_none_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_none_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_none_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_none_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nuw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nuw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nuw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nuw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nuw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nuw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nuw_mul_nsw_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nuw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_nuw_mul_none(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_nuw_mul_none_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_nuw_mul_nsw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_nuw_mul_nsw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_nuw_mul_nuw(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_nuw_mul_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_sub_nsw_nuw_add_nsw_nuw_mul_nsw_nuw_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_addcomm_allflags(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %y, %m
  %r = sub nsw nuw i64 %x, %a

  ret i64 %r
}

define i64 @test_i64_mulswap_allflags(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 4, %q
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a

  ret i64 %r
}

define i64 @test_i64_bothswap(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 4, %q
  %a = add i64 %y, %m
  %r = sub i64 %x, %a

  ret i64 %r
}

define i64 @test_i64_bothswap_allflags(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 4, %q
  %a = add nsw nuw i64 %y, %m
  %r = sub nsw nuw i64 %x, %a

  ret i64 %r
}

define i1 @test_i1_c1(i1 %x, i1 %y) {
  %q = sdiv i1 %x, 1
  %m = mul i1 %q, 1
  %a = add i1 %m, %y
  %r = sub i1 %x, %a
  ret i1 %r
}

define i1 @test_i1_c1_allflags(i1 %x, i1 %y) {
  %q = sdiv i1 %x, 1
  %m = mul nsw nuw i1 %q, 1
  %a = add nsw nuw i1 %m, %y
  %r = sub nsw nuw i1 %x, %a
  ret i1 %r
}

define i1 @test_i1_c1_exact(i1 %x, i1 %y) {
  %q = sdiv exact i1 %x, 1
  %m = mul i1 %q, 1
  %a = add i1 %m, %y
  %r = sub i1 %x, %a
  ret i1 %r
}

define i2 @test_i2_c1(i2 %x, i2 %y) {
  %q = sdiv i2 %x, 1
  %m = mul i2 %q, 1
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_c1_allflags(i2 %x, i2 %y) {
  %q = sdiv i2 %x, 1
  %m = mul nsw nuw i2 %q, 1
  %a = add nsw nuw i2 %m, %y
  %r = sub nsw nuw i2 %x, %a
  ret i2 %r
}

define i2 @test_i2_c1_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, 1
  %m = mul i2 %q, 1
  %a = add i2 %m, %y
  %r = sub i2 %x, %a
  ret i2 %r
}

define i3 @test_i3_c1(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 1
  %m = mul i3 %q, 1
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_c1_allflags(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 1
  %m = mul nsw nuw i3 %q, 1
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_c1_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 1
  %m = mul i3 %q, 1
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i32 @test_i32_c1(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 1
  %m = mul i32 %q, 1
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_c1_allflags(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 1
  %m = mul nsw nuw i32 %q, 1
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_c1_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 1
  %m = mul i32 %q, 1
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i64 @test_i64_c1(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 1
  %m = mul i64 %q, 1
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_c1_allflags(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 1
  %m = mul nsw nuw i64 %q, 1
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_c1_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 1
  %m = mul i64 %q, 1
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i3 @test_i3_cmin(i3 %x, i3 %y) {
  %q = sdiv i3 %x, -4
  %m = mul i3 %q, -4
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_cmin_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, -4
  %m = mul i3 %q, -4
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_cmin_allflags(i3 %x, i3 %y) {
  %q = sdiv i3 %x, -4
  %m = mul nsw nuw i3 %q, -4
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_cmax(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 3
  %m = mul i3 %q, 3
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_cmax_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 3
  %m = mul i3 %q, 3
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

define i3 @test_i3_cmax_allflags(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 3
  %m = mul nsw nuw i3 %q, 3
  %a = add nsw nuw i3 %m, %y
  %r = sub nsw nuw i3 %x, %a
  ret i3 %r
}

define i32 @test_i32_cmin(i32 %x, i32 %y) {
  %q = sdiv i32 %x, -2147483648
  %m = mul i32 %q, -2147483648
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_cmin_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, -2147483648
  %m = mul i32 %q, -2147483648
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_cmin_allflags(i32 %x, i32 %y) {
  %q = sdiv i32 %x, -2147483648
  %m = mul nsw nuw i32 %q, -2147483648
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_cmax(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 2147483647
  %m = mul i32 %q, 2147483647
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_cmax_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 2147483647
  %m = mul i32 %q, 2147483647
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_i32_cmax_allflags(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 2147483647
  %m = mul nsw nuw i32 %q, 2147483647
  %a = add nsw nuw i32 %m, %y
  %r = sub nsw nuw i32 %x, %a
  ret i32 %r
}

define i64 @test_i64_cmin(i64 %x, i64 %y) {
  %q = sdiv i64 %x, -9223372036854775808
  %m = mul i64 %q, -9223372036854775808
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_cmin_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, -9223372036854775808
  %m = mul i64 %q, -9223372036854775808
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_cmin_allflags(i64 %x, i64 %y) {
  %q = sdiv i64 %x, -9223372036854775808
  %m = mul nsw nuw i64 %q, -9223372036854775808
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_cmax(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 9223372036854775807
  %m = mul i64 %q, 9223372036854775807
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_cmax_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 9223372036854775807
  %m = mul i64 %q, 9223372036854775807
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

define i64 @test_i64_cmax_allflags(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 9223372036854775807
  %m = mul nsw nuw i64 %q, 9223372036854775807
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

define i32 @test_nofire_cmismatch(i32 %x, i32 %y) {
  %q = sdiv i32 %x, 4
  %m = mul i32 %q, 2
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i32 @test_nofire_neg1(i32 %x, i32 %y) {
  %q = sdiv i32 %x, -1
  %m = mul i32 %q, -1
  %a = add i32 %m, %y
  %r = sub i32 %x, %a
  ret i32 %r
}

define i1 @test_i1_neg1_nofire(i1 %x, i1 %y) {
  %q = sdiv i1 %x, -1
  %m = mul i1 %q, -1
  %a = add i1 %m, %y
  %r = sub i1 %x, %a
  ret i1 %r
}

define i2 @test_i2_addcomm_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 %q, -2
  %a = add i2 %y, %m
  %r = sub i2 %x, %a

  ret i2 %r
}

define i2 @test_i2_mulswap_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 -2, %q
  %a = add i2 %m, %y
  %r = sub i2 %x, %a

  ret i2 %r
}

define i2 @test_i2_bothswap_exact(i2 %x, i2 %y) {
  %q = sdiv exact i2 %x, -2
  %m = mul i2 -2, %q
  %a = add i2 %y, %m
  %r = sub i2 %x, %a

  ret i2 %r
}

define i3 @test_i3_addcomm_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %y, %m
  %r = sub i3 %x, %a

  ret i3 %r
}

define i3 @test_i3_mulswap_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 2, %q
  %a = add i3 %m, %y
  %r = sub i3 %x, %a

  ret i3 %r
}

define i3 @test_i3_bothswap_exact(i3 %x, i3 %y) {
  %q = sdiv exact i3 %x, 2
  %m = mul i3 2, %q
  %a = add i3 %y, %m
  %r = sub i3 %x, %a

  ret i3 %r
}

define i32 @test_i32_addcomm_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 %q, 4
  %a = add i32 %y, %m
  %r = sub i32 %x, %a

  ret i32 %r
}

define i32 @test_i32_mulswap_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 4, %q
  %a = add i32 %m, %y
  %r = sub i32 %x, %a

  ret i32 %r
}

define i32 @test_i32_bothswap_exact(i32 %x, i32 %y) {
  %q = sdiv exact i32 %x, 4
  %m = mul i32 4, %q
  %a = add i32 %y, %m
  %r = sub i32 %x, %a

  ret i32 %r
}

define i64 @test_i64_addcomm_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %y, %m
  %r = sub i64 %x, %a

  ret i64 %r
}

define i64 @test_i64_mulswap_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 4, %q
  %a = add i64 %m, %y
  %r = sub i64 %x, %a

  ret i64 %r
}

define i64 @test_i64_bothswap_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 4, %q
  %a = add i64 %y, %m
  %r = sub i64 %x, %a

  ret i64 %r
}


; CHECK: 586 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
