; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules subi-zext-to-add-sext %s | filecheck %s

define i64 @test(i64 %x, i1 %b) {
  %z = zext i1 %b to i64
  %r = sub i64 %x, %z
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test(
; CHECK-NOT: zext
; CHECK-NOT: sub i64
; CHECK: sext i1 {{.*}} to i64
; CHECK: add i64
; CHECK: ret i64

define i32 @test_i32(i32 %x, i1 %b) {
  %z = zext i1 %b to i32
  %r = sub i32 %x, %z
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_i32(
; CHECK: sext i1 {{.*}} to i32
; CHECK: add i32
; CHECK: ret i32

define i64 @test_nofire_wide(i64 %x, i8 %b) {
  %z = zext i8 %b to i64
  %r = sub i64 %x, %z
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_wide(
; CHECK: zext i8 {{.*}} to i64
; CHECK: sub i64
; CHECK: ret i64

define i2 @test_i2_nsw(i2 %x, i1 %b) {
  %z = zext i1 %b to i2
  %r = sub nsw i2 %x, %z
  ret i2 %r
}

; CHECK-LABEL: define {{.*}} @test_i2_nsw(
; CHECK: sext i1 {{.*}} to i2
; CHECK: add nsw i2
; CHECK: ret i2

define i3 @test_i3(i3 %x, i1 %b) {
  %z = zext i1 %b to i3
  %r = sub i3 %x, %z
  ret i3 %r
}

; CHECK-LABEL: define {{.*}} @test_i3(
; CHECK: sext i1 {{.*}} to i3
; CHECK: add i3
; CHECK: ret i3

define i64 @test_nneg(i64 %x, i1 %b) {
  %z = zext nneg i1 %b to i64
  %r = sub i64 %x, %z
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_nneg(
; CHECK: sext i1 {{.*}} to i64
; CHECK: add i64
; CHECK: ret i64

define i64 @test_nsw_preserve(i64 %x, i1 %b) {
  %z = zext i1 %b to i64
  %r = sub nsw i64 %x, %z
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_nsw_preserve(
; CHECK: sext i1 {{.*}} to i64
; CHECK: add nsw i64
; CHECK: ret i64

define i64 @test_nuw_drop(i64 %x, i1 %b) {
  %z = zext i1 %b to i64
  %r = sub nuw i64 %x, %z
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_nuw_drop(
; CHECK: sext i1 {{.*}} to i64
; CHECK-NOT: add nuw i64
; CHECK-NOT: add nsw i64
; CHECK: add i64
; CHECK: ret i64

define i64 @test_nsw_nuw(i64 %x, i1 %b) {
  %z = zext i1 %b to i64
  %r = sub nsw nuw i64 %x, %z
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_nsw_nuw(
; CHECK: sext i1 {{.*}} to i64
; CHECK-NOT: add nuw i64
; CHECK: add nsw i64
; CHECK: ret i64

define i64 @test_nofire_lhs(i64 %x, i1 %b) {
  %z = zext i1 %b to i64
  %r = sub i64 %z, %x
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_lhs(
; CHECK: zext i1 {{.*}} to i64
; CHECK: sub i64
; CHECK: ret i64
