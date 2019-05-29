#lang scheme

;(30 points).Scheme has implemented some of the constructs -
;you may not use these implementations, but rather must implement them yourself.
;Write a Scheme function (iterator (start step end))
;which returns a function which when repeatedly called returns the numbers in the
;sequence (range (start step end)). When the sequence is exhausted the returned function should return (). 
;Example: (define next (iterator '(0 2 7))), (begin (next) (next) (next) (next) (next)) => 0, 2, 4, 6, ()




(define (iterator L)
  (let ((start (car L))
        (step (car (cdr L)))
        (end (car (cdr (cdr L)))))
   (iterator-helper start step end '())))

(define (iterator-helper start step end L)
  (cond
    ((= start end) (iterator-helper start step end (cons '() L)))
    ((< start end) (iterator-helper (+ start step) step end (cons start L)))
    (else
     (if (equal? (car L) '())
         (print-function (reverse L))
         (print-function (reverse (cons '() L)))))))
  
    

(define (print-function ll)
  ll)
  
  
  
(iterator '(0 2 7))