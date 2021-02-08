#lang racket

(require yaml)
(require "./gen_pt_marco2num.scm")



(define (gen-proto yaml-src)
  (define pt-marco (make-pt-marco))
  (define pt-set (mutable-set))


  (define (check-duplicate-pt? pt-num)
	(cond ((set-member? pt-set pt-num) #f)
		  (else #t)))

  (define (add-pt-set! pt-num)
	(set-add! pt-set pt-num))

  (define (iter yaml-src0)
	(cond ((null? yaml-src0) #t)
		  (else (let* ((pt (car yaml-src0))
					   (pt-num (hash-ref pt "pt-num")))
				  (cond ((check-duplicate-pt? pt-num) ((pt-marco 'add) pt)
													  (add-pt-set! pt-num)
													  (iter (cdr yaml-src0)))
						(else (error "duplicate pt" pt-num)))))))

  (iter yaml-src)
  (pt-marco 'print)
  (newline))

(define (get-yaml path)
  (file->yaml path))


(map gen-proto
	 (map get-yaml (directory-list "./pt" #:build? #t)))


