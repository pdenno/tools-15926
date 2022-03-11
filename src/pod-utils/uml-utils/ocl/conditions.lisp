
(in-package :ocl)

(define-condition ocl-error (error) ())

(define-condition ocl-type-error (ocl-error)
  ((value :initarg :value)
   (type :initarg :type))
  (:report 
     (lambda (c stream)
       (with-slots (value type) c
	 (format stream "~S is not of type ~A." value type)))))

(define-condition ocl-type-not-compatible (ocl-error)
  ((value :initarg :value)
   (type :initarg :type))
  (:report 
     (lambda (c stream)
       (with-slots (value type) c
	 (format stream "~S is not compatible with type ~A." value type)))))

(define-condition ocl-set-values-not-unique (ocl-error)
  ((set :initarg :set))
  (:report 
   (lambda (c stream)
     (with-slots (set) c
       (format stream "During construction of the Set ~A, the elements provided are not unique." set)))))

(define-condition ocl-index-out-of-range (ocl-error)
  ((index :initarg :index)
   (ordered-value :initarg :ordered-val))
  (:report 
   (lambda (c stream)
     (with-slots (index ordered-value) c
       (format stream "The index ~A is out of range of the ordered collection with value ~A"
	       index ordered-value)))))

(define-condition ocl-invalid-operation-for-value (ocl-error)
  ((operation :initarg :operation)
   (value :initarg :value))
  (:report 
   (lambda (c stream)
     (with-slots (operation value) c
       (format stream "The operation ~A cannot be applied to values ~A."
	       operation value)))))

(define-condition ocl-spec-unclear (ocl-error)
  ((text :initarg :text))
  (:report 
   (lambda (c stream)
     (with-slots (text) c (format stream "~A" text)))))

;;;===========================================================
;;; Parse errors
;;;===========================================================
(define-condition ocl-parse-error (ocl-error)
  ((tag :initarg :tag :initform nil)
   (expected :initarg :expected)
   (actual :initarg :actual))
  (:report 
   (lambda (err stream)
     (with-slots (tag expected actual) err
       (format stream "Line ~A: In ~A : expected ~A, got '~A'"
	       *line-number*
	       (or tag (car *tags-trace*))
	       (if (stringp expected) expected (format nil "'~A'" expected))
	       actual)
       (format stream "<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>" *tags-trace*)))))

(defun tkn-key2string (keyword)
  "Translate :less-great into the string '<>' etc."
  (ecase keyword
    (:less-equal "<=")
    (:less-great "<>")
    (:great-equal ">=")
    (:colon-colon "::")
    (:carot-carot "^^")
    (:dot-dot "..")
    (:point-right "->")
    (:eof :eof)))

(define-condition ocl-parse-token-error (ocl-error)
  ((tag :initarg :tag)
   (expected :initarg :expected)
   (actual :initarg :actual))
  (:report (lambda (err stream)
	     (with-slots (tag expected actual) err
	       (format stream "~A : expected ~A  got '~A'"
			  tag 
			  (if (stringp expected) expected (format nil "'~A'" expected))
			  (if (keywordp actual) (tkn-key2string actual) actual))
	       (format stream "<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>" *tags-trace*)))))

(define-condition ocl-parse-incomplete (ocl-error)
  ((actual :initarg :actual))
  (:report 
    (lambda (err stream)
      (with-slots (actual) err
	(format stream "Parse ended with input remaining. Current token: ~A" 
		(if (keywordp actual) (tkn-key2string actual) actual))
	(format stream "<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>" *tags-trace*)))))

(define-condition ocl-token-balance-error (ocl-error)
  ((token :initarg :token)
   (line :initarg :line))
  (:report (lambda (err stream)
	     (with-slots (token line) err
		  (format stream "Unbalanced '~A' before line ~A." token line)
		  (format stream "<br/>Parse Stack:<ul>~{~%<li>~A</li>~}</ul>" *tags-trace*)))))

