; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules addi-zero-to-x,de-morgan-and-to-or %s | filecheck %s
; RUN: llrwt --rules addi-zero-to-x,de-morgan-and-to-or %s -o %t.out && filecheck %s < %t.out
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
