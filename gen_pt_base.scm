#lang racket

(provide valid-pt-num?
         valid-pt-type?
         valid-pt-marco?
		 valid-pt-comment?)


(define (valid-pt-num? pt)
  (and (hash-has-key? pt "pt-num")
       (let ((pt-num (hash-ref pt "pt-num")))
         (number? pt-num))))

(define (valid-pt-type? pt)
  (and (hash-has-key? pt "pt-type")
       (let ((pt-type (hash-ref pt "pt-type")))
         (or (equal? pt-type "c")
             (equal? pt-type "s")))))

(define (valid-pt-marco? pt)
  (and (hash-has-key? pt "pt-marco")
       (let ((pt-marco (hash-ref pt "pt-marco")))
         (string? pt-marco))))

(define (valid-pt-comment? pt)
  (and (hash-has-key? pt "pt-comment")
       (let ((pt-comment (hash-ref pt "pt-comment")))
         (string? pt-comment))))
