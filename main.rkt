#lang racket

(require
  yaml
  "marco2num.rkt"
  "pt-unit.rkt"
  )


(define (gen-proto yaml-src)

  (define pt-marco (make-pt-marco))

  (define (iter yaml-src0)
    (cond ((null? yaml-src0) #t)
          (else (let ((pt (pt-unit (car yaml-src0))))
				  ((pt-marco 'add) pt)
				  (iter (cdr yaml-src0)))
				)))

  (iter yaml-src)
  (pt-marco 'print)
  (newline))

(define (get-yaml path)
  (file->yaml path))

(map gen-proto
     (map get-yaml (directory-list "./pt" #:build? #t)))


