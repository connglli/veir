; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules muli-two-to-addi %s | filecheck %s

define i32 @test(i32 %a) {
  %r = mul i32 %a, 2
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test(
; CHECK-NOT: mul i32
; CHECK: %{{.*}} = add i32 %{{.*}}, %{{.*}}
; CHECK: ret i32

define i32 @test_nsw(i32 %a) {
  %r = mul nsw i32 %a, 2
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_nsw(
; CHECK-NOT: mul
; CHECK: %{{.*}} = add nsw i32 %{{.*}}, %{{.*}}
; CHECK: ret i32

define i32 @test_nuw(i32 %a) {
  %r = mul nuw i32 %a, 2
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test_nuw(
; CHECK-NOT: mul
; CHECK: %{{.*}} = add nuw i32 %{{.*}}, %{{.*}}
; CHECK: ret i32

define i3 @test_i3_nsw(i3 %a) {
  %r = mul nsw i3 %a, 2
  ret i3 %r
}

; CHECK-LABEL: define {{.*}} @test_i3_nsw(
; CHECK-NOT: mul
; CHECK: %{{.*}} = add nsw i3 %{{.*}}, %{{.*}}
; CHECK: ret i3

define i2 @test_i2_no_nsw(i2 %a) {
  %r = mul nsw i2 %a, 2
  ret i2 %r
}

; CHECK-LABEL: define {{.*}} @test_i2_no_nsw(
; CHECK-NOT: add nsw i2
