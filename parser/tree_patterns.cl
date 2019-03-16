
;***********************************************************   TREE PATTERNS   ***********************************************************    

; This is a print function for writing the tree to a file
(defun write-lexem(text)
	(with-open-file (fileName "parse.tree"
		             :direction :output
		             :if-exists :append
		             :if-does-not-exist :create)
	(format fileName text))
)


; It prints the tree that is created for storing the program text.
(defun printAST (ast)
  (write-lexem (string (car ast)))
  (write-lexem "~%")
  (printASTprivate (cdr ast) 2))


; This is the main function for printing the tree. It makes some recursion calls based on the expression that it is delivered. 
(defun printASTprivate (ast spaceAmn) ; printEXPI gibi oldu bu biraz, lol. printEPBI da ayri yazmak gerekecek gibi.
  (if (null ast)
	()
	(if (listp (car ast))
	  (goDeep ast spaceAmn)
	  (if (or (equal (car ast) "EXPI") (equal (car ast) "VALUES") (equal (car ast) "LISTVALUE") (equal (car ast) "EXPLISTI")
			  (equal (car ast) "EXPB") (equal (car ast) "EXPB") (equal (car ast) "IDLIST") (equal (car ast) "INPUT"))
	    (writeTYPE ast spaceAmn)
	    (writeOTHER ast spaceAmn)))))


; If the expression contains more than one expression, flow of the program makes a call to this function.
(defun goDeep (ast spaceAmn)
  (printASTprivate (car ast) spaceAmn)
  (printASTprivate (cdr ast) spaceAmn))


; If what will be written isn't the main type, this function is invoked so as to print it on the screen.
(defun writeTYPE (ast spaceAmn)
  (printSpaces spaceAmn)
  (write-lexem (string (car ast)))
  (write-lexem "~%")
  (printASTprivate (cdr ast) (+ spaceAmn 2)))


; If what will be written isn't the other type, this function is invoked so as to print it on the screen.
(defun writeOTHER (ast spaceAmn)
  (printSpaces spaceAmn)
  (write-lexem (string (car ast)))
  (write-lexem "~%")
  (printASTprivate (cdr ast) spaceAmn))


; Print given amount of white space characters.
(defun printSpaces (n)
  (write-lexem " ")
  (if (> n 0)
	(printSpaces (- n 1))))
