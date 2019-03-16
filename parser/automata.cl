
;***********************************************************   FINITE AUTOMATAS   ***********************************************************    



; This is one of the finite automatas. When the flow of a program runs into an expression which is type of EXPI, specifies which EXPI it is. It then starts creating a branch of a tree recursively and stores it in the variable called *AST*. If it runs into an expression that is not defined in the given grammar, it prints it on the screen.
(defun expi (lexems)
  (if (equal (carcdrCheck lexems) ")") 
    (cleanParentheses ")")) 
  (cond 
	((equal (carcar *lexems*) "identifier") (list "EXPI" (carcdr *lexems*)))
	((equal (carcar *lexems*) "integer") (list "VALUES" (carcdr *lexems*)))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "+")) (expiOperation "+"))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "-")) (expiOperation "-"))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "*")) (expiOperation "*"))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "/")) (expiOperation "/"))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "set")) (setOperation))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "deffun")) (deffunOperation))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcar2Check *lexems*) "identifier")) (expi_explisti_operation))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "defvar")) (defvarOperation))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "if")) (ifOperation))
    ((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "while")) (whileOperation))
	((and T T) (print "ERROR EXPI!!"))
 ))


; This is one of the EXPI operation. If the expression is either +, -, * or /, this function creates it recursively.
(defun expiOperation (opr)
  (carcdr *lexems*)
  (carcdr *lexems*)
  (setf *parentheses* (+ *parentheses* 1))
  (list "EXPI" opr (expi *lexems*) (expi *lexems*)))


; This is one of the EXPI operation. If the expression is if, this function creates it recursively.
(defun ifOperation ()
  (carcdr *lexems*)
  (carcdr *lexems*)
  (setf *parentheses* (+ *parentheses* 1))
  (list "EXPI" (expb) (explisti) (explisti)))


; This is one of the EXPI operation. If the expression is while, this function creates it recursively.
(defun whileOperation ()
  (carcdr *lexems*)
  (carcdr *lexems*)
  (setf *parentheses* (+ *parentheses* 1))
  (list "EXPI" (list "EXPI" "while") (expb) (explisti)))
  

; This is one of the EXPI operation. If the expression contains an expression which is type of EXPLISTI, this function creates it recursively.
(defun expi_explisti_operation ()
  (carcdr *lexems*)
  (setf first_id (carcdr *lexems*))
  (setf *parentheses* (+ *parentheses* 1))
  (list "EXPI" (list "EXPI" first_id) (explisti)))


; This is one of the EXPI operation. If the expression is defvar, this function creates it recursively.
(defun defvarOperation ()
  (carcdr *lexems*)
  (carcdr *lexems*)
  (setf *parentheses* (+ *parentheses* 1))
  (list "EXPI" (list "EXPI" (carcdr *lexems*)) (expi *lexems*)))


; This is one of the EXPI operation. If the expression is set, this function creates it recursively.
(defun setOperation ()
  (carcdr *lexems*)
  (carcdr *lexems*)
  (setf *parentheses* (+ *parentheses* 1))
  (list "EXPI" "set" (idOperation "ERROR | AFTER set KEYWORD, AN IDENTIFIER IS REQUIRED.") (expi *lexems*)))


; This is one of the EXPI operation. If the deffun is set, this function creates it recursively.
(defun deffunOperation ()
  (carcdr *lexems*)
  (carcdr *lexems*)
  (list "EXPI" "deffun" (idOperation "ERROR | AFTER deffun KEYWORD, AN IDENTIFIER IS REQUIRED.") (idlist) (explisti)) 
  )


; This is one of the EXPI operation. If the deffun is set, this function creates it recursively.
(defun idOperation (errMessage)
  (if (equal (carcar *lexems*) "identifier")
	(list "EXPI" (carcdr *lexems*))
	(format t errMessage)))


; This is one of the LISTVALUE operation. It creates one of the LISTVALUE branch recursively.
(defun value ()
  (if (equal (carcdrCheck *lexems*) ")") 
    (skipParentheses))
  (if (equal (car (car *lexems*)) "integer")
	(list (carcdr *lexems*) (value))))


