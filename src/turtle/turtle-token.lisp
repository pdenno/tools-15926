

(in-package :turtle)

;;; Purpose: Tokenizer for RDF turtle (See http://www.w3.org/TR/2012/WD-turtle-20120710/)
;;; Creates the following object and types:
;;; prefixed-name (includes ns and local name), iriref, :prefix :base
;;;  blank-node, langtag, number, string-literal
;;;  #\[ #\] #\( #\) #\. #\,


(defparameter *TURTLE-READTABLE* (copy-readtable))
(defparameter *TURTLE-PKG* (find-package :turtle))

(defstruct pname
  (-ns nil)  ; namespace
  (-ln nil)) ; local name

(defstruct iriref
  (-name))

(defstruct blank-node
  (-label))

(defstruct langtag
  (-value))


(declaim (inline hex-p ws-p pn-local-esc-suffix-p pn-chars-base-p pn-chars-u-p pn-chars-p))

(defun hex-p (c)
  "True if C [0-9] | [A-F] | [a-f]"
  (and (characterp c)
       (let ((code (char-code c)))
	 (or (<= 48 code 57) 
	     (<= 65 code 70) 
	     (<= 97 code 102)))))

(defun ws-p (c) 
  (and (characterp c)
       (or (char= c #\Space)
	   (char= c #\Tab)
	   (char= c #\Return)
	   (char= c #\Newline))))

(defun pn-local-esc-suffix-p (c)
  (and (characterp c)
       (member c
	       '(#\_ #\~ #\. #\- #\! #\$ #\& #\' #\( #\) #\* #\+ #\, #\; #\= #\/ #\? #\# #\@ #\%)
	       :test #'char=)))

(defun pn-chars-base-p (c)
  (and (characterp c)
       (let ((code (char-code c)))
	 (or (<= #.(char-code #\A) code #.(char-code #\Z))
	     (<= #.(char-code #\a) code #.(char-code #\z))
	     (<= #x00C0 code #x00D6)
	     (<= #x00D8 code #x00F6) 
	     (<= #x00F8 code #x02FF) 
	     (<= #x0370 code #x037D) 
	     (<= #x037F code #x1FFF) 
	     (<= #x200C code #x200D) 
	     (<= #x2070 code #x218F) 
	     (<= #x2C00 code #x2FEF) 
	     (<= #x3001 code #xD7FF) 
	     (<= #xF900 code #xFDCF) 
	     (<= #xFDF0 code #xFFFD) 
	     (<= #x10000 code #xEFFFF)))))

(defun pn-chars-u-p (c)
  (and (characterp c)
       (or (char= c #\_)
	   (char= c #\:)
	   (pn-chars-base-p c))))

(defun pn-chars-p (c)
  (and (characterp c)
       (or (char= c #\-)
	   (pn-chars-u-p c)
	   (let ((code (char-code c)))
	     (or 
	      (<= #.(char-code #\0) code #.(char-code #\9))
	      (=  #x00b7 code)
	      (<= #x0300 code #x036f)
	      (<= #x203f code #x2040))))))


  ;; real    - [ sign ] digit { digit } [ '.' { digit } [ 'E' [ sign ] digit { digit } ] ]
  ;; real    - digit { digit } [ '.' { digit } [ 'E'|'e' [ sign ] digit { digit } ] ]

(defun turtle-dot (in char)
  (if (digit-char-p (peek-char nil in nil nil))
      (turtle-number in char)
      #\.))

;;; INTEGER  ::= [+-]? [0-9]+
;;; DECIMAL  ::= [+-]? [0-9]* '.' [0-9]+
;;; DOUBLE   ::= [+-]? ([0-9]+ '.' [0-9]* EXPONENT | '.' [0-9]+ EXPONENT | [0-9]+ EXPONENT)
;;; EXPONENT ::= [eE] [+-]? [0-9]+
(defun turtle-number (in char)
  (let ((sign 1) (int 0) (esign 1) (exp 0) (dec 0) (cdec 1) floatp)
    (flet ((finish-number ()  
	     ;(VARS int dec cdec sign esign exp)
	     (let ((val (* sign (+ int (/ dec cdec)) (expt 10 (* esign exp)))))
	       (if floatp (coerce val 'float) val)))
	   (char2n (ch) (- (char-code ch) #.(char-code #\0))))
      ;; The (optional) sign...
      (case char
	(#\+) 
	(#\- (setf sign -1))
	(t (unread-char char in)))
      ;; The integer part (if any) 
      (unless (eql #\. (peek-char nil in nil nil))
	(loop for ch = (read-char in nil nil) do
	   (setf int (+ (* int 10) (char2n ch)))
	   while (digit-char-p (peek-char nil in nil nil))))
      ;; The part right of the decimal....123 is legal DECIMAL .3E4, 3E4 are legal DOUBLEs...
      (when (char= #\.(peek-char nil in nil nil))
	(read-char in nil nil)
	(setf floatp t)
	(let ((p (peek-char nil in nil nil)))
	  (unless (or (digit-char-p p) (and (characterp p) (char-equal p #\e)))
	    (error 't-lex-error :in "reading a number" :expect "digit or E after #\." :got p))
	    (setf dec 0 cdec 1)
	    (loop for ch = (read-char in t nil t) do
	         (setf dec (+ (* dec 10) (char2n ch)))
		 (setf cdec (* cdec 10))
	          while (digit-char-p (peek-char nil in nil nil)))))
      (let ((p (peek-char nil in nil nil)))
	(cond ((not (or (digit-char-p p) (char-equal #\e p)))
	       (return-from turtle-number (finish-number)))
	      ;; Scientific notation...
	      ((char-equal #\e p)
	       (setf floatp t)
	       (read-char in nil nil)
	       (let ((p (peek-char nil in nil nil)))
		 (cond ((char= p #\+) (read-char in nil nil))
		       ((char= p #\-) (read-char in nil nil) (setf esign -1))))
	       (loop for ch = (read-char in nil nil)
		  while (digit-char-p ch) do
		    (setf exp (+ (* exp 10) (char2n ch)))
		  finally (unread-char ch in))
	       (return-from turtle-number (finish-number))))))))


(defun turtle-newline (stream char)
  (declare (ignore stream char))
  (incf *line-number*)
  (values))

(defun turtle-char (stream char)
  "Used for single character tokens. Returns CHAR as itself."
  (declare (ignore stream))
  char)

(defun read-hex (cnt in out)
  "Read CNT hex digits from IN and write to OUT"
  (loop for i from 1 to cnt
        for c = (read-char in nil nil)
        when (null c) do (error 't-lex-eof :in "read-hex")
        unless (hex-p c) do (error 't-lex-error :in "read-hex" :expect "hex-char" :got c)
        do (write-char c out)))

(defun turtle-eol-comment (in char)
  (declare (ignore char))
  (loop for p = (peek-char nil in nil nil)
        while (and p (not (char= p #\Newline)))
        do (read-char in nil nil))
  (values))

;;; '<' ([^#x00-#x20<>\"{}|^`\] | UCHAR)* '>'
(defun turtle-iriref (in char)
  (declare (ignore char))
  (let ((name
	 (with-output-to-string (str)
	   (block reading
	     (loop for c = (peek-char nil in nil nil nil) do
		  (cond ((null c) (error 't-lex-eof :in "IRIREF"))
			((eql c #\>) (read-char in) (return-from reading))
			((eql c #\\) 
			 (write-char c str) (read-char in)
			 (let ((c (peek-char nil in nil :eof nil)))
			   (cond ((eql c #\u) (read-char in) (read-hex 4 in str))
				 ((eql c #\U) (read-char in) (read-hex 8 in str))
				 (t (error 't-lex-error :in "IRIREF" :expect "\u or \U" :got c)))))
			((or (<= #x00 (char-code c) #x20) (eql c #\<) (eql c #\{)
			     (eql c #\}) (eql c #\|) (eql c #\`))
			 (error 't-lex-error :in "IRIREF" :expect "(see syntax)" :got c))
			(t (write-char c str) (read-char in))))))))
    (make-iriref :-name name)))


;;;[23]	STRING_LITERAL_QUOTE 	         ::= '"' ([^#x22#x5C#xA#xD] | ECHAR | UCHAR)* '"'
;;;[24]	STRING_LITERAL_SINGLE_QUOTE 	 ::= "'" ([^#x27#x5C#xA#xD] | ECHAR | UCHAR)* "'"
;;;[25]	STRING_LITERAL_LONG_SINGLE_QUOTE ::= "'''" (("'" | "''")? [^'\] | ECHAR | UCHAR)* "'''"
;;;[26]	STRING_LITERAL_LONG_QUOTE 	 ::= '"""' (('"' | '""')? [^"\] | ECHAR | UCHAR)* '"""'	  
(defun turtle-string-lit (in start-char)
  (flet ((read-more-start-char ()
	   (loop for i from 1 to 2
	      for end = (read-char in nil nil)
	      unless (eql end start-char) do 
		(error 't-lex-error :in "string literal" :expect "\" or '" :got end))))
  (let (allow-cr)
    (with-output-to-string (str)
      (block reading
	(let ((c2 (peek-char nil in nil nil)))
	  (cond ((null c2) (error 't-lex-eof :in "string literal"))
		((char= c2 start-char)
		 (setf allow-cr t)
		 (read-more-start-char))
		(t (read-char in nil nil) ; it's just first char, write it.
		   (write-char c2 str)))
	  (loop for c = (read-char in nil nil) do
	        (cond ((null c)  (error 't-lex-eof :in "string literal"))
		      ((char= c #\\)
		       (write-char #\\ str)
		       (let ((u/e (read-char in nil nil))) ; uchar / echar
			 (cond ((null u/e) (error 't-lex-eof :in "string literal"))
			       ((or (char= u/e #\u) (char= u/e #\U))
				(write-char u/e str)
				(loop for i from 1 to (if (char= u/e #\u) 4 8)
				      for h = (read-char in nil nil)
				      unless (hex-p h) do 
				     (error 't-lex-error :in "string literal" :expect "hex digit" :got h)
                                      do (write-char h str)))
			       ((member u/e '(#\t #\b #\n #\r #\f #\\ #\" #\') :test #'char=)
				(write-char u/e str))
			       (t (error 't-lex-error :in "string literal" :expect "tbnrl\\\"'" :got u/e)))))
		      ((or (char= c #\Newline) (char= c #\Return))
		       (unless allow-cr 
			 (error 't-lex-error :in "string literal" :expect "no Newline or Return" :got c))
		       (write-char c str))
		      ((char= c start-char)
		       (when allow-cr (read-more-start-char))
		       (return-from reading))
		      (t (write-char c str))))))))))

;;; Actually langtag / @prefix / @base
;;; LANGTAG 	::= 	'@' [a-zA-Z]+ ('-' [a-zA-Z0-9]+)*
(defun turtle-langtag (in char)
  (declare (ignore char))
  (let ((value
	 (with-output-to-string (str)
	   (loop for c = (read-char in nil nil)
	      for code = (char-code c)
	      until (ws-p c) do 
		(cond ((null c) (error 't-lex-eof :in "langtag"))
		      ((or (<= 97 code 122) (<= 65 code 90) (<= 48 code 57) (eql c #\-))
		       (write-char c str))
		      (t (error 't-lex-error :in "langtag" :expect "[a-zA-Z0-9] or -" :got c)))))))
    (cond ((string= value "prefix") :prefix) ; must be lowercase when using @ prefix (not SPARQL)
	  ((string= value "base") :base) 
	  (t (make-langtag :-value value)))))

;;; PNAME_NS 	::= 	PN_PREFIX? ':'
;;; PNAME_LN 	::= 	PNAME_NS PN_LOCAL
;;; PN_LOCAL 	::= 	(PN_CHARS_U | [0-9] | PLX) ((PN_CHARS | '.' | PLX)* (PN_CHARS | PLX))?
;;; PN_PREFIX 	::= 	PN_CHARS_BASE ((PN_CHARS | '.')* PN_CHARS)?
(defun turtle-prefixed-name (in char)
  (declare (ignore stream))
  (let* ((pn-prefix 
	  (with-output-to-string (str)
	    (when (or (char= char #\:) (pn-chars-base-p char))
	      (loop for c = char then (read-char in nil nil)
		 until (or (eql c #\:) (ws-p c))
		 when (null c) do (error 't-lex-eof :in "prefixed name")
		 unless (or (eql c #\.) (pn-chars-p c)) do 
		   (error 't-lex-error :in "prefix name" :expect "PN_CHARS or ." :got c)
		 do (write-char c str)
		 when (eql c #\.) do (unless (pn-chars-p (peek-char nil in nil nil))
				       (error 't-lex-error :in "prefix name" 
					      :expect "PN_CHARS" :got "something else"))))))
	 (pn-local ; hmmm pn_chars_u includes #\:
	  (let ((p (peek-char nil in nil nil)))
	    (unless (or (ws-p p) (pn-chars-u-p p) (<= 48 (char-code p) 57) (eql p #\%) (eql p #\\))
	      (error 't-lex-error :in "prefix name" :expect "PN_CHARS_U,%,\\)" :got p))
	    (with-output-to-string (str)
	      (unless (ws-p p)
		(write-char (read-char in nil nil) str)
		(loop for c = (read-char in nil nil) 
		   until (ws-p c) do
		     (cond ((null c) (error 't-lex-eof :in "prefixed name"))
			   ((char= c #\%) (write-char c str) (read-hex 2 in str))
			   ((char= c #\\) 
			    (unless (pn-local-esc-suffix-p (peek-char nil in nil nil))
			      (error 't-lex-error :in "prefix name" 
				     :expect "local escape char" :got (peek-char nil in nil nil)))
			    (write-char (read-char in nil nil) str))
			   ((char= c #\.)
			    (let ((p (peek-char nil in nil nil)))
			      (unless (or (pn-chars-p p) (eql p #\%) (eql p #\\))
				(error 't-lex-error :in "prefixed name" :expect "PN_CHARS" :got p)))
			    (write-char c str)
			    (write-char (read-char in nil nil) str))
			   ((or (pn-chars-p c) (eql c #\%) (eql c #\\))
			    (write-char c str))
			   (t (error 't-lex-error :in "prefixed name" :expect "PN_CHARS" :got p)))))))))
    (make-pname :-ns pn-prefix :-ln pn-local)))

;;; BLANK_NODE_LABEL 	::= 	'_:' (PN_CHARS_U | [0-9]) ((PN_CHARS | '.')* PN_CHARS)?
(defun turtle-blank-node-label (in char)
  (declare (ignore char))
  (let ((n "BLANK_NODE_LABEL"))
    (let ((c (read-char in nil nil)))
      (unless (eql #\: c) 
	(error 't-lex-error :in n :expect #\: :got c)))
    (let ((label
	   (let ((p (peek-char nil in nil nil)))
	     (unless (or (ws-p p) (pn-chars-u-p p) (<= #.(char-code #\0) (char-code p) #.(char-code #\9)))
	       (error 't-lex-error :in n :expect "PN_CHARS_U or 0-9" :got p))
	     (with-output-to-string (str)
	       (unless (ws-p p)
		 (write-char (read-char in nil nil) str)
		 (loop for c = (read-char in nil nil) 
		    until (ws-p c) do
		      (cond ((null c) (error 't-lex-eof :in n))
			    ((char= c #\.)
			     (let ((p (peek-char nil in nil :eof)))
			       (unless (pn-chars-p p) 
				 (error 't-lex-error :in n :expect "PN_CHARS" :got p)))
			     (write-char c str)
			     (write-char (read-char in nil nil) str))
			    ((or (pn-chars-p p) (<= #.(char-code #\0) (char-code p) #.(char-code #\9)))
			     (write-char c str))
			    (t (error 't-lex-error :in n :expect "PN_CHARS or 0-9" :got c)))))))))
      (when (string= label "") 
	(error 't-lex-error :in n :expect "PN_CHARS_U" :got "white space"))
      (make-blank-node :-label label))))


;;;==============================================================================================
;; Modify the characters
(let ((*readtable* *turtle-readtable*))
  ;;(set-syntax-from-char to-char from-char)
  ;;(set-macro-character char function &opt non-terminating-p)

  (loop for c from #.(char-code #\0) to #.(char-code #\9)
	do (set-macro-character (code-char c) #'turtle-number))
  (set-macro-character #\+ #'turtle-number)
  (set-macro-character #\- #'turtle-number)
  (set-macro-character #\< #'turtle-iriref)
  (set-macro-character #\' #'turtle-string-lit)
  (set-macro-character #\" #'turtle-string-lit)
  (set-macro-character #\_ #'turtle-blank-node-label)
  (set-macro-character #\@ #'turtle-langtag)
  (set-macro-character #\# #'turtle-eol-comment)
  (set-macro-character #\. #'turtle-dot)

  (dolist (ch '(#\( #\) #\[ #\] #\, #\;))
    (set-macro-character ch #'turtle-char))

  (set-macro-character #\Newline #'turtle-newline)

  ;; PN_CHARS_BASE (for prefixed name)
  (loop for (start . stop) in 
       (list (cons (char-code #\A) (char-code #\Z))
	     (cons (char-code #\a) (char-code #\z))
	     (cons (char-code #\:) (char-code #\:))
	     (cons #x00C0 #x00D6)
	     (cons #x00D8 #x00F6)
	     (cons #x00F8 #x02FF) 
	     (cons #x0370 #x037D) 
	     (cons #x037F #x1FFF) 
	     (cons #x200C #x200D) 
	     (cons #x2070 #x218F) 
	     (cons #x2C00 #x2FEF) 
	     (cons #x3001 #xD7FF) 
	     (cons #xF900 #xFDCF) 
	     (cons #xFDF0 #xFFFD) 
	     ;(cons #x10000 #xEFFFF)
	     ) do
       (loop for c from start to stop 
	    if (null (code-char c)) do (format t "No character for code ~x." c)
	    else do (set-macro-character (code-char c) #'turtle-prefixed-name)))
)

(defun turtle-read (&rest args)
  (let ((*package* *turtle-pkg*)
	(*readtable* *turtle-readtable*))
    (let ((result (apply #'read args))
	  (stream (car args)))
      (dbg-message :lexer 5 "~%In turtle-read, result = ~A" result)
      (dbg-message :lexer 5 "~%In turtle-read, file pos = ~A" (file-position stream))
      (with-slots (recent-token-positions) *token-stream*
	  (setf (gethash result recent-token-positions)
		(file-position stream)))
      result)))

(defun turtle-read-from-string (string &rest args)
  (let ((*package* *turtle-pkg*)
	(*readtable* *turtle-readtable*))
    (let ((result (apply #'read-from-string string args)))
      (dbg-message :lexer 5 "~%In turtle-read, result = ~A" result)
      result)))

