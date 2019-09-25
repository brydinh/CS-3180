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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; find-words: Filters out words in words.txt that do not have a string-legnth of 7
;;             or are not an anagram of the letters being passed. Uses helper function
;;             anagram? for main filter. 
(define (find-words letters)  
  (string-downcase (string-join
                    (filter (lambda (x) (eq? (string-length x) 7))
                            (filter (lambda (x) (anagram? (string->list (string-downcase x))
                                                          (string->list (string-downcase (string-append* letters))))) wordLst)) ", "))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; anagram?: Returns true if words in words.txt are composed of the same characters,
;;           and is <= number of characters of the string list being passed.
;;           Uses helper function not-char-length? for character check. 
(define (anagram? word letters)
  (cond
    [(and (empty? letters) (empty? word)) #t] 
    [(and (empty? letters) (not (empty? word))) #f]
    [(not-char-length? word letters) #f]
    [else (anagram? (filter (lambda (x) (not (equal? (first letters) x))) word) (rest letters))]
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; not-char-length?: Returns true if the characters in the word are greater than
;;                   the number of characters of the string list being passed.
(define (not-char-length? word letters)
  (cond
    [(empty? word) #f]
    [(<= (count (lambda (x) (eq? x (first word))) word) (count (lambda (x) (eq? x (first word))) letters)) (not-char-length? (rest word) letters)]
    [else #t]
   )
)

;; Test-cases
(find-words '("zymomin" "omixa"))



