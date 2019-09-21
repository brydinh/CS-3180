#lang racket
(require 2htdp/batch-io)

(define wordLst (read-lines "words.txt"))

; CONTRACT: find-words : letters -> String
; PURPOSE: Returns a string of comma delimited dictionary words 7
; letters long and in alphabetical order that can be composed of
; characters in letters. (anagrams of letters) There is no trailing
; comma after the last word in the returned string.
; Each letter in letters may only be used once per match, e.g.
; (find-words '("zymomin" "am")) could return "mammoni, zymomin"
; because "mammoni" is composed of letters in letters including the
; three 'm' characters in letters, and "zymomin" is similarly composed of
; letters in letters. However, "mammomi" could not be 
; returned because "mammomi" requires four 'm' characters and 
; only three are available in letters.
; CODE:

; Gods I was strong then

; TODO Figure out correct logic for contains?
(define (find-words letters)
  (string-join (filter (lambda (x) (eq? (string-length x) 7))
                       (filter (lambda (x) (contains? (string->list x) (string->list (string-append* letters)))) wordLst)) ", ")  
)

; BOTH PASSED ARGUMENTS ARE CHAR LISTS
(define (contains? list-a list-b) ; A = (a z i m i n o), B = (z y m o m i n o i x a)
  (cond
    [(and (empty? list-b) (empty? list-a)) #t]
    [(and (empty? list-b) (not (empty? list-a))) #f]
    [else (contains? (filter (lambda (x) (not (equal? (first list-b) x))) list-a) (rest list-b))]
  )
)

(define (removeAll list-a list-b)
  (cond
    [(empty? list-b) list-a]
    [else (removeAll (filter (lambda (x) (not (equal? (first list-b) x))) list-a) (rest list-b))]
  )
)

; Maximon, monimia, monomya
; ammonia, amninia, anonyma,

;(removeAll '(a z i m i n o) '(z y m o m i n o i x a))
;(removeAll '(m a m m o n i) '(z y m o m i n o i x a))
;(removeAll '(m a x i m i n) '(z y m o m i n o i x a))
;(removeAll '(m a x i m o n) '(z y m o m i n o i x a))
;(removeAll '(m i n i m a x) '(z y m o m i n o i x a))
;(removeAll '(m o n i m i a) '(z y m o m i n o i x a))
;(removeAll '(m o n o m y a) '(z y m o m i n o i x a))
;(removeAll '(b y m o m i n) '(z y m o m i n o i x a))



;(removeAll '(a z i m i n o) '(z y m o m i n o i x a))
;(removeAll '(a b b c c d) '(a c a))

; displayln (find-words '("zymomin" "omixa"))) should output
; azimino, mammoni, maximin, maximon, minimax, monimia, monomya, zymomin
  
(find-words '("zymomin" "omixa"))



