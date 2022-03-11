
(in-package :QVT)

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

(defparameter *QVT-READTABLE* (copy-readtable))
(defparameter *QVT-PKG* (find-package :qvt))

;;;
;;; QVT Readtable code
;;;

;; Notes for tokenizing an QVT character stream.
;; o  Single character tokens:
;;    . , ; :  = { } ( ) _
;; o  Strings are enclosed by #\'
;; o  Comments:
;;    '//' to end of line (#\Newline)
;;    '/* ... */'   bracketing

(defun QVT-CHAR (stream char)
  ;; Used for single character tokens
  ;; Returns CHAR as itself
  (declare (ignore stream))
  (char-buffered char))

;; 'this is a string'   => "this is a string"
;; 'John Doe''s string' => "John Doe's string"
;; line breaks (\n) are not allowed inside string constants (POD That's an EXPRESS-ism)
(defun QVT-STRING (stream char)
  (char-buffered char)
  (loop with string = (make-array 100 :element-type 'character :adjustable t)
	and strlen = 100 and stridx = 0
	for ch = (read-char-buffered stream t nil t) ; error-p was nil
	until (and (eql ch #\') (not (eql (peek-char nil stream t nil t) #\')))
	finally (progn (adjust-array string stridx)
		       (return string))
	do (cond ((null ch)
		  (adjust-array string stridx)
		  ;; Error: end-of-file inside string constant
		  (error 'stream-error :stream stream))
		 ((eql ch #\')
		  ;; eat extra #\' char
		  (read-char-buffered stream t nil t))) ;; error-p was nil
	   (setf (aref string stridx) ch)
	   (incf stridx)
	   (when (= stridx strlen)
	     (incf strlen 40)
	     (setf string (adjust-array string strlen :element-type 'character)))))


;;; POD I guess no characters here should be buffered unless its a lone /. 
(defun QVT-SLASH (stream char)
  "Read /* ... */ comment, // comment, or lone /."
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
    (t (char-buffered char))))

;;; New for 2012
(defun QVT-DASH(stream char)
  "Read -- comment, or lone -."
  (case (peek-char nil stream t nil t)
    (#\-
     ;; eat comment
     (loop for ch = (read-char stream t nil t) ; error-p was nil
	   until (or (null ch) (char= #\Newline ch))
	   finally (unless (null ch) 
		     (when (char= #\Newline ch) 
		       (unless (typep stream 'string-stream) (incf *line-number*)))))
      (values))
    (t (char-buffered char))))

(defun QVT-SYMBOL (stream char)
  (unread-char-buffered char stream) ; no need for -buffered, wasn't put on.
  (loop with string = (make-array 100 :element-type 'character :adjustable t :fill-pointer 0)
	for ch = (read-char-buffered stream t nil t)
	while (or (digit-char-p ch)
		     (char<= #\a ch #\z)
		     (char<= #\A ch #\Z)
		     (char<= #\0 ch #\9)
		     (char= ch #\_))
	do (vector-push-extend ch string)
	finally return 
	(progn 
	  (unread-char-buffered ch stream) 
	  ;; Check for reserved words. (intern only those).
	  (if (find string (mofi:reserved-words (mofi:find-model :qvt)) :test #'string=)
	     (intern string *qvt-pkg*)
	      string))))

(defun QVT-NEWLINE (stream char)
  (char-buffered char)
  (unless (typep stream 'string-stream) (incf *line-number*))
  (values))

(defun QVT-PLUS (stream char)
  (char-buffered char)
  (if (eql #\+ (peek-char nil stream t nil t))
      (progn (read-char-buffered stream t nil t) :plus-plus)
      #\+))

;;; If :colon-colon is returned, it is because peeking into an OCL expression.
(defun QVT-COLON (stream char)
  ;; : ::
  (char-buffered char)
  (case (peek-char nil stream nil nil t)
    (#\: (read-char-buffered stream t nil t) :colon-colon)
    (t  #\:)))


;; Modify the characters
(let ((*readtable* *qvt-readtable*))
  ;;(set-syntax-from-char to-char from-char)
  ;;(set-macro-character char function &opt non-terminating-p)

  ;; Note that due to my solution to the multi-lexer problem (switching lexers)
  ;; this must include things from OCL too....except maybe #\_  Yikes! 
  ;; POD I'm removing #\_ for now, and hoping for the best...
  (dolist (ch '(#\; #\. #\, #\( #\) #\{ #\} #\= 
		;; These are for ocl only (POD -- I can't have #\/ in this list!!!)
		#\@ #\& #\* #\\ #\[ #\] #\? #\|))
    (set-macro-character ch #'qvt-char))

  (loop for ch in '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m
		    #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z
		    #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M
		    #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z)
	do (set-macro-character ch #'qvt-symbol))

  ;(set-syntax-from-char #\# #\a)

  (set-macro-character #\' #'qvt-string)
  (set-macro-character #\/ #'qvt-slash)
  (set-macro-character #\- #'qvt-dash) ; new for 2012
  (set-macro-character #\+ #'qvt-plus)
  (set-macro-character #\: #'qvt-colon)
  (set-macro-character #\Newline #'qvt-newline)
  )

(defun qvt-read (&rest args)
  (let ((*package* *qvt-pkg*)
        (*readtable* *qvt-readtable*))
    (let ((result (apply #'read args))
	  (stream (car args)))
      (with-slots (recent-token-positions) *token-stream* ; 2012-02-12 added if numberp
	(setf (gethash (if (numberp result) (format nil "~A" result) (string result)) recent-token-positions)
	      (file-position stream)))
      result)))
  
(defun qvt-read-from-string (string &rest args)
  (let ((*package* *qvt-pkg*)
	(*readtable* *qvt-readtable*))
    (apply #'read-from-string string args)))



