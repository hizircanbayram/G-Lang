
;***********************************************************   PARSE PROCESSING   ***********************************************************    


(defun parser (lexems)
  (setq *lexems* lexems)
  (parserPrivate *lexems*)
  (setf *AST* (reverse *AST*))
  (push "INPUT" *AST*)
  (push "START" *AST*)
  (printAST *AST*)
  )

; ;DIRECTIVE: parse tree
; Checks if next next expression is either EXPI or EXPLISTI. There is no any other expression type here since the only two of them are allowed to start a program. If any expression isn't matched with either of these, an error message prints on the screen. 
(defun parserPrivate (lexems)
  (cond 
	((> (isEXPI) 0) (push (expi *lexems*) *AST*))
	((> (isEXPLISTI) 0) (push (explisti) *AST*))
;	((> (isLISTVALUE) 0) (push (listvalue) *AST*))
;	((> (isEXPB) 0) (push (expb) *AST*))
	((and T T) (finishLexems)))
  (cleanParentheses ")")
  (if (not (null *lexems*))
	(parserPrivate *lexems*)))
