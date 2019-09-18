#lang racket

(require 2htdp/batch-io)

(define wordLst (read-words "words.txt"))

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
    [(string-contains? (car lst) "z") (+ 1 (count-of (rest lst)))]
    [(string-contains? (car lst) "Z") (+ 1 (count-of (rest lst)))]
    [else (count-of (rest lst))]
  ]
)


(displayln filteredLst)

(count-of wordLst)



; TODO: Optimize filters and function
