
; It is a simple function for reading from file to string.
(defun fileToString (file-path)
	(with-open-file (file-stream file-path)
		(let ((content (make-string (file-length file-stream))))
			(read-sequence content file-stream)
content)))


; After every state is completed, the computation ends up with a result value that is based on the type of the state. The result value is passed into this
; function as a parameter. While this operation is still on process, one lexem is become ready. Based on the result value, the lexem and its token are paired
; so as to be added into the lexem table. After every lexem is delivered to the lexem table, string that holds the lexem is assigned to null.
(defun printTokens (retVal)
  (cond 
	((eq retVal -1) (push (list "error" *lexem*) *lexTable*)) ; error
	((eq retVal 1) (push (list "integer" *lexem*) *lexTable*)) ; int_value
	((eq retVal 2) (push (list "identifier" *lexem*) *lexTable*)) ; identifier
	((eq retVal 3) (push (list "binary" *lexem*) *lexTable*)) ; binary_t
	((eq retVal 4) (push (list "binary" *lexem*) *lexTable*)) ; binary_f
	((eq retVal 5) (push (list "keyword" *lexem*) *lexTable*)) ; kw_and
	((eq retVal 6) (push (list "keyword" *lexem*) *lexTable*)) ; kw_or
	((eq retVal 7) (push (list "keyword" *lexem*) *lexTable*)) ; kw_not
	((eq retVal 8) (push (list "keyword" *lexem*) *lexTable*)) ; kw_equal
	((eq retVal 9) (push (list "keyword" *lexem*) *lexTable*)) ; kw_append
	((eq retVal 10) (push (list "keyword" *lexem*) *lexTable*)) ; kw_concat
	((eq retVal 11) (push (list "keyword" *lexem*) *lexTable*)) ; kw_set
	((eq retVal 12) (push (list "keyword" *lexem*) *lexTable*)) ; kw_deffun
	((eq retVal 13) (push (list "keyword" *lexem*) *lexTable*)) ; kw_for
	((eq retVal 14) (push (list "keyword" *lexem*) *lexTable*)) ; kw_while
	((eq retVal 15) (push (list "keyword" *lexem*) *lexTable*)) ; kw_if
	((eq retVal 16) (push (list "keyword" *lexem*) *lexTable*)) ; kw_exit
	((eq retVal 17) (push (list "operator" *lexem*) *lexTable*)) ; op_plus
	((eq retVal 18) (push (list "operator" *lexem*) *lexTable*)) ; op_minus
	((eq retVal 19) (push (list "operator" *lexem*) *lexTable*)) ; op_div
	((eq retVal 20) (push (list "operator" *lexem*) *lexTable*)) ; op_mul
	((eq retVal 21) (push (list "operator" *lexem*) *lexTable*)) ; op_open_par
	((eq retVal 22) (push (list "operator" *lexem*) *lexTable*)) ; op_fac
	((eq retVal 23) (push (list "operator" *lexem*) *lexTable*))) ; op_close_par
  (setf *lexem* "")
  	)
