
;***********************************************************   ERROR PROCESSING   ***********************************************************    



; After an error message prints on the screen, rest of the lexems of the expression is consumed.
(defun finishLexems ()
  (print "LEXEMS FINISHING. ABORTING...")
  (setf *lexems* (cdr *lexems*))
  (if (not (null *lexems*))
	(finishLexems)))


; After an expression is finished except its left parentheses, this function removes them from the list.
(defun cleanParentheses (prt)
  (if (> *parentheses* 0)
	(if (equal (carcdrCheck *lexems*) prt)
	 (cleanParentInside) 
	 ()))) ; parenthesesError fonk vardi burada ancak burada olmamasi gerektigini dusunuyorum. Bir yerler abuk olursa buraya da bakip ilgili fonk.u tekrar cagirmayi dusunebiliriz.


; This function is an inside function of the function called cleanParentheses.
(defun cleanParentInside ()
  (skipParentheses)
  (cleanParentheses ")"))


; This function is a helper function. It reduces the parentheses by one.
(defun skipParentheses ()
 (setf *parentheses* (- *parentheses* 1))
 (carcdr *lexems*))


; It's a simple prompt function.
(defun parenthesesError ()
  (print "UNMATCHED PARENTHESES ERROR!!"))
