# G-Lang


## G-Lang is a functional programming language with
  * Lisp like syntax
  * Imperative, non-object oriented
  * Static scope, static binding, strongly typed
  * Keywords:
    * ``` and, or, not, equal, append, concat, set, deffun, for, if, exit ```
  * Operators:
    * ``` +, -, /, *, (, ), ** ```
  * Terminals:
    * Keywords
    * Operators
    * 0-9
    * BinaryValue -> True | False
    * IntegerValue -> [-]* [1-9]* [0-9]+
    * Id -> [a-zA-Z]+

## Grammar Rules of G-Lang

```
- START -> INPUT
 
 - INPUT -> EXPI | EXPLISTI 
 
 - EXPI -> (set ID EXPI) 
 - EXPI -> (+ EXPI EXPI) 
 - EXPI -> (- EXPI EXPI) 
 - EXPI -> (* EXPI EXPI) 
 - EXPI -> (/ EXPI EXPI) 
 - EXPI -> ID | (ID EXPLISTI) | VALUES 
 - EXPI -> (deffun ID IDLIST EXPLISTI) 
 - EXPI -> (ID EXPLISTI) 
 - EXPI -> (defvar ID EXPI) 
 - EXPI -> (set ID EXPI)  
 - EXPI -> (if EXPB EXPLISTI EXPLISTI) 
 - EXPI -> (while (EXPB) EXPLISTI) 
  
 - EXPB -> (and EXPB EXPB) 
 - EXPB -> (or EXPB EXPB) 
 - EXPB -> (not EXPB) 
 - EXPB -> (equal EXPB EXPB) 
 - EXPB -> (equal EXPI EXPI) 
 - EXPB -> BinaryValue 
  
 - EXPLISTI -> EXPI | (concat EXPLISTI EXPLISTI) | (append EXPI EXPLISTI) | null | ‘( VALUES ) | ‘() 
  
 - VALUES -> VALUES IntegerValue | IntegerValue 
  
 - IDLIST -> ID | (IDLIST) | ID IDLIST
```

## Modules 
* Lexer (done)
* Parser (done)
* Evaluator (to do)

## Built With

* [Common Lisp](https://www.gnu.org/software/gcl/) 


