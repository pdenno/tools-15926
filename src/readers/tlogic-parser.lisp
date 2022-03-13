;;; Purpose: An parser for 'template logic' -- a KIF-like bi-conditional.

;;; ToDo:
;;;   - Enclose the toplevel in a universal quantification.
;;;   - Check that all variables declared (in universal and existential quantifications) are used.

(in-package :tlogic)

(defclass tlogic-stream (token-stream)
  ((read-fn :initform 'tlogic-read)))

;;; For now, I can't use assert-token. (I have no idea why.)
(defmethod assert-token (token (stream-obj tlogic-stream))
  "Read next token from stream checking that it matches TOKEN, error if not."
  (let ((*token-stream* stream-obj))
    (let ((tkn (read-token stream-obj)))
      (unless (eql tkn token)
	(error 'axiom-parse-token-error
	       :tag (car *tags-trace*)
	       :tags *tags-trace*
	       :expected token
	       :actual tkn
	       :line-number *line-number*))
      tkn)))

(defmacro defparse (tag (&rest keys) &body body)
   "Defines a parse-data eql method on TAG. The method macrolets parse."
   `(defmethod parse-data ((stream tlogic-stream) (tag (eql ',tag)) &key ,@keys)
      (macrolet ((parse (tag &rest keys) ; the mystery solved: pass2 needs to call parse too.
			`(parse-data stream ',tag ,@keys)))
	,@body)))

(defgeneric tlogic2lisp (str &key debug-p &allow-other-keys))

(defmethod tlogic2lisp ((str string) &key debug-p)
  "Create a string-intput-stream and call tlogic2lisp with it."
  (when debug-p (format t "~%Testcase: ~S~%" str))
  (let ((string-stream (make-string-input-stream (strcat str " ")))
	(*package* (find-package :tlogic)))
    (with-open-stream (stream (setf *token-stream*
				    (make-instance 'tlogic-stream :stream string-stream)))
      (let ((result (tlogic2lisp stream)))
	(if (eql :eof (peek-token stream))
	    result
	  (error 'axiom-parse-incomplete :actual (peek-token stream)))))))

(defmethod tlogic2lisp ((stream stream) &key)
  "Top-level call. Returns a translated ocl expression. SCOPE is used when coming in from QVT."
  (setf *tags-trace* nil)
  (parse-data stream '|TlogicSentence|))

(defmethod parse-data :around ((stream tlogic-stream) tag &rest args)
  (push tag *tags-trace*)
  (dbg-message :parser 5 "~%Entering ~S(~S) peek=~S~%" tag args (peek-token stream))
  (let ((result (call-next-method)))
    (dbg-message :parser 5 "~%Exiting ~S with value ~S ~%" tag result)
    (force-output *debug-stream*)
    result))

(defvar *def* nil "Dynamically bound to the current MM object during parsing (when with-instance is used")

;;; This IS NOT a candidate for pod-utils. Each impementation differs (See the EXPRESS one.)
(defmacro with-instance ((type &rest init-args) &body body)
  "A macro that creates an object and provides with-slots to use it."
  (let ((slot-names (mapcar #'slot-definition-name (class-slots (find-class type)))))
    `(let* ((*def* (make-instance ',type ,@init-args)))
      (with-slots ,slot-names *def*
	(declare (ignorable ,@slot-names))
	(setf mofi:|token-position| (token-position *token-stream*))
	,@body
	*def*))))

;;;======================== The Grammar ==============================
;;; TlogicSentence ::= TemplateSentence '<->' BooleanSentence .
;;; TemplateSentence ::= AtomicSentence                              -- Hack for universal quantification
;;; BooleanSentence ::= Conjunction                                  -- would be more.
;;; Conjuction ::= (QuantifiedSentence | AtomicSentence) ('&' (QuantifiedSentence | AtomicSentence))*
;;; QuantifiedSentence ::= ExistentialQuantification                 -- would be more.
;;; ExistentialQuantification ::= ('exists' Name)+ '(' Conjunction ')'
;;; Atom ::= AtomicSentence                                          -- would be more.
;;; AtomicSentence ::= Predicate '(' Term (, Term)* ')'
;;; Term ::= Name  | number | string-constant                        -- would be more.
;;; Predicate ::= string
;;; Name ::= string

(defvar *scopes* nil "A list of scope objects, closest first")
(defstruct scope (-vars nil))

;;; 2022 Really!?! (The stuff below is old code.)
;;;#.(unintern 'ocl:|body|)
;;;#.(import 'odm-cl::|body|)

;;; TlogicSentence ::= TemplateSentence '<->' BooleanSentence .
(defparse |TlogicSentence| ()
    (setf *line-number* 1)
    (setf *scopes* nil)
    (let ((body
	   (with-instance (|Biconditional|)
	     (setf |lvalue| (parse |TemplateSentence| :parent *def*))
	     (assert-token :<-> stream)
	     (setf |rvalue| (parse |BooleanSentence| :parent *def*))
	     (assert-token #\. stream))))
      ;; Wrap it in a Universal Quantification
      (with-instance (|UniversalQuantification|)
	(setf |binding| (scope--vars (last1 *scopes*)))
	(setf (mofi:%source-elem body) *def*)
	(setf odm-cl::|body| body))))

;;; The variables introduced here are assumed universally scoped.
;;; TemplateSentence ::= AtomicSentence
(defparse |TemplateSentence| (parent)
  (let* ((result (parse |AtomicSentence| :new-vars t :parent parent))
	 (new-vars (scope--vars (car *scopes*))))
    (unless (= (length new-vars) (length (remove-duplicates new-vars :test #'string=)))
      (error 'axiom-duplicate-variable-lhs :vars new-vars))
    result))

;;; BooleanSentence ::= Conjunction
(defparse |BooleanSentence| (parent)
  (parse |Conjunction| :parent parent))

;;; QuantifiedSentence ::= ExistentialQuantification
(defparse |QuantifiedSentence| (parent)
  (parse |ExistentialQuantification| :parent parent))

;;; AtomicSentence ::= Predicate '(' Term (, Term)* ')'
(defparse |AtomicSentence| (new-vars parent)
  (with-instance (|AtomicSentence|)
    (setf |predicate| (parse |Predicate|))
    (assert-token #\( stream)
    (setf |argument|
	  (cons (parse |Term| :error-p (not new-vars))
		(loop while (eql #\, (peek-token stream))
		      do (read-token stream)
		      collect (parse |Term| :error-p (not new-vars)))))
    (when new-vars (push (make-scope :-vars |argument|) *scopes*))
    (setf mofi:|source-elem| parent)
    (assert-token #\) stream)))

;;; BooleanSentence ::= Conjunction
(defparse |BooleanSentence| (parent)
  (parse |Conjunction| :parent parent))

;;; Conjuction ::= (QuantifiedSentence | AtomicSentence) ('&' (QuantifiedSentence | AtomicSentence))*
(defparse |Conjunction| (parent)
  (with-instance (|Conjunction|)
    (setf |conjunct|
	  (cons (if (eql (peek-token stream) :exists)
		    (parse |QuantifiedSentence| :parent *def*)
		    (parse |AtomicSentence| :parent *def*))
		(loop while (eql #\& (peek-token stream))
		      do (read-token stream)
		      collect (if (eql (peek-token stream) :exists)
				  (parse |QuantifiedSentence| :parent *def*)
				  (parse |AtomicSentence| :parent *def*)))))
    (setf mofi:|source-elem| parent)))

;;; ExistentialQuantification ::= ('exists' Name)+ '(' Conjunction ')'
(defparse |ExistentialQuantification| (parent)
  (with-instance (|ExistentialQuantification|)
    (assert-token :exists stream)
    (setf |binding| (list (parse |Name| :parent *def*)))
    (loop while (eql :exists (peek-token stream))
       do (read-token stream)
	 (push (parse |Name| :parent *def*) |binding|))
    (assert-token #\( stream)
    (push (make-scope :-vars |binding|) *scopes*)
    (setf |body| (parse |Conjunction| :parent *def*))
    (assert-token #\) stream)
    (setf mofi:|source-elem| parent)
    (pop *scopes*)))

;;; Term ::= Name  | number | string-constant
(defparse |Term| ((error-p t))
    (let ((term (read-token stream)))
      (typecase term
	(string (if (find-if #'(lambda (x) (member term x :test #'string=)) *scopes* :key #'scope--vars )
		    term
		    (if error-p
			(error 'axiom-unbound-variable :var term)
			term)))
	(number term)
	(string-constant term)
	(t (error 'axiom-parse-token-error
		  :expected "a variable, number, or string constant"
		  :actual term)))))

(defparse |Name| ()
  (let ((name (read-token stream)))
    (unless (stringp name)
      (error 'axiom-parse-token-error :expected "a variable" :actual name))
    name))

(defparse |Predicate| ()
  (let ((pred (read-token stream)))
    (unless (stringp pred)
      (error 'axiom-parse-token-error :expected "a predicate symbol" :actual pred))
    pred))
