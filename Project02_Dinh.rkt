#lang racket

; Require Racket provided test support (as used in assignment's example)
(require test-engine/racket-tests)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ADT Queue Algebraic Specs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; CANONICAL CONSTRUCTORS
;; Queue() : -> Queue
;; enqueue() : Queue, X -> Queue
;; clear() : -> Queue
;;
;; OBSERVERS
;; dequeue() : Queue -> Queue
;; size() : Queue -> Natural
;; equals() : Queue, Queue -> Boolean

;; CONSTRUCTOR AXIOMS
;;
;; ;;;;; The following Axiom specifies "Queue" constructor semantics ;;;;;;
;; Queue() -> Queue
;; AXIOM: size(queue()) = 0
;;
;; ;;;;; The following Axiom specifies "enqueue" constructor semantics ;;;;;;
;; enqueue() : Queue, X -> Queue
;;
;; AXIOM: For all Q in Queue and X
;; size(enqueue(Q, X)) > 0
;;
;; AXIOM: For all Q in Queue
;; dequeue(enqueue(Q, X)) -> Q             ;; enqueue() can be undone via dequeue()
;;
;; AXIOM: For all Q in Queue
;; equals(enqueue(S, X), S) -> False    ;; enqueue() returns a different/modified Queue
;;
;; OBSERVER AXIOMS
;;
;; dequeue:
;; AXIOM: dequeue(queue()) -> queue()
;;    - also -
;; AXIOM: For all Q in Queue
;; dequeue(enqueue(Q, X)) -> Q
;;
;; size:
;; AXIOM: size(queue()) -> 0
;;    - also -
;; AXIOM: For all Q in Queue
;; size(enqueue(Q, X)) -> 1 + size(Q)
;;
;; equal:
;; AXIOM: For all Q in Queue
;; equal(enqueue(Q, X), Q) -> False     ;; enqueue() produces a different queue
;;    - also -
;; AXIOM: For all Q, Q1 in Queue and X, X1  ;; Specifies criteria for equality
;; equal(push(S, X), push(S1, X1)) -> 
;;     True if equal(S, S1) and X is equal X1
;;     else False
;;    - also -
;; AXIOM: For all S, S1 in Stack
;; equal(S, S1) -> equal(S1, S)       ;; Order of comparison doesn't matter
;;    - also -
;; AXIOM: For all S in Stack          ;; Identity property of equal()
;; equal(S, S) -> True

;; Constructor
;; queue -> Queue
(define (queue) '())

;; qenqueue
;; Queue Item -> Queue
(define (qenqueue q item) (append q (list item)))

;; qdequeue
;; Queue -> Queue
(define (qdequeue q) (cdr q))

;; qfirst
;; Queue -> Item if size Queue > 0 else 'error
(define (qfirst q) (first q))

;; qsize
;; Queue -> Natural
;; For all q in Queue
;;   if q = queue then 0
;;   else 1 + qsize (dequeue q)
(define (qsize q) (length q))

;; qclear
;; Queue -> Queue
;; Axiom
;; For a q in Queue
;;   qclear q = queue
(displayln (qfirst (qenqueue (qenqueue (queue) 'a) 'b)))
