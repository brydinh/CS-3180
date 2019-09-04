#lang racket

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CS 3180 Fall '19
;; Small Project 00
;; Brian Dinh
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: add implementations for 17.5 & 17.11

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FTN Name:    dotProduct
;; DESCRIPTION: dotProduct takes two lists of numbers and proudces their dot product
;;              (or reports their incompatibility)
(define (dotProduct l1 l2)
  (cond [(> (length l1) (length l2)) (displayln "Lists are incompatible")]
        [(> (length l2) (length l1)) (displayln "Lists are incompatible")]
        [else (define dotProduct (apply + (map * l1 l2))) (displayln dotProduct)]
  )
)

(define (removeAll l1 l2)
  (displayln "help me")
)

(define (lastLess l1 l2)
  (displayln "god left me unfinished")
)



; test cases
(dotProduct '(1 2) '(3 4))
(dotProduct '(1 2 3) '(4 5 6))
(dotProduct '(1 2 3) '(4 5))
(dotProduct '(1 2 ) '(4 5 6))