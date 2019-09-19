#lang racket
(require 2htdp/batch-io)

(define wordLst (read-lines "words.txt"))

; TODO: Optimize filters/code

; Part 1: Reads words.txt and filters out 7 letter words that do not contain the letters e, i, o, or u. Output will be on the same line seperated by commas.

(define (contains? word)
  (cond
    [(empty? word) #f]
    [(string-contains? word "e" ) #f]
    [(string-contains? word "i" ) #f]
    [(string-contains? word "o" ) #f]
    [(string-contains? word "u" ) #f]
    [(string-contains? word "E" ) #f]
    [(string-contains? word "I" ) #f]
    [(string-contains? word "O" ) #f]
    [(string-contains? word "U" ) #f]
    [else #t]
    )
)

(define filteredLst
  (string-join (filter (lambda (x) (eq? (string-length x) 7))
                       (filter (lambda (x) (contains? x)) wordLst)) ", "))


; Part 2: Counts how frequent Z and z occurs in wordLst (read from words.txt).
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


(displayln filteredLst)
(count-of wordLst)
