;;; -*- Mode: LISP; -*-

(in-package :P11P)

;;; Copyright (c) 2002 Logicon, Inc.
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without restriction,
;;; including without limitation the rights to use, copy, modify,
;;; merge, publish, distribute, sublicense, and/or sell copies of the
;;; Software, and to permit persons to whom the Software is furnished
;;; to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
;;; ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
;;; CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;;;-----------------------------------------------------------------------

(defparameter *p11-readtable* (copy-readtable))

;; 7.1.1   digits [0-9]
;; 7.1.2   letters [a-z,A-Z]
;;         uppercase and lowercase equivalent except in string literals
;; 7.1.3   special:  ()*'!"#$%&+,-./:;<=>?@[\]^_'{|}~
;; 7.1.4   underscore [_]
;; 7.1.5   whitespace
;; 7.1.5.1  \s - #\Space
;; 7.1.5.2  \n - #\Newline
;; 7.1.5.3  \o - other chars NOT in 7.1.1 - 7.1.5.2
;;
;; 6.2  Special Character Notation
;;   \a - alpha (#x21-#x7E)
;;   \n - Newline (see 7.1.5.2)
;;   \q - #\' (quote char)
;;   \s - #\Space
;;   \o - other chars (#x00-#x1F,#x7F)

;;117 bit = [01] .
;;118 digit = [0123456789] .
;;119 digits = digit { digit } .
;;120 encoded_character = octet octet octet octet .
;;121 hex_digit = digit | [abcdef] .
;;122 letter = [abcdefghijklmnopqrstuvwxyz] .
;;123 lparen_not_star = '(' not_star .
;;124 not_lparen_star = not_paren_star | ')' .
;;125 not_paren_star = letter | digit | not_paren_star_special .
;;126 not_paren_star_quote_special = [!"#$%&+,-./:;<=>?@\^_'{|}~] | '[' | ']' .
;;127 not_paren_star_special = not_paren_star_quote_special | '''' .
;;128 not_quote = not_paren_star_quote_special | letter | digit | '(' | ')' | '*' .
;;129 not_rparen = not_paren_star | '*' | '(' .
;;130 not_star = not_paren_star | '(' | ')' .
;;131 octet = hex_digit hex_digit .
;;132 special = not_paren_star_quote_special | '(' | ')' | '*' | '''' .
;;133 star_not_rparen = '*' not_rparen .
;;134 binary_literal = '%' bit { bit } .
;;135 encoded_string_literal = '"' encoded_character { encoded_character } '"' .
;;136 integer_literal = digits .
;;137 real_literal = digits '.' [ digits ] [ 'e' [ sign ] digits ] .
;;138 simple_id = letter { letter | digit | '_' } .
;;139 simple_string_literal = \q { ( \q \q ) | not_quote | \s | \o } \q .
;;140 embedded_remark = '(*' { not_lparen_star | lparen_not_star | star_not_rparen | embedded_remark } '*)' .
;;141 remark = embedded_remark | tail_remark .
;;142 tail_remark = '--' { \a | \s | \o } \n .

;;;
;;; Express Readtable code
;;;

;; Notes for tokenizing an EXPRESS character stream.
;; o  Single character tokens:
;;    . , ; : * + - = \ / < > [ ] { } | ( ) ?
;; o  Special multi-character tokens:
;;    **    :star-star
;;    <=    :less-equal
;;    <>    :less-great
;;    >=    :great-equal
;;    <*    :less-star
;;    :=    :colon-equal
;;    ||    :vbar-vbar
;;    :=:   :colon-equal-colon
;;    :<>:  :colon-less-great-colon
;;    ~~    :tilda-tilda
;; o  Strings are enclosed by #\'
;; o  Encoded strings are enclosed by #\" (ISO 10646)
;; o  String constants do not span line boundaries
;; o  Binary constants are prefixed by #\%
;; o  Comments:
;;    '--' to end of line (#\Newline)
;;    '(*' to '*)', nesting is legal

(eval-when (:compile-toplevel :load-toplevel :execute)
(defparameter *reserved-strings-ht* (make-hash-table :test #'equal))
(loop for s in (mofi:reserved-words (mofi:find-model :MEXICO))
      do (setf (gethash s *reserved-strings-ht*) s)))

(declaim (notinline reserved-word-p))
(defun reserved-word-p (str)
  "Returns the argument in upper case if it is an EXPRESS v2 reserved word."
  (let ((upstr (string-upcase (copy-seq str))))
    (values (gethash upstr *reserved-strings-ht*))))

(defun p11-char (stream char)
  " Used for single character tokens; Returns CHAR as itself."
  (declare (ignore stream))
  char)

;; 'this is a string'   => "this is a string"
;; 'John Doe''s string' => "John Doe's string"
;; line breaks (\n) are not allowed inside string constants
(defun p11-string (stream char)
  " Read an EXPRESS string literal."
  (declare (ignore char))
  (loop with string = (make-array 100 :element-type 'character :adjustable t :fill-pointer 0)
     for ch = (read-char stream nil nil t)
     until (and (char= ch #\') 
		(not (char= (peek-char nil stream t nil t) #\')))
     do (cond ((null ch) (error 'stream-error :stream stream))
	      ((char= ch #\newline) (expo:info-message "Warning: Newline inside string constant"))
	      ((char= ch #\') (read-char stream nil nil t)))
       (vector-push-extend ch string)
     finally (return (make-string-const :-value string))))

#|
(defun p11-string (stream match)
  " Read an EXPRESS string literal."
  (let ((str
	 (loop with string = (make-array 100 :element-type 'character :adjustable t)
	       and strlen = 100 and stridx = 0
	       for ch = (read-char stream nil nil t)
	       until (and (eql ch match) (not (eql (peek-char nil stream t nil t) match)))
	       finally (progn (adjust-array string stridx)
			      (return (make-string-const :-value string)))
	       do (cond ((null ch)
			 (adjust-array string stridx)
			 ;; Error: end-of-file inside string constant
			 (error 'stream-error :stream stream))
			((eql ch #\newline)
			 ;; Error: end-of-line inside string constant
			 (expo:info-message "Warning: Newline inside string constant"))
			((eql ch match)
			 ;; eat extra #\' char
			 (read-char stream nil nil t)))
	       (setf (aref string stridx) ch)
	       (incf stridx)
	       (when (= stridx strlen)
		 (incf strlen 40)
		 (setf string (adjust-array string strlen :element-type 'character))))))
    (make-string-const :-value str)))
|#

;; Encoded characters must conform to the ISO 10646 standard
;; ISO 10646-1: Universal Multiple-Octet Coded Character Set (UCS)
;; "00000041" => "A"
;;  \/\/\/\/
(defun p11-encoded (stream match)
  ;; Used for EXPRESS encoded string constants
  (loop with string = (make-array 100 :element-type 'character :adjustable t :fill-pointer 0)
	and strlen = 100 and stridx = 0
	for ch = (read-char stream nil nil t)
	until (eql ch match)
	finally (progn (adjust-array string stridx)
		       (return string))
	do (when (null ch)
	     (adjust-array string stridx)
	     ;; Error: end-of-file inside encoded string constant
	     (error 'stream-error :stream stream))
	   (setf (aref string stridx) ch)
	   (incf stridx)
	   (when (= stridx strlen)
	     (incf strlen 40)
	     (setf string (adjust-array string strlen :element-type 'character)))))

(defun p11-binary (stream char)
  ;; Used for EXPRESS binary literal
  (declare (ignore char))
  (loop with string = (make-array 20 :element-type 'bit :adjustable t :fill-pointer 0)
	and strlen = 20 and stridx = 0
	for ch = (read-char stream nil nil t)
	while (member ch '(#\0 #\1))
	finally (progn (adjust-array string stridx)
		       (return string))
	do (when (null ch)
	     (adjust-array string stridx)
	     ;; Error: end-of-file inside binary literal
	     (error 'stream-error :stream stream))
	   (setf (aref string stridx) (char-code ch))
	   (incf stridx)
	   (when (= stridx strlen)
	     (incf strlen 10)
	     (setf string (adjust-array string strlen :element-type 'character)))))

(defun p11-symbol (stream char)
  "Read a P11 identifier or reserved word."
  (unread-char char stream)
  (loop with string = (make-array 100 :element-type 'character :adjustable t :fill-pointer 0)
	for ch = (read-char stream t nil t)
	while (or (digit-char-p ch)
		     (char<= #\a ch #\z)
		     (char<= #\A ch #\Z)
		     (char= ch #\_))
	do (vector-push-extend ch string)
        when (char= ch #\Newline) do (incf *line-number*)
	finally (progn (unread-char ch stream)
		       (return 
			 (if (reserved-word-p string)
			     (intern string :p11p)  
			     string)))))

#|
(defun P11-SYMBOL (stream char)
  (unread-char char stream)
  (loop with string = (make-array 100 :element-type 'character :adjustable t)
	and strlen = 100 and stridx = 0
	for ch = (read-char stream t nil t)
	while (or (digit-char-p ch)
		     (char<= #\a ch #\z)
		     (char<= #\A ch #\Z)
		     (char= ch #\_))
	finally (progn (adjust-array string stridx)
		       (unread-char ch stream)
		       (return (intern string)))
	do (setf (aref string stridx) (char-upcase ch))
	   (incf stridx)
	   (when (= stridx strlen)
	     (incf strlen 40)
	     (setf string (adjust-array string strlen :element-type 'character)))))
|#

(defun p11-number (stream char)
  ;; handling sign here causes other problems
  ;; integer - [ sign ] digit { digit }
  ;; real    - [ sign ] digit { digit } [ '.' { digit } [ 'E' [ sign ] digit { digit } ] ]
  ;; integer - digit { digit }
  ;; real    - digit { digit } [ '.' { digit } [ 'E' [ sign ] digit { digit } ] ]
  (let (sign (int 0) dec cdec esign exp)
    (case char
      ((#\+ #\-) (setf sign char))
      (t (setf int (- (char-code char) #x30))))
;    (setf int (- (char-code char) #x30))
    (loop for ch = (read-char stream t nil t)
	  while (digit-char-p ch)
	  do (setf int (+ (* int 10) (- (char-code ch) #x30)))
	  finally (unread-char ch stream))
    (when (char= (peek-char nil stream t nil t) #\.)
      (read-char stream nil nil t)
      (setf dec 0 cdec 1)
      (loop for ch = (read-char stream t nil t)
	    while (digit-char-p ch)
	    do (setf dec (+ (* dec 10) (- (char-code ch) #x30)))
	       (setf cdec (* cdec 10))
	    finally (unread-char ch stream))
      (when (char-equal (peek-char nil stream t nil t) #\e)
	(read-char stream nil nil t)
	(setf exp 0)
	(when (member (peek-char nil stream t nil t) '(#\+ #\-))
	  (setf esign (read-char stream nil nil t)))
	(loop for ch = (read-char stream t nil t)
	      while (digit-char-p ch)
	      do (setf exp (+ (* exp 10) (- (char-code ch) #x30)))
	      finally (unread-char ch stream))))
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

(defun p11-plus (stream char)
  ;; don't try to handle signed numbers, it messes up expressions like i+42
;  (if (member (peek-char nil stream t nil t)
;		 '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9))
;	 (p11-number stream char)
  (declare (ignore stream))
  char)

(defun p11-hyphen (stream char)
  ;; Check for double hyphen
  ;;   if found, eat comment
  ;;   else return first hyphen as token
  (case (peek-char nil stream t nil t)
    (#\-
     ;; eat comment
     (loop for ch = (read-char stream nil nil t)
	   until (or (null ch) (char= #\Newline ch))
	   finally (when (char= #\Newline ch)   (incf *line-number*)))
     ;; tell reader that nothing was constructed
     (values))
    ;; don't try to handle signed numbers, it messes up expressions like i-42
;    ((#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)
;     (p11-number stream char))
    (t char)))

(defun p11-open (stream char)
  ;; check for '(*' token when '(' is read
  (case (peek-char nil stream t nil t)
    (#\*
     (read-char stream t nil t)			;eat #\*
     (let ((lp-p nil) (star-p nil) (level 1) char)
       (loop (unless (plusp level) (return))
	     (setf char (read-char stream t nil t))
	     (cond ((and star-p (char= char #\))) (decf level))
		   ((and lp-p   (char= char #\*)) (incf level))
		   ((char= char #\Newline) (incf *line-number*)))
	     (setf star-p (if lp-p nil (char= char #\*)))
	     (setf lp-p (char= char #\())))
     (values))
    (t char)))

(defun P11-STAR (stream char)
  ;; * **
  (case (peek-char nil stream t nil t)
    (#\*
     (read-char stream t nil t)			;eat #\*
     :star-star)
    (t char)))

(defun P11-LANGLE (stream char)
  ;; read left angle (<) tokens
  ;; < <= <* <> <-
  (case (peek-char nil stream t nil t)
    (#\=
     (read-char stream t nil t)			;eat #\=
     :less-equal)
    (#\*
     (read-char stream t nil t)			;eat #\*
     :less-star)
    (#\>
     (read-char stream t nil t)			;eat #\>
     :less-great)
    (#\-
     (read-char stream t nil t)			;eat #\-
     :less-dash)
    (t char)))

(defun P11-RANGLE (stream char)
  ;; read right angle (>) tokens
  ;; > >=
  (case (peek-char nil stream t nil t)
    (#\=
     (read-char stream t nil t)			;eat #\=
     :great-equal)
    (t char)))

(defun P11-COLON (stream char)
  ;; : := :=: :<>: ::
  (case (setq char (read-char stream t nil t))
    (#\<
     (case (read-char stream t nil t)
       (#\>
	(case (read-char stream t nil t)
	  (#\: :colon-less-great-colon)
	  (t (error 'reader-error :stream stream))))
       (t (error 'reader-error :stream stream))))
    (#\=
     (case (peek-char nil stream t nil t)
       (#\:
	(read-char stream t nil t)		;eat #\:
	:colon-equal-colon)
       (t :colon-equal)))
    (#\:
     :colon-colon)
    (t (unread-char char stream)
       #\:)))

(defun P11-VBAR (stream char)
  ;; ||
  (case (peek-char nil stream t nil t)
    (#\|
     (read-char stream t nil t)			;eat #\|
     :vbar-vbar)
    (t char)))

(defun P11-TILDA (stream char)
  ;; ~~
  (case (peek-char nil stream t nil t)
    (#\~
     (read-char stream t nil t)			;eat #\~
     :tilda-tilda)
    (t char)))

(defun P11-NEWLINE (stream char)
  (declare (ignore stream char))
  (incf *line-number*)
  (values))

;; Modify the characters
(let ((*readtable* *p11-readtable*))
  ;;(set-syntax-from-char to-char from-char)
  ;;(set-macro-character char function &opt non-terminating-p)

  (dolist (ch '(#\@ #\& #\+ #\. #\, #\; #\= #\\ #\/ #\[ #\] #\{ #\} #\) #\?))
    (set-macro-character ch #'p11-char))

  (loop for i from 0 to 9
	do (set-macro-character (code-char (+ i #x30)) #'p11-number))
  (loop for ch in '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m
		    #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z
		    #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M
		    #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z)
	do (set-macro-character ch #'p11-symbol))

  (set-syntax-from-char #\# #\a)

  (set-macro-character #\| #'p11-vbar)
  (set-macro-character #\' #'p11-string)
  (set-macro-character #\" #'p11-encoded)
  (set-macro-character #\- #'p11-hyphen)
  (set-macro-character #\+ #'p11-plus)
  (set-macro-character #\* #'p11-star)
  (set-macro-character #\< #'p11-langle)
  (set-macro-character #\> #'p11-rangle)
  (set-macro-character #\( #'p11-open)
  (set-macro-character #\: #'p11-colon)
  (set-macro-character #\~ #'p11-tilda)
  (set-macro-character #\% #'p11-binary t)
  (set-macro-character #\Newline #'p11-newline)
  )

(defvar *p11p-pkg* (find-package :p11p))

(defun p11-read (&rest args)
  (let ((*package* *p11p-pkg*)
        (*readtable* *p11-readtable*))
    (let ((result (apply #'read args))
	  (stream (car args)))
      (with-slots (recent-token-positions) *token-stream*
	(when (stringp result) 
	  (setf (gethash result recent-token-positions)
		(file-position stream)))
	(when (eql result 'repeat) 
	  (setf (gethash "ANONYMOUS-REPEAT" recent-token-positions)
		(file-position stream))))
      result)))

(defun p11-read-from-string (string &rest args)
  (let ((*package* *p11p-pkg*)
	(*readtable* *p11-readtable*))
    (apply #'read-from-string string args)))


