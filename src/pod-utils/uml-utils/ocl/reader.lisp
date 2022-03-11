
(in-package :OCLP)

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

;;; TODO  -- 2012-02-20 Get rid of all that make-array/adjust array crap!

(defparameter *OCL-READTABLE* (copy-readtable))
(defparameter *OCL-PKG* (find-package :ocl))

;;;
;;; OCL Readtable code
;;;

;; Notes for tokenizing an OCL character stream.
;; o  Single character tokens:
;;    . , ; : * + - = \ / < > [ ] { } | ( ) ?
;; o  Special multi-character tokens:
;;    <=    :less-equal
;;    <>    :less-great
;;    >=    :great-equal
;; o  Strings are enclosed by #\'
;; o  Comments:
;;    '--' to end of line (#\Newline)

(defun OCL-CHAR (stream char)
  "Used for single character tokens. Returns CHAR as itself."
  (declare (ignore stream))
  (char-buffered char))

;; 'this is a string'   => "this is a string"
;; 'John Doe''s string' => "John Doe's string"
;; line breaks (\n) are not allowed inside string constants
(defun OCL-STRING (stream char)
  " Used for OCL string constants."
  (char-buffered char)
  (let ((str
	 (loop with string = (make-array 100 :element-type 'character :adjustable t)
	       and strlen = 100 and stridx = 0
	       for ch = (read-char-buffered stream t nil t) ; error-p was nil
	       until (and (eql ch #\') (not (eql (peek-char nil stream nil nil t) #\')))
	       finally (progn (adjust-array string stridx)
			      (return string))
	       do (cond ((null ch)
			 (adjust-array string stridx)
			 ;; Error: end-of-file inside string constant
			 (error 'stream-error :stream stream))
			((eql ch #\')
			 ;; eat extra #\' char
			 (read-char-buffered stream t nil t))) ; error-p was nil
	       (setf (aref string stridx) ch)
	       (incf stridx)
	       (when (= stridx strlen)
		 (incf strlen 40)
		 (setf string (adjust-array string strlen :element-type 'character))))))
    (make-string-const :-value str)))
	
(defun OCL-SYMBOL (stream char)
  (unread-char char stream) ; DO NOT use -buffered, wasn't put on.
  (loop with string = (make-array 100 :element-type 'character :adjustable t :fill-pointer 0)
	for ch = (read-char-buffered stream t nil t)
	while (or (digit-char-p ch)
		     (char<= #\a ch #\z)
		     (char<= #\A ch #\Z)
		     (char= ch #\_))
	do (vector-push-extend ch string)
	finally (return
		  (let ((ocl (mofi:find-model :ocl)))
		    (unread-char-buffered ch stream)
		    ;; Check for reserved words. (intern only those).
		    (if (or (member string (mofi:reserved-words   ocl) :test #'string=)
			    (member string (mofi:operator-strings ocl) :test #'string=)
			    (member string 
				    '("Bag" "Boolean"  "Collection"  "Integer" "OclAny" "OclVoid" 
				      "OrderedSet" "Real" "Sequence" "Set" "String" "Tuple"  
				      "UnlimitedInteger")
				    :test #'string=))
			(intern string *ocl-pkg*)
			string)))))

;;; Nowhere in the OCL spec does it say that #this is an enumeration value, yet
;;; the UML constraints are replete with these! I concede!
(defun OCL-ENUM (stream char)
  (char-buffered char)
  (loop with string = (make-array 100 :element-type 'character :adjustable t :fill-pointer 0)
	for ch = (read-char-buffered stream t nil t)
	while (or (digit-char-p ch)
		     (char<= #\a ch #\z)
		     (char<= #\A ch #\Z)
		     (char= ch #\_))
	do (vector-push-extend ch string)
	finally (progn 
		  (unread-char-buffered ch stream) 
		  (return (kintern (string-upcase string))))))


(defun OCL-NUMBER (stream char)
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

(defun OCL-HYPHEN (stream char)
  ;; -- ->
  ;; Check for double hyphen
  ;;   if found, eat comment
  ;;   else return first hyphen as token.
  ;; Don't try to read signed numbers, it messes up expressions like i-42
  (char-buffered char)
  (case (peek-char nil stream nil nil t)
    (#\-
     ;; eat comment
     (loop for ch = (read-char-buffered stream nil nil t)
	   until (or (null ch) (char= #\Newline ch))
	   finally (unless (null ch) (when (char= #\Newline ch)   (incf *line-number*))))
     ;; tell reader that nothing was constructed
     (values))
    (#\> (read-char-buffered stream t nil t) :point-right)
    (t char)))

(defun OCL-DOT (stream char)
  ;; . ..
  (char-buffered char)
  (case (peek-char nil stream nil nil t)
    (#\.
     (read-char-buffered stream t nil t)
     :dot-dot)
    (t char)))

(defun OCL-LANGLE (stream char)
  ;; read left angle (<) tokens
  ;; < <= <* <> 
  (char-buffered char)
  (case (peek-char nil stream nil nil t)
    (#\=
     (read-char-buffered stream t nil t)
     :less-equal)
    (#\>
     (read-char-buffered stream t nil t)
     :less-great)
    (t char)))

(defun OCL-RANGLE (stream char)
  ;; read right angle (>) tokens
  ;; > >=
  (char-buffered char)
  (case (peek-char nil stream nil nil t)
    (#\=
     (read-char-buffered stream nil nil t)
     :great-equal)
    (t char)))

(defun OCL-COLON (stream char)
  ;; : ::
  (char-buffered char)
  (case (peek-char nil stream nil nil t)
    (#\: (read-char-buffered stream t nil t) :colon-colon)
    (t  #\:)))

(defun OCL-CAROT (stream char)
  ;; ^ ^^
  (char-buffered char)
  (case (setq char (read-char-buffered stream t nil t))
    (#\^ :carot-carot)
    (t (unread-char-buffered char stream)
       #\^)))

;;; 2012-02-20 new for OCL 2.3
(defun OCL-UNDERSCORE (stream char)
  " _'something' returns string without the #\_ and #\- ... a way to use reserved words."
  (char-buffered char)
  (case (peek-char nil stream nil nil t)
    (#\'
     (read-char-buffered stream t nil t)     
     (with-output-to-string (s)
       (loop while (not (char= #\' (peek-char nil stream nil nil t)))
	    do (write-char (read-char-buffered stream t nil t) s))
       (read-char-buffered stream t nil t)))
    (t ; ordinary SimpleName
     (with-output-to-string (s)       
       (write-char #\_ s)
       (loop for ch = (read-char-buffered stream t nil t)
	while (or (digit-char-p ch)
		     (char<= #\a ch #\z)
		     (char<= #\A ch #\Z)
		     (char= ch #\_))
	    do (write-char (read-char-buffered stream t nil t) s))))))
  

(defun OCL-NEWLINE (stream char)
  (declare (ignore stream))
  (char-buffered char)
  (incf *line-number*)
  (values))


(defun QVT-PROBLEM-SLASH (stream char)
  "Read /* ... */ comment, or lone /. /* ... */ ISN'T a legal OCL comment, but
   this appears to be the best solution to the problem of buffering / in switching
   between OCL and QVT lexers."
  (case (peek-char nil stream t nil t)
    (#\* ; It starts a comment. And let's suppose they can be nested. (I don't know).
     (read-char stream t nil t) ; pod not buffered
     (let ((slash-p nil) (star-p nil) (level 1) c)
       (loop (unless (plusp level) (return))
	     (setf c (read-char stream t nil t))
	     (cond ((and star-p (char= c #\/)) (decf level))
		   ((and slash-p (char= c #\*)) (incf level))
		   ((char= c #\Newline) 
		    (unless (typep stream 'string-stream) (incf *line-number*))))
	     (setf star-p (if slash-p nil (char= c #\*)))
	     (setf slash-p (char= c #\/))))
     (values))
    (#\/  ; This is from QVT.
     (loop for ch = (read-char stream t nil t) ; error-p was nil
	   until (or (null ch) (char= #\Newline ch))
	   finally (unless (null ch) 
		     (when (char= #\Newline ch) 
		       (unless (typep stream 'string-stream) (incf *line-number*)))))
      (values))
    (t (char-buffered char))))


;; Modify the characters
(let ((*readtable* *ocl-readtable*))
  ;;(set-syntax-from-char to-char from-char)
  ;;(set-macro-character char function &opt non-terminating-p)

  (dolist (ch '(#\@ #\& #\, #\+ #\* #\; #\= #\\ #\[ #\] #\{ #\} #\( #\) #\? #\|))
    (set-macro-character ch #'ocl-char))

  (loop for i from 0 to 9
	do (set-macro-character (code-char (+ i #x30)) #'ocl-number))


;;; POD I don't handle this yet:

;;; OCL 2.3.1 Section 9.4.4:  
;;; The identifier form starts with a Unicode letter:
;;; NameStartChar ::= [A-Z] | "_" | "$" | [a-z]
;;; | [#xC0-#xD6] | [#xD8-#xF6] | [#xF8-#x2FF]
;;; | [#x370-#x37D] | [#x37F-#x1FFF]
;;; | [#x200C-#x200D] | [#x2070-#x218F] | [#x2C00-#x2FEF]
;;; | [#x3001-#xD7FF] | [#xF900-#xFDCF] | [#xFDF0-#xFFFD]
;;; | [#x10000-#xEFFFF]
;;; and may continue with a Unicode letter or digit.
;;;    NameChar ::= NameStartChar | [0-9]

;;; Don't put #\_ in here. See ocl-underscore. 
  (loop for ch in '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m
		    #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z
		    #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M
		    #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z)
	do (set-macro-character ch #'ocl-symbol))

  ;(set-syntax-from-char #\# #\a)

  (set-macro-character #\# #'ocl-enum)
  (set-macro-character #\' #'ocl-string)
  (set-macro-character #\- #'ocl-hyphen)
  (set-macro-character #\. #'ocl-dot)
  (set-macro-character #\< #'ocl-langle)
  (set-macro-character #\> #'ocl-rangle)
  (set-macro-character #\: #'ocl-colon)
  (set-macro-character #\^ #'ocl-carot)
  (set-macro-character #\_ #'ocl-underscore)
  (set-macro-character #\/ #'qvt-problem-slash)
  (set-macro-character #\Newline #'ocl-newline)
  )

(defun ocl-read (&rest args)
  (let ((*package* *ocl-pkg*)
	(*readtable* *ocl-readtable*))
    (let ((result (apply #'read args))
	  (stream (car args)))
      (dbg-message :lexer 5 "~%In ocl-read, stream = ~A" stream)
      (dbg-message :lexer 5 "~%In ocl-read, result = ~A" result)
      (dbg-message :lexer 5 "~%In ocl-read, file pos = ~A" (file-position stream))
      (with-slots (switched-out-p recent-token-positions) *token-stream*
	(unless switched-out-p  ;pod7 was (string result)
	  (setf (gethash result recent-token-positions)
		(file-position stream))))
      result)))

(defun ocl-read-from-string (string &rest args)
  (let ((*package* *ocl-pkg*)
	(*readtable* *ocl-readtable*))
    (let ((result (apply #'read-from-string string args)))
      (dbg-message :lexer 5 "~%In ocl-read, result = ~A" result)
      result)))

