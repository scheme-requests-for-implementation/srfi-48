;;
;; srfi-48 format test for Gambit
;;

(include "srfi-48.scm")

(define ok-flag #t)

(define-macro (expect expected form . compare)
  `(let* ((same?  (if (null? ',compare) equal? (eval (car ',compare))))
          (wanted ,expected)
          (actual ,form))
     (cond
      ((same? wanted actual)
       (format #t "PASSED:  ~s~%" ',form))
      (else
       (set! ok-flag #f)
       (format #t
               "~%**FAIL: expected: ~s~% got:  ~s~% from: ~s~%"
               wanted
               actual
               ',form)))))

(define (test-section txt) (display (string-append "<TEST-SECTION>: " txt)) (newline))

(define (write-with-shared-structure obj port) (error "write/ss is not supported"))

(define (x->number x)
  (cond
   ((number? x) x)
   ((string? x) (string->number x))
   (else (error "x->number error"))))

(include "test-0001-Gambit.scm")

(display "== RESULT ==") (newline)
(display (if ok-flag "OK." "FAILED.")) (newline)

