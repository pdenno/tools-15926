
;;; Copyright (c) 2007 Peter Denno
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

;;;
;;; Peter Denno
;;;  Date: 12/2/95 - on going, moved from expresso. 
;;;

(in-package :pod-utils)

;;; To do: Get the *line-number* value (from *reader*) to reflect where the 'cursor'
;;; is rather than the whatever was peeked. This is especially useful in ugly grammars
;;; such as OCL and QVT, where there is arbitrary look-aheads that make the line number useless.


(defvar *token-stream* nil "Lexically bound, the active token-stream object")

(defclass simple-token-stream (#+LispWorks stream:fundamental-character-input-stream
			       #+LispWorks stream:fundamental-character-output-stream

			#+Allegro excl:fundamental-character-input-stream
			#+Allegro excl:fundamental-character-output-stream

                        #+CMU ext:fundamental-character-input-stream
			#+CMU ext:fundamental-character-output-stream

			#+SBCL sb-gray:fundamental-character-input-stream
			#+SBCL sb-gray:fundamental-character-output-stream)
  ;; The stream object (to use lisp terminology).
  ((stream :initarg :stream :reader token-stream-stream)
   ;; A function that sets the readtable calls read with at least the stream object as an argument.
   (read-fn :initarg :read-fn)
   ;; A hash table indexed by token string, value is file position of the last 
   ;; reader read of the token string.
   (recent-token-positions :reader recent-token-positions :initform (make-hash-table :test #'equal))
   ;; Tokens that have been peeked, but not yet consumed
   (peeked-tokens :initform nil)))

(defmethod stream-filename ((stream simple-token-stream))
  (with-slots ((str stream)) stream
    (truename str)))

(defmethod stream-element-type ((stream simple-token-stream))
  'simple-char)

(defmethod input-stream-p ((stream simple-token-stream))
  (with-slots ((fs stream)) stream
    (input-stream-p fs)))

(defmethod output-stream-p ((stream simple-token-stream))
  (with-slots ((fs stream)) stream
    (output-stream-p fs)))

;;; This one is only needed for qvt/opl AFAIK. (Go back and change turtle, etc.)
(defclass token-stream (simple-token-stream)
   ;; True if the normal stream for this buffer is NOT being used (we are using buffer-string)
   ;; This is NOT about the stream versus buffer-string string-stream. It is used with with-other-reader
  ((switched-out-p :reader switched-out-p :initform nil)
   ;; A buffer that stores characters read while peeking (used by with-other-reader)
   ;; Set this to nil when you don't need with-other-reader. Then you won't have to use
   ;; read-char-buffered, etc. 
   (buffer-string :initform (make-array 100 :element-type 'character :fill-pointer 0 :adjustable t)
		  :initarg :buffer-string)
   ;; Holds the real (not string-input-stream) always.
   (hold-stream :initform nil)))

(defmethod initialize-instance :after ((obj token-stream) &key)
  "Set the hold-stream. This will be used to ensure correct usage of with-other-reader.
   It is never modified."
  (when (slot-boundp obj 'stream)
    (with-slots (hold-stream stream) obj
      (setf hold-stream stream))))


;(defun make-token-stream (character-stream)
;  (make-instance 'token-stream :stream character-stream))

(defvar *line-number* 1 "Counts lines while reading.")
(defvar *tags-trace* nil "Stack of entry points into parser")
(defvar *bcounter-starts* nil "Dynamically bound to a list of syntax element start tokens (strings).")
(defvar *bcounter-ends* nil "Dynamically bound to a list of syntax element start tokens (strings).")

;;; This may be used in some parsers (OCL) where I don't want a special object
;;; for string constants (so that other tokens can be strings, and not be interned to 
;;; distinguish them from what is intended to be a string constant. 
(defstruct string-const (-value))

;;; POD Make this check-bcounters stuff functions stored in a slot. Make the default call #'identity.

;;; Stuff to check, at end of every declaration, whether every x is balanced with an end_x.
;;; Must be package-neutral, thus use of strings.
(let* ((bcounters (make-hash-table :test #'equal))
       (twins (make-hash-table :test #'equal))
       (+syms *bcounter-starts*)
       (-syms (loop for s in +syms
		    for -sym = (strcat "END_" s) ; All wrong ??? check ocl/token-stream.lisp
		    collect (setf (gethash s twins) -sym)))) ; pod 2006-09-20 was 'do' Why? 
  (defun init-bcounters () 
    (loop for s in +syms do (setf (gethash s bcounters) 0)))
  (defun check-bcounters (token) ; called in read-token
    (when (symbolp token)
      (let ((name (symbol-name token)))
	(if-bind (mem (member name +syms :test #'equal)) ; increment or decrement...
		 (incf (gethash (car mem) bcounters))
		 (when-bind (mem (member token -syms :test #'equal))
			    (decf (gethash (gethash (car mem) twins) bcounters))))
	(when (member token *bcounter-ends* :test #'equal) ; then check...
	  (loop for key being the hash-key of bcounters using (hash-value val)
		unless (zerop val) 
		do (error 'token-balance-error :token key :line-number *line-number*)))
	token)))
)
 
(defun token-position (token)
  "Returns the file-position of the most recently read instance of string TOKEN, a string."
  (with-slots (recent-token-positions) *token-stream*
    (gethash token recent-token-positions)))

(declaim (inline check-token))
(defun check-token (token stream-obj)
  (let ((*token-stream* stream-obj))
    (eql (peek-token stream-obj) token)))

(defgeneric assert-token (token stream))

;2013-03-08(declaim (inline assert-token))
;2013-03-08(defun assert-token (token stream-obj)
(defmethod assert-token (token (stream-obj t))
  (let ((*token-stream* stream-obj))
    (let ((tkn (read-token stream-obj)))
      (unless (eql tkn token)
	(error 'parse-token-error 
	       :tags *tags-trace* 
	       :expected token
	       :actual tkn
	       :line-number *line-number*))
      tkn)))


(declaim (inline assert-token-str))
(defun assert-token-str (token stream-obj)
  "String version of assert-token"
  (let ((*token-stream* stream-obj))
    (let ((tkn (read-token stream-obj)))
      (unless (string= tkn token)
	(error 'parse-token-error 
	       :tags *tags-trace*
	       :expected token
	       :actual tkn
	       :line-number *line-number*))
      tkn)))

(defvar *peeking* nil)
(defmethod peek-token (stream-obj &optional (ahead 1))
  (let ((*token-stream* stream-obj))
    (let (result)
      (unwind-protect
	   (with-slots (peeked-tokens) stream-obj
	     (setf *peeking* t)
	     (or (setf result (nth (1- ahead) peeked-tokens))
		 (loop for i from (length peeked-tokens) to (1- ahead)
		       for tkn = (read-token stream-obj :pop-ok nil) do
		       (push-last tkn peeked-tokens)
		       (dbg-message :lexer 5 "~%==== Peek pushed, peeked-tokens now = ~S" peeked-tokens)
		       finally (setf result tkn))))
	(setf *peeking* nil))
      result)))

(defun trim-buffer-string (stream-obj popped-from-peeked)
  "POPPED-FROM-PEEKED was the token at the top of peeked-tokens. This function, called
   when a token is actually consumed (and not just peeked) keeps stream-obj.buffer-string 
   current with stream-obj.peeked-tokens by likewise (likewise to the peeked-token pop) 
   removing the token from the buffer string."
  (when (string-const-p popped-from-peeked)
    (setf popped-from-peeked (string-const--value popped-from-peeked)))
  (with-slots (read-fn buffer-string) stream-obj
    (dbg-message :lexer 5 "~%Old buffer-string = ~S" buffer-string)
    (let* ((str-stream (make-string-input-stream buffer-string))
	   (read-from-string (funcall read-fn str-stream nil :eof))
	   (new-string (make-array 100 :element-type 'character :fill-pointer 0 :adjustable t)))
      (when (string-const-p read-from-string)
	(setf read-from-string (string-const--value read-from-string)))
      ;; This is comparing just two tokens, not the whole buffers.
      (unless (equal read-from-string popped-from-peeked)
	(format t "~%--- error ---")
	(VARS read-from-string popped-from-peeked)
	(error "Inconsistency between buffer-string and popped token. (File not syntactically correct?)"))
      ;; 'Trim' the string by copying what was not read onto a new string. 
      (loop for i from (file-position str-stream) to (1- (fill-pointer buffer-string))
	    do (vector-push-extend (aref buffer-string i) new-string))
      (setf buffer-string new-string))
    (dbg-message :lexer 5 "~%New buffer-string = ~S" buffer-string))
  (values))

(defmethod read-token ((stream-obj simple-token-stream) &key (pop-ok t))
  "Return a token, either by calling read-fn with STREAM-OBJ, or popping from peeked stuff."
  (let ((*token-stream* stream-obj))
    (handler-case
	(with-slots (stream peeked-tokens read-fn) stream-obj
	  (let (result)
	    (if (and pop-ok peeked-tokens)
		(setf result (pop peeked-tokens))
		(setf result (funcall read-fn stream t)))
	    (unless *peeking* (dbg-message :parser 5 "~%Consuming: ~S (in ~A)" result (car *tags-trace*)))
	    result))
      (end-of-file () :eof))))

(defmethod read-token ((stream-obj token-stream) &key (pop-ok t))
  "Return a token, either by calling read-fn with STREAM-OBJ, or popping from peeked stuff.
   In the case of :eof, check that you aren't running on the 'other' stream -- if you are switch
   streams and call yourself again."
  (let ((*token-stream* stream-obj))
    (handler-case
	(with-slots (stream peeked-tokens read-fn buffer-string) stream-obj
	  (let (result result-was-popped)
	    (when buffer-string ; some parsers (e.g. p11, alf) don't use this.
	      (vector-push-extend #\Space buffer-string)) ; separate peeked-tokens
	    ;; POD I removed check-bcounters for clarity while debugging.
	    (if (and pop-ok peeked-tokens)
		(setf result (setf result-was-popped (pop peeked-tokens)))
		(setf result (funcall read-fn stream t)))
	    (when buffer-string
	      (when result-was-popped (trim-buffer-string stream-obj result)))
	    (unless *peeking*                                                      
	      (dbg-message :parser 5 "~%Consuming: ~S (in ~A)" result (car *tags-trace*)))
	    result))
      (end-of-file ()
	(with-slots (hold-stream stream) stream-obj
	  (cond (;(and (typep stream 'string-stream)   ;; Here if you exhausted the buffer-string (or don't have one). 
		 (not (eql stream hold-stream)) ;; Could be called with a string stream!
		 ;; Switch back to normal operation.
		 (dbg-message :lexer 5 "~%==== Exhausted string buffer.")
		 (dbg-message :lexer 5 "~%==== Reverting to ~A" hold-stream)
		 (setf stream hold-stream)
		 (read-token stream-obj :pop-ok pop-ok))
		(t :eof ;(error "End of file while reading tokens.")
		   )))))))

;;; POD New for 2014-04-08. NOT coordinated with read-char-buffered or other stuff here. (Does it need to be?)
(defmethod unread-token (tkn stream-obj)
  "Push a token back onto the peeked-tokens stack."
  (with-slots (peeked-tokens) stream-obj
    (push tkn peeked-tokens)
    t))

;;;=================================================
;;; Managing the buffer-string
;;;=================================================
(defun read-char-buffered (&rest args)
  "Wraps read-char, pushes result on to buffer-string if peeking."
  (when-bind (c (apply #'read-char args))
    (when *peeking* 
      (with-slots (buffer-string) *token-stream*
	(vector-push-extend c buffer-string)))
    c))

(defun unread-char-buffered (&rest args)
  "Wraps read-char, pops from buffer-string if peeking."
  (apply #'unread-char args)
    (when *peeking* 
      (with-slots (buffer-string) *token-stream*
	(vector-pop buffer-string)))
    nil)

(defun char-buffered (char)
  "For use where characters where read by reader, but not otherwise caught.
   For example, ocl-char, qvt-char, qvt-newline"
  (when *peeking*
    (with-slots (buffer-string) *token-stream*
      (vector-push-extend char buffer-string)))
  char)

;;;=================================================
;;; Handling 'other' readers
;;;=================================================
;;; POD Variable capture on with-slots!
(defmacro with-other-reader ((stream-obj other-read-fn) &body body)
  "A macro to use a different lexer, handles problem of unread (peeked) tokens 
   on entry and exit from BODY. READ-FN is the read-fn of the switched-to lexer."
  (with-gensyms (hold-read)
    `(with-slots (read-fn (lisp-stream stream) buffer-string peeked-tokens switched-out-p) ,stream-obj
      (when switched-out-p (error "Nested entry into with-other-reader?"))
      (vector-push-extend #\Space buffer-string) ; separate tokens
      (let ((,hold-read read-fn))
	(dbg-message :lexer 5 "~%==== Switching out to 'other' reader.")
	(setf read-fn #',other-read-fn)
	(setf switched-out-p t)
	(when peeked-tokens ; stream-obj has peeked stuff (from primary reader) we need to un-read 
	  (dbg-message :lexer 5 "~%==== Have left-over peeked-tokens on 'main' stream.")
	  (dbg-message :lexer 5 "~%==== peeked-tokens = ~A buffer-string = ~S" peeked-tokens buffer-string)
	  ;; Hitting :eof is responsible for resetting this (not at exit here).
	  (setf lisp-stream (make-string-input-stream buffer-string))
	  ;; Prepare to buffer peeked tokens from 'other' stream.
	  (setf peeked-tokens nil)
	  (setf (fill-pointer buffer-string) 0))
	(progn ,@body)
	(setf read-fn ,hold-read)
	(setf switched-out-p nil)
	(dbg-message :lexer 5 "~%==== Switching back to original reader.")
	(when peeked-tokens ; have stuff you need to un-read (from 'other' reader)
	  ;; Same as above: set stream to buffer, clear buffer and peeked-tokens
	  (dbg-message :lexer 5 "~%==== Have left-over peeked-tokens from 'other' stream.")
	  (dbg-message :lexer 5 "~%==== peeked-tokens = ~A buffer-string = ~S" peeked-tokens buffer-string)
	  (setf lisp-stream (make-string-input-stream buffer-string))
	  (setf peeked-tokens nil)
	  (setf (fill-pointer buffer-string) 0))))))


;;;=================================================
;;; Parsing
;;;=================================================
;;; "parse1" means "parse pass1"
(defgeneric parse1-data (stream-obj tag &key &allow-other-keys))
(defgeneric parse2-data (stream-obj tag &key &allow-other-keys))
(defgeneric parse-data (stream-obj tag &key &allow-other-keys))


;;; This is nice to have around, just in case something didn't get wrapped
;;; by the macrolet.
(defmacro parse (tag &rest keys)
  (declare (ignore tag keys))
  (error "Never use this."))

;;;=====================================================
;;; Parsing errors
;;;=====================================================
(define-condition utils-parse-error (error)
  ((line-number :initarg :line-number :initform nil)
   (text :initarg :text)) ; pre-formatted text
  (:report (lambda (err stream)
	     (with-slots (line-number text) err
	       (format stream "Line ~A: ~A"
		       (or line-number *line-number*)
		       (or text "Error while parsing."))))))

(defmacro def-parse-error (name superclasses &body body)
  `(define-condition ,name ,(or superclasses '(utils-parse-error)) ,@body))
  
(def-parse-error parse-token-error ()
  ((tags :initarg :tags :initform nil)
   (expected :initarg :expected :initform nil)
   (actual :initarg :actual :initform nil))
  (:report (lambda (err stream)
	     (with-slots (tags expected actual line-number) err
	       (format stream "~A (line ~A) : expected '~S'  read '~S' ~%Parse stack: ~{~%   * ~A~}"
			  (car tags) line-number expected actual tags)))))

(def-parse-error token-balance-error ()
  ((token :initarg :token))
  (:report (lambda (err stream)
	     (with-slots (token line-number) err
		  (format stream "Unbalanced ~A before line ~A." token line-number)))))

(def-parse-error parse-error-with-token ()
  ((definition :initarg :definition)
   (token      :initarg :token))
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, an error occurred at token '~A'"
			   definition token)))))

(defun print-parse-stack (err language pass)
  "Print the error ERR, and parse stack to info-message."
  (format *debug-stream* "~%Error at line ~A while reading ~A (pass ~A) file:" 
		     *line-number* language pass)
  (format *debug-stream* "~%  ~A" err)
  (format *debug-stream* "~%Parse stack: ~{~%   * ~A~}" *tags-trace*))

;;;===============================================================
;;; Scope Management
;;;==============================================================
(defvar *scope* nil   "Dynamically bound to the current scope.")

(defclass %%scope () 
  ((%%name :initarg :%%name :accessor %%name :initform nil)
   (%%type  :initarg :%%type :reader %%type) ;; :global :let :iterator ... others
   (%%parent :initarg :%%parent :accessor %%parent :initform nil)
   (%%children :accessor %%children :initform nil)
   (%%ids :initarg :%%ids :initform (make-hash-table :test #'equal) :reader %%ids)
   (%%package :initarg :%%package :initform nil :reader %%package)))

(defmethod initialize-instance :after ((obj %%scope) &key)
  (when (%%parent obj)
    (push obj (%%children (%%parent obj)))))

(defmethod print-object ((obj %%scope) stream) 
  (with-slots (%%name %%type) obj
	      (format stream "#<scope ~A (a ~A)>" 
			 (if %%name (string %%name) "[unnamed]")
				%%type)))

(defgeneric token-is (name type scope &key &allow-other-keys))
(defgeneric add-type (name scope type &key &allow-other-keys))

(defmethod token-is (name type (scope %%scope) &key)
  "Returns T if NAME is of type signified by TYPE. SCOPE is starting scope. 
   The function recurses through %%parent. NAME is an identifier. TYPE is a keyword: 
   :entity, :function, :procedure :enum-val :constant :type :variable :parameter, etc...
   (whatever values you provided to add-type)."
  (with-slots (%%ids %%parent) scope
    (or 
      (and (hash-table-p %%ids)
	   (member type (gethash name %%ids) :key #'car))
      (when %%parent
	(token-is name type %%parent)))))

(defmethod token-scope (name &key (start-scope *scope*) (error-p t))
  "Return a scope staring with START-SCOPE and looking upward, that
   has the key NAME in its %%ids (a hash table)."
  (let ((result 
	 (loop for scope = start-scope then (%%parent scope) while scope
	       when (gethash name (%%ids scope)) return scope)))
    (when (and error-p (null result))
      (error "Could not find scope for identifier ~A." name))
    result))

;;; add-type is used (in the first pass in P11 and second pass in OCL and QVT)
;;; to add ids to the %%ids hash table of the current %%scope object.  The %%ids hash table
;;; is keyed by the id and lists all the declaration types that the id is in that scope.
;;; add-type records the file-position, but this is only accurate when the token was the last thing read.
(defmethod add-type (name (scope %%scope) type &key package)
   "Typical usage:  (add-type some-id *scope* :variable)"
   (with-slots (%%ids %%package) scope
     (when package (setf %%package package))
     (pushnew (cons type (token-position (string name)))
	      (gethash (string name) %%ids)
	      :test #'equal)))
;    (when (and (eql type :attribute) (%%parent scope))
;      (add-type name (%%parent scope) :attribute))))

(defun find-child-scope (name &key contains) 
  "Find a scope that is a direct child of *scope* and contains NAME or satisfies the parameters 
   specified in CONTAINS. NAME names a scope (or is nil). CONTAINS.INAME is a name found in it."
  (or 
   (and name (find name (%%children *scope*) :test #'string-equal :key #'%%name))
   (dbind (itype iname token-pos) contains ; itype is :query-expression or :repeat-stmt
     (depth-first-search *scope* 
			 #'(lambda (c)
			    (and (eql itype (%%type c))
				 (member token-pos (gethash iname (%%ids c)) :key #'cdr :test #'equal)))
			 #'%%children))
   (if name 
       (error "Could not find scope with name: ~A." name)
       (dbind (itype iname token-pos) contains
	 (error "Could not find scope of type ~A containing ~A at position ~A."
		itype iname token-pos)))))

(defun toplevel-scope (&optional (scope *scope*))
  (if (null (%%parent scope)) scope (toplevel-scope (%%parent scope))))

(defun describe-scopes (&optional (scope *scope*) (level 0))
  (flet ((spaces () (format t "~%") (loop for i from 1 to level do (format t "   "))))
    (with-slots (%%children %%ids) scope
      (spaces) (format t "SCOPE at level ~A = ~A" level scope)
      (unless (zerop (hash-table-count %%ids))
	(spaces) (format t "IDs:")
	(loop for key being the hash-key of %%ids using (hash-value vals)
	      do (spaces) (format t "   ~S     ~A" key vals)))
      ;(when %%children (spaces) (format t " children = ~A" %%children))
      (mapcar #'(lambda (x) (describe-scopes x (1+ level))) %%children)))
  (values))

(defun found-at-pos (predicate stream &key (max 1000))
 " Return the position (only useful for relative comparison) in the 
   token stream where PREDICATE (function of one arg) returns true. Pred is applied to 
   tokens read sequentially from the stream. If hit :eof, returns nil."
 (loop for pos from 1 to max
       for tkn = (peek-token stream pos)
       when (eql tkn :eof) return nil
       when (funcall predicate tkn) return pos
       finally (return (1+ max))))
