; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules add_zero,demorgan_and %s | filecheck %s
; RUN: llrwt --rules add_zero,demorgan_and %s -o %t.out && filecheck %s < %t.out
;
; Unmodeled constructs pass through unchanged under any rule selection.

declare i32 @ext(i32)

define i32 @test(i32 %x) {
  %r = call i32 @ext(i32 %x)
  ret i32 %r
}

; CHECK: declare i32 @ext(i32)
; CHECK-LABEL: define {{.*}} @test
; CHECK: = call i32 @ext(i32 {{.*}})
; CHECK: ret i32
