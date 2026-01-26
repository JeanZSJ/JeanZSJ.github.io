#lang racket

; ----------------------------------------
; Summary:

; In the morning quiz, we practiced parsing the inputs & outputs of functions.

; In the lecture, we continued parsing the inputs & outputs of functions (we learned that functions can return functions), and we learned about environments (local environment vs top-level environment)
;-----------------------------------------


;--------------------
;Morning Quiz:

; One good question is this: (define w (lamdba (f x) (f (f x x) x)));
; How to go thinking about it:
; from the first lambda, we see that w is a function that takes in two arguments, the function f and the argument x;
; from the second parenthesis, we see that f is a function that takes in two arguments, so it has the contract (number number->number)
; Hence, the contract is (number number -> number) number -> number
;                         |___________f_________|    x     f((f x x) x)

;----------------------


;----------------------
;Lecture

; Part 1: The biodiversity of functions:

; (1) You can take in inputs & not do anything with it
(define bilibala (lambda(n) "hahaha I am ignoring that"))
; if you call (bilibala 333<or whatever input you choose>), you are always going to get "hahaha I am ignoring that"


; (2) You can make a function output a procedure
(define j
  (lambda (n)
    (lambda (m) (+ m n))))
;this one's contract is: number-> (number->number); input a number, output a procedure
; this function j takes in an argument n and returns a new function; this new function takes m and adds n to it
; if you call (j 1), racket returns #<procedure:...ass 4/Lecture_4.rkt:38:4>


(define j-applied-to-1 (j 1))
; this function takes a procedure as input
; if you call j-applied-to-1, it calls (j 1), which calls j; j takes 1 as input and store it as n; (j 1) outputs a procedure that takes m and adds n to it
(j-applied-to-1 5)
; now j-applied-to-1 takes 5 and adds it to n, which is 1, and yields 6

; here are some modifications you can make to the function
(j-applied-to-1 9)
(define j-applied-to-6 (j 6))
(j-applied-to-6 9)

((j 3) 2)
; (j 3) outputs a procedure that adds 3 to m; (j 3) takes 2 as m and outputs 5;


; Part 2: Environments:

(define n 6)
(define x 5)
; these assignments live in the top-level environment


(define g (lambda (n) (* n x)))
; this [n] in lambda(n) lives in the local environment. although it has the same name as our assignment in the top-level environments, they do not interfere because (g 4) overwrites n to 4

(g 4)

; top-level environment: where the lambda procedure g is created; if identifier not found, raise "unbound identifier" error

; how is a function stored?
; formal arguments;
; body: (* n x)
; birth env: top level environment

; local environment: where n=4 is located; if identifier is not found, search top-level environment


; a weird looking function made simple:
((lambda (a + b) (+ a b)) 2 * 3)
; this function takes in a,+,and b as arguments;
; it applies the "+" procedure to a and b;
; it assigns a=2, +=*, b=3
; so it multiplies 2 and 3 to yield 6.

