#lang racket

(require "utils.rkt")

(provide make-pt-marco)

(define (make-pt-marco)

  (define marco-list '())
  (define pt-marco-set (mutable-set))

  (define (print-marco-list)
    (map (lambda(x) (display x)
                    (newline))
         (reverse marco-list)))

  (define (check-duplicate-pt? pt)
	(let ((pt-marco-name (pt 'get-marco-name))
		  (pt-marco-type-num (pt 'get-marco-type-num)))
	  (cond ((or (set-member? pt-marco-set pt-marco-name)
				 (set-member? pt-marco-set pt-marco-type-num)) #f)
			(else #t))))

  (define (add-pt-set! pt)
	(let ((pt-marco-name (pt 'get-marco-name))
		  (pt-marco-type-num (pt 'get-marco-type-num)))
	  (set-add! pt-marco-set pt-marco-name)
	  (set-add! pt-marco-set pt-marco-type-num)))

  (define (write-file)
    (call-with-output-file "./proto.hrl"
                           (lambda (out)
                             (map (lambda(e) (displayln e out))
                                  (reverse marco-list)))
                           #:exists 'replace))

  (define (add-marco new-marco)
    (set! marco-list (cons new-marco marco-list)))

  (define (can-add-marco? pt)
    (and ((pt 'valid-yaml) valid-pt-num?) (check-duplicate-pt? pt)
         ((pt 'valid-yaml) valid-pt-marco?)
         ((pt 'valid-yaml) valid-pt-type?)
         ((pt 'valid-yaml) valid-pt-comment?)))

  (define (try-add-pt-marco pt)
    (if (can-add-marco? pt)
	  (begin (add-marco (pt 'output-formatter-marco))
			 (add-pt-set! pt))
      (error "pt not valid" pt)))

  (define (disp opt)
    (cond ((eq? opt 'add) try-add-pt-marco)
          ((eq? opt 'print) (write-file))
          ((eq? opt 'write-file) (write-file))
          (else (error "make-pt-marco wrong opt"))))

  disp)
