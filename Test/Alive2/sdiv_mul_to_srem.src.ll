; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules sdiv_mul_to_srem %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; sdiv_mul_to_srem

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

; CHECK: 9 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
