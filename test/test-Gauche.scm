;;
;; srfi-48 format test for Gauche
;;

(add-load-path "." :relative)
(use gauche.test)

(include "srfi-48")

(test-start "srfi-48 format")

(define-syntax expect
  (syntax-rules ()
    ((_ ans expr)
     (test* (string-append ": " (format "~s" 'expr)) ans expr))
    ((_ ans expr chk)
     (test* (string-append ": " (format "~s" 'expr)) ans expr chk))))

(include "test-0001")

(test-end)

