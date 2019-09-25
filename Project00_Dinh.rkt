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

(define (find-words letters)  
  (string-downcase (string-join (filter (lambda (x) (eq? (string-length x) 7))
                                       (filter (lambda (x) (anagram? (string->list (string-downcase x)) (string->list (string-downcase (string-append* letters))))) wordLst)) ", "))
)

(define (anagram? list-a list-b)
  (cond
    [(and (empty? list-b) (empty? list-a)) #t] 
    [(and (empty? list-b) (not (empty? list-a))) #f]
    [(not-char-length? list-a list-b) #f]
    [else (anagram? (filter (lambda (x) (not (equal? (first list-b) x))) list-a) (rest list-b))]
  )
)

(define (not-char-length? list-a list-b)
  (cond
    [(empty? list-a) #f]
    [(<= (count (lambda (x) (eq? x (first list-a))) list-a) (count (lambda (x) (eq? x (first list-a))) list-b)) (not-char-length? (rest list-a) list-b)]
    [else #t]
   )
)

(find-words '("zymomin" "omixa"))



