; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules subi-sdiv-mul-to-srem %s | filecheck %s

define i64 @test(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test(
; CHECK-NOT: sdiv i64
; CHECK: srem i64 {{.*}}, 4
; CHECK: sub i64
; CHECK: ret i64

define i64 @test_comm(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %y, %m
  %r = sub i64 %x, %a
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_comm(
; CHECK: srem i64 {{.*}}, 4
; CHECK: sub i64
; CHECK: ret i64

define i64 @test2(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 2
  %m = mul i64 %q, 2
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test2(
; CHECK: srem i64 {{.*}}, 2
; CHECK: ret i64

define i64 @test_nofire_mismatch(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 %q, 2
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_mismatch(
; CHECK: sdiv i64
; CHECK: ret i64

define i3 @test_i3(i3 %x, i3 %y) {
  %q = sdiv i3 %x, 2
  %m = mul i3 %q, 2
  %a = add i3 %m, %y
  %r = sub i3 %x, %a
  ret i3 %r
}

; CHECK-LABEL: define {{.*}} @test_i3(
; CHECK: srem i3 {{.*}}, 2
; CHECK: sub i3
; CHECK: ret i3

define i64 @test_exact(i64 %x, i64 %y) {
  %q = sdiv exact i64 %x, 4
  %m = mul i64 %q, 4
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_exact(
; CHECK-NOT: sdiv i64
; CHECK: srem i64 {{.*}}, 4
; CHECK: ret i64

define i64 @test_flags_dropped(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul nsw nuw i64 %q, 4
  %a = add nsw nuw i64 %m, %y
  %r = sub nsw nuw i64 %x, %a
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_flags_dropped(
; CHECK: srem i64 {{.*}}, 4
; CHECK-NOT: nsw
; CHECK-NOT: nuw
; CHECK: sub i64
; CHECK: ret i64

define i64 @test_lhs_const(i64 %x, i64 %y) {
  %q = sdiv i64 %x, 4
  %m = mul i64 4, %q
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_lhs_const(
; CHECK: srem i64 {{.*}}, 4
; CHECK: ret i64

define i8 @test_neg(i8 %x, i8 %y) {
  %q = sdiv i8 %x, -4
  %m = mul i8 %q, -4
  %a = add i8 %m, %y
  %r = sub i8 %x, %a
  ret i8 %r
}

; CHECK-LABEL: define {{.*}} @test_neg(
; CHECK: srem i8 {{.*}}, -4
; CHECK: ret i8

define i64 @test_nofire_neg1(i64 %x, i64 %y) {
  %q = sdiv i64 %x, -1
  %m = mul i64 %q, -1
  %a = add i64 %m, %y
  %r = sub i64 %x, %a
  ret i64 %r
}

; CHECK-LABEL: define {{.*}} @test_nofire_neg1(
; CHECK: sdiv i64
; CHECK: ret i64
