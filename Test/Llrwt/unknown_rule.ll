; RUN: not llrwt --rules nope %s
;
; Unknown rule names are a usage error.

define i32 @f(i32 %a) {
  ret i32 %a
}
