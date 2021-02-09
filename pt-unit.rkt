#lang racket

(provide
  pt-unit)

(define (pt-unit pt-yaml)

  (define (get-raw)
	pt-yaml)

  (define (get-marco-name)
	(let ((pt-type (hash-ref pt-yaml "pt-type"))
		  (pt-marco (hash-ref pt-yaml "pt-marco")))
	  (string-upcase (string-append pt-type "_" pt-marco))))


  (define (output-formatter-marco)
    (let* ((pt-num (hash-ref pt-yaml "pt-num"))
           (pt-comment (hash-ref! pt-yaml "pt-comment" ""))
           (marco-name (get-marco-name)))
           (string-append "-define(?" marco-name ", " (number->string pt-num) "). %% " pt-comment)))

  (define (disp opt)
	(cond ((eq? opt 'get-raw) (get-raw))
		  ((eq? opt 'get-marco-name) (get-marco-name))
		  ((eq? opt 'output-formatter-marco) (output-formatter-marco))
		  (else (error "pt-unit error opt" opt))))

  disp)
