#lang racket
(require 2htdp/batch-io)

;(time (begin (read-lines "words.txt") 'done))

(define wordLst (read-lines "words.txt"))

; TODO: Optimize filters/code

; Part 1: Reads words.txt and filters out 7 letter words that do not contain the letters e, i, o, or u. Output will be on the same line seperated by commas.
(define filteredLst (string-join (filter (lambda (x) (eq? (string-length x) 7))
        (filter (lambda (x) (not (string-contains? x "e")))
                (filter (lambda (x) (not (string-contains? x "i")))
                        (filter (lambda (x) (not (string-contains? x "o")))
                                (filter (lambda (x) (not (string-contains? x "u")))
                                        (filter (lambda (x) (not (string-contains? x "E")))
                                                (filter (lambda (x) (not (string-contains? x "I")))
                                                        (filter (lambda (x) (not (string-contains? x "O")))
                                                                (filter (lambda (x) (not (string-contains? x "U"))) wordLst))))))))) ", "))

; Part 2:
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
