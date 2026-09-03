; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules ashr_zero %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; ashr_zero

define i32 @test_i32(i32 %x) {
  %r = ashr i32 %x, 0
  ret i32 %r
}

define i32 @test_i32_exact(i32 %x) {
  %r = ashr exact i32 %x, 0
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %r = ashr exact i64 %x, 0
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %r = ashr exact i128 %x, 0
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %r = ashr exact i8 %x, 0
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %r = ashr exact i7 %x, 0
  ret i7 %r
}

define i3 @test_i3(i3 %x) {
  %r = ashr exact i3 %x, 0
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %r = ashr i2 %x, 0
  ret i2 %r
}

define i2 @test_i2_exact(i2 %x) {
  %r = ashr exact i2 %x, 0
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %r = ashr i1 %x, 0
  ret i1 %r
}

define i1 @test_i1_exact(i1 %x) {
  %r = ashr exact i1 %x, 0
  ret i1 %r
}

define i32 @test_chained(i32 %x) {
  %a1 = ashr i32 %x, 0
  %a2 = ashr i32 %a1, 0
  ret i32 %a2
}

; CHECK: 12 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
