;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Package: EXPRESSO; Base: 10 -*-

;;; Copyright (c) 2001 Logicon, Inc.
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


;;; Peter Denno
;;; Date: 9/3/96
;;;
;;; Purpose: Macros. 
;;;

(in-package :expresso)

(defmacro with-gensyms (syms &body body)
  "Paul Graham ON LISP pg 145. Used in macros to avoid variable capture."
  `(let ,(mapcar #'(lambda (s) 
		     `(,s (gensym)))
	  syms)
     ,@body))

(defmacro express-error (type string &rest args)
  "Two usages: 
    (1) (express-error <type> <format-string> <format-args>)
    (2) (express-error <type> <keyword/arg pair> <keyword/arg pair> ...)"
  (if (stringp string)
      `(warn ',type :format-string ,string :format-arguments (list ,@args))
      `(warn ',type ,string ,@args)))

(defmacro express-true (arg)
  "Returns true unless the argumnent is :f :u or :?. 
   Argument may be a p21-boolean-logical-select."
  (with-gensyms (val)
    `(let ((,val ,arg))
       (typecase ,val
         (p21-boolean-logical-select
          (eql :t (p21-boolean-logical-select--keyword ,val)) t)
         (otherwise
          (unless (or (null ,val) (eql ,val :?) (eql ,val :u) (eql ,val :f)) t))))))

;;; from express-utils.lsp

(defmacro set-option (slot value)
  "Convenience macro for preference"
  `(option-set *expresso* ',slot ,value))

(defmacro get-option (slot)
  `(option-get *expresso* ',slot))

(defmacro incf-option (slot)
  `(option-incf *expresso* ',slot))

(defmacro decf-option (slot)
  `(option-decf *expresso* ',slot))

(defmacro get-special (slot)
  `(option-get *expresso* ',slot))

(defmacro set-special (slot value)
  `(option-set *expresso* ',slot ,value))

(defmacro set-special* (slot value)
  `(option-set *expresso* ,slot ,value))

#+Allegro
(defmacro display-message (message &rest args)
  `(format *message-stream* ,message ,@args))

(defmacro with-done-message ((fmt-string &rest args) &body body)
  `(progn
     (info-message "~2%;;; ~@? ...~%" ,fmt-string ,@args)
     ,@body
     (info-message "~2%;;; DONE~%")))

(let (in-derived)
  (defun printing-derived-p () in-derived)
  (defun (setf printing-derived) (val)
    (setf in-derived val))
)

(defmacro with-derived-printing (&body body)
  "Set the generalized variable (printing-derived-p)."
  (with-gensyms (oldval)
    `(let ((,oldval (printing-derived-p)))
       (unwind-protect
         (progn 
           (setf (printing-derived) t)
            ,@body)
         (setf (printing-derived) ,oldval)))))


(defclass delay-evaluation ()
  ((lambda-list :initarg :lambda-list :accessor expo-lambda-list) 
   (form :initarg :form :accessor form)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Things that are NOT RHS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; POD variable capture?
(defmacro defdomain-rules (entity-type &body body)
  "Macro for WHERE rule thing from generated lisp"
  (let ((+inst+ (intern "INSTANCE" (lisp-package (schema *expresso*)))))
    `(defmethod domain-rules :after ((,+inst+ ,(intern entity-type (lisp-package (schema *expresso*)))))
       (with-partial-context (,entity-type)
	 (let ((rule-labels
		',(loop for form in body for i from 1 
		     if (null (car form)) collect (format nil "unnamed-~A" i)
		     else collect (car form)))
	       (rule-fns 
		(list ,@(loop for form in body 
			   collect `(function (lambda () ,(second form)))))))
	   (loop while rule-fns do
		(when-bind (rule-fn (pop rule-fns))
		  (when-bind (rule-label (pop rule-labels))
		    (catch 'next-domain-rule
		      (handler-bind
			  ((error #'(lambda (c)
				      (warn
				       'express-execution-error
				       :lisp-error c
				       :rule-name ,entity-type
				       :rule-label rule-label
				       :instance ,+inst+)
				      (throw 'next-domain-rule nil))))
			(let ((result (funcall rule-fn)))
			  (cond ((or (null result) (eql result :f))
				 (warn 'failed-domain-rule 
				       :instance ,+inst+
				       :rule-name ,entity-type
				       :rule-label rule-label))
				((or (eql result :u) (eql result :?))
				 (warn 'domain-rule-returned-indeterminate
				       :instance ,+inst+
				       :rule-name ,entity-type
				       :rule-label rule-label))))))))))))))

;;; POD Consider using hash tables to contain aggregates. It would help here!
(defmacro defglobal-rule (name types &body body)
  `(progn 
    (setf (gethash ',name (global-rules (expo::schema expo::*expresso*)))
     #'(lambda (dataset)
	 (with-partial-context ,types
	   (let* (,@(loop for type in types ; extents
			  collect
			  `(,type (make-instance 'express-bag ; skip doing express-equal...
				   :value (ht2list (extent ',type dataset)) ; pod UGH!
				   :type-descriptor
				   (make-instance 'bag-typ :base-type ',type
				    :l-bound 1
				    :u-bound (hash-table-count (extent ',type dataset))))))
		    (rule-labels 
		     ',(loop for form in body for i from 1 
			     if (null (car form)) collect (format nil "unnamed-~A" i)
			     else collect (car form)))
		    (rule-fns 
		     (list ,@(loop for form in body collect `(function (lambda () ,(second form)))))))
	     (loop while rule-fns do
		   (when-bind (rule-fn (pop rule-fns))
		     (when-bind (rule-label (pop rule-labels))
		       (catch 'next-global-rule
			 (handler-bind
			     ((error #'(lambda (c)
					 (warn
					  'express-execution-error
					  :lisp-error c
					  :rule-name ',name
					  :rule-label rule-label)
					 (throw 'next-global-rule nil))))
			   (let ((result (funcall rule-fn)))
			     (when (or (null result) (eql result :f))
			       (warn 'failed-global-rule 
				     :rule-name ',name
				     :rule-label rule-label))))))))))))))


(defun canonicalize-direct-slot (class class-name spec)
  "Similar to mof.lisp version, CLASS is the class symbol, spec is like above, produced by def-mm-class."
  (declare (ignore class))
  (let ((name (car spec))
	(pairs (cdr spec))
	initform initfunction other-options)
    (loop while pairs for key = (pop pairs) for val = (pop pairs) do
	  (case key
	    (:initform
	     (setf initfunction `(function (lambda () ,val)))
	     (setf initform `',val))
	    (:range
	     (push-last key other-options)
	     (if (listp val) (push-last val other-options) (push-last `',val other-options)))
	    (otherwise 
	     (push-last key other-options) 
	     (push-last `',val other-options))))
    `(list 
      :name ',(intern name)
      :initargs '(,(kintern (format nil "~A.~A" class-name name)))
      ,@(if initfunction
	    `(:initform ,initform :initfunction ,initfunction)
	    `(:initform nil :initfunction (function (lambda () nil))))
      ,@other-options)))

;(defmacro hey (&body (slots . options))
;  `(progn ,slots ,options))

;;; Purpose: Macro to create a defclass and set slot-definition attibutes:
;;;          express-type, string-class-name and inverse slot,
;;; POD variable capture!
(defmacro defentity-class (name-string schema-name &body (slots . options))
  "Create a class object. This must be performed in the model package."
  (flet ((derived-method-name (slot-name-string)
	   (intern (format nil "%~A.~A-DERIVED" name-string slot-name-string))))
    (with-gensyms (class-symbol)
      `(let ((,class-symbol ',(shadow-for-model name-string))
	     (*schema-loading* t))
	 (export ,class-symbol)
	 (dbg-message :exp 1 "~% Loading Entity ~A ..." ,name-string)
	 #+LispWorks (setq *current-class-name* ,class-symbol)
	 (unless (find-class ,class-symbol nil)
	   (setf (find-class ,class-symbol)
		 (make-instance 'closer-mop:forward-referenced-class 
				:name ,class-symbol)))
	 (let ((class
		(closer-mop:ensure-class
		 ,class-symbol
		 :metaclass (find-class 'express-entity-type-mo)
		 :direct-superclasses nil
		 :direct-slots 
		 (list ,@(mapcar #'(lambda (slot) 
				     (canonicalize-direct-slot class-symbol name-string slot)) slots)))))
	   (setf (schema (find-class ,class-symbol)) ',schema-name)
	   (setf (uniqueness (find-class ,class-symbol)) ,(second (assoc :unique (car options))))
	   class)))))
	 
  
(defmacro uniqueness-macro (&rest rules)
  "Expands to a list of functions that return keys for argument instance."
  `(list
    ,@(loop for rule in rules
	    for label = (first rule)
	    for accessors = (rest rule)
	    collect 
	    `(function
	      (lambda (instance)
	       (list ,(when label (kintern label))
		     ,@(loop for accessor in accessors
			     collect `(,(first accessor)
				       instance
				       ',(second accessor))
			     )))))))

(defmacro def-express-constant (name value)
  `(make-instance 'express-constant 
                  :name ',name 
                  :value #'(lambda () ,value)))

;;; POD NYI
(defmacro def-subtype-constraint (&body body)
  (declare (ignore body)))

(defmacro deftype-class (name schema-name &body body)
  "Macro to form a defclass for metaclass express-type and set a few slots"
  (let ((test (second (member :where-test body)))
        ;; POD There is apparently something I don't know about lisp packages!
        (THIS-instance (intern "INSTANCE" (lisp-package (schema *expresso*)))))
    (with-gensyms (class-symbol class)
      `(let ((,class-symbol ',(shadow-for-model name))
	     (*schema-loading* t))
	 (export ,class-symbol)
	 (dbg-message :exp 1 "~% Loading Type ~A ..." ,name)
	 (let ((,class
		(closer-mop:ensure-class
		 ,class-symbol
		 :metaclass (find-class 'express-defined-type-mo)
		 :direct-superclasses nil
		 :direct-slots nil)))
	   (setf (type-descriptor ,class) ; PODsampson was find-eu-class
		 #'(lambda ()
		     ,(second (member :type-descriptor body))))
	   (setf (schema ,class) ',schema-name) ; PODsampson was find-eu-class
	   ,(when test
		  `(setf (where-test ,class) ; PODsampson was find-eu-class
			 ;; POD This will have to be fixed for package-name=schema-name
			 #'(lambda (,THIS-instance) ,test)))
	   ,class)))))


(defmacro supertype-expression-macro (class expression)
  `(progn
     (setf (supertype-constraint ,class)
	   #'(lambda () ,expression))
     (setf (supertype-expression ,class)
	   ',expression)))

(defmacro where-rule-unless (name label expression report)
  `(progn
     (set-special where-rule-entity ',name)
     (set-special where-rule-label ',label)
     (unless
         ,expression
       ,report)))
     
  
    

