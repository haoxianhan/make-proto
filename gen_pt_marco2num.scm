#lang racket

(require "./gen_pt_base.scm")

(provide make-pt-marco)

(define (make-pt-marco)
  (define marco-list '())

  (define (print-marco-list)
    (map (lambda(x) (display x)
                    (newline))
         (reverse marco-list)))

  (define (write-file)
    (call-with-output-file "./proto.hrl"
                           (lambda (out)
                             (map (lambda(e) (displayln e out))
                                  (reverse marco-list)))
                           #:exists 'replace))

  (define (add-marco new-marco)
    (set! marco-list (cons new-marco marco-list)))

  (define (can-add-marco? pt)
    (and (valid-pt-num? pt)
         (valid-pt-marco? pt)
         (valid-pt-type? pt)
		 (valid-pt-comment? pt)))

  (define (formatter pt)
    (let* ((pt-num (hash-ref pt "pt-num"))
           (pt-type (hash-ref pt "pt-type"))
           (pt-marco (hash-ref pt "pt-marco"))
           (pt-comment (hash-ref pt "pt-comment"))
           (marco-name (string-upcase (string-append pt-type "_" pt-marco))))
	  (string-append "-define(?" marco-name ", " (number->string pt-num) "). %% " pt-comment)))

  (define (try-add-pt-marco pt)
    (if (can-add-marco? pt)
      (add-marco (formatter pt))
      (error "pt not valid" pt)))

  (define (disp opt)
    (cond ((eq? opt 'add) try-add-pt-marco)
          ((eq? opt 'print) (write-file))
          ((eq? opt 'write-file) (write-file))
          (else (error "make-pt-marco wrong opt"))))

  disp)
