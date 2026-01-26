#lang racket

; ----------------------------------------
; summary:
; In the morning quiz, we analyzed various types of errors: parity mismatch, calling something that's not a procedure

; In the lecture, we learned about 2 special forms:
;(1) the [if procedure] (if <body> <if-branch> <else-branch>)
;(2) the [define] procedure, which has 2 forms:
; (a) (define (<function-name> <argument>) (<function-body: what you do with the argument>)
; (b) (define <function-name> (<lambda(n) (<function-body: what you do with n>)>)
; ----------------------------------------


; ----------------------------------------
; Morning Quiz For Lecture 3

;(string-length "Hello" "World")
; parity mismatch, expects 1 argument, given 2

;((+ (if (not (number? 10)) 1 3) 2) 4)
; tries to call a number as procedure

;(define Well (if (string? "Hello") string-append +))
; is "Hello" a string? if yes, well=string-append
;(Well "Hello" "there")
; evalutes to "Hellothere"


;(define age (+ (if #t 3 1) 15))
; if true (always), pick 3, 3+15=18
;(age - 3)
; this tries to call age as a procedure & fails to.
;(- age 3) is correct


;(define x 3)

;(+ (if (< x 5) x y) 1)

; outputs e

; both [define] and [if] are not procedures; they are special forms.
; define evalutes the 2nd argument and assigns the indentifier name to the 2nd argument;

; ----------------------------------------



; ----------------------------------------
; Lecture Notes;

; (if <smt is true> <true branch> <false branch>)

(define m "Hello")

(if (number? m) (+ m 3) (string-append m "There"))

;The lambda special form has syntax: (lambda (<id>) <expr>)
; for example, (lambda (n) (n*n)) [you take in a number, call it n, and square it]
; this is how you define a procedure

(define sqr (lambda (n) (* n n)))

(sqr 2)

(require 2htdp/image)
(require 2htdp/universe)

(define my-function
  (lambda (n)
    (overlay
     (square n "solid" "blue")
     (square 200 "solid" "white"))))

; slow-mo: (number->image)->(number->image)
(define slow-mo
  ;animation: number ->image
  (lambda (animation)
    ;the slow-mo version of animation
    ;.... something new function
    (lambda (frame-number) (animation (/ frame-number 2)))
    ))
    
; the function evaluates the body in a new local environment; if it can't find, it will search in the top environment.
; ----------------------------------------
