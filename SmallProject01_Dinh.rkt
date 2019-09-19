#lang racket
(require 2htdp/batch-io)

(define wordLst (read-lines "words.txt"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CS 3180 Fall '19
;; Small Project 01
;; Brian Dinh
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Part 1: Reads words.txt and filters out 7 letter words that do not contain
;;         the letters e, i, o, or u. Output will be on the same line seperated
;;         by commas. Implemented helper function for letter check.

(define (contains? word)
  (cond
    [(empty? word) #f]
    [(or (string-contains? word "e") (string-contains? word "i") (string-contains? word "o")
         (string-contains? word "u") (string-contains? word "E") (string-contains? word "I")
         (string-contains? word "O") (string-contains? word "U")) #f]
    [else #t]
    )
)

(define filteredLst
  (string-join (filter (lambda (x) (eq? (string-length x) 7))
                       (filter (lambda (x) (contains? x)) wordLst)) ", "))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Part 2: Counts how frequent the letters 'Z' and 'z' occurs in words.txt. The
;;         Count-of function detects if 'Z' or 'z' are present in the string,
;;         and the helper function count-char counts the total amount of time 'Z'
;;         or 'z' occurs per string.

(define (count-of lst)
  [cond
    [(null? lst) 0]
    [(string-contains? (first lst) "z") (+ (count-char (string->list(first lst))) (count-of (rest lst)))] 
    [(string-contains? (first lst) "Z") (+ (count-char (string->list(first lst))) (count-of (rest lst)))] 
    [else (count-of (rest lst))]
  ]
)

(define (count-char word)
  (+ (count (lambda (x) (eq? x #\z)) word) (count (lambda (x) (eq? x #\Z)) word))
)

;; Displays filtered list & number of z occurrences
(displayln filteredLst)
(count-of wordLst)
