(in-package :P21P)

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


(defparameter *p21-readtable* (copy-readtable))


; space = ' ' .
; omitted_parameter = '*' .
; binary = '"' ( '0' | '1' | '2' | '3' ) { hex } '"' .
; character = space | digit | lower | upper | special | reverse_solidus | apostrophe .
; digit = '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' .
; hex = digit | 'A' | 'B' | 'C' | 'D' | 'E' | 'F' .
; hex_four = hex_two hex_two .
; hex_one = hex hex .
; hex_two = hex_one hex_one .
; lower = 'a' | 'b' | 'c' | 'd' | 'e' | 'f' | 'g' | 'h' | 'i' | 'j' | 'k' | 'l' | 'm'
;       | 'n' | 'o' | 'p' | 'q' | 'r' | 's' | 't' | 'u' | 'v' | 'w' | 'x' | 'y' | 'z' .
; upper = 'A' | 'B' | 'C' | 'D' | 'E' | 'F' | 'G' | 'H' | 'I' | 'J' | 'K' | 'L' | 'M'
;       | 'N' | 'O' | 'P' | 'Q' | 'R' | 'S' | 'T' | 'U' | 'V' | 'W' | 'X' | 'Y' | 'Z' .
; special = '!' | '"' | '*' | '$' | '%' | '&' | '.' | '#' | '+' | ',' | '-' | '(' | ')' | '?'
;         | '/' | ':' | ';' | '<' | '=' | '>' | '@' | '[' | ']' | '{' | '|' | '}' | '^' | '`' .
; enumeration = '.' upper { upper | digit | '_' } '.' .
; keyword = user_defined_keyword | standard_keyword .
; user_defined_keyword = '!' upper { upper | digit | '_' } .
; standard_keyword = upper { upper | digit | '_' } .
; integer = [ sign ] digit { digit } .
; real = [ sign ] digit { digit } '.' { digit } [ 'E' [ sign ] digit { digit } ] .
; sign = '+' | '-' .

; string = '''' { non_q_char | apostrophe apostrophe | reverse_solidus reverse_solidus | control_directive } '''' .
; non_q_char = special | digit | space | lower | upper .
; apostrophe = '''' .
; reverse_solidus = '\' .
; control_directive = page | alphabet | extended2 | extended4 | arbitrary .
; page = reverse_solidus 'S' reverse_solidus character .
; alphabet = reverse_solidus 'P' upper reverse_solidus .
; extended2 = reverse_solidus 'X2' reverse_solidus hex_two { hex_two } end_extended .
; extended4 = reverse_solidus 'X4' reverse_solidus hex_four { hex_four } end_extended .
; arbitrary = reverse_solidus 'X' reverse_solidus hex_one .
; end_extended = reverse_solidus 'X0' reverse_solidus .

;;;
;;; Part-21 Readtable code
;;;

;; Notes for tokenizing an EXPRESS character stream.
;; o  Single character tokens:
;;    # $ & * ( ) = ; / ,
;; o  Special multi-character tokens:
;;    none
;; o  Strings are enclosed by #\'
;; o  String constants do not span line boundaries
;; o  Binary constants are enclosed by #\"
;; o  Comments:
;;    '/*' to '*/', nesting is illegal


#+Genera
;; clean somethings up for Genera
(progn
  ;; set name to "P21"
  nil)


(defun p21-char (stream char)
  ;; Used for single character tokens
  ;; Returns CHAR as itself
  (declare (ignore stream))
  char)

; string = '''' { non_q_char | apostrophe apostrophe | reverse_solidus reverse_solidus | control_directive } '''' .
; non_q_char = special | digit | space | lower | upper .
; apostrophe = '''' .
; reverse_solidus = '\' .
; control_directive = page | alphabet | extended2 | extended4 | arbitrary .
; page = reverse_solidus 'S' reverse_solidus character .
; alphabet = reverse_solidus 'P' upper reverse_solidus .
; extended2 = reverse_solidus 'X2' reverse_solidus hex_two { hex_two } end_extended .
; extended4 = reverse_solidus 'X4' reverse_solidus hex_four { hex_four } end_extended .
; arbitrary = reverse_solidus 'X' reverse_solidus hex_one .
; end_extended = reverse_solidus 'X0' reverse_solidus .

