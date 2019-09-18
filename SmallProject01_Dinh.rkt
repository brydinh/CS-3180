#lang racket

(require 2htdp/batch-io)

(define wordLst (read-words "words.txt"))

; TODO: Optimize filters and figure out how to iterate through entire string, not check one occurrence/string

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

;(define (count-of lst)
 ; [cond
  ;  [(null? lst) 0]
   ; [(string-contains? (car lst) "z") (+ (killme (string->list (car lst))) (count-of (rest lst)))] ; we want to iterate through the entire string to see if multiple occurrences happen
    ;[(string-contains? (car lst) "Z") (+ (killme (string->list (car lst))) (count-of (rest lst)))] ; we want to iterate through the entire string to see if multiple occurrences happen
    ;[else (count-of (rest lst))]
  ;]
;)

;(define (killme word)
 ; (displayln word)
  ;[cond
   ; [(null? word) 0]
    ;[(char=? (car word) #\z) (+ 1 (killme (rest word)))] ; we want to iterate through the entire string to see if multiple occurrences happen
    ;[(char=? (car word) #\Z) (+ 1 (killme (rest word)))] ; we want to iterate through the entire string to see if multiple occurrences happen
    ;[else (count-of (rest word))]
  ;]
;)