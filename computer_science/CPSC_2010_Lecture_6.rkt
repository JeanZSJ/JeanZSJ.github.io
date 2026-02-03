#lang racket


#|
Summary:

This lecture is spent analyzing the 3 questions in the morning quiz

(1) We learned how to write list functions map, filter, append

MAP:
(define (my-map func lst)
  (cond
    [(empty? lst) lst]
    [else (cons (func (car lst)) (my-map func (cdr lst)))]))

FILTER:
(define (my-filter1 func lst)
  (cond
    [(empty? lst) lst]
    [(func (car lst))(cons (car lst) (my-filter1 func (cdr lst)))]
    [else (my-filter1 func (cdr lst))]))
;(my-filter1 (lambda(n) (equal? n "haha")) '("haha" "hahahaha" "heiheihei"))=>'("haha")

APPEND:
(define (my-append1 lst1 lst2)
  (cond
    [(empty? lst1) lst2]
    [else (cons (car lst1) (my-append1 (cdr lst1) lst2))]))
;(my-append1 '(1 2 '()) '(3 4)) => '(1 2 '() 3 4)


(2) We learned about the [struct] data structure, and #: transparent
   -(struct user (name id) #:transparent)


(struct worldseed [year planet galaxy])
(define nowseed (worldseed 2025 "earth" "milky-way"))
; nowseed => #<worldseed>

(struct transparent-worldseed [year planet galaxy] #:transparent)
(define nowseed1 (transparent-worldseed 2025 "earth" "milky-way"))
; nowseed1 => (transparent-worldseed 2025 "earth" "milky-way")
|#





#|
Morning Quiz — 1/28/2026

In Racket, the struct special form defines a new datatype with the given fields.

When the following expression is evaluated:

|#

(struct student [name residential-college class-year])

#|

Racket automatically adds five procedures to the active environment:

student : string string number -> student

(Builds a new "student" object with the given name, residential college, and class year.)

student? : any -> boolean

(Tests whether a given argument is a student object.)

student-name : student -> string

(Extracts the name field of a student object.)

student-residential-college : student -> string

(Extracts the residential college field of a student object.)

student-class-year : student -> number

(Extracts the class year of a student object.)

For example, we can write a function that describes a student using a string as follows:

; describe-student : student -> string
(define (describe-student st)
  (string-append
    (student-name st)
    " is an "
    (if (> (student-class-year st) 27)
      "underclassman"
      "upperclassman")
    " in "
    (student-residential-college st)
    " college."))
If we write (define student-1 (student "John Doe" "Berkeley" 29)), then call (describe-student student-1), we get the string "John Doe is an underclassman in Berkeley college."

In this problem, you will have to fill in the recursive case of several recursive functions. The last two use structs, described in the instructions.

You may run the code in Racket to test it.

|#

;Problem 1: The MAP function

; increment-all : (list-of number) -> (list-of number)
; Takes in a (possibly empty) list of numbers, and 
; adds 1 to every number, returning a new list.
; Examples:
;   (increment-all '(1 2 5)) => '(2 3 6)
;   (increment-all '()) => '()
(define (increment-all lst)
  (if (empty? lst)
    '()
    (cons (+ 1 (car lst)) (increment-all (cdr lst)))));

;how you can generalize this:
;this is essentially racket's "map" function
(define (do-to-all operation lst)
  (if (empty? lst)
    '()
    (cons (operation (car lst)) (do-to-all operation (cdr lst)))));

;test-case: (do-to-all (lambda(n) (* n 2)) '(1 2 3))=>'(2 4 6)


;(map function list-1 list-2 ... list-n)
(map (lambda (x) (* x x)) '(1 2 3 4 5 6))
;; => '(1 4 9 16 25 36)


; Problem 2

; find-students : (list-of student) string -> (list-of string)
; Find the names of all students from the given list who are in a given college.
; Assume students are given as student objects, according to the definition in the instructions of this quiz.
; Example:
;   (find-students (list (student "A" "BK" 27) (student "B" "BR" 29) (student "C" "BR" 28)) "BR") => '("B" "C")

(define (find-students lst college)
  (if (empty? lst)
    '()
    (if (equal? (student-residential-college (car lst)) college)
        (cons
         (student-name (car lst))
         (find-students (cdr lst) college))
        (find-students (cdr lst) college))))


; I think using cond is slightly simpler. slightly.

(define (find-students2 lst college)
  (cond
    [(empty? lst) '()]
    [(equal? (student-residential-college (car lst)) college) (cons (student-name (car lst))(find-students2 (cdr lst) college))]
    [else (find-students2 (cdr lst) college)]))


; using map & filter is much simpler

(define (find-students3 lst college)
  (map student-name
       ; apply student-name to each element of the list
       (filter (lambda (st) (equal? (student-residential-college st) college)) lst)))
       ; only include the elements in the list where student-residential college = the one we are looking for

; how to use filter: (filter (some function that gives true or false) list)
; test-case: (find-students3 (list (student "A" "BK" 27) (student "B" "BR" 29) (student "C" "BR" 28)) "BR")=>'("B" "C")


; writing the filter function:
(define (my-filter pred? lst)
  (cond
    [(empty? lst) '()]
    [(pred? (car lst)) (cons (car lst) (my-filter pred? (cdr lst)))]
    [else (my-filter pred? (cdr lst))]))



; you can use block to block multiple lines together;
(require racket/block)

(define (block-example x y)
  (block
   (displayln (string-append "x is : " (number->string x)))
   (displayln (string-append "y is : " (number->string y)))
   (displayln (string-append "x + y is : " (number->string (+ x y))))))
   


; Problem 3

; A player has a name (string) and skill level (number).
(struct player [name skill])
; A game is a match between two players, p1 and p2.
(struct game [p1 p2])

; Each of p1 and p2 may EITHER be a player object OR another match, the idea being that this *other* match must be played first, with the winner moving on to compete in *this* match.
; For example, here is a tournament:

(define my-tournament
  (game
    (game (player "Alice" 9) (player "Jordan" 8))
    (game (player "Ronald" 8)
          (game (player "Teresa" 7) (player "Bob" 6)))))

; In this tournament, Teresa plays Bob (with Teresa winning), then Teresa plays Ronald (with Ronald winning). Alice plays Jordan (with Alice winning),
; and finally Alice plays Ronald (with Alice winning).
; Thus, Alice is the winner of the overall tournament. Given a tournament, the following function should find the winner:
; winner : game -> player
; Example:
;   (player-name (winner my-tournament)) => "Alice"

(define (winner g)
  (define p1 (if (player? (game-p1 g)) (game-p1 g) (winner (game-p1 g))))
  ; find player 1
  (define p2 (if (player? (game-p2 g)) (game-p2 g) (winner (game-p2 g))))
  ; find player 2
   (if (< (player-skill p1) (player-skill p2)) p2 p1))
  ; find the winner


#|

#:transparent, allows a struct's internal structure to be visible

|#

(struct user (name id) #:transparent)
(define u (user "Alice" 101))
; u => (user "Alice" 101)

(struct user1 (name id))
(define u1 (user1 "Bob" 102))
; u1 => #<user1>


#|

Writing the append function:
 
 (define (countup n)
   (if (= n 0)
       '()
       (add-to-end (countup (-n 1)) n)));
  
add to end is a helper function you can write;
|#

(define (my-append lst1 lst2)
  (cond
    [(empty? lst1) lst2]
    [else
     (cons (car lst1) (my-append (cdr lst1) lst2))]))



