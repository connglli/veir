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

; CHECK: 9 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
