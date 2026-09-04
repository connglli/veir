; REQUIRES: alive-tv, mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules ori-self-to-x %s -o %t.ll
; RUN: alive-tv --disable-undef-input %s %t.ll | filecheck %s

; ori-self-to-x

define i32 @test_i32(i32 %x) {
  %r = or i32 %x, %x
  ret i32 %r
}

define i32 @test_i32_disjoint(i32 %x) {
  %r = or disjoint i32 %x, %x
  ret i32 %r
}

define i64 @test_i64(i64 %x) {
  %r = or disjoint i64 %x, %x
  ret i64 %r
}

define i128 @test_i128(i128 %x) {
  %r = or disjoint i128 %x, %x
  ret i128 %r
}

define i8 @test_i8(i8 %x) {
  %r = or disjoint i8 %x, %x
  ret i8 %r
}

define i7 @test_i7(i7 %x) {
  %r = or disjoint i7 %x, %x
  ret i7 %r
}

define i3 @test_i3(i3 %x) {
  %r = or disjoint i3 %x, %x
  ret i3 %r
}

define i2 @test_i2(i2 %x) {
  %r = or i2 %x, %x
  ret i2 %r
}

define i2 @test_i2_disjoint(i2 %x) {
  %r = or disjoint i2 %x, %x
  ret i2 %r
}

define i1 @test_i1(i1 %x) {
  %r = or i1 %x, %x
  ret i1 %r
}

define i1 @test_i1_disjoint(i1 %x) {
  %r = or disjoint i1 %x, %x
  ret i1 %r
}

define i32 @test_chained(i32 %x) {
  %o1 = or i32 %x, %x
  %o2 = or i32 %o1, %o1
  ret i32 %o2
}

; CHECK: 12 correct transformations
; CHECK: 0 incorrect transformations
; CHECK: 0 failed-to-prove transformations
; CHECK: 0 Alive2 errors
