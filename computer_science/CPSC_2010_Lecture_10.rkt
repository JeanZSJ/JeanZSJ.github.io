#lang racket

#|

Morning quiz:

Felt what's like to be a Turing Machine

|#


#|

Two approaches to defining a minimal language

What solvable problem means?

Simplification #1: On the paper, we write symbols from a finite alphabet

Simplification #2: Let's say the paper is organized as a long 1D tape (infinitely long, because you can always buy more paper)

Simplification #3: The tape is ruled into cells, each of which holds one symbol. At any moment, your eyes can only focus on one cell.
(there's some limit to what you can see one time)

Simplification #4: Your brain can only remember a finite amount of information

-state of mind: add numbers state of mind, carry over a 1 state of mind

-if you are in x state of mind, and you see this, change to y-state of mind

By Turing Machine, we mean a particular set of instructions, from which we build a particular machine.

This algorithm is possible: 
The input tape contains instructions for another Turing machine!

Von Neumann model for computer architecture

|#




