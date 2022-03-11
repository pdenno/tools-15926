

(in-package :tlogic)

;;; Purpose: Tokenizer for template logic.

(defparameter *TLOGIC-READTABLE* (copy-readtable))
(defparameter *TLOGIC-PKG* (find-package :tlogic))

;;;
;;; TLOGIC Readtable code
;;;

;; Notes for tokenizing an TLOGIC character stream.
;; o  Single character tokens:
;;    . , ; : * + - = \ / < > [ ] { } | ( ) ?
;; o  Special multi-character tokens:
;;    <=    :less-equal
;;    <>    :less-great
;;    >=    :great-equal
;; o  Strings are enclosed by #\'
;; o  Comments:
;;    '--' to end of line (#\Newline)

(defun TLOGIC-CHAR (stream char)
  "Used for single character tokens. Returns CHAR as itself."
  (declare (ignore stream))
  (char-buffered char))

;; 'this is a string'   => "this is a string"
;; 'John Doe''s string' => "John Doe's string"
(defun TLOGIC-STRING (stream char)
  " Used for TLOGIC string constants."
  (char-buffered char)
  (let ((str
	 (with-output-to-string (sstream)
	   (loop for ch = (read-char-buffered stream t nil t) ; error-p was nil
	      until (and (eql ch #\') (not (eql (peek-char nil stream nil nil t) #\')))
	      do (cond ((null ch) (error 'stream-error :stream stream))
		       ((eql ch #\') ;; eat extra #\' char
			(read-char-buffered stream t nil t))) ; error-p was nil
		(write-char ch sstream)))))
    (make-string-const :-value str)))
	
(defun TLOGIC-SYMBOL (stream char)
  (unread-char char stream) ; DO NOT use -buffered, wasn't put on.
  (let ((str
	 (with-output-to-string (out)
	   (loop for ch = (read-char-buffered stream t nil t)
	      while (or (digit-char-p ch)
			(char<= #\a ch #\z)
			(char<= #\A ch #\Z)
			(char= ch #\_)
			(char= ch #\-))
	      do (write-char ch out)
	      finally (unread-char-buffered ch stream)))))
      (if (string= str "exists") :exists str)))

(defun TLOGIC-NUMBER (stream char)
  ;; handling sign here causes other problems
  ;; integer - [ sign ] digit { digit }
  ;; real    - [ sign ] digit { digit } [ '.' { digit } [ 'E' [ sign ] digit { digit } ] ]
  ;; integer - digit { digit }
  ;; real    - digit { digit } [ '.' { digit } [ 'E' [ sign ] digit { digit } ] ]
  (char-buffered char)
  (let (sign (int 0) dec cdec esign exp)
    (case char
      ((#\+ #\-) (setf sign char))
      (t (setf int (- (char-code char) #x30))))
;    (setf int (- (char-code char) #x30))
    (loop for ch = (read-char-buffered stream t nil t)
	  while (digit-char-p ch)
	  do (setf int (+ (* int 10) (- (char-code ch) #x30)))
	  finally (unread-char-buffered ch stream))
    (when (char= (peek-char nil stream nil nil t) #\.)
      (read-char-buffered stream nil nil t)
      (if (char= (peek-char nil stream nil nil t) #\.) ; then .. (not part of number)
	  (unread-char-buffered #\. stream)
	  (progn
	    (setf dec 0 cdec 1)
	    (loop for ch = (read-char-buffered stream t nil t)
	       while (digit-char-p ch)
	       do (setf dec (+ (* dec 10) (- (char-code ch) #x30)))
		 (setf cdec (* cdec 10))
	       finally (unread-char-buffered ch stream))
	    (when (char-equal (peek-char nil stream nil nil t) #\e)
	      (read-char-buffered stream nil nil t) 
	      (setf exp 0)
	      (when (member (peek-char nil stream nil nil t) '(#\+ #\-))
		(setf esign (read-char-buffered stream nil nil t)))
	      (loop for ch = (read-char-buffered stream t nil t)
		 while (digit-char-p ch)
		 do (setf exp (+ (* exp 10) (- (char-code ch) #x30)))
		 finally (unread-char-buffered ch stream))))))
    (let (res)
      (setf res int)
      (when (eql sign #\-)
	(setf res (- res)))
      (when dec
	(setf res (coerce res 'float))
	(when (plusp dec)
	  (setf res (+ res (/ (coerce dec 'float) cdec))))
	(when (and exp (plusp exp))
	  (when (eql esign #\-)
	    (setf exp (- exp)))
	  (setf res (* res (expt 10 exp)))))
      res)))

(defun TLOGIC-NEWLINE (stream char)
  (declare (ignore stream))
  (char-buffered char)
  (incf *line-number*)
  (values))

;;; Read everything to EOF and return the .
(defun TLOGIC-END-OF-AXIOM-COMMENT (stream char)
  (declare (ignore char))
  (loop for ch = (read-char stream nil :eof nil)
        until (eql ch :eof))
  (char-buffered #\.)
  #\.)

(defun TLOGIC-< (stream char)
  (char-buffered char)
  (case (peek-char nil stream nil nil t)
    (#\-
     (read-char-buffered stream nil nil t)
     (case (peek-char nil stream nil nil t)
       (#\> (read-char-buffered stream nil nil t)
	   :<->)
       (t :<-)))
    (t #\<)))


;; Modify the characters
(let ((*readtable* *tlogic-readtable*))
  ;;(set-syntax-from-char to-char from-char)
  ;;(set-macro-character char function &opt non-terminating-p)

  (dolist (ch '(#\( #\) #\, #\&))
    (set-macro-character ch #'tlogic-char))

  (loop for i from 0 to 9
	do (set-macro-character (code-char (+ i #x30)) #'tlogic-number))

  (loop for ch in '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m
		    #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z
		    #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M
		    #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z)
	do (set-macro-character ch #'tlogic-symbol))

  (set-macro-character #\Newline #'tlogic-newline)
  (set-macro-character #\< #'tlogic-<)
  (set-macro-character #\. #'tlogic-end-of-axiom-comment)
  )

(defun tlogic-read (&rest args)
  (let ((*package* *tlogic-pkg*)
	(*readtable* *tlogic-readtable*))
    (let ((result (apply #'read args))
	  (stream (car args)))
      (dbg-message :lexer 5 "~%In tlogic-read, result = ~A" result)
      (dbg-message :lexer 5 "~%In tlogic-read, file pos = ~A" (file-position stream))
      (with-slots (switched-out-p recent-token-positions) *token-stream*
	(unless switched-out-p  ;pod7 was (string result)
	  (setf (gethash result recent-token-positions)
		(file-position stream))))
      result)))

(defun tlogic-read-from-string (string &rest args)
  (let ((*package* *tlogic-pkg*)
	(*readtable* *tlogic-readtable*))
    (let ((result (apply #'read-from-string string args)))
      (dbg-message :lexer 5 "~%In tlogic-read, result = ~A" result)
      result)))

