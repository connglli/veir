; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules or_all_ones %s | filecheck %s

define i32 @test(i32 %a) {
  %r = or i32 %a, -1
  ret i32 %r
}

; CHECK-LABEL: define {{.*}} @test
; CHECK-NOT: or i32
; CHECK: ret i32 -1
