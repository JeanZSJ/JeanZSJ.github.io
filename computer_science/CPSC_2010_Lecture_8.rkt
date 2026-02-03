#lang racket


#|
Summary:
We learned about the 2 ways to write recursion on trees:

(1) Car-Cdr method: recurse on car, recurse on cdr; combine results

(2) All-Children method: use map to break the list into smaller elements, then recurse on the individual parts; then combine results.

|#


#|

Lecture 8:


Tree Recursion:

Nested lists can be viewed as trees

                       * root node
                     / | \
                   / \ 'c /\  "nodes"
                 'a  'b 'd  'f
                    "leaves"
other stuff: parent/children etc.

                 '(+ 1 (* 3 2))
                     / | \
                    +  1  /|\
                         * 3 2
Given a string, return a string concatenating alll leaf nodes in left-to-right order

2 General Strategies:

(1) Car/Cdr recursion:
    - base case (can't break down further): '() => " "
                                            'x => "x" (symbol-to-string x)
    - recurse on car, recurse on cdr, combine results (string-append)

(2) All children recursion:
     -base case: individual leavs
     -recursive: recurse on individual branches
|#

(define (stringify tree)
  (cond
    [(empty? tree) ""]
    [(symbol? tree) (symbol->string tree)]
    [else (string-append
           (stringify (car tree))
           (stringify (cdr tree)))]))
; what's different here is that you call stringify on both the car and the cdr, while in previous code we only call recursively on the cdr

(define (stringify2 tree)
  (cond
    [(symbol? tree) (symbol->string tree)]
    [else (join-list-of-strings (map stringify2 tree))]))
; map does the operation to every element
; join-list-of-strings joins list of strings


(define (join-list-of-strings strs)
  (if (empty? strs) "" (string-append (car strs)
                                     (join-list-of-strings (cdr strs)))))

;
(require racket/trace)
(trace stringify2)
(stringify2 '((a b) (c (d e) f)))

#|

What instructions should be allowed in an algorithm?
; any answer to this question defines a "programming language"
; 2 approaches to defining a minimal language
; turing & church.

|#




  