;; 'this is a string'   => "this is a string"
;; 'John Doe''s string' => "John Doe's string"
;; basic alphabet G(02/00) through G(07/14) I think this means #x20 - #x7E
;; See ISO 10303-21:1994 7.3.3 String
;; line breaks (\n) are not allowed inside string constants
(defun p21-string (stream match)
  ;; Used for P21 string constants
  (loop with string = (make-array 100 :element-type 'character :adjustable t)
	and strlen = 100 and stridx = 0
	for ch = (read-char stream nil nil t)
	until (cl:and (eql ch match) (cl:not (eql (peek-char nil stream t nil t) match)))
	finally (progn (adjust-array string stridx)
		       (cl:return string))
	;; newlines must be silently dropped according to ISO
	unless (eql ch #\newline)
	do (cond ((null ch)
		  (adjust-array string stridx)
		  ;; Error: end-of-file inside string constant
		  (error 'stream-error :stream stream))
		 ((eql ch match)
		  ;; eat extra #\' char
		  (read-char stream nil nil t)))
	   (setf (aref string stridx) ch)
	   (incf stridx)
	   (when (= stridx strlen)
	     (incf strlen 40)
	     (setf string (adjust-array string strlen :element-type 'character)))))

; binary = '"' ( '0' | '1' | '2' | '3' ) { hex } '"' .
; hex    = digit | 'A' | 'B' | 'C' | 'D' | 'E' | 'F' .
; digit  = '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' .
(defun p21-binary (stream char)
  ;; Used for EXPRESS binary literal
  (declare (ignore char))
  (loop with string = (make-array 20 :element-type 'bit :adjustable t)
	and strlen = 20 and stridx = 0
	for ch = (read-char stream nil nil t)
	while (member ch '(#\0 #\1))
	finally (progn (adjust-array string stridx)
		       (cl:return string))
	do (when (null ch)
	     (adjust-array string stridx)
	     ;; Error: end-of-file inside binary literal
	     (error 'stream-error :stream stream))
	   (setf (aref string stridx) (char-code ch))
	   (incf stridx)
	   (when (= stridx strlen)
	     (incf strlen 10)
	     (setf string (adjust-array string strlen :element-type 'character)))))

; enumeration = '.' upper { upper | digit | '_' } '.' .
(defun p21-enum-val (stream char)
  (let ((string (make-array 100 :element-type 'character :adjustable t))
	(strlen 100) (stridx 0))
    (setf (aref string stridx) char)
    (incf stridx)
    (loop for ch = (read-char stream t nil t)
	  while (cl:or (digit-char-p ch)
		       (char<= #\A ch #\Z)
		       (char= ch #\_))
	  finally (progn (unless (char= ch #\.)
			   (error "Enumeration value ended without a '.'"))
			 (setf (aref string stridx) ch)
			 (incf stridx)
			 (adjust-array string stridx)
			 (cl:return (intern string)))
	  do (setf (aref string stridx) (char-upcase ch))
	     (incf stridx)
	     (when (= stridx strlen)
	       (incf strlen 40)
	       (setf string (adjust-array string strlen :element-type 'character))))))

; keyword = user_defined_keyword | standard_keyword .
; user_defined_keyword = '!' upper { upper | digit | '_' } .
; standard_keyword = upper { upper | digit | '_' } .
(defun p21-keyword (stream char)
  (let ((string (make-array 100 :element-type 'character :adjustable t))
	(strlen 100) (stridx 0))
    (setf (aref string stridx) char)
    (incf stridx)
    (loop for ch = (read-char stream t nil t)
	  while (cl:or (digit-char-p ch)
		       (char<= #\A ch #\Z)
		       (char= ch #\_)
		       (char= ch #\-)	; to read ISO-10303-21 and END-ISO-10303-21
		       )
	  finally (progn (adjust-array string stridx)
			 (unread-char ch stream)
			 (cl:return (intern string)))
	  do (setf (aref string stridx) (char-upcase ch))
	     (incf stridx)
	     (when (= stridx strlen)
	       (incf strlen 40)
	       (setf string (adjust-array string strlen :element-type 'character))))))

; integer = [ sign ] digit { digit } .
; real    = [ sign ] digit { digit } '.' { digit } [ 'E' [ sign ] digit { digit } ] .
; sign    = '+' | '-' .
(defun p21-number (stream char)
  (let (sign (int 0) dec cdec esign exp)
    (flet ((char->int (ch) (- (char-code ch) #x30)))
      (cl:case char
	((#\+ #\-) (setf sign char))
	(t (setf int (char->int char))))
      (loop for ch = (read-char stream t nil t)
	    while (digit-char-p ch)
	    do (setf int (+ (* int 10) (char->int ch)))
	    finally (unread-char ch stream))
      (when (char= (peek-char nil stream t nil t) #\.)
	(read-char stream nil nil t)	;eat '.'
	(setf dec 0 cdec 1)
	(loop for ch = (read-char stream t nil t)
	      while (digit-char-p ch)
	      do (setf dec (+ (* dec 10) (char->int ch)))
		 (setf cdec (* cdec 10))
	      finally (unread-char ch stream))
	(when (char-equal (peek-char nil stream t nil t) #\e)
	  (read-char stream nil nil t)
	  (setf exp 0)
	  (when (member (peek-char nil stream t nil t) '(#\+ #\-))
	    (setf esign (read-char stream nil nil t)))
	  (loop for ch = (read-char stream t nil t)
	        while (digit-char-p ch)
		do (setf exp (+ (* exp 10) (char->int ch)))
		finally (unread-char ch stream))))
      (let ((res int))
	(when dec
	  (setf res (coerce res 'float))
	  (when (plusp dec)
	    (setf res (+ res (/ (coerce dec 'float) cdec))))
	  (when (cl:and exp (plusp exp))
	    (when (eql esign #\-)
	      (setf exp (- exp)))
	    (setf res (* res (expt 10 exp)))))
	(when (eql sign #\-)
	  (setf res (- res)))
	res))))

; comment
; '/*' { char } '*/'
(defun p21-comment (stream char)
  (declare (ignore char))
  (unless (char= (read-char stream nil nil t) #\*)
    (error "'/' is an invalid character"))
  (loop with star = nil
	for ch = (read-char stream nil nil t)
	until (and star (char= ch #\/))
	do (setf star (char= ch #\*)))
  (cl:values))

(defun p21-newline (stream char)
  (declare (ignore stream char))
  (incf expo:*line-number*)
  (values))

;; Modify the characters
(let ((*readtable* *p21-readtable*))
  ;;(set-syntax-from-char to-char from-char)
  ;;(set-macro-character char function &opt non-terminating-p)

  (dolist (ch '(#\# #\$ #\& #\* #\( #\) #\= #\; #\,))
    (set-macro-character ch #'p21-char))

  (loop for ch in '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\+ #\-)
	do (set-macro-character ch #'p21-number))

  (loop for ch in '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m
		    #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z)
	do (set-macro-character ch #'p21-keyword)
	   (set-macro-character (char-upcase ch) #'p21-keyword))

  (set-macro-character #\. #'p21-enum-val)
  (set-macro-character #\! #'p21-keyword)
  (set-macro-character #\/ #'p21-comment)
  (set-macro-character #\' #'p21-string)
  (set-macro-character #\" #'p21-binary)
  (set-macro-character #\Newline #'p21-newline)
  )

(defvar *p21p-pkg* (find-package :p21p))

(defun p21-read (&rest args)
;  (declare (arglist &optional stream eof-error-p eof-value recursive-p))
  (let ((*package*   *p21p-pkg*)
	(*readtable* *p21-readtable*))
    (apply #'read args)))

(defun p21-read-from-string (string &optional eof-error-p eof-value &key (start 0) end preserve-whitespace)
  (let ((*package*   *p21p-pkg*)
	(*readtable* *p21-readtable*))
    (read-from-string string eof-error-p eof-value :start start :end end
		      :preserve-whitespace preserve-whitespace)))
