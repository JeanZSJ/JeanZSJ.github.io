#lang racket

; summary:
; This lesson introduces the basics rules of Racket.
; We learn what's a literal & a procedure

(require 2htdp/image)

(circle 10 "solid" "red")

(+ 4 6)

(string? +)

; functions themselves are data in racket

; Church: operations are just a kind of stuff



;Rules of Racket:

;1. Literals evaluate to themselves. Literals include: number, strings, booleans, images
   ; to include the " " mark as string, use \" something \"
;2. The value of an identifier is found by looking it up in the "relevant environment"

;3. A procedure application is enclosed in parenthesis, with the procesure first, followed by its arguments.

; 4. The evaluation rules apply recursively

;5. The define special forn has syntax (define <id> <expression>)
 ; special form because, id is not an existing identifier, it is a new identifier that should be added to the identifier list



;debugging
; we see stuff inside the parenthesis as the procedure
 ; if we type (3), racket will say applicaton: not a procedure, because 3 is not a procedure

; wrong arguments








