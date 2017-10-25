
(define-syntax expect
  (syntax-rules ()
    ((expect ?expected ?form) ;=>
     (expect ?expected ?form equal?)
    )
    ((expect ?expected ?form ?compare) ;=>
     (let ( (expected ?expected)
            (actual   ?form)
          )
       (if (?compare expected actual)
           (format #t "PASSED:  ~w~%" '?form)
           (format #t 
                   "~%**FAIL: expected: ~w~% got: ~w~% from: ~w~%"
                   expected
                   actual
                   '?form)))
    )
) )

;; Or old style macros [Gambit]
;
;(define-macro (expect expected form . compare)
;  (let* ( (same? (if (null? compare) equal? (eval (car `,compare))))
;          (wanted (eval `,expected))
;          (actual (eval `,form))
;        )
;    (if (same? wanted actual)
;        (format #t "PASSED:  ~s~%" form)
;        (format #t 
;                "~%**FAIL: expected: ~s~% got:  ~s~% from: ~s~%"
;                wanted
;                actual
;                form))
;) )
        

;;;===================================================

(expect (format "test ~s" 'me) (format #f "test ~a" "me"))

(expect  " 0.333" (format "~6,3F" 1/3)) ;;; "  .333" OK

(expect "  12" (format "~4F" 12))

(expect "  12.346" (format "~8,3F" 12.3456))

(expect "123.346" (format "~6,3F" 123.3456))

(expect "123.346" (format "~4,3F" 123.3456))

(expect "0.000+1.949i" (format "~8,3F" (sqrt -3.8)))

(expect " 32.00" (format "~6,2F" 32))

(expect "    32" (format "~6F" 32))

;(expect "   32." (format "~6F" 32.)) ;; "  32.0" OK
(expect "  32.0" (format "~6F" 32.))
;; NB: (not (and (exact? 32.) (integer? 32.)))

(expect "  3.2e46" (format "~8F" 32e45))

(expect " 3.2e-44" (format "~8F" 32e-45))

(expect "  3.2e21" (format "~8F" 32e20))

;;(expect "   3.2e6" (format "~8F" 32e5)) ;; ok.  converted in input to 3200000.0

;(expect "   3200." (format "~8F" 32e2)) ;; "  3200.0" OK
(expect "  3200.0" (format "~8F" 32e2))

(expect " 3.20e11" (format "~8,2F" 32e10))

(expect "      1.2345" (format "~12F" 1.2345))

(expect "        1.23" (format "~12,2F" 1.2345))

(expect "       1.234" (format "~12,3F" 1.2345))

(expect "        0.000+1.949i" (format "~20,3F" (sqrt -3.8)))

(expect "0.000+1.949i" (format "~8,3F" (sqrt -3.8)))

(expect " 3.46e11" (format "~8,2F" 3.4567e11))

; (expect "#1=(a b c . #1#)"
;         (format "~w" (let ( (c '(a b c)) ) (set-cdr! (cddr c) c) c)))

(expect "
"
        (format "~A~A~&" (list->string (list #\newline)) ""))

(expect "a new test"
        (format "~a ~? ~a" 'a "~s" '(new) 'test))

(expect "a new test, yes!"
        (format "~a ~?, ~a!" 'a "~s ~a" '(new test) 'yes))

(expect " 3.46e20" (format "~8,2F" 3.4567e20))

(expect " 3.46e21" (format "~8,2F" 3.4567e21))

(expect " 3.46e22" (format "~8,2F" 3.4567e22))

(expect " 3.46e23" (format "~8,2F" 3.4567e23))

(expect "   3.e24" (format "~8,0F" 3.4567e24))

(expect "  3.5e24" (format "~8,1F" 3.4567e24))

(expect " 3.46e24" (format "~8,2F" 3.4567e24))

(expect "3.457e24" (format "~8,3F" 3.4567e24))

(expect "   4.e24" (format "~8,0F" 3.5567e24))

(expect "  3.6e24" (format "~8,1F" 3.5567e24))

(expect " 3.56e24" (format "~8,2F" 3.5567e24))

;(expect "       -0." (format "~10,0F" -3e-4))
(expect "    -3.e-4" (format "~10,0F" -3e-4))

;(expect "      -0.0" (format "~10,1F" -3e-4))
(expect "   -3.0e-4" (format "~10,1F" -3e-4))

;(expect "     -0.00" (format "~10,2F" -3e-4))
(expect "  -3.00e-4" (format "~10,2F" -3e-4))

;(expect "    -0.000" (format "~10,3F" -3e-4))
(expect " -3.000e-4" (format "~10,3F" -3e-4))

;(expect "   -0.0003" (format "~10,4F" -3e-4))
(expect "-3.0000e-4" (format "~10,4F" -3e-4))

;(expect "  -0.00030" (format "~10,5F" -3e-4))
(expect "-3.00000e-4" (format "~10,5F" -3e-4))

(expect "     1.020" (format "~10,3F" 1.02))

(expect "     1.025" (format "~10,3F" 1.025))

(expect "     1.026" (format "~10,3F" 1.0256))

(expect "     1.002" (format "~10,3F" 1.002))

(expect "     1.002" (format "~10,3F" 1.0025))

(expect "     1.003" (format "~10,3F" 1.00256))

;;   ---   E O F   ---   ;;
