#lang racket



#|

Summary:

We learned

(1) How to use trace to see what the code is doing

(require racket/trace)
(trace func)
(func some parameters)


(2) Iterative vs recursive functions, and how iterative functions are more efficient in some cases

; Note: need to meditate on iterative & recursive functions (more internalization needed)

|#



(require racket/trace)
(require racket/block)

; morning quiz
(define (mystery-func x)
  (cond
    [(number? x) (list x)]
    [(symbol? x) (list (symbol->string x))]
    [(empty? x) '()]
    [(not (list? x)) (list 'unsupported-type)]
    [else (helper (mystery-func (car x)) (mystery-func (cdr x)))]))

; redefining the append function again
(define (helper x y)
  (cond
    [(empty? x) y]
    [else (cons (car x) (helper (cdr x) y))]))

;you can use trace to see what the function is doing

;!!!!!
;(trace mystery-func)
;!!!!!

(mystery-func '(1 2 3 x))

#|
>(mystery-func '(1 2 3 x))
> (mystery-func 1)
< '(1)
> (mystery-func '(2 3 x))
> >(mystery-func 2)
< <'(2)
> >(mystery-func '(3 x))
> > (mystery-func 3)
< < '(3)
> > (mystery-func '(x))
> > >(mystery-func 'x)
< < <'("x")
> > >(mystery-func '())
< < <'()
< < '("x")
< <'(3 "x")
< '(2 3 "x")
<'(1 2 3 "x")
'(1 2 3 "x")

|#


#|
; the cond expression:

evaluate the first expression of each branch, starting at the top, until one of them is #t or else

; how can you understand what the procedure does?


CODETracing

(1) Try base cases:
- (mystery-func '())=> '()
- (myster-func 3)=>'()
- (myster-func '(42))
=> (helper (mystery-func 42))(myster-func '())
=>(cons 42 (helper '() '()))
=> (cons 42 '())=>'(42)

(2) Make hypothesis:
-(myster-func '(1 42))
-(helper (mystery-func 1) (mystery-func 42))
=>(helper '(1) '(42)) ; breaking it into things we already know the output of;
=> (cons 1 (cons '() '(42))) => (cons 1 '(42)) => '(1 42)

=> so now we know that helper is appending 2 lists

;note: if I could visualize these recursion procedures as function blocks (in a tree like fashion), it would be much easier to understand.

;now we can guess that '(1 2 3 4 5)=> '(1 2 3 4 5)

(mystery-func '((42))) => (helper (mystery-func '(42))(mystery-func '())) => (helper '(42) '()) =>'(42)
; it removes all the nesting

; skill: can you trace your code?
; on an exam: figure out what a mystery func does

; you can add (block) to group stuff together;

; you can use (trace) to do code tracing
|#



#|
A simple recursive function vs a simple iterative function:
|#

; This is a simple recursive function:

(define (sum lst)
  (cond
    [(empty? lst)
     0]
    [else
     (+ (car lst) (sum (cdr lst)))]))

; It uses memory to remember all the things it has to do

; This is a simple iterative function doing the same thing that takes up less memory
(define (sum-list lst)
  (define (helper sum-so-far remaining-nums)
    (cond
      ; stop condition: when is my job done:
      [(empty? remaining-nums)
       sum-so-far]
      [else (helper
             (+ (car remaining-nums) sum-so-far)
             (cdr remaining-nums))]))
  ;start & initialize the loop
(helper 0 lst))


; recursive functions call themselves & take up more memory;
; iterative functions utilize helper functions to create a loop & take up less memory:


; a recursive count-up

(define (countup-rec n)
  (if (= n 0) '() (append (countup-rec (- n 1)) (list n))))
; Base case: when our job is easy and the answer is immediate
; Recursive case: imagine countup already works for all smaller n

(trace countup-rec)
(countup-rec 5)

#| Here's the memory of the recursive case:

>(countup-rec 5)
> (countup-rec 4)
> >(countup-rec 3)
> > (countup-rec 2)
> > >(countup-rec 1)
> > > (countup-rec 0)
< < < '()
< < <'(1)
< < '(1 2)
< <'(1 2 3)
< '(1 2 3 4)
<'(1 2 3 4 5)
'(1 2 3 4 5)

|#

; writing an interative countup function
(define (countup n)
  (define (helper list-so-far M)
    (cond
      [(= M 0) list-so-far]
      [else (helper
             (cons M list-so-far) (- M 1))]))
  ; (cons v1 v2)=>'(v1 v2)
  ; here you are creating a list by putting a M that is increasingly getting smaller at the front
  ; so it makes sense that it is a count-up
  (helper '() n))


(trace countup)
(countup 5)


#|Here's the memory of the iterative case:

>(countup 5)
<'(1 2 3 4 5)
'(1 2 3 4 5)

|#

















