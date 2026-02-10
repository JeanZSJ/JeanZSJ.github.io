#lang racket


#| Morning quiz:

The following gives a list of Turing machine instructions for a machine with four states: 'init, 'incr, 'reset, and 'done. Assume the tape starts with all blank cells, except for a finite sequence of 0s and 1s, with the cursor positioned at the first digit of this sequence. We interpret the input sequence as a binary number. The job of the Turing machine is to increment the given binary number by 1, and then halt with the cursor pointing at the start of the incremented number. For example, if the tape starts in the state 101 (denoting 5), after execution the tape should read 110 (denoting 6).

Many of the instructions have already been provided, but parts of each instruction in the "incr" state are missing. Try to understand how the machine is intended to work, then fill in the missing parts.

(list
  (ins 'init 0  'init 0 'R)
  (ins 'init 1  'init 1 'R)
  (ins 'init 'b 'incr 'b 'L)
  ;(ins 'incr 0 'reset 1 'L)
  ;(ins 'incr 1 'incr 0 'L)
  ;(ins 'incr 'b 'reset  1 'L)
  (ins 'reset 0 'reset 0 'L)
  (ins 'reset 1 'reset 1 'L)
  (ins 'reset 'b 'done 'b 'R)) 


(These instructions are in the format specified in Homework 3, and covered on Friday in class. Each instruction is given as an instance of the ins struct, which has 5 fields: first, the current state and current tape symbol for which the instruction should activate; then, the new state, new symbol, and movement direction ('L or 'R for left or right) to use when the instruction does activate.)
|#

#|

Binary Encoding:

How do you represent pairs using binary? 13,6; for example

How does it know when to divide?

1101; 110;
I probably want to label the beginning of the nums

what is the starting place of the new number?

the 3rd place

8

[_ _ _](predesignated number of digits)[1234][1234]

(you can also make the length of the digit identifier M+N, where M=length of 1st number; N=length of second number


[0 1 1] [1 1 0 1] [1 1 0]

[000000...000 = num length of ]

[][0]

or you can develop a comma with binary


















|#