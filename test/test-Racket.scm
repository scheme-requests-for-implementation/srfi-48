#lang racket

;;
;; srfi-48 format test for Racket
;;

(define-syntax if
  (syntax-rules ()
    ((_ test then)
     (when test then))
    ((_ test then else1)
     (cond (test then) (else else1)))
    ((_ . other)
     (syntax-error "malformed if"))))

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

(define (test-section txt) (print (string-append "<TEST-SECTION>: " txt)) (newline))

(define (write-with-shared-structure obj port) (write obj port))

(define (x->number x)
  (cond
   ((number? x) x)
   ((string? x) (string->number x))
   (else (error "x->number error"))))

(include "test-0001-Racket.scm")

