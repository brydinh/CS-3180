#lang racket

(require test-engine/racket-tests)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CS 3180 Fall '19
;; Small Project 00
;; Brian Dinh
;;
;; Only the following references were used to inform
;; the development solutions in this file:
;; http://docs.racket-lang.org/guide/Lists__Iteration__and_Recursion.html
;; https://stackoverflow.com/questions/13550482/removing-elements-from-a-list-in-scheme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FTN Name:    dotProduct
;; DESCRIPTION: dotProduct takes two lists of numbers and produces their dot product
;;              (or reports their incompatibility)
(define (dotProduct l1 l2)
  (cond
    [(empty? l1) #f]
    [(empty? l2) #f]
    [(> (length l1) (length l2)) #f]
    [(> (length l2) (length l1)) #f]
    [else (define dotProduct (apply + (map * l1 l2))) dotProduct]
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FTN Name:    max (17.5)
;; DESCRIPTION: max takes one or more numeric arguments and returns the largest of them.
(define(max l1)
  (cond
    [(empty? l1) #f]
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
;; FTN Name:    removeAll
;; DESCRIPTION: removeAll takes two lists, list-a and list-b and returns a list
;;              containing only the items in list-a that are not also in list-b.
(define (removeAll list-a list-b)
  (cond
    [(empty? list-b) list-a]
    [else (removeAll (filter (lambda (x) (not (equal? (first list-b) x))) list-a) (rest list-b))]
  )
)

;; test cases
(check-expect (dotProduct '(1 2) '(3 4)) 11)
(check-expect (dotProduct '(1 1) '(1 1)) 2)
(check-expect (dotProduct '(1 2 3) '(4 5)) #f)
(check-expect (dotProduct '(1 2) '(4 5 6)) #f)

(check-expect (max '(1 3 2)) 3)
(check-expect (max '()) #f)
(check-expect (max '(10 16 19 33 22)) 33)


(check-expect (before-in-list? '(1 2) 1 2) #t)
(check-expect (before-in-list? '(1 2) 2 1) #f)
(check-expect (before-in-list? '() 2 1) #f)

(check-expect (removeAll '(a b b c c d) '(a c a)) '(b b d))
(check-expect (removeAll '(a b b c c d) '(a c b)) '(d))
(check-expect (removeAll '() '(c)) '())


(test)
