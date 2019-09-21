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

; help

; TODO Figure out how to account for one letter/each

(define (find-words letters)
  (string-downcase (string-join (filter (lambda (x) (eq? (string-length x) 7))
                       (filter (lambda (x) (contains? (string->list (string-downcase x)) (string->list (string-append* letters)))) wordLst)) ", "))
)

; BOTH PASSED ARGUMENTS ARE CHAR LISTS
(define (contains? list-a list-b) ; A = (a z i m i n o), B = (z y m o m i n o i x a)
  (cond
    [(and (empty? list-b) (empty? list-a)) #t] ; both list-a and list-b are composed of each other.
    [(and (empty? list-b) (not (empty? list-a))) #f] ; list-a and list-b are inherently different  
    [else (contains? (filter (lambda (x) (not (equal? (first list-b) x))) list-a) (rest list-b))]
  )
)

; Currently prints:
;                  Amazona, ammonia, amninia, Anamnia, anonyma, azimino, Izanami, mammoni, Manannn,
;                  mannaia, manomin, Manxman, manzana, Manzoni, maximin, Maximon, Mazzini, minimax,
;                  Moazami, monaxon, Monimia, monnion, monoazo, Monomya, mononym, Monozoa, moonman,
;                  Naamana, Naamann, Nanaimo, omniana, Oxonian, oxonian, xoanona, yamamai, yamanai,
;                  Yannina, Zannini, Zanonia, Zizania, zizania, zoonomy, zymomin"


; Should output- azimino, mammoni, maximin, maximon, minimax, monimia, monomya, zymomin
  

;(contains? '(a z i m i n o) '(z y m o m i n o i x a))
;(contains? '(m a m m o n i) '(z y m o m i n o i x a))
;(contains? '(m a x i m i n) '(z y m o m i n o i x a))
;(contains?  '(M a x i m o n) '(z y m o m i n o i x a))
;(contains? '(m i n i m a x) '(z y m o m i n o i x a))
;(contains? '(m o n i m i a) '(z y m o m i n o i x a))
;(contains? '(m o n o m y a) '(z y m o m i n o i x a))
;(contains? '(z y m o m i n) '(z y m o m i n o i x a))


(find-words '("zymomin" "omixa"))



