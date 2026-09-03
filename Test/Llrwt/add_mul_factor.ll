; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules add_mul_factor %s | filecheck %s

define i64 @test_shl(i64 %x) {
  %a = mul i64 %x, 9
  %s = shl i64 %x, 8
  %r = add i64 %a, %s
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_shl(
; CHECK-NOT: shl i64
; CHECK-NOT: 9
; CHECK: mul i64 {{.*}}, 265
; CHECK: ret i64

define i32 @test_mul(i32 %x) {
  %a = mul i32 %x, 3
  %b = mul i32 %x, 5
  %r = add i32 %a, %b
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_mul(
; CHECK: mul i32 {{.*}}, 8
; CHECK: ret i32

define i64 @test_add(i64 %x) {
  %a = mul i64 %x, 8
  %r = add i64 %x, %a
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_add(
; CHECK: mul i64 {{.*}}, 9
; CHECK: ret i64

define i32 @test_nofire_base(i32 %x, i32 %y) {
  %a = mul i32 %x, 3
  %b = mul i32 %y, 5
  %r = add i32 %a, %b
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_base(
; CHECK: mul i32 {{.*}}, 3
; CHECK: mul i32 {{.*}}, 5
; CHECK: ret i32

define i32 @test_nofire_addself(i32 %x) {
  %r = add i32 %x, %x
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_addself(
; CHECK: add i32
; CHECK: ret i32

define i3 @test_wrap(i3 %x) {
  %a = mul i3 %x, 3
  %b = mul i3 %x, 5
  %r = add i3 %a, %b
  ret i3 %r
}

; CHECK-LABEL: define {{.*}} @test_wrap(
; CHECK: mul i3 {{.*}}, 0
; CHECK: ret i3

define i2 @test_i2_wrap(i2 %x) {
  %a = mul i2 %x, 2
  %b = mul i2 %x, 2
  %r = add i2 %a, %b
  ret i2 %r
}

; CHECK-LABEL: define {{.*}} @test_i2_wrap(
; CHECK: mul i2 {{.*}}, 0
; CHECK: ret i2

define i32 @test_neg(i32 %x) {
  %a = mul i32 %x, -1
  %b = mul i32 %x, 1
  %r = add i32 %a, %b
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_neg(
; CHECK: mul i32 {{.*}}, 0
; CHECK: ret i32

define i32 @test_flags_drop(i32 %x) {
  %a = mul nsw i32 %x, 3
  %b = shl nsw i32 %x, 2
  %r = add nsw nuw i32 %a, %b
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_flags_drop(
; CHECK-NOT: mul nsw i32
; CHECK-NOT: mul nuw i32
; CHECK: mul i32 {{.*}}, 7
; CHECK: ret i32

define i3 @test_i3_flags(i3 %x) {
  %a = mul nsw i3 %x, 2
  %b = mul nuw i3 %x, 1
  %r = add nsw i3 %a, %b
  ret i3 %r
}

; CHECK-LABEL: define {{.*}} @test_i3_flags(
; CHECK-NOT: mul nsw i3
; CHECK-NOT: mul nuw i3
; CHECK: mul i3 {{.*}}, 3
; CHECK: ret i3

define i1 @test_i1_nofire(i1 %x) {
  %r = add i1 %x, %x
  ret i1 %r
}

; CHECK-LABEL: define {{.*}} @test_i1_nofire(
; CHECK: add i1
; CHECK: ret i1

define i32 @test_nofire_poison_shl(i32 %x) {
  %a = mul i32 %x, 3
  %s = shl i32 %x, 32
  %r = add i32 %a, %s
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_poison_shl(
; CHECK: shl i32 {{.*}}, 32
; CHECK: ret i32
