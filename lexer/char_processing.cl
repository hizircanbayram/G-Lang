
; This function queries if the given character is a digit or not. It returns 1 if it is a digit, 0 otherwise.
(defun isDigit (num)
  (if (or (char= num #\0) (char= num #\1) (char= num #\2) (char= num #\3) (char= num #\4) (char= num #\5) (char= num #\6) (char= num #\7) (char= num #\8) (char= num #\9) )
	(- 2 1)
	()))


; This function queries if the given character is a number or not(except 0). It returns 1 if it is a number, 0 otherwise.
(defun isNumber (num)
  (if (or (char= num #\1) (char= num #\2) (char= num #\3) (char= num #\4) (char= num #\5) (char= num #\6) (char= num #\7) (char= num #\8) (char= num #\9) )
	(- 2 1)
	()))


; This function queries if the given character is a whitespace or not. It returns 1 if it is a whitespace character, 0 otherwise.
(defun isWhiteSpace (ch)
  (if (or (char= ch #\Tab) (char= ch #\Newline) (char= ch #\Space))
    (- 2 1)
    ()))


; This function queries if the given character is acceptible or not. It means that the given character is allowed to be used or not.
; It returns 1 if it is an acceptable character, 0 otherwise.
(defun isAcceptable (ch)
  (if (or (isNumber ch) (alpha-char-p ch) (char= #\)) (char= #\() (char= #\+) (char= #\-) (char= #\*) (char= #\/))
	(- 2 1)
	()))
