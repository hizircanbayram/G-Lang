# gLang

gLang is an interpreted programming language that is being developed based on functional programming paradigm. Its lexer and parser are implemented. Any contribution to evaluator or bug notification is very welcome.

## gLang is a functional programming language with
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

## Grammar Rules of gLang

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

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.
    
### Prerequisites

* Common Lisp
* GNU/Linux based operating system

### Installing

After downloading, go to directory where you downloaded the repository to. Then type

```
mv gLang ~
cd
cd gLang
```

Now you are in gLang. Type the following commands.

```
chmod +x install.gl
./install.gl
```

These commands load the install.gl binary to your /usr/bin directory in order to call gLang from any directory in your file system. Now we're ready to go.


### Uninstalling

To uninstall gLang from your local machine, type the following commands after you are in gLang directory.

```
chmod +x uninstall.gl
./uninstall.gl
```

These commands uninstall gLang from your /usr/bin/ directory.

### Deployment

Create a file based on the grammar rules of gLang. After installing, type the following command to execute gLang.

```
glang file_name.gl
```

## Getting your hands dirty on gLang

Create a file, let's say sample.gl. Open it and type the following code sample.

```
(deffun sumup (x)
  (if (equal x 0)
  1
  (+ x (sumup (- x 1)))))
```

Then type the following to run it.

```
glang sample.gl
```

You'll get the following result.

```
START
   INPUT
     EXPI
       deffun
       EXPI
         sumup
       IDLIST
         x
       EXPI
         EXPB
           equal
           EXPI
             x
           VALUES
             0
         VALUES
           1
         EXPI
           +
           EXPI
             x
           EXPI
             EXPI
               sumup
             EXPI
               -
               EXPI
                 x
               VALUES
                 1
```

## Modules 
* Lexer (done)
* Parser (done)
* Evaluator (to do)

## Built With

* [Common Lisp](https://www.gnu.org/software/gcl/) 
