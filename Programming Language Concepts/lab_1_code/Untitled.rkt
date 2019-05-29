#lang scheme

(define (fact n)
  (cond
    ((< n 0) 0)
    ((= n 1) 1)
    (else (* n (fact( - n 1))))))
(define (tail-fact n x)
  (if ( = n 0)
      x
      (tail-fact (- n 1) (* x n))))

(define (power2 n)
  (if (= n 0) 1
      (* 2 (power2 (- n 1)))))

(define (tail-power2 n x)
  (if (= n 0)
      x
      (tail-power2 (- n 1) (* 2 x))))

(define (compose g f)
  (lambda (x)
    (g(f(x)))))

(compose fact (power2 2))

(define (range start step end)
  (cond
    ((> start end) '())
    ((= start end) '())
    (else
         (cons start (range (+ start step) step end)))))


(define (seq f start step end)
  (cond
    ((> start end) '())
    ((= start end) '())
    (else
         (cons (* start start) (seq f (+ start step) step end)))))



(define (binom n k)
  (cond
    ((< n 0) 0)
    ((< k 0) 0)
    ((< n k) 0)
    ((equal? k 0) 1)
    ((equal? k n) 1)
    (else
        (+ (binom (- n 1) (- k 1)) (binom (- n 1) k)))))
     

;Test Cases
(fact 5)
(tail-fact 5 1)
(power2 5)
(tail-power2 5 1)
(range 0 2 7)
(seq (lambda (x) (* x x)) 0 2 7)
(binom 12 4)