#lang racket

(require yaml)
(require "./gen_pt_marco2num.scm")



(define (gen-proto yaml-src)
  (define pt-marco (make-pt-marco))

  (define (iter yaml-src0)
    (cond ((null? yaml-src0) #t)
          (else (let ((pt (car yaml-src0)))
                  ((pt-marco 'add) pt)
                  (iter (cdr yaml-src0))))))

  (iter yaml-src)
  (pt-marco 'print)
  (newline))

(define (get-yaml path)
  (file->yaml path #:mode 'binary))


(map gen-proto
     (map get-yaml (directory-list "./pt" #:build? #t)))

