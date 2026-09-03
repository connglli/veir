; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules mul_pow2_shl %s | filecheck %s

define i32 @test4(i32 %x) {
  %r = mul i32 %x, 4
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test4(
; CHECK-NOT: mul i32
; CHECK: shl i32 {{.*}}, 2
; CHECK: ret i32

define i64 @test8(i64 %x) {
  %r = mul i64 %x, 8
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test8(
; CHECK-NOT: mul i64
; CHECK: shl i64 {{.*}}, 3
; CHECK: ret i64

define i32 @test_nofire3(i32 %x) {
  %r = mul i32 %x, 3
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire3(
; CHECK: mul i32 {{.*}}, 3
; CHECK: ret i32

define i32 @test_nofire5(i32 %x) {
  %r = mul i32 %x, 5
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire5(
; CHECK: mul i32 {{.*}}, 5
; CHECK: ret i32

define i3 @test_i3_pow2(i3 %x) {
  %r = mul i3 %x, 2
  ret i3 %r
}

; CHECK-LABEL: define {{.*}} @test_i3_pow2(
; CHECK-NOT: mul i3
; CHECK: shl i3 {{.*}}, 1
; CHECK: ret i3

define i3 @test_i3_nsw(i3 %x) {
  %r = mul nsw i3 %x, 2
  ret i3 %r
}

; CHECK-LABEL: define {{.*}} @test_i3_nsw(
; CHECK-NOT: mul i3
; CHECK: shl nsw i3 {{.*}}, 1
; CHECK: ret i3

define i8 @test_i8_nsw_nuw(i8 %x) {
  %r = mul nsw nuw i8 %x, 64
  ret i8 %r
}

; CHECK-LABEL: define {{.*}} @test_i8_nsw_nuw(
; CHECK-NOT: mul i8
; CHECK: shl nuw nsw i8 {{.*}}, 6
; CHECK: ret i8

define i32 @test_lhs_const(i32 %x) {
  %r = mul i32 16, %x
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_lhs_const(
; CHECK-NOT: mul i32
; CHECK: shl i32 {{.*}}, 4
; CHECK: ret i32

define i2 @test_nofire_wrap(i2 %x) {
  %r = mul i2 %x, 4
  ret i2 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_wrap(
; CHECK-NOT: shl i2
; CHECK: ret i2

define i32 @test_nofire_neg(i32 %x) {
  %r = mul i32 %x, -4
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_neg(
; CHECK: mul i32 {{.*}}, -4
; CHECK: ret i32

define i8 @test_nofire_huge(i8 %x) {
  %r = mul i8 %x, 128
  ret i8 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_huge(
; CHECK-NOT: shl i8
; CHECK: ret i8
