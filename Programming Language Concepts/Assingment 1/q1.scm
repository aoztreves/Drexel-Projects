#lang scheme

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))



(define sample-tree
  (make-code-tree (make-leaf 'a 4)
                  (make-code-tree
                  (make-code-tree (make-leaf 'b 2) (make-leaf 'c 1))
                  (make-leaf 'd 1))))



(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))



(define (in-list? x xs)
  (cond [(null? xs) #f]
        [(equal? x (car xs)) #t]
        [else (in-list? x (cdr xs))]))

(define (encode-symbol symbol tree)
  (if (in-list? symbol (symbols tree))
      (if (leaf? tree) 
          '()
          (let ((l (left-branch tree))
                (r (right-branch tree)))
            (if (in-list? symbol (symbols l))
                (cons 0 (encode-symbol symbol l))
                (cons 1 (encode-symbol symbol r)))))
      (error "symbol is not in tree" symbol tree)))




;Test

(decode '(1 0 0 1 0 1 1 1 0) sample-tree)

(encode '(b c d a) sample-tree)