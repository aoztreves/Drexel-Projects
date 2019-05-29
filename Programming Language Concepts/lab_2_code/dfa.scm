#lang scheme
;;; Example 11.20 (Figures 11.1 and 11.2)

(define simulate
  (lambda (dfa input)
    (letrec ((helper  ; note that helper is tail recursive,
              ; but builds the list of moves in reverse order
              (lambda (moves d2 i)
                (let ((c (current-state d2)))
                  (if (null? i) (cons c moves)
                      (helper (cons c moves) (move d2 (car i)) (cdr i)))))))
      (let ((moves (helper '() dfa input)))
        (reverse (cons (if (is-final? (car moves) dfa)
                           'accept 'reject) moves))))))

;; access functions for machine description:
(define current-state car)
(define transition-function cadr)
(define final-states caddr)
(define is-final? (lambda (s dfa) (memq s (final-states dfa))))

(define move
  (lambda (dfa symbol)
    (let ((cs (current-state dfa)) (trans (transition-function dfa)))
      (list
       (if (eq? cs 'error)
           'error
           (let ((pair (assoc (list cs symbol) trans)))
             (if pair (cadr pair) 'error))) ; new start state
       trans                                ; same transition function
       (final-states dfa)))))               ; same final states

(define zero-one-even-dfa
 '(q0                                                 ; start state
   (((q0 0) q2) ((q0 1) q1) ((q1 0) q3) ((q1 1) q0)   ; transition fn
    ((q2 0) q0) ((q2 1) q3) ((q3 0) q1) ((q3 1) q2))
   (q0)))                                             ; final states

(define test1
  (lambda ()
    (simulate
     zero-one-even-dfa  ; machine description
     '(0 1 1 0 1))))    ; input string

(define test2
  (lambda ()
    (simulate
     zero-one-even-dfa  ; machine description
     '(0 1 0 0 1 0))))  ; input string

(define figure-4-dfa
  '(q0
    (((q0 a) q1) ((q0 b) q2) ((q0 c) q3) ((q1 a) q1) ((q1 c) q3) ((q1 b) q4) ((q2 b) q2)
                ((q2 a) q1) ((q2 c) q5) ((q3 c) q3) ((q3 b) q2) ((q3 a) q5) ((q4 a) q1)
                ((q4 b) q2) ((q4 c) q5) ((q5 b) q2) ((q5 a) q6) ((q5 c) q3) ((q6 c) q3)
                ((q6 a) q1) ((q6 b) q4)) (q5)))


     
(define figure-5-dfa
  '(q0
    (((q0 0) q0) ((q0 1) q1) ((q1 0) q1) ((q1 1) q0)) (q0)))

(define figure-7-dfa
  '(q0
    (((q0 0) q0) ((q0 1) q1)  ((q1 0) q0) ((q1 1) q2) ((q2 0) q2) ((q2 1) q2))
          (q2)))

(define test7
  (lambda ()
    (simulate
     figure-7-dfa  ; machine description
     '(0 1 1 0 1))))

(define test5
  (lambda ()
    (simulate
     figure-5-dfa  ; machine description
     '(0 1 1 0 1))))
(define test4
  (lambda ()
    (simulate
     figure-4-dfa  ; machine description
     '(a b c))))


;
(test4)
(test5)
(test7)