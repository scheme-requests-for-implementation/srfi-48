;;
;; srfi-48 format test for Sagittarius
;;

(import (rnrs))

(define write-with-shared-structure write/ss)
(define exact->inexact inexact)
(define inexact->exact exact)

(include "test-tool.scm")
(include "srfi-48.scm")
(include "test-0001.scm")

