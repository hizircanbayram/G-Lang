
;***********************************************************   QUERY FUNCTIONS   ***********************************************************    



; Checks if next expression is type of an EXPI or not. Then it is decided that the flow of a program is going to which finite automata. This function is based on the given grammar.
(defun isEXPI ()
  (cond 
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "+")) (+ 0 1))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "-")) (+ 0 1))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "*")) (+ 0 1))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "/")) (+ 0 1))
	((equal (carcar *lexems*) "identifier") (+ 0 1))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "set")) (+ 0 1))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "deffun")) (+ 0 1))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcar2Check *lexems*) "identifier")) (+ 0 1))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "defvar")) (+ 0 1))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "if")) (+ 0 1))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "while")) (+ 0 1))
;	((equal (carcar *lexems*) "integer") (+ 0 1)) integer'i LISTVALUE kabul ettigimizden beri burasi yorumda. Bakalim ileride ne olacak.
	((and T T) (+ 0 0))))


; Checks if next expression is type of an VALUES or not. Then it is decided that the flow of a program is going to which finite automata. This function is based on the given grammar.
(defun isVALUE ()
  (if (equal (car (car *lexems*)) "integer")
	(+ 1 0)
	(+ 0 0)))


; Checks if next expression is type of an LISTVALUES or not. Then it is decided that the flow of a program is going to which finite automata. This function is based on the given grammar.
(defun isLISTVALUE ()
  (cond 
	((equal (carcdrCheck *lexems*) "null") (+ 1 0))
	((and (equal (carcdrCheck *lexems*) "'") (equal (carcdrCheck2 *lexems*) "(")) (+ 1 0))
	((+ 1 0) (+ 0 0))))


; Checks if next expression is type of an IDLIST or not. Then it is decided that the flow of a program is going to which finite automata. This function is based on the given grammar.
(defun isIDLIST ()
  (cond 
  ((and (equal (carcdrCheck *lexems*) "(") (equal (carcar2Check *lexems*) "identifier")) (+ 1 0))
  ((+ 1 0) (+ 0 0))))


; Checks if next expression is type of an EXPLISTI or not. Then it is decided that the flow of a program is going to which finite automata. This function is based on the given grammar.
(defun isEXPLISTI ()
  (cond 
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "concat")) (+ 1 0))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "append")) (+ 1 0))
	((> (isLISTVALUE) 0) (+ 1 0))
	((+ 0 1) (+ 0 0)) 
	))


; Checks if next expression is type of an EXPB or not. Then it is decided that the flow of a program is going to which finite automata. This function is based on the given grammar.
(defun isEXPB ()
  (cond 
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "and")) (+ 1 0))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "or")) (+ 1 0))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "not")) (+ 1 0))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "equal")) (+ 1 0))
	((equal (carcar *lexems*) "binary") (+ 1 0))
	((+ 0 1) (+ 0 0)) ; kisa yol 
	))
