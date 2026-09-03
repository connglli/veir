; REQUIRES: mlir-translate, mlir-opt, mlir-min-22
; RUN: llrwt --rules add_zero %s | filecheck %s
;
; Only `add_zero` runs: `add x, 0` folds away, `mul x, 2` stays.

define i32 @test(i32 %a) {
  %add = add i32 %a, 0
  %mul = mul i32 %a, 2
  %r = add i32 %add, %mul
  ret i32 %r
}

; CHECK-NOT: , 0
; CHECK: = mul i32 {{.*}}, 2
; CHECK-NOT: , 0
