; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules ori-zero-to-x %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; ori-zero-to-x

define i32 @test_i32(i32 %x) {
  %r = or i32 %x, 0
  ret i32 %r
}

define i32 @test_i32_disjoint(i32 %x) {
  %r = or disjoint i32 %x, 0
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %r = or disjoint i64 %x, 0
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %r = or disjoint i128 %x, 0
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %r = or disjoint i8 %x, 0
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %r = or disjoint i7 %x, 0
  ret i7 %r
}

define i3 @test_i3(i3 %x) {
  %r = or disjoint i3 %x, 0
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %r = or i2 %x, 0
  ret i2 %r
}

define i2 @test_i2_disjoint(i2 %x) {
  %r = or disjoint i2 %x, 0
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %r = or i1 %x, 0
  ret i1 %r
}

define i1 @test_i1_disjoint(i1 %x) {
  %r = or disjoint i1 %x, 0
  ret i1 %r
}

define i32 @test_chained(i32 %x) {
  %o1 = or i32 %x, 0
  %o2 = or i32 %o1, 0
  ret i32 %o2
}

define i64 @test_i64_nondisjoint(i64 %x) {
  %r = or i64 %x, 0
  ret i64 %r
}

define i3 @test_i3_nondisjoint(i3 %x) {
  %r = or i3 %x, 0
  ret i3 %r
}


; CHECK: 14 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