;;;===========================================
;;; Stuff that gets used in constraints.lisp
;;;===========================================
(defvar +ocl-constraints-gf+ 
  (ensure-generic-function 'ocl:ocl-constraints
			   :lambda-list '(self)
			   :generic-function-class 
			   #-sbcl 'closer-mop:standard-generic-function
			   #+sbcl 'closer-mop::standard-generic-function))

(defvar +ocl-constraints-cmof-gf+ 
  (ensure-generic-function 'ocl:ocl-constraints-cmof
			   :lambda-list '(self)
			   :generic-function-class 
			   #-sbcl 'closer-mop:standard-generic-function
			   #+sbcl 'closer-mop::standard-generic-function))


;;; Q: Would it be possible to put the error handling in an around method???
;;; A: No, because you want to continue through the constraints. (There is a loop...)
(defmethod ocl-constraints ((self t))
  "This is called for 'typical' constraints found in metamodels. 
   All the work is done in :after methods. "
  t)

(defmethod ocl-constraints-cmof ((self t))
  "This is called for the constraints peculiar to CMOF.
   All the work is done in :after methods"
  t)


(defgeneric compile-constraints (class &key gf-name))
#+nil
(defun tryme ()
  (let ((oclp::*in-scope-models* (list (mofi:find-model :uml22)
				       (mofi:find-model :ocl)))
	(*model* (mofi:find-model :uml22)))
    (oclp:ocl2lisp "self.inherit(self.parents()->collect(p | p.inheritableMembers(self)))")))
;   (compile-constraints (find-class 'uml:|NamedElement|))))

;;; This gets called by by load-model, not by evaluating the def-mm-constraint
;;; Handler-case doesn't need to throw and it always handles the error.
;;; POD NOTE!!! To test this function in isolation, wrap it in 
;;; (let ((*in-scope-models* (list (find-model :uml) (find-model :ocl)))) ...)
(defmethod compile-constraints ((class mofi:mm-type-mo) &key (gf-name 'ocl-constraints))
  "Compile all OCL constraints of class CLASS with (eq x.constraint-gf gf-name). 
    (1) Add a method to the generic function named by gf-name for CLASS.
    (2) Set op.lisp to the lisp produced by the concatenation (with special variable 
        binding for tracking) of the  ocl2lisp for each constraint."
  (flet ((compile-one-constraint (ocl-text constraint-name)
	   (handler-case 
	       (let ((oclp::*in-scope-models* ; 2012-02-24 added this binding of oclp::*in-scope-models*
		      (list (mofi:of-model class) (mofi:find-model :ptypes) (mofi:find-model :ocl)))
		     (mofi:*model* (mofi:of-model class)))
		 (declare (special oclp::*in-scope-models* mofi:*model*))
		 (oclp:ocl2lisp ocl-text))
	     (error () 
	       (warn "OCL parse error on constraint ~A.~A: ~% '~A'"
		     (class-name class) constraint-name ocl-text)
	       '(true/parse-error)))))
    (when-bind (constraints (loop for c in (mofi:type-constraints class) 
			       when (eql (mofi:constraint-gf c) gf-name) collect c))
	 (let* ((combined (loop for op in constraints
			     for name = (mofi::operation-name op)
			     for body = (compile-one-constraint (mofi::operation-body op) name)
			     do (setf (mofi::operation-lisp op) body)
			     collect `(push-last #'(lambda (self) 
						     (declare (ignorable self)) 
					;(format t "~%~A" ,(format nil "Running constraint ~A" name))
						     ,body)
						 constraint-fns)))
		(body
		 `(let ((constraint-fns nil)
			(constraints (remove-if-not #'(lambda (x) (eql ',gf-name (mofi:constraint-gf x)))
						    (mofi:type-constraints (find-class ',(class-name class))))))
		    ,@combined ; push the anonymous functions onto constraint-fns
		    (catch 'next-constraint
		      (loop while constraint-fns do
			   (when-bind (constraint-fn (pop constraint-fns))
			     (when-bind (constraint (pop constraints))
			       (handler-bind 
				   ((ocl::ocl-type-error
				     #'(lambda (c) 
					 (declare (ignore c))
					 (mofi:warn- 'mofi:ocl-type-error-report ; POD temporary was mofi:warn-
						     :object self
						     :constraint constraint)
					 (throw 'next-constraint nil)))
				    (error #'(lambda (c) 
					       (mofi:warn- 'mofi:ocl-execution-error ; POD temporary was mofi:warn-
							   :object self
							   :constraint constraint
							   :lisp-error c)
					       (throw 'next-constraint nil))))
				 (when (eql (funcall constraint-fn self) :false)
				   (warn 'mofi:ocl-violation 
					 :object self 
					 :constraint constraint))))))))))
					;	(pprint body)  ; <========= This is really useful for debugging!!!
	   (ocl:ocl-add-after-method gf-name body class)))))

(defun ocl-add-after-method (gf-name body class)
  "add-method a method for ocl:ocl-constraints containing BODY and specializing class.
   BODY should contain stuff for stepping through the various constraints."
  (let* ((gf (if (eql gf-name 'ocl:ocl-constraints) +ocl-constraints-gf+ +ocl-constraints-cmof-gf+))
	 (lamb (closer-mop:make-method-lambda 
		gf
		(closer-mop:class-prototype (find-class 'standard-method))
		`(lambda (self) (declare (ignorable self)) ,body)
		nil)))
    (add-method 
     gf
     (make-instance 'standard-method 
		    :lambda-list '(self) 
		    :qualifiers '(:after)
		    :specializers (list class) 
		    :function (compile nil lamb) #|(coerce lamb 'function)|#))))

#+nil
(defun show-compile (op)
  (with-debugging (:data 5)
    (with-debugging (:parser 5)
      (let ((oclp::*in-scope-models* 
	     (list (mofi:find-model :uml22) (mofi:find-model :ocl)))
	    (*model* (mofi:find-model :uml22)))
	(compile-one-operation op)))))

(defun true/parse-error ()
  "A function that just returns :true, it's presence indicates that 
   the code that should be in its place didn't compile from OCL."
;   (warn "~A:~A did not compile. Returning :true anyway."
;	 class-name (car constraint-names))
  :true)

#+nil
(defun doit ()
  (let ((oclp::*in-scope-models* (list (mofi:find-model :uml22) (mofi:find-model :ocl))))
    (compile-operations (find-class 'uml22:|NamedElement|))))

#+nil
(defun doit ()
  (let ((oclp::*in-scope-models* (list (mofi:find-model :uml22) (mofi:find-model :ocl)))
	(*package* (find-package :uml22)))
    (oclp:ocl2lisp (clean-body "result = if self.name->notEmpty() and 
                                 self.allNamespaces()->select(ns | ns.name->isEmpty())->isEmpty()
                              then 
                                  self.allNamespaces()->iterate( ns : Namespace; 
                                  result : String = self.name | ns.name.concat(self.separator()).concat(result))
                              else
                                 self.name
                              endif") :class-context (find-class 'uml22:|NamedElement|))))

(defgeneric compile-operations (class &key gf-name))

;;; This gets called by by load-model, not by evaluating the def-mm-constraint
;;; POD NOTE!!! To test this function in isolation, wrap it in 
;;; (let ((oclp::*in-scope-models* (list (mofi:find-model :uml22) (mofi:find-model :ocl)))) ...)
(defmethod compile-operations ((class-obj mofi:mm-type-mo) &key (gf-name 'ocl-constraints))
  (loop for op in (remove-if-not #'(lambda (x) (eql gf-name (mofi:constraint-gf x)))
				 (mofi:type-operations class-obj)) do
	(compile-one-operation op)))

;;; This gets called by by load-model, not by evaluating the def-mm-constraint
;;; POD NOTE!!! To test this function in isolation, wrap the call in 
;;; (let ((oclp::*in-scope-models* (list (mofi:find-model :uml241) (mofi:find-model :ocl)))) ...)
(defun compile-one-operation (op)
  "Compile an OCL operation of class CLASS-OBJ
    (1) Add a method named by the operation. 
    (2) Set op.lisp to the lisp produced by ocl2lisp."
  (flet ((compile-it (ocl-text class op-name)
	   (handler-case 
	       (let ((oclp::*in-scope-models* ; 2012-02-24 added this binding of oclp::*in-scope-models*
		      (list (mofi:of-model class) (mofi:find-model :ptypes) (mofi:find-model :ocl)))
		     (mofi:*model* (mofi:of-model class)))
		 (declare (special oclp::*in-scope-models* mofi:*model*))
		   (oclp:ocl2lisp ocl-text :class-context class))
	     (error () 
	       (warn "OCL parse error on operation ~A.~A: ~% '~A'"
		     (class-name class) op-name ocl-text)
	       '(true/parse-error)))))
    (with-slots ((name mofi:operation-name)
		 (body mofi:operation-body)
		 (class mofi:operation-class) ; NOTE may be different than class-obj!
		 (params mofi:operation-parameters)) op
      ;; 2012-02-24 Some of these operations will have ".1" names. That's good! They are for derived!
      ;;            Code that makes the reader function will reference it. 
      (let* ((vars (remove-if #'mofi:parameter-return-p params))
	     ;; We only do the def with parameters, (other than self) and doing so
	     ;; only provides additional (progn (ocl-assert...) (ocl-assert...) ...).
	     (full-body (strcat (if vars (add-def name vars) "") (clean-body body)))
	     ;; If you don't wrap it in progn, lisp that is just a string will 
	     ;; be placed as though it where a defun documentation line (in LW at least). 
	     (lisp `(progn ,(compile-it full-body class name)))
	     (var-names 
	      (cons 'self
		    (mapcar #'(lambda (v) 
				(intern (format nil "?~A" 
						(mofi:parameter-name v))
					(mofi:lisp-package mofi:*model*)))
			    vars)))
	     (pkg (mofi:lisp-package (mofi:of-model class)))
	     (gf (ensure-generic-function 
		  (mofi:shadow-and-warn (string-upcase (c-name2lisp name)) pkg :export-p nil)
		  :lambda-list var-names
		  :generic-function-class 
		  #-sbcl 'closer-mop:standard-generic-function
		  #+sbcl 'closer-mop::standard-generic-function))
	     (lamb (closer-mop:make-method-lambda 
		    gf
		    (closer-mop:class-prototype (find-class 'standard-method))
		    `(lambda ,var-names (declare (ignorable self)) ,lisp)
		    nil))
	     (meth (make-instance 
		    'standard-method 
		    :lambda-list var-names
		    :qualifiers nil
		    :specializers (cons class (mapcar #'(lambda (x) (declare (ignore x)) (find-class t))
						      vars))
		    :function (compile nil lamb) #|(coerce lamb 'function)|#   )))
	(when-debugging (:data 5) 
	  (format t "~2%(defun ~A ~A" 			  
		  (intern (string-upcase (c-name2lisp name))
			  (mofi:lisp-package (mofi:of-model class)))
		  var-names)
	  (pprint lisp)
	  (format t ")"))
	(setf (mofi:operation-lisp op) lisp)
	(add-method gf meth)))))


(defun clean-body (txt)
  "Remove the initial 'result =' and &#x encoding from the body of the OCL code, if it's there."
  (flet ((cbody (txt) 
	   (mvb (success regs) (cl-ppcre:scan-to-strings "^\\s*(result\\s*=)?\\s*(.*)" txt)
	     (if success (aref regs 1) " "))))
    (with-input-from-string (s txt)
      (loop for line = (read-line s nil :eof) with found with text = ""
	    until (eql line :eof) do
	    (setf line (cl-ppcre:regex-replace-all "&#x\\w{1,2};" line " "))
	    if (and (not found) (cl-ppcre:scan "^\\s*result\\s*=" line))
	    do (setf text (strcat text (cbody line) (string #\Newline))) (setf found t)
	    else do (setf text (strcat text line (string #\Newline)))
	    finally (return text)))))

(defun add-def (cname vars)
  "The MM XMI doesn't contain the def: language elements. This function
   creates that string to attach to the front of the stuff to be parsed.
   This will cause ocl-assert to be generated for each argument."
  (format nil "def: ~A (~{~A : ~A~^, ~}) "
	  cname
	  (loop for v in vars 
		collect (mofi::parameter-name v) 
		collect (mofi::parameter-type v))))

#|
(defmethod mofi:load-model ((m mofi:compiled-model))
  "Do all the classes related stuff."
  (let ((*package* (lisp-package m)))
    (with-slots (mofi::classes-path) m
      (when mofi::classes-path 
	(load (compile-file mofi::classes-path)) ; little reason to compile it -- no code.
	;; Do this before class-finalize-slots. Needed to make accessors.
	(mofi::set-derived-slot-no-fn m)
	;; Sets Model.types Finalize classes.
	(with-slots (mofi::types mofi::abstract-classes) m
	  (loop for class being the hash-value of mofi::types
		do (mofi::class-finalize-slots class))
	  (loop for class being the hash-value of mofi::types
		do (mofi::compute-derived-union-sources class))
	  ;; pod7 can't this go away? Replace with abstract-p on the class?
	  (loop for cname in mofi::abstract-classes
		do (setf (abstract-p (find-class cname)) t)))
    (unless (or (eql m mofi::+mof+)                    ;; ocl:compile-constraints not yet defined
		(eql m (mofi::find-model :ocl))) ;; (and no constraints anyway).
      (let ((oclp:*in-scope-models* (list (mofi::find-model :ocl) m)))
	(loop for class being the hash-value of (mofi::types m) 
	      do (ocl:compile-operations class)
	      do (ocl:compile-constraints class))))
    m))))
|#
