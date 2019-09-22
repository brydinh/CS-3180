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

; TODO: Optimize this flaming piece of shit

(define (find-words letters)
  (string-downcase (string-join (filter (lambda (x) (killMe? (string->list (string-downcase x)) (string->list (string-downcase (string-append* letters)))))
          (filter (lambda (x) (eq? (string-length x) 7)) (filter (lambda (x) (contains? (string->list (string-downcase x)) (string->list (string-append* letters)))) wordLst))) ", "))
)

(define (contains? list-a list-b)
  (cond
    [(and (empty? list-b) (empty? list-a)) #t] 
    [(and (empty? list-b) (not (empty? list-a))) #f]
    [else (contains? (filter (lambda (x) (not (equal? (first list-b) x))) list-a) (rest list-b))]
  )
)

(define (killMe? list-a list-b)
  (cond
    [(empty? list-a) #t]
    [(<= (how-many list-a (first list-a)) (how-many list-b (first list-a))) (killMe? (rest list-a) list-b)]
    [else #f]
   )
)

(define (how-many word char)
  (count (lambda (x) (eq? x char)) word)
)

(find-words '("zymomin" "omixa"))




