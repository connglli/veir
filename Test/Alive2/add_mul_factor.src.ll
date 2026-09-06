; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules addi-mul-factor %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; addi-mul-factor

define i64 @test_shl(i64 %x) {
  %a = mul i64 %x, 9
  %s = shl i64 %x, 8
  %r = add i64 %a, %s
  ret i64 %r
}

define i32 @test_mul(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i64 @test_add(i64 %x) {
  %a = mul i64 %x, 8
  %r = add i64 %x, %a
  ret i64 %r
}

define i64 @test_nsw_nuw(i64 %x) {
  %a = mul nsw nuw i64 %x, 9
  %s = shl i64 %x, 8
  %r = add nsw nuw i64 %a, %s
  ret i64 %r
}

define i32 @test_i32_nsw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i3 @test_i3_wrap(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i2 @test_i2_wrap(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i32 @test_i32_neg(i32 %x) {
  %a = mul i32 %x, -1
  %b = mul i32 %x, 1
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_flags_preserve(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = shl nsw i32 %x, 2
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i1 @test_i1_add_none_lhs_none_rhs_none(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_none_rhs_nsw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_none_rhs_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_none_rhs_nsw_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nsw_rhs_none(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nsw_rhs_nsw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nsw_rhs_nuw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nsw_rhs_nsw_nuw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nuw_rhs_none(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nuw_rhs_nsw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nuw_rhs_nuw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nuw_rhs_nsw_nuw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nsw_nuw_rhs_none(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nsw_nuw_rhs_nsw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nsw_nuw_rhs_nuw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_none_lhs_nsw_nuw_rhs_nsw_nuw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_none_rhs_none(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_none_rhs_nsw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_none_rhs_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_none_rhs_nsw_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nsw_rhs_none(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nsw_rhs_nsw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nsw_rhs_nuw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nsw_rhs_nsw_nuw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nuw_rhs_none(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nuw_rhs_nsw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nuw_rhs_nuw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nuw_rhs_nsw_nuw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nsw_nuw_rhs_none(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nsw_nuw_rhs_nsw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nsw_nuw_rhs_nuw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_lhs_nsw_nuw_rhs_nsw_nuw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_none_rhs_none(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_none_rhs_nsw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_none_rhs_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_none_rhs_nsw_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nsw_rhs_none(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nsw_rhs_nsw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nsw_rhs_nuw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nsw_rhs_nsw_nuw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nuw_rhs_none(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nuw_rhs_nsw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nuw_rhs_nuw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nuw_rhs_nsw_nuw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nsw_nuw_rhs_none(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nsw_nuw_rhs_nsw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nsw_nuw_rhs_nuw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_none_rhs_none(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_none_rhs_nsw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_none_rhs_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_none_rhs_nsw_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nsw_rhs_none(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nsw_rhs_nsw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nsw_rhs_nuw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nsw_rhs_nsw_nuw(i1 %x) {
  %a = mul nsw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nuw_rhs_none(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nuw_rhs_nsw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nuw_rhs_nuw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nuw_rhs_nsw_nuw(i1 %x) {
  %a = mul nuw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nsw_nuw_rhs_none(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nsw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nsw_nuw_rhs_nuw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nuw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i1 %x) {
  %a = mul nsw nuw i1 %x, -1
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i2 @test_i2_add_none_lhs_none_rhs_none(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_none_rhs_nsw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_none_rhs_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_none_rhs_nsw_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nsw_rhs_none(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nsw_rhs_nsw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nsw_rhs_nuw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nsw_rhs_nsw_nuw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nuw_rhs_none(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nuw_rhs_nsw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nuw_rhs_nuw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nuw_rhs_nsw_nuw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nsw_nuw_rhs_none(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nsw_nuw_rhs_nsw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nsw_nuw_rhs_nuw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_none_lhs_nsw_nuw_rhs_nsw_nuw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_none_rhs_none(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_none_rhs_nsw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_none_rhs_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_none_rhs_nsw_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nsw_rhs_none(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nsw_rhs_nsw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nsw_rhs_nuw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nsw_rhs_nsw_nuw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nuw_rhs_none(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nuw_rhs_nsw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nuw_rhs_nuw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nuw_rhs_nsw_nuw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nsw_nuw_rhs_none(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nsw_nuw_rhs_nsw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nsw_nuw_rhs_nuw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_lhs_nsw_nuw_rhs_nsw_nuw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_none_rhs_none(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_none_rhs_nsw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_none_rhs_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_none_rhs_nsw_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nsw_rhs_none(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nsw_rhs_nsw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nsw_rhs_nuw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nsw_rhs_nsw_nuw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nuw_rhs_none(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nuw_rhs_nsw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nuw_rhs_nuw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nuw_rhs_nsw_nuw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nsw_nuw_rhs_none(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nsw_nuw_rhs_nsw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nsw_nuw_rhs_nuw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_none_rhs_none(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_none_rhs_nsw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_none_rhs_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_none_rhs_nsw_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nsw_rhs_none(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nsw_rhs_nsw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nsw_rhs_nuw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nsw_rhs_nsw_nuw(i2 %x) {
  %a = mul nsw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nuw_rhs_none(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nuw_rhs_nsw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nuw_rhs_nuw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nuw_rhs_nsw_nuw(i2 %x) {
  %a = mul nuw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nsw_nuw_rhs_none(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nsw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nsw_nuw_rhs_nuw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nuw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i2 %x) {
  %a = mul nsw nuw i2 %x, -2
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i3 @test_i3_add_none_lhs_none_rhs_none(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_none_rhs_nsw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_none_rhs_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_none_rhs_nsw_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nsw_rhs_none(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nsw_rhs_nsw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nsw_rhs_nuw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nsw_rhs_nsw_nuw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nuw_rhs_none(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nuw_rhs_nsw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nuw_rhs_nuw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nuw_rhs_nsw_nuw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nsw_nuw_rhs_none(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nsw_nuw_rhs_nsw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nsw_nuw_rhs_nuw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_none_lhs_nsw_nuw_rhs_nsw_nuw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_none_rhs_none(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_none_rhs_nsw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_none_rhs_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_none_rhs_nsw_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nsw_rhs_none(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nsw_rhs_nsw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nsw_rhs_nuw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nsw_rhs_nsw_nuw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nuw_rhs_none(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nuw_rhs_nsw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nuw_rhs_nuw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nuw_rhs_nsw_nuw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nsw_nuw_rhs_none(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nsw_nuw_rhs_nsw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nsw_nuw_rhs_nuw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_lhs_nsw_nuw_rhs_nsw_nuw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_none_rhs_none(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_none_rhs_nsw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_none_rhs_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_none_rhs_nsw_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nsw_rhs_none(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nsw_rhs_nsw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nsw_rhs_nuw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nsw_rhs_nsw_nuw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nuw_rhs_none(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nuw_rhs_nsw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nuw_rhs_nuw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nuw_rhs_nsw_nuw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nsw_nuw_rhs_none(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nsw_nuw_rhs_nsw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nsw_nuw_rhs_nuw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_none_rhs_none(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_none_rhs_nsw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_none_rhs_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_none_rhs_nsw_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nsw_rhs_none(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nsw_rhs_nsw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nsw_rhs_nuw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nsw_rhs_nsw_nuw(i3 %x) {
  %a = mul nsw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nuw_rhs_none(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nuw_rhs_nsw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nuw_rhs_nuw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nuw_rhs_nsw_nuw(i3 %x) {
  %a = mul nuw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nsw_nuw_rhs_none(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nsw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nsw_nuw_rhs_nuw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nuw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i3 %x) {
  %a = mul nsw nuw i3 %x, 3
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i32 @test_i32_add_none_lhs_none_rhs_nsw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_none_rhs_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_none_rhs_nsw_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nsw_rhs_none(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nsw_rhs_nsw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nsw_rhs_nuw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nsw_rhs_nsw_nuw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nuw_rhs_none(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nuw_rhs_nsw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nuw_rhs_nuw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nuw_rhs_nsw_nuw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nsw_nuw_rhs_none(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nsw_nuw_rhs_nsw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nsw_nuw_rhs_nuw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_none_lhs_nsw_nuw_rhs_nsw_nuw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_none_rhs_none(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_none_rhs_nsw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_none_rhs_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_none_rhs_nsw_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nsw_rhs_none(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nsw_rhs_nuw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nsw_rhs_nsw_nuw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nuw_rhs_none(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nuw_rhs_nsw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nuw_rhs_nuw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nuw_rhs_nsw_nuw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nsw_nuw_rhs_none(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nsw_nuw_rhs_nsw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nsw_nuw_rhs_nuw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_lhs_nsw_nuw_rhs_nsw_nuw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_none_rhs_none(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_none_rhs_nsw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_none_rhs_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_none_rhs_nsw_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nsw_rhs_none(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nsw_rhs_nsw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nsw_rhs_nuw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nsw_rhs_nsw_nuw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nuw_rhs_none(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nuw_rhs_nsw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nuw_rhs_nuw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nuw_rhs_nsw_nuw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nsw_nuw_rhs_none(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nsw_nuw_rhs_nsw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nsw_nuw_rhs_nuw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_none_rhs_none(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_none_rhs_nsw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_none_rhs_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_none_rhs_nsw_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nsw_rhs_none(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nsw_rhs_nsw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nsw_rhs_nuw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nsw_rhs_nsw_nuw(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nuw_rhs_none(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nuw_rhs_nsw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nuw_rhs_nuw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nuw_rhs_nsw_nuw(i32 %x) {
  %a = mul nuw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nsw_nuw_rhs_none(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nsw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nsw_nuw_rhs_nuw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nuw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i32 %x) {
  %a = mul nsw nuw i32 %x, 3
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i64 @test_i64_add_none_lhs_none_rhs_none(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_none_rhs_nsw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_none_rhs_nuw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_none_rhs_nsw_nuw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nsw_rhs_none(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nsw_rhs_nsw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nsw_rhs_nuw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nsw_rhs_nsw_nuw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nuw_rhs_none(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nuw_rhs_nsw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nuw_rhs_nuw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nuw_rhs_nsw_nuw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nsw_nuw_rhs_none(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nsw_nuw_rhs_nsw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nsw_nuw_rhs_nuw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_none_lhs_nsw_nuw_rhs_nsw_nuw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_none_rhs_none(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_none_rhs_nsw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_none_rhs_nuw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_none_rhs_nsw_nuw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nsw_rhs_none(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nsw_rhs_nsw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nsw_rhs_nuw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nsw_rhs_nsw_nuw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nuw_rhs_none(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nuw_rhs_nsw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nuw_rhs_nuw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nuw_rhs_nsw_nuw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nsw_nuw_rhs_none(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nsw_nuw_rhs_nsw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nsw_nuw_rhs_nuw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_lhs_nsw_nuw_rhs_nsw_nuw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_none_rhs_none(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_none_rhs_nsw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_none_rhs_nuw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_none_rhs_nsw_nuw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nsw_rhs_none(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nsw_rhs_nsw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nsw_rhs_nuw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nsw_rhs_nsw_nuw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nuw_rhs_none(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nuw_rhs_nsw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nuw_rhs_nuw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nuw_rhs_nsw_nuw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nsw_nuw_rhs_none(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nsw_nuw_rhs_nsw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nsw_nuw_rhs_nuw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_none_rhs_none(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_none_rhs_nsw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_none_rhs_nuw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_none_rhs_nsw_nuw(i64 %x) {
  %a = mul i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nsw_rhs_none(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nsw_rhs_nsw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nsw_rhs_nuw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nsw_rhs_nsw_nuw(i64 %x) {
  %a = mul nsw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nuw_rhs_none(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nuw_rhs_nsw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nuw_rhs_nuw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nuw_rhs_nsw_nuw(i64 %x) {
  %a = mul nuw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nsw_nuw_rhs_none(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nsw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nsw_nuw_rhs_nuw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nuw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_add_nsw_nuw_lhs_nsw_nuw_rhs_nsw_nuw(i64 %x) {
  %a = mul nsw nuw i64 %x, 3
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i1 @test_i1_shl_add_none(i1 %x) {
  %a = mul i1 %x, -1
  %s = shl i1 %x, 0
  %r = add i1 %a, %s
  ret i1 %r
}

define i1 @test_i1_shl_add_nsw(i1 %x) {
  %a = mul i1 %x, -1
  %s = shl i1 %x, 0
  %r = add nsw i1 %a, %s
  ret i1 %r
}

define i1 @test_i1_shl_add_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %s = shl i1 %x, 0
  %r = add nuw i1 %a, %s
  ret i1 %r
}

define i1 @test_i1_shl_add_nsw_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %s = shl i1 %x, 0
  %r = add nsw nuw i1 %a, %s
  ret i1 %r
}

define i2 @test_i2_shl_add_none(i2 %x) {
  %a = mul i2 %x, -2
  %s = shl i2 %x, 1
  %r = add i2 %a, %s
  ret i2 %r
}

define i2 @test_i2_shl_add_nsw(i2 %x) {
  %a = mul i2 %x, -2
  %s = shl i2 %x, 1
  %r = add nsw i2 %a, %s
  ret i2 %r
}

define i2 @test_i2_shl_add_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %s = shl i2 %x, 1
  %r = add nuw i2 %a, %s
  ret i2 %r
}

define i2 @test_i2_shl_add_nsw_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %s = shl i2 %x, 1
  %r = add nsw nuw i2 %a, %s
  ret i2 %r
}

define i3 @test_i3_shl_add_none(i3 %x) {
  %a = mul i3 %x, 3
  %s = shl i3 %x, 2
  %r = add i3 %a, %s
  ret i3 %r
}

define i3 @test_i3_shl_add_nsw(i3 %x) {
  %a = mul i3 %x, 3
  %s = shl i3 %x, 2
  %r = add nsw i3 %a, %s
  ret i3 %r
}

define i3 @test_i3_shl_add_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %s = shl i3 %x, 2
  %r = add nuw i3 %a, %s
  ret i3 %r
}

define i3 @test_i3_shl_add_nsw_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %s = shl i3 %x, 2
  %r = add nsw nuw i3 %a, %s
  ret i3 %r
}

define i32 @test_i32_shl_add_none(i32 %x) {
  %a = mul i32 %x, 3
  %s = shl i32 %x, 2
  %r = add i32 %a, %s
  ret i32 %r
}

define i32 @test_i32_shl_add_nsw(i32 %x) {
  %a = mul i32 %x, 3
  %s = shl i32 %x, 2
  %r = add nsw i32 %a, %s
  ret i32 %r
}

define i32 @test_i32_shl_add_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %s = shl i32 %x, 2
  %r = add nuw i32 %a, %s
  ret i32 %r
}

define i32 @test_i32_shl_add_nsw_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %s = shl i32 %x, 2
  %r = add nsw nuw i32 %a, %s
  ret i32 %r
}

define i64 @test_i64_shl_add_nsw(i64 %x) {
  %a = mul i64 %x, 9
  %s = shl i64 %x, 8
  %r = add nsw i64 %a, %s
  ret i64 %r
}

define i64 @test_i64_shl_add_nuw(i64 %x) {
  %a = mul i64 %x, 9
  %s = shl i64 %x, 8
  %r = add nuw i64 %a, %s
  ret i64 %r
}

define i64 @test_i64_shl_add_nsw_nuw(i64 %x) {
  %a = mul i64 %x, 9
  %s = shl i64 %x, 8
  %r = add nsw nuw i64 %a, %s
  ret i64 %r
}

define i1 @test_i1_lhsx_add_none_mul_none(i1 %x) {
  %b = mul i1 %x, -1
  %r = add i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_none_mul_nsw(i1 %x) {
  %b = mul nsw i1 %x, -1
  %r = add i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_none_mul_nuw(i1 %x) {
  %b = mul nuw i1 %x, -1
  %r = add i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_none_mul_nsw_nuw(i1 %x) {
  %b = mul nsw nuw i1 %x, -1
  %r = add i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nsw_mul_none(i1 %x) {
  %b = mul i1 %x, -1
  %r = add nsw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nsw_mul_nsw(i1 %x) {
  %b = mul nsw i1 %x, -1
  %r = add nsw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nsw_mul_nuw(i1 %x) {
  %b = mul nuw i1 %x, -1
  %r = add nsw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nsw_mul_nsw_nuw(i1 %x) {
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nuw_mul_none(i1 %x) {
  %b = mul i1 %x, -1
  %r = add nuw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nuw_mul_nsw(i1 %x) {
  %b = mul nsw i1 %x, -1
  %r = add nuw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nuw_mul_nuw(i1 %x) {
  %b = mul nuw i1 %x, -1
  %r = add nuw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nuw_mul_nsw_nuw(i1 %x) {
  %b = mul nsw nuw i1 %x, -1
  %r = add nuw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nsw_nuw_mul_none(i1 %x) {
  %b = mul i1 %x, -1
  %r = add nsw nuw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nsw_nuw_mul_nsw(i1 %x) {
  %b = mul nsw i1 %x, -1
  %r = add nsw nuw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nsw_nuw_mul_nuw(i1 %x) {
  %b = mul nuw i1 %x, -1
  %r = add nsw nuw i1 %x, %b
  ret i1 %r
}

define i1 @test_i1_lhsx_add_nsw_nuw_mul_nsw_nuw(i1 %x) {
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw nuw i1 %x, %b
  ret i1 %r
}

define i2 @test_i2_lhsx_add_none_mul_none(i2 %x) {
  %b = mul i2 %x, -2
  %r = add i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_none_mul_nsw(i2 %x) {
  %b = mul nsw i2 %x, -2
  %r = add i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_none_mul_nuw(i2 %x) {
  %b = mul nuw i2 %x, -2
  %r = add i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_none_mul_nsw_nuw(i2 %x) {
  %b = mul nsw nuw i2 %x, -2
  %r = add i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nsw_mul_none(i2 %x) {
  %b = mul i2 %x, -2
  %r = add nsw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nsw_mul_nsw(i2 %x) {
  %b = mul nsw i2 %x, -2
  %r = add nsw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nsw_mul_nuw(i2 %x) {
  %b = mul nuw i2 %x, -2
  %r = add nsw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nsw_mul_nsw_nuw(i2 %x) {
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nuw_mul_none(i2 %x) {
  %b = mul i2 %x, -2
  %r = add nuw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nuw_mul_nsw(i2 %x) {
  %b = mul nsw i2 %x, -2
  %r = add nuw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nuw_mul_nuw(i2 %x) {
  %b = mul nuw i2 %x, -2
  %r = add nuw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nuw_mul_nsw_nuw(i2 %x) {
  %b = mul nsw nuw i2 %x, -2
  %r = add nuw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nsw_nuw_mul_none(i2 %x) {
  %b = mul i2 %x, -2
  %r = add nsw nuw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nsw_nuw_mul_nsw(i2 %x) {
  %b = mul nsw i2 %x, -2
  %r = add nsw nuw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nsw_nuw_mul_nuw(i2 %x) {
  %b = mul nuw i2 %x, -2
  %r = add nsw nuw i2 %x, %b
  ret i2 %r
}

define i2 @test_i2_lhsx_add_nsw_nuw_mul_nsw_nuw(i2 %x) {
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw nuw i2 %x, %b
  ret i2 %r
}

define i3 @test_i3_lhsx_add_none_mul_none(i3 %x) {
  %b = mul i3 %x, 5
  %r = add i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_none_mul_nsw(i3 %x) {
  %b = mul nsw i3 %x, 5
  %r = add i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_none_mul_nuw(i3 %x) {
  %b = mul nuw i3 %x, 5
  %r = add i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_none_mul_nsw_nuw(i3 %x) {
  %b = mul nsw nuw i3 %x, 5
  %r = add i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nsw_mul_none(i3 %x) {
  %b = mul i3 %x, 5
  %r = add nsw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nsw_mul_nsw(i3 %x) {
  %b = mul nsw i3 %x, 5
  %r = add nsw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nsw_mul_nuw(i3 %x) {
  %b = mul nuw i3 %x, 5
  %r = add nsw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nsw_mul_nsw_nuw(i3 %x) {
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nuw_mul_none(i3 %x) {
  %b = mul i3 %x, 5
  %r = add nuw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nuw_mul_nsw(i3 %x) {
  %b = mul nsw i3 %x, 5
  %r = add nuw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nuw_mul_nuw(i3 %x) {
  %b = mul nuw i3 %x, 5
  %r = add nuw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nuw_mul_nsw_nuw(i3 %x) {
  %b = mul nsw nuw i3 %x, 5
  %r = add nuw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nsw_nuw_mul_none(i3 %x) {
  %b = mul i3 %x, 5
  %r = add nsw nuw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nsw_nuw_mul_nsw(i3 %x) {
  %b = mul nsw i3 %x, 5
  %r = add nsw nuw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nsw_nuw_mul_nuw(i3 %x) {
  %b = mul nuw i3 %x, 5
  %r = add nsw nuw i3 %x, %b
  ret i3 %r
}

define i3 @test_i3_lhsx_add_nsw_nuw_mul_nsw_nuw(i3 %x) {
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw nuw i3 %x, %b
  ret i3 %r
}

define i32 @test_i32_lhsx_add_none_mul_none(i32 %x) {
  %b = mul i32 %x, 5
  %r = add i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_none_mul_nsw(i32 %x) {
  %b = mul nsw i32 %x, 5
  %r = add i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_none_mul_nuw(i32 %x) {
  %b = mul nuw i32 %x, 5
  %r = add i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_none_mul_nsw_nuw(i32 %x) {
  %b = mul nsw nuw i32 %x, 5
  %r = add i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nsw_mul_none(i32 %x) {
  %b = mul i32 %x, 5
  %r = add nsw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nsw_mul_nsw(i32 %x) {
  %b = mul nsw i32 %x, 5
  %r = add nsw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nsw_mul_nuw(i32 %x) {
  %b = mul nuw i32 %x, 5
  %r = add nsw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nsw_mul_nsw_nuw(i32 %x) {
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nuw_mul_none(i32 %x) {
  %b = mul i32 %x, 5
  %r = add nuw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nuw_mul_nsw(i32 %x) {
  %b = mul nsw i32 %x, 5
  %r = add nuw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nuw_mul_nuw(i32 %x) {
  %b = mul nuw i32 %x, 5
  %r = add nuw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nuw_mul_nsw_nuw(i32 %x) {
  %b = mul nsw nuw i32 %x, 5
  %r = add nuw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nsw_nuw_mul_none(i32 %x) {
  %b = mul i32 %x, 5
  %r = add nsw nuw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nsw_nuw_mul_nsw(i32 %x) {
  %b = mul nsw i32 %x, 5
  %r = add nsw nuw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nsw_nuw_mul_nuw(i32 %x) {
  %b = mul nuw i32 %x, 5
  %r = add nsw nuw i32 %x, %b
  ret i32 %r
}

define i32 @test_i32_lhsx_add_nsw_nuw_mul_nsw_nuw(i32 %x) {
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw nuw i32 %x, %b
  ret i32 %r
}

define i64 @test_i64_lhsx_add_none_mul_none(i64 %x) {
  %b = mul i64 %x, 5
  %r = add i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_none_mul_nsw(i64 %x) {
  %b = mul nsw i64 %x, 5
  %r = add i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_none_mul_nuw(i64 %x) {
  %b = mul nuw i64 %x, 5
  %r = add i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_none_mul_nsw_nuw(i64 %x) {
  %b = mul nsw nuw i64 %x, 5
  %r = add i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nsw_mul_none(i64 %x) {
  %b = mul i64 %x, 5
  %r = add nsw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nsw_mul_nsw(i64 %x) {
  %b = mul nsw i64 %x, 5
  %r = add nsw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nsw_mul_nuw(i64 %x) {
  %b = mul nuw i64 %x, 5
  %r = add nsw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nsw_mul_nsw_nuw(i64 %x) {
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nuw_mul_none(i64 %x) {
  %b = mul i64 %x, 5
  %r = add nuw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nuw_mul_nsw(i64 %x) {
  %b = mul nsw i64 %x, 5
  %r = add nuw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nuw_mul_nuw(i64 %x) {
  %b = mul nuw i64 %x, 5
  %r = add nuw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nuw_mul_nsw_nuw(i64 %x) {
  %b = mul nsw nuw i64 %x, 5
  %r = add nuw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nsw_nuw_mul_none(i64 %x) {
  %b = mul i64 %x, 5
  %r = add nsw nuw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nsw_nuw_mul_nsw(i64 %x) {
  %b = mul nsw i64 %x, 5
  %r = add nsw nuw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nsw_nuw_mul_nuw(i64 %x) {
  %b = mul nuw i64 %x, 5
  %r = add nsw nuw i64 %x, %b
  ret i64 %r
}

define i64 @test_i64_lhsx_add_nsw_nuw_mul_nsw_nuw(i64 %x) {
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw nuw i64 %x, %b
  ret i64 %r
}

define i1 @test_i1_mullhs(i1 %x) {
  %a = mul i1 -1, %x
  %b = mul i1 %x, -1
  %r = add i1 %a, %b
  ret i1 %r
}

define i1 @test_i1_mullhs_allflags(i1 %x) {
  %a = mul nsw nuw i1 -1, %x
  %b = mul nsw nuw i1 %x, -1
  %r = add nsw nuw i1 %a, %b
  ret i1 %r
}

define i2 @test_i2_mullhs(i2 %x) {
  %a = mul i2 -2, %x
  %b = mul i2 %x, -2
  %r = add i2 %a, %b
  ret i2 %r
}

define i2 @test_i2_mullhs_allflags(i2 %x) {
  %a = mul nsw nuw i2 -2, %x
  %b = mul nsw nuw i2 %x, -2
  %r = add nsw nuw i2 %a, %b
  ret i2 %r
}

define i3 @test_i3_mullhs(i3 %x) {
  %a = mul i3 3, %x
  %b = mul i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

define i3 @test_i3_mullhs_allflags(i3 %x) {
  %a = mul nsw nuw i3 3, %x
  %b = mul nsw nuw i3 %x, 5
  %r = add nsw nuw i3 %a, %b
  ret i3 %r
}

define i32 @test_i32_mullhs(i32 %x) {
  %a = mul i32 3, %x
  %b = mul i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i32 @test_i32_mullhs_allflags(i32 %x) {
  %a = mul nsw nuw i32 3, %x
  %b = mul nsw nuw i32 %x, 5
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

define i64 @test_i64_mullhs(i64 %x) {
  %a = mul i64 3, %x
  %b = mul i64 %x, 5
  %r = add i64 %a, %b
  ret i64 %r
}

define i64 @test_i64_mullhs_allflags(i64 %x) {
  %a = mul nsw nuw i64 3, %x
  %b = mul nsw nuw i64 %x, 5
  %r = add nsw nuw i64 %a, %b
  ret i64 %r
}

define i32 @test_nofire_base(i32 %x, i32 %y) {
  %a = mul i32 %x, 3
  %b = mul i32 %y, 5
  %r = add i32 %a, %b
  ret i32 %r
}

define i1 @test_i1_shl_none(i1 %x) {
  %a = mul i1 %x, -1
  %s = shl i1 %x, 0
  %r = add i1 %a, %s
  ret i1 %r
}

define i1 @test_i1_shl_nsw(i1 %x) {
  %a = mul i1 %x, -1
  %s = shl nsw i1 %x, 0
  %r = add i1 %a, %s
  ret i1 %r
}

define i1 @test_i1_shl_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %s = shl nuw i1 %x, 0
  %r = add i1 %a, %s
  ret i1 %r
}

define i1 @test_i1_shl_nsw_nuw(i1 %x) {
  %a = mul i1 %x, -1
  %s = shl nsw nuw i1 %x, 0
  %r = add i1 %a, %s
  ret i1 %r
}

define i2 @test_i2_shl_none(i2 %x) {
  %a = mul i2 %x, -2
  %s = shl i2 %x, 1
  %r = add i2 %a, %s
  ret i2 %r
}

define i2 @test_i2_shl_nsw(i2 %x) {
  %a = mul i2 %x, -2
  %s = shl nsw i2 %x, 1
  %r = add i2 %a, %s
  ret i2 %r
}

define i2 @test_i2_shl_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %s = shl nuw i2 %x, 1
  %r = add i2 %a, %s
  ret i2 %r
}

define i2 @test_i2_shl_nsw_nuw(i2 %x) {
  %a = mul i2 %x, -2
  %s = shl nsw nuw i2 %x, 1
  %r = add i2 %a, %s
  ret i2 %r
}

define i3 @test_i3_shl_none(i3 %x) {
  %a = mul i3 %x, 3
  %s = shl i3 %x, 2
  %r = add i3 %a, %s
  ret i3 %r
}

define i3 @test_i3_shl_nsw(i3 %x) {
  %a = mul i3 %x, 3
  %s = shl nsw i3 %x, 2
  %r = add i3 %a, %s
  ret i3 %r
}

define i3 @test_i3_shl_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %s = shl nuw i3 %x, 2
  %r = add i3 %a, %s
  ret i3 %r
}

define i3 @test_i3_shl_nsw_nuw(i3 %x) {
  %a = mul i3 %x, 3
  %s = shl nsw nuw i3 %x, 2
  %r = add i3 %a, %s
  ret i3 %r
}

define i32 @test_i32_shl_none(i32 %x) {
  %a = mul i32 %x, 3
  %s = shl i32 %x, 2
  %r = add i32 %a, %s
  ret i32 %r
}

define i32 @test_i32_shl_nsw(i32 %x) {
  %a = mul i32 %x, 3
  %s = shl nsw i32 %x, 2
  %r = add i32 %a, %s
  ret i32 %r
}

define i32 @test_i32_shl_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %s = shl nuw i32 %x, 2
  %r = add i32 %a, %s
  ret i32 %r
}

define i32 @test_i32_shl_nsw_nuw(i32 %x) {
  %a = mul i32 %x, 3
  %s = shl nsw nuw i32 %x, 2
  %r = add i32 %a, %s
  ret i32 %r
}

define i64 @test_i64_shl_none(i64 %x) {
  %a = mul i64 %x, 9
  %s = shl i64 %x, 8
  %r = add i64 %a, %s
  ret i64 %r
}

define i64 @test_i64_shl_nsw(i64 %x) {
  %a = mul i64 %x, 9
  %s = shl nsw i64 %x, 8
  %r = add i64 %a, %s
  ret i64 %r
}

define i64 @test_i64_shl_nuw(i64 %x) {
  %a = mul i64 %x, 9
  %s = shl nuw i64 %x, 8
  %r = add i64 %a, %s
  ret i64 %r
}

define i64 @test_i64_shl_nsw_nuw(i64 %x) {
  %a = mul i64 %x, 9
  %s = shl nsw nuw i64 %x, 8
  %r = add i64 %a, %s
  ret i64 %r
}

define i2 @test_i2_shlshl(i2 %x) {
  %s1 = shl i2 %x, 1
  %s2 = shl i2 %x, 0
  %r = add i2 %s1, %s2
  ret i2 %r
}

define i2 @test_i2_shlshl_allflags(i2 %x) {
  %s1 = shl nsw nuw i2 %x, 1
  %s2 = shl nsw nuw i2 %x, 0
  %r = add nsw nuw i2 %s1, %s2
  ret i2 %r
}

define i3 @test_i3_shlshl(i3 %x) {
  %s1 = shl i3 %x, 1
  %s2 = shl i3 %x, 2
  %r = add i3 %s1, %s2
  ret i3 %r
}

define i3 @test_i3_shlshl_allflags(i3 %x) {
  %s1 = shl nsw nuw i3 %x, 1
  %s2 = shl nsw nuw i3 %x, 2
  %r = add nsw nuw i3 %s1, %s2
  ret i3 %r
}

define i32 @test_i32_shlshl(i32 %x) {
  %s1 = shl i32 %x, 1
  %s2 = shl i32 %x, 3
  %r = add i32 %s1, %s2
  ret i32 %r
}

define i32 @test_i32_shlshl_allflags(i32 %x) {
  %s1 = shl nsw nuw i32 %x, 1
  %s2 = shl nsw nuw i32 %x, 3
  %r = add nsw nuw i32 %s1, %s2
  ret i32 %r
}

define i64 @test_i64_shlshl(i64 %x) {
  %s1 = shl i64 %x, 1
  %s2 = shl i64 %x, 3
  %r = add i64 %s1, %s2
  ret i64 %r
}

define i64 @test_i64_shlshl_allflags(i64 %x) {
  %s1 = shl nsw nuw i64 %x, 1
  %s2 = shl nsw nuw i64 %x, 3
  %r = add nsw nuw i64 %s1, %s2
  ret i64 %r
}

define i1 @test_i1_shlshl_nofire(i1 %x) {
  %s1 = shl i1 %x, 0
  %s2 = shl i1 %x, 0
  %r = add i1 %s1, %s2
  ret i1 %r
}


; CHECK: 466 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