; This is one of the finite automatas. When the flow of a program runs into an expression which is type of LISTVALUE, specifies which LISTVALUE it is. It then starts creating a branch of a tree recursively and stores it in the variable called *AST*. If it runs into an expression that is not defined in the given grammar, it prints it on the screen.
(defun listvalue ()
  (if (equal (carcdrCheck *lexems*) ")") 
    (skipParentheses))
  (cond 
	((equal (carcdrCheck *lexems*) "null") (list "EXPLISTI" (carcdr *lexems*))) ; VALUES TEKRAR EXPI'YA CEVRILEBILIR
	((and (equal (carcdrCheck *lexems*) "'") (equal (carcdrCheck2 *lexems*) "(")) (listvalueOperation))
	((equal (carcar *lexems*) "integer") (list "VALUES" (carcdr *lexems*)))
	((and T T) (print "ERROR LISTVALUE!! "))))
  

; This is one of the finite automatas. When the flow of a program runs into an expression which is type of IDLIST, specifies which IDLIST it is. It then starts creating a branch of a tree recursively and stores it in the variable called *AST*. If it runs into an expression that is not defined in the given grammar, it prints it on the screen.
(defun idlist ()
  (cond
   ((and (equal (carcdrCheck *lexems*) "(") (equal (carcar2Check *lexems*) "identifier")) (list "IDLIST" (idlistOperation)))))


; This is one of the IDLIST operation. It creates one of the IDLIST branch recursively.
(defun idlistOperation ()
  (if (equal (carcdrCheck *lexems*) ")") 
    (skipParentheses))
  (setf *parentheses* (+ *parentheses* 1))
  (carcdr *lexems*)
  (if (equal (carcar *lexems*) "identifier")
	(list (carcdrCheck *lexems*) (idlistOperation))))


; This is one of the LISTVALUE operation. It creates one of the LISTVALUE branch recursively.
(defun listvalueOperation () 
  (carcdr *lexems*)
  (carcdr *lexems*)
  (setf *parentheses* (+ *parentheses* 1))
  (list "LISTVALUE" (value)))


; This is one of the finite automatas. When the flow of a program runs into an expression which is type of EXPLISTI, specifies which EXPLISTI it is. It then starts creating a branch of a tree recursively and stores it in the variable called *AST*. If it runs into an expression that is not defined in the given grammar, it prints it on the screen.
(defun explisti ()
  (if (equal (carcdrCheck *lexems*) ")") 
    (skipParentheses))
  (cond 
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "concat")) (explistiOperation "concat"))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "append")) (explistiOperation "append"))
	((isEXPI) (expi *lexems*))
	((isLISTVALUE) (list "EXPLISTI" (listvalue))) 
	((and T T) (print "ERROR EXPLISTI"))))


; This is one of the EXPLISTI operation. It creates one of the EXPLISTI branch recursively.
(defun explistiOperation (choice)
  (carcdr *lexems*)
  (carcdr *lexems*)
  (setf *parentheses* (+ *parentheses* 1))
  (cond 
	((equal choice "concat") (list "EXPLISTI" "concat" (explisti) (explisti)))
	((equal choice "append") (list "EXPLISTI" "append" (expi *lexems*) (explisti)))))


; This is one of the finite automatas. When the flow of a program runs into an expression which is type of EXPB, specifies which EXPB it is. It then starts creating a branch of a tree recursively and stores it in the variable called *AST*. If it runs into an expression that is not defined in the given grammar, it prints it on the screen.
(defun expb ()
  (if (equal (carcdrCheck *lexems*) ")")
    (skipParentheses))
  (cond 
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "and")) (expbOperation "and"))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "or")) (expbOperation "or"))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "not")) (expbOperation "not"))
	((and (equal (carcdrCheck *lexems*) "(") (equal (carcdrCheck2 *lexems*) "equal")) (expbOperation "equal"))
	((equal (carcar *lexems*) "binary") (list "EXPB" (carcdr *lexems*)))
	((and T T) (+ 0 0))))


; This is one of the EXPB operation. It creates one of the EXPB branch recursively.
(defun expbOperation (choice)
  (carcdr *lexems*) 
  (carcdr *lexems*)
  (setf *parentheses* (+ *parentheses* 1))
  (cond 
	((equal choice "and") (list "EXPB" "and" (expb) (expb)))
	((equal choice "or") (list "EXPB" "or" (expb) (expb)))
;	((equal choice "equal") (list "EXPB" "equal" (expb) (expb)))
	((equal choice "equal") (list "EXPB" "equal" (expi *lexems*) (expi *lexems*))) 
	((equal choice "not") (list "EXPB" "not" (expb)))))
