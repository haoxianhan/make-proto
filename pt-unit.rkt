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

  (define (get-marco-type-num)
	(let ((pt-type (hash-ref pt-yaml "pt-type"))
		  (pt-num (hash-ref pt-yaml "pt-num")))
	  (string-upcase (string-append pt-type "_" (number->string pt-num)))))

  (define (output-formatter-marco)
    (let* ((pt-num (hash-ref pt-yaml "pt-num"))
           (pt-comment (hash-ref! pt-yaml "pt-comment" ""))
           (marco-name (get-marco-name)))
           (string-append "-define(?" marco-name ", " (number->string pt-num) "). %% " pt-comment)))

  (define (valid-yaml? f)
	(f pt-yaml))

  (define (disp opt)
	(cond ((eq? opt 'get-raw) (get-raw))
		  ((eq? opt 'valid-yaml) valid-yaml?)
		  ((eq? opt 'get-marco-name) (get-marco-name))
		  ((eq? opt 'get-marco-type-num) (get-marco-type-num))
		  ((eq? opt 'output-formatter-marco) (output-formatter-marco))
		  (else (error "pt-unit error opt" opt))))

  disp)
