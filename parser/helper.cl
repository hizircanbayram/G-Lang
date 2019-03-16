
;***********************************************************   HELPER FUNCTIONS   ***********************************************************    


; Returns the first element of the first element of a given list.
(defun carcar (lexems)
  (car (car lexems)))


; Returns the second element of the first element of a given list. It iterates the given program also.
(defun carcdr (lexems)
  (setf *lexems* (cdr *lexems*))
  (car (cdr (car lexems))))


; Returns the second element of the first element of a given list.
(defun carcdrCheck (lexems)
  (car (cdr (car lexems))))


; Returns the first element of the first element of a given list.
(defun carcar2Check (var)
  (car (car (cdr var))))


; Returns the second element of the first element of a given list.
(defun carcdrCheck2 (lexems)
  (car (cdr (car (cdr lexems)))))



; Returns the second element of the second element of a given list.
(defun cdrcdr ()
  (setf *lexems* (cdr (cdr *lexems*))))


; It is a simple function for reading from file to string.
(defun fileToString (file-path)
	(with-open-file (file-stream file-path)
		(let ((content (make-string (file-length file-stream))))
			(read-sequence content file-stream)
content)))
