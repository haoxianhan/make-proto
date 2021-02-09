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
    (let ((pt-num (hash-ref pt "pt-num")))
      (cond ((set-member? pt-marco-set pt-num) #f)
            (else #t))))

  (define (add-pt-set! pt-num)
    (set-add! pt-marco-set pt-num))

  (define (write-file)
    (call-with-output-file "./proto.hrl"
                           (lambda (out)
                             (map (lambda(e) (displayln e out))
                                  (reverse marco-list)))
                           #:exists 'replace))

  (define (add-marco new-marco)
    (set! marco-list (cons new-marco marco-list)))

  (define (can-add-marco? pt)
    (and ((pt 'valid) valid-pt-num?) ((pt 'valid) check-duplicate-pt?)
         ((pt 'valid) valid-pt-marco?)
         ((pt 'valid) valid-pt-type?)
         ((pt 'valid) valid-pt-comment?)))

  (define (try-add-pt-marco pt)
    (if (can-add-marco? pt)
	  (begin (add-marco (pt 'output-formatter-marco))
			 (add-pt-set! (hash-ref (pt 'get-raw) "pt-num")))
      (error "pt not valid" pt)))

  (define (disp opt)
    (cond ((eq? opt 'add) try-add-pt-marco)
          ((eq? opt 'print) (write-file))
          ((eq? opt 'write-file) (write-file))
          (else (error "make-pt-marco wrong opt"))))

  disp)
