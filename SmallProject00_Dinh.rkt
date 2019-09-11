#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CS 3180 Fall '19
;; Small Project 00
;; Brian Dinh
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: add implementations for typer, lastless

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FTN Name:    dotProduct
;; DESCRIPTION: dotProduct takes two lists of numbers and produces their dot product
;;              (or reports their incompatibility)
(define (dotProduct l1 l2)
  (cond
    [(empty? l1) #f]
    [(empty? l2) #f]
    [(> (length l1) (length l2)) (displayln "Lists are incompatible")]
    [(> (length l2) (length l1)) (displayln "Lists are incompatible")]
    [else (define dotProduct (apply + (map * l1 l2))) (displayln dotProduct)]
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FTN Name:    max (17.5)
;; DESCRIPTION: max takes two lists of numbers and returns the larger list
(define(max l1)
  (cond
    [(empty? l1) "bad"]
    [(empty? (rest l1)) (first l1)]
    [else (max2  (first l1) (max (rest l1)))]
    )
)
    

(define (max2 a b)
  (if (> b a) b a))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FTN Name:    before-in-list? (17.11)
;; DESCRIPTION: before-in-list? takes a list and 2 elements of the list. Returns
;;              true if the second argument appears before the third argument. 
(define (before-in-list? l1 e1 e2)
   (cond
    [(empty? l1) #f]
    [(eq? e1 (first l1)) #t]
    [(eq? e2 (first l1)) #f]
    [else (before-in-list? (rest l1) e1 e2)]
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FTN Name:    remove-all
;; DESCRIPTION: 
(define (removeAll list-a list-b)
  (cond
    [(empty? list-b) list-a]
    [else (removeAll (filter (lambda (x) (not (equal? (first list-b) x))) list-a) (rest list-b))]
  )
)
    
(define (lastLess l1 l2)
  (displayln "lol")
)

(define (typer nl)
   (displayln "lol")
)

; test cases
;(dotProduct '(1 2) '(3 4))
;(dotProduct '(1 2 3) '(4 5 6))
;(dotProduct '(1 2 3) '(4 5))
;(dotProduct '(1 2 ) '(4 5 6))

;(before-in-list? '(1 2) 1 2)
;(before-in-list? '(2 1) 1 2)

(removeAll '(a b b c c d) '(a c a))

(max '(0 2))