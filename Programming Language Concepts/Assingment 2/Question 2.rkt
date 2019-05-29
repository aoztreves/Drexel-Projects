#lang scheme

;4.4 and 4.9 of 4.1.2

; Exercise 4.4.
;
; Recall the definitions of the special forms and and or from
; chapter 1:

; and: The expressions are evaluated from left to right. If any expression
; evaluates to false, false is returned; any remaining expressions are not
; evaluated. If all the expressions evaluate to true values, the value of the
; last expression is returned. If there are no expressions then true is
; returned.
;
; or: The expressions are evaluated from left to right. If any
; expression evaluates to a true value, that value is returned; any remaining
; expressions are not evaluated. If all expressions evaluate to false, or if
; there are no expressions, then false is returned.  Install and and or as new
; special forms for the evaluator by defining appropriate syntax procedures and
; evaluation procedures eval-and and eval-or.  Alternatively, show how to
; implement and and or as derived expressions.
; ------------------------------------------------------------

(define (and-eval exp env)
  (define (and-operands-eval-recur operands)
    (let ((next (car operands))
          (rest (cdr operands)))
      (cond ((null? next) '#t)
            ((null? rest) (eval next env))
            ((eq? (eval next env) '#f) '#f)
            ((eq? (eval next env) '#t)
             (and-operands-eval-recur (cdr operands))))))
  (and-operands-eval-recur (cdr exp)))

(define (or-eval exp env)
  (define (or-operands-eval-recur operands)
    (let ((next (car operands))
          (rest (cdr operands)))
      (cond ((null? next) '#f)
            ((eq? (eval next env) '#t) '#t)
            ((eq? (eval next env) '#f)
             (or-operands-eval-recur (cdr operands))))))
  (or-operands-eval-recur (cdr exp)))

;(and-eval '(and a b) '((a #t) (b #f)))

;Exercise 4.9

;Many languages support a variety of iteration constructs, such as do, for, while, and until.
;In Scheme, iterative processes can be expressed in terms of ordinary procedure calls,
;so special iteration constructs provide no essential gain in computational power.
;On the other hand, such constructs are often convenient. Design some iteration constructs,
;give examples of their use, and show how to implement them as derived expressions.
;(define (while? exp) (tagged-list? exp 'while))
(define (for? exp)
  (tagged-list? exp 'for))

(define (for-var exp)
  (car (cadr exp)))

(define (for-initial exp)
  (cadr (cadr exp)))

(define (for-condition exp)
  (caddr exp))

(define (for-update exp)
  (cadddr exp))

(define (for-body exp)
  (cddddr exp))

(define (for->named-let exp)
  (list 'let 'go (list (list (for-var exp) (for-initial exp)))
        (list 'if (for-condition exp)
              (cons
                (cons 'begin (for-body exp))
                (list 'go (for-update exp))))))

;Exercise 4.11.

;Instead of representing a frame as a pair of lists, we can represent a
;frame as a list of bindings, where each binding is a name-value pair.
;Rewrite the environment operations to use this alternative representation.

(define (make-binding var val)
  (cons var val))

(define (binding-variable binding)
  (car binding))

(define (binding-value binding)
  (cdr binding))
(define (make-frame variables values)
  (list (map make-binding variables values)))
(define (frame-variables frame) (map binding-variable (car frame)))
(define (frame-values frame) (map binding-value (car frame)))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons (make-binding var val) (car frame))))
(define (set-binding-value! binding val)
  (set-cdr! binding val))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan bindings)
      (cond ((null? bindings)
             (env-loop (enclosing-environment env)))
            ((eq? var (binding-variable (car bindings)))
             (set-binding-value! (car bindings) val))
            (else (scan (cdr bindings)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable -- SET!" var)
        (let ((frame (first-frame env)))
          (scan frame))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan bindings)
      (cond ((null? bindings)
             (add-binding-to-frame! var val frame))
            ((eq? var (binding-variable (car bindings)))
             (set-binding-value! (car bindings) val))
            (else (scan (cdr bindings)))))
    (scan frame)))