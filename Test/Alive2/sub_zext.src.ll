; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules sub_zext %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; sub_zext

define i64 @test_i64(i64 %x, i1 %b) {
  %z = zext i1 %b to i64
  %r = sub i64 %x, %z
  ret i64 %r
}

define i64 @test_i64_nsw(i64 %x, i1 %b) {
  %z = zext i1 %b to i64
  %r = sub nsw i64 %x, %z
  ret i64 %r
}

define i64 @test_i64_nuw(i64 %x, i1 %b) {
  %z = zext i1 %b to i64
  %r = sub nuw i64 %x, %z
  ret i64 %r
}

define i32 @test_i32(i32 %x, i1 %b) {
  %z = zext i1 %b to i32
  %r = sub i32 %x, %z
  ret i32 %r
}

define i32 @test_i32_nsw_nuw(i32 %x, i1 %b) {
  %z = zext i1 %b to i32
  %r = sub nsw nuw i32 %x, %z
  ret i32 %r
}

define i16 @test_i16(i16 %x, i1 %b) {
  %z = zext i1 %b to i16
  %r = sub i16 %x, %z
  ret i16 %r
}

define i2 @test_i2_nsw(i2 %x, i1 %b) {
  %z = zext i1 %b to i2
  %r = sub nsw i2 %x, %z
  ret i2 %r
}

define i3 @test_i3_nuw(i3 %x, i1 %b) {
  %z = zext i1 %b to i3
  %r = sub nuw i3 %x, %z
  ret i3 %r
}

define i64 @test_i64_nneg(i64 %x, i1 %b) {
  %z = zext nneg i1 %b to i64
  %r = sub i64 %x, %z
  ret i64 %r
}

define i32 @test_i32_flags_preserve(i32 %x, i1 %b) {
  %z = zext i1 %b to i32
  %r = sub nsw nuw i32 %x, %z
  ret i32 %r
}

; CHECK: 10 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
