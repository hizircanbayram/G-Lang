
; This function is responsible for controlling one of the states of deterministic finite automata. It checks whether given character that is on process
; is digit or not so as to decide current lexem is integer or not. As long as current element is a digit, the cursor moves forward to determine where the lexem
; stops. The function adds every digit element into the variable called lexem so that lexem can be determined. Any character but digit ends recursion.
(defun isIntValue (str ind)
  (if (and (< ind (length str)) (isDigit (schar str ind))) ; identifier'dan sonra gelen karakter ) ise,cursor'i arttirmaki, lex fonk.u kendini cagirdiginda tekrar ) karakterinde baslayip ) karakterini hesaba katsin.
	(setf *cursor* (+ 1 *cursor*)))
  (if (and (< ind (length str)) (isDigit (schar str ind)) (not (char= #\) (schar str ind))))
    (setf *lexem* (concatenate 'string *lexem* (string (schar str ind)))))
  (cond
	((= (length str) ind) (+ 1 0))
	((isDigit (schar str ind)) (isIntValue str (+ 1 ind)))
	(t (+ 1 0))))


; This is a sub-state for negative integers' control. What basically does is checking if there is any negative integers starting
; with 0. If it is, returns error. It is also used as a state for generating negative integers. Recursion operations used in this
; state ends with any unintented character for this state(etc. 'a', ' ')
(defun isSS (str ind)
  (if (and (< ind (length str)) (isDigit (schar str ind)))
    (setf *cursor* (+ 1 *cursor*)))
  (if (and (< ind (length str)) (isDigit (schar str ind)))
    (setf *lexem* (concatenate 'string *lexem* (string (schar str ind)))))
  (cond 
	((= (length str) ind) (+ 17 1)) ; uzunluk kontrolunun cond'un basinda olmasi elzem.
	((isNumber (schar str ind)) (isIntValue str (+ 1 ind)))
	((isWhiteSpace (schar str ind)) (+ 17 1))
	((not (isAcceptable (schar str ind))) (- 0 1))
	(t (+ 17 1))))


; This function is responsible for controlling one of the states of deterministic finite automata. It checks whether given character 
; that is on process is alaphabetic or not so as to decide current lexem is identifier or not. As long as current element is an 
; alphabetic character, the cursor moves forward to determine where the lexem stops. The function adds every character element into 
; the variable called lexem so that lexem can be determined. Any character but character ends recursion.
(defun isId (str ind)
  (if (and (< ind (length str)) (alpha-char-p (schar str ind))) ; identifier'dan sonra gelen karakter ) ise,cursor'i arttirmaki, lex fonk.u kendini cagirdiginda tekrar ) karakterinde baslayip ) karakterini hesaba katsin.
	(setf *cursor* (+ 1 *cursor*)))
  (if (and (< ind (length str)) (alpha-char-p (schar str ind))) ; identifier'dan sonra gelen karakter ) ise,cursor'i arttirmaki, lex fonk.u kendini cagirdiginda tekrar ) karakterinde baslayip ) karakterini hesaba katsin.
    (setf *lexem* (concatenate 'string *lexem* (string (schar str ind)))))
  (cond 
	((= (length str) ind) (checkKeywords str ind))
	((alpha-char-p (schar str ind)) (isId str (+ 1 ind)))
	((not (isAcceptable (schar str ind))) (- 0 1))
	(t (checkKeywords str ind))))
 

; This is another state for keywords and binary values. If any lexem can be classified as identifier, it goes to this state in order
; to determine the lexem can also be classified as either binary value or keyword before it is not classified as identifier. If it is
; it is classified as it has to be, identifier otherwise.
(defun checkKeywords (str endPoint)
  (cond 
	((string= (subseq str *backward* endPoint) "true") (+ 1 2))
	((string= (subseq str *backward* endPoint) "false") (+ 1 3))
	((string= (subseq str *backward* endPoint) "and") (+ 1 4))
	((string= (subseq str *backward* endPoint) "or") (+ 1 5))
	((string= (subseq str *backward* endPoint) "not") (+ 1 6))
	((string= (subseq str *backward* endPoint) "equal") (+ 1 7))
	((string= (subseq str *backward* endPoint) "append") (+ 1 8))
	((string= (subseq str *backward* endPoint) "concat") (+ 1 9))
	((string= (subseq str *backward* endPoint) "set") (+ 1 10))
	((string= (subseq str *backward* endPoint) "deffun") (+ 1 11))
	((string= (subseq str *backward* endPoint) "for") (+ 1 12))
	((string= (subseq str *backward* endPoint) "while") (+ 1 13))
	((string= (subseq str *backward* endPoint) "if") (+ 1 14))
	((string= (subseq str *backward* endPoint) "exit") (+ 1 15))
	(t (+ 1 1)))) ; keyword'lerden biri degilse Id'dir. Id'nin return value'su da 2'dir


; This is a sub-state for factor operation. If consecutive two '*' characters follow each other, the operations is considered as
; factor operation. This function checks this condition. If there is only one '*' character, it is considered as multiplication.
(defun isMul (str ind)
  (if (and (< ind (length str)) (char= #\* (schar str ind)))
    (setf *cursor* (+ 1 *cursor*)))
  (if (and (< ind (length str)) (char= #\* (schar str ind)))
    (setf *lexem* (concatenate 'string *lexem* (string (schar str ind)))))
  (cond
	((not (char= (schar str ind) #\*)) (+ 19 1))
	((char= (schar str ind) #\*) (+ 21 1))))


; This function is the main state of deterministic finite automata. It takes a character and goes to any state that is based on
; the character. This function also skips white-space characters. 
(defun lexPrivate (str ind)
  (if (and (< ind (length str)) (alpha-char-p (schar str ind)))
    (setf *backward* ind))
  (setf *cursor* (+ 1 *cursor*))
  (if (and (< ind (length str)) (not (isWhiteSpace (schar str ind))))
    (setf *lexem* (concatenate 'string *lexem* (string (schar str ind)))))
  (cond 
	((>= ind (length str)) ()) ; index'in string boyutunun disina tasmamasi icin
	((isWhiteSpace (schar str ind)) (lexPrivate str (+ 1 ind)))
	((isDigit (schar str ind)) (isIntValue str (+ 1 ind)))
	((char= (schar str ind) #\-) (isSS str (+ 1 ind)))
	((char= (schar str ind) #\+) (+ 16 1))
	((char= (schar str ind) #\-) (+ 17 1))
	((char= (schar str ind) #\/) (+ 18 1))
	((char= (schar str ind) #\*) (isMul str (+ 1 ind)))
	((char= (schar str ind) #\() (+ 20 1))
	((char= (schar str ind) #\)) (+ 22 1))
	((alpha-char-p (schar str ind)) (isId str (+ 1 ind)))
	(t (- 0 1))))


; This is a wrapper function for lexPrivate. It gets started the deterministic finite automata.
(defun lex (str)
  (if (< *cursor* (length str))
    (printTokens (lexPrivate str *cursor*)))
  (if (< *cursor* (length str))
	(lex str)))


; This is another wrapper function with just one parameter. It takes the input file and creates its lextable.
(defun lexer (str)
  (lex (fileToString str))
  (setf *lexTable* (reverse *lexTable*)))
