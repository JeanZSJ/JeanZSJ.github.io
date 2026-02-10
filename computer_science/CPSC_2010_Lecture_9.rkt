#lang racket


#|

Today's lecture introduces recursion functions that return a function as output;

When you need to call a function recursively, you can define a subfunction within the function that updates the number of times the main function is applied;


(define (apply-n-times func times)
  (cond
    [(equal? times 0) func]
    [(> times 0)
     (define (updater n)
       (apply-n-times func (- 1 n)))
       ; this you would use to call the function n-1 times
       ; now you return a function that takes in x (the number of times you repeat the function)
           ;calls the updater to apply the function x-1 times, and then apply the function one more time
       (lambda (x) (func (updater x)))]))

you'll also need to get comfortable understanding what a function outputs when that output contains nested functions

|#



(require racket/trace)

;1. Write a function repeatedly : number (A -> A) -> (A -> A) that takes in a number n and an operation op, and returns repeated-op, which applies op n times to the input. When n is 0, op is performed zero times, i.e. the input is returned as is.

;For example, ((repeatedly 3 sqr) 4) evaluates to (sqr (sqr (sqr 4))) = (sqr (sqr 16)) = (sqr 256) = 65536. As another example, ((repeatedly 5 (lambda (x) (* 2 x))) 3) = 3 * 2 * 2 *2 *2 *2 = 96. Finally, consider the example ((repeatedly 0 sqr) 19), which evaluates to 19 (applies sqr 0 times).

; repeatedly : number (A -> A) -> (A -> A)
(define (repeatedly n op)
  (cond
    ; Base case: when n is zero, return the function that doesn't apply op at all.

    [(= n 0) (lambda (x) x)]
    ; Recursive case: when n > 0...
    [(> n 0)
       ; Make the recursive call to obtain a function that applies op n-1 times
       ; that's very cool, defining a subfunction that updates the main function
       (define op-n-1-times (repeatedly (- n 1) op))
       ; Create the version that applies op n times
       (lambda (x) (op (op-n-1-times x)))]))

;defining a function that calls repeatedly
(define sqr-repeat3 (repeatedly 3 sqr))


(trace repeatedly)

;square the number 3 times, with the number being 10.
(sqr-repeat3 10)



#|

2. Write a function curry :
(A B -> C) -> (A -> (B -> C)), which takes in a function of two arguments, and returns a function that, given the first argument, yields another function still waiting for the second argument. For instance, if curried-plus is (curry +), then ((curried-plus 3) 4) is 7, and (curried-plus 3) is the procedure that adds three to its argument.

|#

; curry : (A B -> C) -> (A -> (B -> C))
(define (curry f)
  ; A -> (B -> C)
  (lambda (a)
    ; curry takes in a
     ; B -> C
    ; and returns a function that takes in b, and does something with a and b.
     (lambda (b)
      (f a b))))

(define curried-+ (curry +))
;(lambda (a) (lambda (b) (+ a b)
; curried-+ takes in the operation + and returns a function is yet to take in an initial value a

(define add3 (curried-+ 3))
;add3 calls curried-+ and supplies 3 to be that initial value

(add3 7)
; (+3 7)=>10
;add3 supplies 7 to be the b-input value.

;what's tricky about this function, is that its output is rather complicated;
;it returns a main function that takes in an initial value 
; & returns a subfunction (which takes in another value and does something with the inital value and the other value);

;hence, if you want a function that is ready to use (i.e., (add5 2))
; you'll first call curry to set the operation sqr
;(define my-add (curry +))

;then you call my-sqr to supply the initial value a;
;(define my-add-init3 (my-add 3))

;and then you call my-add-init3 to take in that final value and finish the computation
;(my-add-init3 5)=>8
#|


3. Now consider the definition (define make-repeater (curry repeatedly)). After this runs, make-repeater will be a function. Give its contract, describe what it does, and give an example of using it.

Contract for the function make-repeater:

|#

; make-repeater : Question Blank 4 of 9

(define make-repeater (curry repeatedly))
; curry takes in the procedure "repeatedly" and returns a function in need of an A input & a B input.
; repeatedly needs 2 arguments: how many times to repeat, and the operation to repeat.

(define threerepeater (make-repeater 3))
; threerepeater calls make-repeater, to set the number of repeat times to be 3;
; this returns a procedure that takes in a procedure, and repeats it 3 times.

((threerepeater sqr) 2)
; threerepeater takes in the procedure square, and returns a function that takes in an initial value b, and squares it 3 times.

(map (curried-+ 7) '(2 3 4 5))

;What make-repeater does to its input:
;(A B -> C) -> (A->(B->C))
;it takes in a function (A B->C)& gives you a subfunction that gives you a subsubfunction(A->(B->C)) ;

#|
(define my-repeater (make-repeater
))
; A->(B->C)

(define my-example (my-repeater
))
; B->C

(define x (my-example Question Blank 8 of 9
type your answer...
))
; now x = Question Blank 9 of 9
type your answer...
|#


#|
Lecture:

;The answer to the question (what instructions should be allowed in an algorithm) defines a programming language.
;There are two approaches to defining a minimal language.


;What makes a function?

The dominant view in the math community: a function is a set of input-output pairs
That creates a problem: can this set {(f,f)} where the function is both the input and the output, be a function?
Math ppl would say a set could not contain itself, because doing so would lead to paradoxes like Russel's Paradox.

Church believed otherwise:
A function f(x)=x can be applied to anything whatsoever, even itself (this is ruled out in the math dominant view)

f(f)=f


Church's alternative: a function is a lambda term.

g = lambda x.x+(x*2)

Is + a function? Is * a function? If they are, shouldn't they be lambda terms?

How can we make them with lambda terms?

the lambda calculus only has variables
(single-argument) lambda terms
(single-argument) function calls

all procedures can be represented as functions

Church Encodings
Booleans:
Boolean operatrions:

Number:

;Stephen Kleene

; great video that explains lambda calculus: https://youtu.be/ViPNHMSUcog?si=epA4iObrqaoRKhXv

|#


(define church-true
  (lambda (x) (lambda (y) x)))

((church-true 1) 0)





