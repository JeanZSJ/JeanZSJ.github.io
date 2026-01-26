#lang racket

;---------------x--------------------
;summary:
; morning quiz: introductino to lists & basic procedures on lists
; lecture: special forms (list & quote), how to write recursion
;---------------x-------------------


;---------------x-------------------
; morning quiz:
; We learned about how to construct a list & basic procedures on lists;
; constructing a list: (list 1 2 (+ 3 4)) evaluates to '(1 2 7)

; weird things you can do with lists:
; (list (list (list (list)))) evaluates to '((( () )))
;(list (+ 3 4) + 3 4) evaluates to '(7 #procedure: +> 3 4)

; we also learned about procedures on list
;(car (1 2 3)) evaluates to 1
;(cdr '(1 2 3)) evaluates to '(2 3)
;(cadr ' (1 2 3)) evaluates to 2
;(empty? '(1 2 3)) evaluates to #f
;(cons (+ 7 8) ' (23 42)) evaluates to ' (15 23 42)

; here's some good questions:
; (empty? '((0)) evaluates to #f
; (empty? (cdr '((())))) evaluates to #t [the nested list counts as a single element]
;(cons '(1) '(2 3)) evaluates to ((1) 2 3)

;----------------x----------------

;----------------x----------------
;lecture:
; We learned about special forms: list & quote;
; We also learned about how to write recursion.

;---------------------------------

; (1) Quote, (quote <expression>)
; (a) If <expr> is a literal, return it unchanged
; (b) If <expr> is an identifier id, return the symbol 'id
; (c) If <expr> is of the form (<expr> ...), return a new list, with one element per expression

;---------------------------------
; How to write Recursion:

; (Example 1:) How can we write a function to find the length of a list?
; our-length: list->number
(define (our-length lst)
  (if (empty? lst)
      ; base case, when our job is easy and the answer is immediate
      0
      ; recursive case: imagine our-length already works for all smaller lists
      (+ 1 (our-length (cdr lst)))
      ))

;(our-length '(5 6 (1 2 3)))

;(+1 (our-length '(6 (1 2 3))))

;(+1 (+1 (our-length '((1 2 3)))))

;(+1 (+1 (+1 (our-length '()))))

;(+1 (+1 (+1 0))) evaluates to 3
;---------------------------------

; (Example 2:) How can we write a function to build a list of given length?

; countdown: number -> list

(define (countdown n)
        (if (= n 0)
            ;base case: when our job is easy and the answer is immediate
            '(0)
            ;Recursive case: imagine countdown already works for all smaller n
            ; you want to print n, n-1, n-2, n-3... into a list
            (cons n (countdown (- n 1)))
            ))

(countdown 1000)

;---------------------------------

      
