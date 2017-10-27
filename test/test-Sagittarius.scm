;;
;; srfi-48 format test for Sagittarius
;;

(import (rnrs))

(include "srfi-48.scm")

(define-syntax expect
  (syntax-rules ()
    ((expect ?expected ?form)
     (expect ?expected ?form equal?))
    ((expect ?expected ?form ?compare)
     (let ((expected ?expected)
           (actual   ?form))
       (if (?compare expected actual)
         (format #t "PASSED:  ~w~%" '?form)
         (format #t
                 "~%**FAIL: expected: ~w~% got: ~w~% from: ~w~%"
                 expected
                 actual
                 '?form))))))

(define (test-section txt) (print (string-append "<TEST-SECTION>: " txt)))

(define write-with-shared-structure write/ss)
(define exact->inexact inexact)
(define inexact->exact exact)

(define (x->number x)
  (cond
   ((number? x) x)
   ((string? x) (string->number x))
   (else (error "x->number error"))))

(include "test-0001.scm")

