#lang scheme
;Aslan Oztreves


;Question 1 - Part 1

(define (lookup name assoc_list)
  (cond
    ((null? assoc_list) '())
    ((equal? name (car assoc_list)) (car assoc_list))
    (else
     (lookup name (cdr assoc_list)))))



;Question 1 - Part 2

(define (lookup-env name environment)
  (cond
    ((null? environment) '())
    ((not (null? (lookup name (car environment))))
     (lookup name (car environment)))
    (else (lookup-env name (cdr environment)))))

(define e1 '( (aslan "A") (eray "E") (sinan "S")))

(lookup 'eray '(aslan eray enis))
(lookup-env 'aslan e1)