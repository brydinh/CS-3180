#lang racket
(require parser-tools/lex (prefix-in : parser-tools/lex-sre))
(define-tokens value-tokens (NUM ERROR SYM COMMENT))
(define-empty-tokens punct-tokens (EOF LPAREN RPAREN ADD MULTIPLY
                                       DIVIDE SUBTRACT LBRACE RBRACE))

(define-lex-abbrev digit (char-set "0123456789"))
(define-lex-abbrev letter (:or (:/ "a" "z") (:/ #\A #\Z) "_"))

(define-lex-abbrev symbol-re (:: letter (:* (:or digit letter))))
  
(define-lex-abbrev comment-re (:: "#"
   (complement (:: any-string #\newline any-string)) #\newline))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CS 3180 Fall '19
;; Small Project 02
;; Brian Dinh
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Returns next token read from in-port
(define get-token ;; get-token is defined as a function that returns a list of
                  ;; tokens scanned from an input-port
  (lexer-src-pos  ;; !!!!! This is a higher order function that returns a
                  ;; generated function that implements regular expression based
                  ;; scanning
    [(eof) 'EOF]
    [(:or #\tab #\space #\newline) (return-without-pos (get-token input-port))]
    [comment-re (return-without-pos (get-token input-port))] ; skips over comment
    ;[(:+ comment-re) (token-COMMENT (string->number lexeme))]
    [(:+ digit) (token-NUM (string->number lexeme))]
    [(:+ symbol-re) (token-SYM (string->number lexeme))]
    [(:: #\() 'LPAREN ]
    [(:: #\)) 'RPAREN]
    [(:: #\+) 'ADD ]
    [(:: #\*) 'MULTIPLY]
    [(:: #\-) 'SUBTRACT]
    [(:: #\/) 'DIVIDE]
    (any-char (token-ERROR lexeme))
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Returns a list of all tokens found read from in-port
(define (build-token-list a-pos-token in-port)
  (cond
    [(eq? 'EOF (token-name (position-token-token a-pos-token)))
       (list a-pos-token)
    ]
    [else (cons a-pos-token (build-token-list (get-token in-port) in-port))]
  )
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Displays all tokens in a a-token-list
(define (display-it a-token-list)
  (cond
     [(empty? a-token-list) (void)]
     [else
        (begin
          (display (token-name (position-token-token (car a-token-list))))     
          (display " ")
          (display-it (cdr a-token-list))
        )
      ]
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TEST DRIVER
;; Read Input Program, Parse It, and Output "Accepted" or "Syntax Error"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Configure input-port to count lines, build a list of all tokens read from
;; and input-port, and then parse the list of tokens indicate of whether the
;; tokens are accepted by the BNF grammar
(define (start-it input-port)
  (begin
    (port-count-lines! input-port)
    (display "(")
    (display-it (build-token-list (get-token input-port) input-port))
    (displayln ")")
  )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Read test cases from standard input for scanning
;;(start-it (current-input-port))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Read test cases from a file for scanning
(start-it (open-input-file "FirstExpressionScannerInput2.txt"))
