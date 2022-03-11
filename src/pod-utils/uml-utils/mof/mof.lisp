
;;; Purpose: MOP programming to implement MOF2- / UML Core-style properties and their facets 
;;; (subsetting etc.) This is a refactoring that combines MEXICO and UML/SysML MM work, 
;;; for subsequent use with the QVT implementation. 

;;; Thanks to the use of Pascal Costanza's excellent "Closer To MOP,"
;;; there is NO lisp-implementation-specific code here.

;;; Date: 2007-10-11 

;;; ToDo:
;;;   - Isn't it the case that I want hyphenated keywords for initargs? (2008-01-21)

(in-package :mofi)

(defvar *owner* nil "Tracks ownership. See uml23-postload.lisp.")

;;;=================================
;;; The M3 Object Definitions  
;;; POD I'd still like to learn how to do metaobject subtypes....
;;;=================================
(defclass mm-type-mo (standard-class)
  ;; abstract-p = T if the class is abstract
  ((abstract-p :initarg :abstract-p :accessor abstract-p :initform nil)
   ;; In MIWG application only used in a few cases (|NamedElement|, |Function|).
   ;; In QVT applications, used a lot. See also Model.tracks-instances-p.
   ;; Note that for efficiency, this was changed to a vector.
   (instances :reader instances :initform (make-array 100 :adjustable t :fill-pointer 0))
   ;; Pointer to the mofi:model to which this class belongs.
   (of-model :initarg :of-model :accessor of-model :initform nil)
   ;; Should be mm-package-mo that owns this type mo. 
   (model-package :initarg :model-package :accessor model-package :initform nil)
   ;; This is the SEI equivalent of mexico::model-package; it points to a mm-package-mo instance
   (owner :reader owner :initform nil)
   ;; A list of ocl-operation objects."
   (type-operations :accessor type-operations :initform nil)
   ;; A list of ocl-constraint objects."
   (type-constraints :accessor type-constraints :initform nil)
   ;; Due to limitations of MOP (or my understanding of it), this is unavoidable!
   ;; 2011-04-26 This take the place of class-p enum-p, datatype-p, primitive-type-p, stereotype-p
   (metatype :reader metatype :initform nil :initarg :metatype)
   ;; T if the type was created 'at run time'
   (programmatic-p :reader programmatic-p :initform nil :initarg :programmatic-p)
   ;; A list of classes. 
   (extended-metaclasses :reader extended-metaclasses :initform nil)
   ;; Only useful for enumerations (and I can't use a subclass of mm-type-mo in LW!
   (enum-values :reader enum-values :initarg :enum-values :initform nil)
   ;; non-xmi-hidden slots in class precedence, and then alphabetical order.
   (mapped-slots :reader mapped-slots :initform nil)
   ;; non-reified 'slots' -- a list of ((accessor-name . source)...)
   (soft-opposite-slots :reader soft-opposite-slots :initform nil)
   ;; XMI 2.4.1 Section 7.10.2.2 allows hrefs using xmi:id of the thing.
   ;; 2012-07-30 This is fine for classes (saved in pop-generated files starting with 2.5)
   ;; but also need to track these down in populations (through XML elem?). See mof-types.lisp
   (xmi-id :reader xmi-id :initform nil :initarg :xmi-id)))

(declaim (inline datatype-p enum-p class-p stereotype-p))
(defun datatype-p       (obj) (when (typep obj 'mm-type-mo) (eq :datatype   (metatype obj))))
(defun enum-p           (obj) (when (typep obj 'mm-type-mo) (eq :enum       (metatype obj))))
(defun stereotype-p     (obj) (when (typep obj 'mm-type-mo) (eq :stereotype (metatype obj))))
(defun class-p          (obj) (when (typep obj 'mm-type-mo) 
				(member (metatype obj) '(:class :stereotyped-class))))
;;; See definitions in ocl/ptypes.lisp
(defmethod primitive-type-p ((obj mm-type-mo)) (eq :primitive  (metatype obj))) ; probably not used.
(defmethod primitive-type-p ((obj t)) nil)

;;; POD Added 2013-12-20
#-sbcl
(defmethod %sort-name ((obj mm-type-mo))
  (string (class-name obj)))

(defmethod print-object ((obj mm-type-mo) stream)
  (if-bind (pkg (symbol-package (class-name obj)))
   (format stream "{~A ~A}"  (package-name pkg) (class-name obj))
   (format stream "{??? ~A}" (class-name obj))))

(defmethod json-print ((obj mm-type-mo) &optional stream) 
  "Writes the JSON information for a class"
  (flet ((obj-type (typ) 
	   (cond ((class-p typ) "class")
		 ((enum-p typ) "enum")
		 ((datatype-p typ) "datatype")
		 ((primitive-type-p typ) "primitive type"))))
    (format stream "~A" 
      (with-output-to-string (s)
	(format s "{  name: ~S, type: ~S " (string (class-name obj)) (obj-type obj))
	(format s ",  abstractp: ~S " (if (abstract-p obj) "true" "false"))
	(format s ", slots: [~{~A~^,~}]" 
		(mapcar #'json-print (remove-if-not 
				      #'(lambda (x) (eql obj (slot-definition-source x)))
				      (mapped-slots obj))))
	(format s ", subclasses: [~{{name:~S}~^,~}]" 
		(mapcar #'(lambda (x) (string (class-name x))) 
			(closer-mop:class-direct-subclasses obj)))
	(format s ", superclasses: [~{{name:~S}~^,~}]" 
		(mapcar #'(lambda (x) (string (class-name x))) 
			(closer-mop:class-direct-superclasses obj)))
	(format s ", enumValues: [~{{name:~S}~^,~}]" 
		(mapcar #'(lambda (x) (format nil "~A" x)) 
			(enum-values obj)))      
	(format s ", documentation: ~S}" 
		(cl-ppcre:regex-replace-all 
		 (string #\Newline) 
		 (cl-ppcre:regex-replace-all 
		  "</p>" 
		  (cl-ppcre:regex-replace-all 
		   "<p>" (documentation obj 'type) "") "") ""))))))

;;; A class with a special compute-CPL method. 
(defclass mm-type-mo--select (mm-type-mo) ())

;;; From Kiczales: "Defining a method on validate-superclass requires detailed knowledge
;;; of of (sic) the internal protocol followed by each of the two class metaobject classes.
;;; A method on validate-superclass which returns true for two different class metaobjects classes
;;; declares that they are compatible."
(defmethod validate-superclass ((class mm-type-mo)
                                (superclass standard-class))
  t)

;;; Representation for MOF classes
;;; Like the MEXICO one, but sets 7 more slot options and moves things around 
;;; to pick up :documentation strings.
;;;==================================================================
;;; Class and Datatype definition, 
;;;==================================================================
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro def-mm-class (name model+packages superclasses doc-string slots)
    `(def-mm-etc :class 
	 ,name 
       ,(if (listp model+packages) `,(car model+packages) model+packages)
       ,(if (listp model+packages) `,(cdr model+packages) model+packages)
       ,superclasses ,doc-string ,slots)))

(defmacro def-meta-class (name (&key model packages superclasses xmi-id) 
			  doc-string slots)
  `(def-mm-etc :class ,name ,model ,packages ,superclasses ,doc-string ,slots ,xmi-id))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro def-mm-datatype (name model+packages superclasses doc-string slots)
    `(def-mm-etc :datatype 
      ,name 
      ,(if (listp model+packages) `,(car model+packages) model+packages)
      ,(if (listp model+packages) `,(cdr model+packages) model+packages)
      ,superclasses ,doc-string ,slots)))

(defmacro def-meta-datatype (name (&key model packages superclasses xmi-id) 
			  doc-string slots)
  `(def-mm-etc :datatype ,name ,model ,packages ,superclasses ,doc-string ,slots ,xmi-id))


;;; 2008-03-14 POD I'm still not satisfied with this implementation of stereotypes.
;;; Fixed: The slot stereotype-p doesn't distinguish between extended metaclasses and 'super stereotypes'
;;; SysML:Copy and Verify for example, are subtypes of the Std UML Stereotype Trace.
;;; And SysML:Discrete and Continuous are subtypes of SysML:Rate. 

;;; In this one, the things in the superclass slot are each supertypes individually
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro def-mm-stereotype (name model+packages superclasses extends-metaclasses doc-string slots)
    `(progn 
      (def-mm-etc :stereotype 
	  ,name 
	,(if (listp model+packages) `,(car model+packages) model+packages)
	,(if (listp model+packages) `,(cdr model+packages) model+packages)
	,superclasses ,doc-string ,slots)
      (setf (slot-value (find-class (intern ,(string name) (find-package ,(if (listp model+packages) 
									      `,(car model+packages) 
									      model+packages))))
	     'extended-metaclasses)
       ',extends-metaclasses))))

(defmacro def-meta-stereotype (name (&key model packages superclasses extends xmi-id) doc-string slots)
  `(progn
     (def-mm-etc :stereotype ,name ,model ,packages ,superclasses ,doc-string ,slots ,xmi-id)
     (setf (slot-value (find-class (intern ,(string name) (find-package ,model))) 'extended-metaclasses)
	   ',extends)))

;;; 2015-02-03 See notes from this date in modelegator/pod-notes.txt
(defun shadow-and-warn (str target-pkg &key (export-p t))
  "Intern STR (a string) an in TARGET-PACKAGE. Return that symbol. 
   If there already is a symbol named STR visible in TARGET-PKG, shadow
   it with the new external symbol, and warn that you are shadowing it."
  (let ((sym (intern str target-pkg)))
    (unless (eql (symbol-package sym) (find-package target-pkg))
      (warn "Shadowing package ~A's symbol ~S in package ~A." 
	    (package-name (symbol-package sym)) 
	    sym 
	    (package-name target-pkg))
      (shadow str target-pkg))
    (when export-p (export (intern str target-pkg) target-pkg))
    (find-symbol (string sym) target-pkg)))

;;; 2010-10-06 Now that I've cleaned up what MOFI exports, there shouldn't be
;;; so many shadow-and-warn warnings, but it is still possible that a symbol
;;; slips through as :range, :source, :redefined-property, etc. 
;;; 2015-02-03 See notes from this date in modelegator/pod-notes.txt
(defmacro def-mm-etc (metatype class-name model packages superclasses doc-string slots &optional xmi-id)
  "Compatibility macro called from various forms of def-mm-class."
  (with-gensyms (class-symbol class)
   `(let* ((*model* (find-model ,model))
	   (,class-symbol 
	    (if (string= ,(string class-name) "MM-ROOT-SUPERTYPE")
		'mofi:mm-root-supertype
		(shadow-and-warn ,(string class-name) *package*)))
	   (,class nil))
      (declare (special *model*))
      (unless (find-class (intern ,(string class-name)) nil)
	(setf (find-class (intern ,(string class-name)))
	      (make-instance 'closer-mop:forward-referenced-class 
			     :name (intern ,(string class-name)))))
      (mapcar #'(lambda (x) (shadow-and-warn x *package*)) ',(mapcar #'(lambda (y) (string (car y))) slots))
      (setf ,class
	    (closer-mop:ensure-class
	     (intern ,(string class-name))
	     :metaclass ,(if (typep *model* 'essential-compiled-select-model)
			     '(find-class 'mm-type-mo--select)
			     '(find-class 'mm-type-mo))
	     :direct-superclasses ,(cond ((equal superclasses '(:none)) nil)
					 ((null superclasses) ''(mm-root-supertype))
					 (t (cond ((eql :import (car superclasses)) ; good idea, in theory!
						   `',(cdr superclasses))
						  ((member :moss *features*) ; too many to :import
						   `',superclasses)
						  (t ;`(mapcar #'(lambda (x) (shadow-and-warn (string x) *package*))
							      `',superclasses))));)
	     :direct-slots (list 
			    ,@(mapcar #'(lambda (s) 
					  (canonicalize-direct-slot class-symbol s))
				      slots))
	     :xmi-id ,xmi-id
	     :documentation ,(or doc-string "")))
      (setf (type-operations ,class) nil)
      (setf (type-constraints ,class) nil)
      (setf (slot-value ,class 'metatype) ,metatype)
      (setf (of-model ,class) *model*)
      (setf (model-package ,class) ',packages)
      (with-slots (types) *model* (vector-push-extend ,class types))
      ,class)))

;;; Unlike mm-class-mo, these don't have to be common-lisp meta objects.
(defclass mm-assoc-mo ()
  ((name :initarg :name)
   (xmi-id :initarg :xmi-id :reader xmi-id)
   (of-model :reader of-model :initarg :of-model)
   (metatype :initarg :metatype) ; :association or :extension
   (owned-ends :initarg :owned-ends :reader owned-ends)
   (member-ends :initarg :member-ends)))

(defmethod print-object ((obj mm-assoc-mo) stream)
  (with-slots (xmi-id) obj
    (format stream "{Assoc ~A}" xmi-id)))

(defmacro def-meta-assoc (xmi-id &key name metatype member-ends owned-ends)
  (with-gensyms (obj)
    `(let ((,obj
	    (make-instance 'mm-assoc-mo
			   :name ',name
			   :xmi-id ',xmi-id
			   :of-model *model*
			   :metatype ,metatype
			   :owned-ends ',owned-ends
			   :member-ends ',member-ends)))
       (with-slots (assocs) *model* (vector-push-extend ,obj assocs))
       ,obj)))

;;; Unlike mm-class-mo, these don't have to be common-lisp meta objects.
(defclass mm-assoc-end-mo ()
  ((name :initarg :name)
   (xmi-id :initarg :xmi-id :reader xmi-id)
   (type :initarg :type)
   (multiplicity :initarg :multiplicity)
   (visibility :initarg :visibility)
   (aggregation :initarg :aggregation)
   (association :initarg :association :reader association)))

(defmethod print-object ((obj mm-assoc-end-mo) stream)
  (with-slots (xmi-id) obj
    (format stream "{Assoc-end ~A}" xmi-id)))

(defmacro def-meta-assoc-end (xmi-id &key type multiplicity visibility association aggregation name)
  (with-gensyms (obj)
    `(let ((,obj
	    (make-instance 'mm-assoc-end-mo
			   :name ,name
			   :xmi-id ,xmi-id
			   :type ',type
			   :multiplicity ',multiplicity
			   :visibility  ,visibility
			   :aggregation ,aggregation
			   :association ,association)))
       (with-slots (assoc-ends) *model* (vector-push-extend ,obj assoc-ends))
       ,obj)))

(defclass mm-package-mo ()
  ;; Name is an interned symbol. The package in which it is interned
  ;; is the same as that in which the owned-elements are interned.
  ((name :initarg :name :reader name)
   (of-model :initarg :of-model :initform nil :reader of-model)
   (owner :initarg :owner :initform nil)
   (owned-element :initarg :owned-element :initform nil :reader owned-element)
   (xmi-id :initarg :xmi-id :initform nil)))


(defmethod print-object ((obj mm-package-mo) stream)
  (with-slots (name) obj
      (format stream "{Package ~A}" name)))

(defmacro def-meta-package (name owner of-model owned-element &key xmi-id)
  `(with-slots (packages) *model*
     (push 
      (make-instance 'mm-package-mo
		     :name ',name
		     :of-model (find-model ,of-model)
		     :owner ',owner
		     :owned-element ',owned-element
		     :xmi-id ',xmi-id)
      packages)))

;;; Same thing as above
(defmacro def-mm-package (name owner of-model owned-element)
  `(def-meta-package ,name ,owner ,of-model ,owned-element))



#| Something like Kickzales p286. Typical usage is:
  (canonicalize-direct-slot
    'mof::|Element|
    '(|importingNamespace| :range |Boolean| :multiplicity (1  1) 
     :subsetted-properties ((|Element| |owner|) (|DirectedRelationship| |source|)) 
     :documentation  "whatever")) |#
(defun canonicalize-direct-slot (class spec)
  "CLASS is the class symbol, spec is like above, produced by def-mm-class."
  (let ((name (car spec))
	(pairs (cdr spec))
	initform initfunction initargs range default other-options)
    (loop while pairs for key = (pop pairs) for val = (pop pairs) do
	  (case key
	    (:initform
	     (setf initfunction `(function (lambda () ,val)))
	     (setf initform `',val))
	    (:default ; 2011-10-13
	     (setf default val)
	     (setf initfunction `(function (lambda () ,val))))
	    ;(setf initform `',val))
	    (:range
	     (setf range val)
	     (setf initform  (if (eql '|Boolean| val) :false nil)))
	    (:initarg (push-last val initargs))
	    (otherwise 
	     (push-last key other-options) 
	     (push-last `',val other-options))))
    `(list 
      :name ',name
      :source ,class
      ,@(if initargs `(:initargs ',initargs) `(:initargs '(,(kintern (c-name2lisp (string name))))))
      ,@(if initfunction
	    `(:initform ,initform :initfunction ,initfunction)
	    `(:initform nil :initfunction (function (lambda () nil))))
      ,@(if range `(:range ',range) '(:range t))
      ,@(when default `(:default ',default))
      ,@other-options)))

;;;==================================================================
;;; Enumeration definition
;;;==================================================================
(defmacro def-mm-enum (name model-packages superclasses vals &optional doc-string)
  `(progn
    (intern ,(string name) ,(lisp-package *model*))
    (defclass ,name 
	,(append superclasses '(mm-root-supertype)) () 
      (:documentation ,(or doc-string ""))
      (:metaclass mm-type-mo))
    (setf (slot-value (find-class ',name) 'enum-values) (mapcar #'kintern ',vals))
;    (setf (slot-value (find-class ',name) 'enum-p) t)
    (setf (slot-value (find-class ',name) 'metatype) :enum)
    (setf (model-package (find-class ',name)) ',model-packages)
;     ,(if (listp model-package) `',(cdr model-package) model-package)) ; infra
    (setf (of-model (find-class ',name)) *model*)
    (vector-push-extend (find-class ',name) (types *model*))
    (export ',name)))

(defmacro def-meta-enum (name (&key model superclasses xmi-id) vals &optional doc-string)
  (with-gensyms (class)
    `(progn
       (intern ,(string name) ,(lisp-package *model*))
       (let ((,class
	      (closer-mop:ensure-class ',name 
				       :direct-superclasses ',(append superclasses '(mm-root-supertype))
				       :documentation ,(or doc-string "")
				       :metaclass 'mm-type-mo
				       :xmi-id ,xmi-id)))
	 (setf (slot-value ,class 'enum-values) (mapcar #'kintern ',vals))
	 (setf (slot-value ,class 'metatype) :enum)
	 (setf (model-package ,class) ',model) ; POD odd. 
	 (setf (of-model ,class) *model*)
	 (vector-push-extend ,class (types *model*))
	 (export ',name)
	 ,class))))


;;;==================================================================
;;; Primitive definition
;;;==================================================================
(defmacro def-mm-primitive (name model-package superclasses &optional doc-string)
  `(progn
    (intern ,(string name) ,(lisp-package *model*))
    (defclass ,name 
	,(append superclasses '(mm-root-supertype)) () 
      (:documentation ,(or doc-string ""))
      (:metaclass mm-type-mo))
    (setf (slot-value (find-class ',name) 'metatype) :primitive)
    (setf (model-package (find-class ',name)) 
     ,(if (listp model-package) `',(cdr model-package) model-package))
    (setf (of-model (find-class ',name)) *model*)
    (vector-push-extend (find-class ',name) (types *model*))
    (export ',name)))

(defmacro def-meta-primitive (name (&key model superclasses xmi-id) &optional doc-string)
  `(progn
     (intern ,(string name) ,(lisp-package *model*))
     (defclass ,name 
	 ,(append superclasses '(mm-root-supertype)) () 
       (:documentation ,(or doc-string ""))
       (:metaclass mm-type-mo)
       (:xmi-id ,xmi-id))
     (setf (slot-value (find-class ',name) 'metatype) :primitive)
     (setf (model-package (find-class ',name)) ,model)
     (setf (of-model (find-class ',name)) *model*)
     (vector-push-extend (find-class ',name) (types *model*))
     (export ',name)))



;;;==================================================================
;;; Constraint/Operation definition
;;;==================================================================
(defclass abstract-ocl-op ()
  ;; A string (no .1)? naming the operator.
  ((operation-name :initarg :operation-name :reader operation-name)
   ;; a symbol naming the class?
   (operation-class :initarg :operation-class :reader operation-class)
   ;; OCL text of the operation
   (operation-body :reader operation-body :initarg :operation-body)
   ;; ocl2lisp translation of operation-body, performed at load-model.
   (operation-lisp :accessor operation-lisp :initarg :operation-lisp :initform nil)
   ;; -- Stuff for tracking
   (operation-comment :initarg :operation-comment)
   ;; One of :original, :draft :rewritten
   (operation-status :initarg :operation-status :reader operation-status :initform :original)
   ;; Original string, whe operation-status not :original
   (original-body :initarg :original-body :reader original-body :initform nil)
   (editor-note :initarg :editor-note :reader editor-note)
   (constraint-gf :initarg :constraint-gf :reader constraint-gf :initform 'ocl:ocl-constraints)))

(defclass ocl-constraint (abstract-ocl-op)
  ())

(defmethod print-object ((obj ocl-constraint) stream)
  (with-slots (operation-class operation-name) obj
     (format stream "#<constraint ~A.~A>" 
	     (class-name operation-class) operation-name)))

;;; deprecated
(defmacro def-mm-constraint (name class-name comment 
			     &key operation-body (operation-status :original) 
			     original-body editor-note)
    `(def-meta-constraint ,name ,class-name ,comment
			:operation-body ,operation-body
			:operation-status ,operation-status
			:original-body ,original-body
			:editor-note ,editor-note))


(defmacro def-meta-constraint (name class-name comment 
			     &key operation-body (operation-status :original) 
			     original-body editor-note (constraint-gf 'ocl:ocl-constraints))
  "Create the ocl-constraint object for the given specification. 
   Completion (translation to lisp) is performed in load-model."
  (with-gensyms (obj class)
    `(let* ((,class (find-class ',class-name))
	    (,obj (make-instance 'ocl-constraint :operation-name ,(string name) ; POD 2017, string
				 :operation-comment ,comment 
				 :operation-class ,class
				 :operation-status ,operation-status
				 :operation-body ,operation-body
				 :original-body ,original-body
				 :editor-note ,editor-note
				 :constraint-gf ',constraint-gf)))
      (setf (slot-value ,obj 'operation-class) ,class)
      (setf (type-constraints ,class) 
       (remove ,(string name) (type-constraints ,class) :test #'string= :key #'operation-name)) ; POD 2017, string
      (push ,obj (type-constraints ,class)))))

(defclass ocl-operation (abstract-ocl-op)
  ((operation-parameters :initarg :operation-parameters :initform nil)))

(defmethod print-object ((obj ocl-operation) stream)
  (with-slots (operation-class operation-name) obj
     (format stream "#<operation ~A.~A>" 
	     (class-name operation-class) operation-name)))

(defmethod initialize-instance :after ((op ocl-operation) &key)
  (with-slots (operation-name) op
   (let ((name operation-name)) ; don't change the cname
     (setf name (cl-ppcre:regex-replace "\\.[0-9]+$" name ""))
     (pushnew name (operator-strings *model*)))))

;;; Deprecated
(defmacro def-mm-operation (name class-name comment 
			    &key operation-body parameters (operation-status :original) 
			    original-body editor-note)
  `(def-meta-operation ,name ,class-name ,comment
		       :operation-body ,operation-body
		       :parameters ,parameters
		       :operation-status ,operation-status
		       :original-body ,original-body
		       :editor-note ,editor-note))


(defmacro def-meta-operation (name class-name comment 
			    &key operation-body parameters (operation-status :original) 
			    original-body editor-note (constraint-gf 'ocl:ocl-constraints))
  (with-gensyms (obj class)
    `(if-bind (,class (find-class (intern ,(string class-name) (lisp-package *model*))))
      (let ((,obj (make-instance 
		   'ocl-operation 
		   :operation-name ,(string name) ; POD 2017, string
		   :operation-class ,class
		   :operation-comment ,comment 
		   :operation-status ,operation-status
		   :operation-body ,operation-body 
		   :original-body ,original-body
		   :operation-parameters ,parameters
		   :editor-note ,editor-note
		   :constraint-gf ',constraint-gf)))
	(setf (slot-value ,obj 'operation-class) ,class)
	(setf (type-operations ,class) 
	      (remove ,(string name) (type-operations ,class) :test #'string= :key #'operation-name)) ; POD 2017, string
	(push ,obj (type-operations ,class)))
      (error ,(format nil "Cannot find class ~A" class-name)))))

(defclass ocl-parameter ()
  ((parameter-name :initarg :parameter-name :initform nil :reader parameter-name)
   (parameter-type :initarg :parameter-type :reader parameter-type)
   (parameter-return-p :initarg :parameter-return-p :reader parameter-return-p)))

;;;===============================
;;; Slot implementation -- See UML:Property, that's what this implements.
;;;===============================
(defclass mm-direct-slot-definition (closer-mop:standard-direct-slot-definition)
  ((range :initarg :range :initform nil :reader slot-definition-range)
   (multiplicity :initarg :multiplicity :initform nil :reader slot-definition-multiplicity)
   (source :initarg :source :initform nil :reader slot-definition-source)
   (is-derived-union-p :initarg :is-derived-union-p :initform nil :reader slot-definition-is-derived-union-p)
   (is-readonly-p :initarg :is-readonly-p :initform nil :reader slot-definition-is-readonly-p)
   (is-composite-p :initarg :is-composite-p :initform nil :reader slot-definition-is-composite-p)
   (is-ordered-p :initarg :is-ordered-p :initform nil :reader slot-definition-is-ordered-p)
   (is-derived-p :initarg :is-derived-p :initform nil :reader slot-definition-is-derived-p)
   (subsetted-properties :initarg :subsetted-properties :initform nil :reader slot-definition-subsetted-properties)
   (redefined-property :initarg :redefined-property :initform nil :reader slot-definition-redefined-property)
   (specializes :initarg :specializes :initform nil :reader slot-definition-specializes) ;called "general" in the MM
   (default :initarg :default :initform nil :reader slot-definition-default)
   (opposite :initarg :opposite :initform nil :reader slot-definition-opposite)
   (s-opposite :initarg :soft-opposite :initform nil :reader slot-definition-soft-opposite)
   (xmi-id :initarg :xmi-id :initform nil :reader slot-definition-xmi-id)
   (xmi-hidden :initarg :xmi-hidden :initform nil :reader slot-definition-xmi-hidden)))

(defmethod print-object ((obj mm-direct-slot-definition) stream)
  (let ((source (slot-definition-source obj)))
    (format stream "{dir-slot ~A.~A}"
	    (if (symbolp source) source (class-name source))
	    (slot-definition-name obj))))

;;; The tie-in to the MOP slot definition is to define this method,
;;; which returns the specialization of standard-direct-slot-definition.   
(defmethod closer-mop:direct-slot-definition-class ((class mm-type-mo) &rest initargs)
  (declare (ignore initargs))
  (find-class 'mm-direct-slot-definition))


(defmethod mm-accessor-fn-name ((slot mm-direct-slot-definition))
  "Returns the reader function (symbol) for an argument SLOT-NAME."
  (car (closer-mop:slot-definition-readers slot)))

(defun compile-time-mm-accessor-fn-name (slot)
  "Returns the reader function name for an argument SLOT-NAME, 
   a symbol available in the package where the reader will be found.
   Used while the class is being compiled."
  (let* ((slot-name (closer-mop:slot-definition-name slot))
	 (str (strcat "%" (string-upcase (c-name2lisp (string slot-name))))))
    ;;(intern str (symbol-package slot-name) 2009-03-22 The slot-name's package??? Why?
    (intern str (lisp-package *model*))))

(defun mm-make-gf-reader (slot)
  "Returns a generic function for a %reader function."
  (ensure-generic-function
   (compile-time-mm-accessor-fn-name slot)
   :lambda-list '(instance)
   :generic-function-class 'standard-generic-function))

;;; pod7 should probably check for derived?
(defun mm-make-gf-writer (slot)
  "Returns a generic function for a %reader function."
  (ensure-generic-function
   `(setf ,(compile-time-mm-accessor-fn-name slot))
   :lambda-list '(new-value object)
   :generic-function-class 'standard-generic-function))

(defvar *inside-derivation-p* nil "Dynamically bound T when executing a derivation.")

(defun mm-make-reader-fn (class-name slot gf) 
  "Returns a %reader method, which might just be a call to slot-value 
   or might be a funcall to a method to derive the value"
  (let ((slot-name (closer-mop:slot-definition-name slot)))
    (closer-mop:make-method-lambda 
     gf
     (closer-mop:class-prototype (find-class 'standard-method))
     `(lambda (instance) ; need reader-failed (and not next-constraint) because 
       (catch 'reader-failed ; access occurs during xmi post-processing too. (AND THROW NIL)
	 ,(cond ((and (slot-definition-is-derived-p slot) 
		      (member slot (derived-slots-no-fn *model*))
		      (slot-definition-default slot))
		 (warn "Ugh! Derived slot, no derivation but has default!: ~A.~A" class-name slot-name)
		 `(slot-value instance ',slot-name))
		((and (slot-definition-is-derived-p slot)
		      (member slot (derived-slots-no-fn *model*)))
		 (warn "Derived slot, no derivation: ~A.~A" class-name slot-name)
		 `(progn (warn- 'ocl-attempts-executing-absent-derived
			  :object instance :class-name ',class-name  :attribute-name ',slot-name)
		   (throw 'reader-failed nil)))
		((and (slot-definition-is-derived-p slot)
		      (not (slot-definition-is-derived-union-p slot)))
		 (let ((fname (intern (format nil "~A.1" (string-upcase (c-name2lisp (string slot-name))))
				      (lisp-package *model*))))
		 `(handler-bind ;; Derived slot. This to catch bad derivations...
		   ((error #'(lambda (c) 
			       (warn- 'ocl-error-calculating-derived
				     :object instance :class-name ',class-name
				     :reader-name ',fname :lisp-error c)
			       (throw 'reader-failed nil))))
		     (let ((*inside-derivation-p* t))
		       (declare (global *inside-derivation-p*))
		       (let ((val (funcall ',fname instance)))
			 (if (typep val 'ocl::|Collection|)
			     (make-instance (class-name (class-of val))
					    :typ-d (ocl::typ-d val) 
					    :value (copy-list (ocl::value val)))
			     val))))))
		;; Normal usage (not derived)...
		(t `(slot-value instance ',slot-name)))))
     nil)))

;;; POD This could do more, like setting the :opposite slot.
(defun mm-make-writer-fn (slot gf) 
  "Returns a %write method, which is (currently) just a call to (setf slot-value)."
  (let ((slot-name (closer-mop:slot-definition-name slot)))
    (closer-mop:make-method-lambda 
     gf
     (closer-mop:class-prototype (find-class 'standard-method))
     `(lambda (new-value instance)
       ,(if (slot-definition-is-derived-p slot)
	    `(error 'setting-derived-attribute :attribute ',slot-name :object instance)
	    `(setf (slot-value instance ',slot-name) new-value)))
     nil)))

;;; POD This previously inherited from bad-operand
(define-condition setting-derived-attribute ()
  ((attribute :initarg :attribute)
   (object    :initarg :object))
  (:report
   (lambda (err stream)
     (with-slots (attribute object) err
       (format stream "Trying to set the value of the derived attribute ~A of ~A"
	       attribute object)))))

(defclass mm-effective-slot-definition (closer-mop:standard-effective-slot-definition) 
  ((range  :accessor slot-definition-range :initform nil)
   (multiplicity  :accessor slot-definition-multiplicity :initform nil)
   ;; Source is the slot is defined, a symbol while reading the model, resolved afterward.
   (source :initarg :source :initform nil :reader slot-definition-source)
   ;; effective slot is a pointer back to the containing class. 
   ;; POD Is this a mistake? :initarg :source in the following?
   (effective-source :initarg :source :initform nil :reader slot-definition-effective-source)
   (is-derived-union-p :initarg :is-derived-union-p :initform nil :reader slot-definition-is-derived-union-p)
   (derived-union-sources :initform nil :accessor slot-definition-derived-union-sources)
   (is-readonly-p :initarg :is-readonly-p :initform nil :reader slot-definition-is-readonly-p)
   (is-composite-p :initarg :is-composite-p :initform nil :reader slot-definition-is-composite-p)
   (is-ordered-p :initarg :is-ordered-p :initform nil :reader slot-definition-is-ordered-p)
   (is-derived-p :initarg :is-derived-p :initform nil :accessor slot-definition-is-derived-p)
   (subsetted-properties :initarg :subsetted-properties :initform nil :accessor slot-definition-subsetted-properties)
   (redefined-property :initarg :redefined-property :initform nil :reader slot-definition-redefined-property)
   (specializes :initarg :specializes :initform nil :reader slot-definition-specializes)
   (default :initarg :default :initform nil :reader slot-definition-default)
   (opposite :initarg :opposite :initform nil :reader slot-definition-opposite)
   (s-opposite :initarg :soft-opposite :initform nil :reader slot-definition-soft-opposite)
   (xmi-hidden :initarg :xmi-hidden :initform t :reader mofi:slot-definition-xmi-hidden)))

(defmethod print-object ((obj mm-effective-slot-definition) stream)
  (format stream "{eff-slot ~A.~A}"
	  (class-name (slot-definition-effective-source obj))
	  (slot-definition-name obj)))

;;; POD Why is it called mm-ACCESSOR-fn-name when it returns the reader?
(defmethod mm-accessor-fn-name ((slot mm-effective-slot-definition))
  "Returns the reader function (symbol) for an argument SLOT-NAME."
    (when-bind (dslot (slot-direct-slot slot))
      (car (closer-mop:slot-definition-readers dslot))))
	  
(defmethod slot-direct-slot ((slot mm-direct-slot-definition))
  slot)

(defmethod slot-direct-slot ((slot mm-effective-slot-definition))
  (find (closer-mop:slot-definition-name slot)
	(closer-mop:class-direct-slots (slot-definition-source slot))
	:key #'closer-mop:slot-definition-name))
  
(defmethod closer-mop:effective-slot-definition-class ((class mm-type-mo) &rest initargs)
  (declare (ignore initargs))
  (find-class 'mm-effective-slot-definition))

(defmethod json-print ((slot mm-effective-slot-definition) &optional stream)
  "Creates the JSON information for a given slot from a slot-definition"
  (flet ((range-name (range) (if (eql range t) "T" (string (class-name range))))
	 (is-model-item (id model) 
	   "Returns a boolean (as a string) for whether or not a class is or is not in the model"
	   (loop for n across (types model) 
	      when (string= (string (class-name n)) id) return "true"
	      finally (return "false"))))
    (with-slots (multiplicity range source) slot
      (format
       stream
       "{sname: ~S, documentation: ~S, multiplicityLower: ~S, multiplicityUpper: ~S, range: ~S, rangelink: ~S}"
       (string (closer-mop::slot-definition-name slot))
       (aif (documentation slot 'type) (cl-ppcre:regex-replace-all (string #\Newline) (string it) "") "")
       (write-to-string (car multiplicity))
       (write-to-string (second multiplicity))
       (string (range-name range))
      (is-model-item (range-name range) (of-model source))))))

(declaim (inline m1-find-slot-named))
(defun m1-find-slot-named (class name)
  "Return the slot-definition object of CLASS that has name NAME, a string designator."
  (and class 
       (find name
	     (mapped-slots class) 
	     :key #'closer-mop:slot-definition-name
	     :test #'string=)))

;;; POD 2009-07-27 Updated so "supersets" variable appends slot-definition-subsetted-properties
;;;                from the slot from which a redefinition was based. 
;;; Called for by both (load-model (compiled-model)) and make-programmatic-class (stereotypes).
(defun update-subsetted-properties-from-redefinition (class) ; 2009-07-27
  (loop for slot in (mapped-slots class) do
       (when-bind (redef (slot-definition-redefined-property slot))
	 (if-bind (found (m1-find-slot-named (find-class (first redef)) (second redef)))
		  (setf (slot-definition-subsetted-properties slot)
			(remove-duplicates 
			 (append (slot-definition-subsetted-properties slot)
				 (slot-definition-subsetted-properties found))
			 :test #'equal))
		  (error "Cannot find redef: ~A" redef)))))

;;; Called for by both (load-model (compiled-model)) and make-programmatic-class (stereotypes).
(defmethod compute-derived-union-sources ((class mm-type-mo))
  "For each slot of CLASS, when it subsets something, push the slot name into 
   the sources of that derived-union."
  (let ((uml-slots (mapped-slots class)))
    (loop for slot in uml-slots
       for supersets = (slot-definition-subsetted-properties slot) do
	 (loop for class/slot in supersets
	    for super-slot = (find (second class/slot) uml-slots :key #'closer-mop:slot-definition-name) do
	    (when (null super-slot) ; Before 2013-11-22 I was breaking here. 
	      (warn "Cannot find ~S in mapped slots of ~A" (second class/slot) class))
	    (copy-du-sources-downward class class/slot super-slot (closer-mop:slot-definition-name slot))))))

(defun copy-du-sources-downward (class class/slot super-slot source-property-name)
  "Push PROPERY, a symbol naming a slot into the derived-union-sources of SUPER-SLOT, 
   and call itself with PROPERTY for each slot that SUPER-SLOT is a subset. 
   CLASS/SLOT (one element of a slots subsetted-properties, is a list of (class-name slot-name)."
  (if (null super-slot)
      (format *error-output* "~%Warning: While copying to a derived union, property ~A.~A is not found."
	      (car class/slot) (second class/slot))
      (when (slot-definition-is-derived-union-p super-slot)
	(pushnew source-property-name (slot-definition-derived-union-sources super-slot))
	(loop for class/slot in (slot-definition-subsetted-properties super-slot)
	      for super-slot = (find (second class/slot) (mapped-slots class) :key #'closer-mop:slot-definition-name)
	      do (copy-du-sources-downward class class/slot super-slot source-property-name)))))

(defun safe-class-precedence-list (class)
  "Finalize the class if necessary, and return its class-precedence-list."
  (if (closer-mop:class-finalized-p class)
      (closer-mop:class-precedence-list class))
  (closer-mop:compute-class-precedence-list class))

;;; 2011-02-16 Encountering problems with multiple stereotypes, I tried this on mm-type-mo
;;; 2011-02-18 It appeared to be messed up. See sysml-notes.txt
;;; Based on Kizales, AMOP, pg 81. 
(defmethod closer-mop:compute-class-precedence-list ((class mm-type-mo--select))
  "This is for select-types, or thing like them." ;<-- I have no idea what is intended.
  (let ((root (find-class 'mm-root-supertype)))
    (append
     (remove root (remove-duplicates (depth-first-preorder-superclasses* class) :from-end t))
     (list root (find-class 'standard-object) (find-class t)))))

(defun depth-first-preorder-superclasses* (class)
  (if (eq class (find-class 'standard-object))
      ()
      (cons class (mapappend #'depth-first-preorder-superclasses*
			     (closer-mop:class-direct-superclasses class)))))

;;; POD 2011-11-25 slot-remover is new. The comments at "object semantics" 
;;; "same-named slots are redefines" suggests today that this isn't quite right. 
;;; 2012-03-14 Nonetheless, it does the right thing for, 
;;; say, Classifier.general / Class.superClass.
;;; See notes at 2012-10-10 where I confirm this as correct. (But have problems with LW not forgetting...)
(defmethod closer-mop:compute-slots ((class mm-type-mo))
  "Returns all effective slots of CLASS. Removes inherited slots that have been redefined."
  (flet ((slot-remover (slots)
	   "If a slot's name and source match the name and source of any redef, don't collect the slot."
          (loop for s in slots
	      for source = (let ((so (slot-definition-source s)))
			     (if (classp so) (class-name so) so))
	      for name = (slot-definition-name s)
	      unless (find-if #'(lambda (x) 
				  (when-bind (redefs (slot-definition-redefined-property x))
				    (when-bind (pos (position source redefs))
				      (and (eql (elt redefs (1+ pos)) name)
					   (not (eql (slot-definition-name x) name)))))) ; NOT means it is renamed.
			      slots)
	     collect s)))
    (closer-mop:compute-class-precedence-list class) ; Always first thing in compute-slots. Sets it too.
    (let* ((all-slots (slot-remover
		       (mapappend #'closer-mop:class-direct-slots
				  (safe-class-precedence-list class))))
	   (all-names (remove-duplicates (mapcar #'closer-mop:slot-definition-name all-slots))))
      (loop for name in all-names    ;; object semantics: same-named slots are redefines
	 for slots = (remove-if  ;; effective slot have :range of most specific.
		      #'(lambda (s) (not (eql name (closer-mop:slot-definition-name s))))
		      all-slots)
	 collect (closer-mop:compute-effective-slot-definition class name slots)))))


(defmethod closer-mop:compute-effective-slot-definition ((class mm-type-mo) name direct-slots)
  "For same-named slots, set the :range, :multiplicity and :source values to those in
   the 'most specific' source. Slot-definition-source are symbols, until class-finalize-slots."
  (let* ((most (most-specific-type (mapcar #'slot-definition-source direct-slots)))
	 (eslot (call-next-method))
	 (dslot (find most direct-slots :test 
		#'(lambda (m x) 
		    (let ((source (slot-definition-source x)))
		      (if (symbolp source)
			  (eql source m)
			(eql (class-name source) m)))))))
    ;; POD Augfggf!
    (setf (closer-mop:slot-definition-initargs eslot) 
	  (if (eql name 'enum-symbol) '(:enum-symbol) (list (kintern (c-name2lisp (string name))))))
    (with-slots ((d-range range) (d-multiplicity multiplicity) (d-source source)
		 (d-du-p is-derived-union-p) (d-ro-p is-readonly-p)
		 (d-comp-p is-composite-p) (d-ord-p is-ordered-p) (d-spec specializes)
		 (d-der-p is-derived-p) (d-sub subsetted-properties) (d-def default)
		 (d-redef redefined-property) (d-opp opposite) (d-s-opp s-opposite) 
		 (d-xmi-h xmi-hidden)) dslot
       (with-slots ((e-range range) (e-multiplicity multiplicity) (e-source source) 
		    (e-du-p is-derived-union-p) (e-ro-p is-readonly-p)
		    (e-comp-p is-composite-p) (e-ord-p is-ordered-p) (e-spec specializes)
		    (e-der-p is-derived-p) (e-sub subsetted-properties) (e-def default)
		    (e-redef redefined-property) (e-opp opposite) (e-s-opp s-opposite) 
		    (e-xmi-h xmi-hidden)) eslot
	 (setf e-range d-range e-multiplicity d-multiplicity e-source d-source 
	       e-du-p d-du-p e-ro-p d-ro-p e-comp-p d-comp-p e-ord-p d-ord-p e-spec d-spec
	       e-der-p d-der-p e-sub d-sub e-redef d-redef e-def d-def e-opp d-opp e-s-opp d-s-opp 
	       e-xmi-h d-xmi-h)))
    (with-slots (effective-source) eslot
      (setf effective-source class))
    eslot))

;;; Restriction: all argument classes must be defined (but possibly not yet finalized). 
;;; Also, of course, could be more than one 'most specific', if args include 
;;; leaves of two 'equal' branches. (Won't happen in compute-effective-slot usage).
(defun most-specific-type (classes-or-names &key (error-p t) (root 'mm-root-supertype))
  "Return the class name of the most specific of the arguments, which must have a
   common ancestor more-specific than ROOT."
  (let ((classes 
	 (mapcar #'(lambda (c?) 
		     (if (symbolp c?) (find-class c?) c?))
		 classes-or-names)))
    (mapc #'(lambda (c) (unless (closer-mop:class-finalized-p c)
			  (closer-mop:compute-class-precedence-list c)))
	    classes)
    (when (single-p classes) (return-from most-specific-type (class-name (car classes))))
    (let ((plists (mapcar #'(lambda (c)  (member (find-class root)
						 (reverse (safe-class-precedence-list c))))
			  classes))
	  (commons nil))
      (when (and (null (setf commons (reduce #'intersection plists))) error-p)
	(error "POD: The classes (~{~a~^, ~}) do not have a common ancestor." 
	       (mapcar #'class-name classes)))
      (let ((most-common (find-if
			  #'(lambda (x) ;  doesn't have any of the others as a supertype.
			      (null (intersection (closer-mop:class-direct-superclasses x) commons)))
			  commons)))
      ;; Count hops back, not lengths of lists, since multiple inheritance.
	(loop for c in classes
	      for path-back = (depth-first-search c #'(lambda (x) (eql x most-common))
						  #'closer-mop:class-direct-superclasses :tracking t)
	      with len = 0 with longest = nil
	      when (> (length path-back) len) do (setf longest c len (length path-back))
	      finally (return (class-name longest)))))))

;;;=========================================================
;;; Stereotype Implementation
;;;=========================================================
(defun make-programmatic-class (base-class stereo-classes new-class-name &key (metatype :class))
  "Return an mm-class-mo having a name 'class <<stereotype>>' for some CLASS/STEREO cdr-coded list.
   where the first is a symbol naming a class and the second is a symbol naming a stereotype.
   Also sets the cons-name property of the new class name to the dotted list (class . sterotype).
   NOTE that CLASS may already have stereotypes applied, thus this has to be careful to reorganize
   the name of the class to alphabetical."
  (let ((new-class (make-instance 'mm-type-mo
				  :name new-class-name
				  :metatype metatype
				  :programmatic-p t
				  :direct-superclasses (append stereo-classes (list base-class))
				  :direct-slots nil)))
    (setf (find-class new-class-name) new-class)
    (setf (of-model new-class) (of-model (car stereo-classes)))
    (class-finalize-slots new-class :suppress-export t)
    (update-subsetted-properties-from-redefinition new-class) ; 2009-07-27
    (compute-derived-union-sources new-class)
;    (substitute-ocl-range new-class)
    new-class))

(defun find-programmatic-class (existing-class mixin-class &key (metatype :class))
  "Apply MIXIN-CLASS (uh, a stereotype) to EXISTING-CLASS, which may already have
   stereotypes applied."
  (let* ((base-class (find-if-not #'(lambda (x) 
				      (typep (of-model x) 'abstract-profile))
				  (closer-mop:class-precedence-list existing-class)))
	 (all-mixins (cons mixin-class
			   (remove-if-not #'(lambda (x) ; Collect other mixin-classes in existing-class
					      (and (typep x 'mm-type-mo) 
						   (extended-metaclasses x)))
					  (closer-mop:class-precedence-list existing-class))))
	 (clean-mixins ; Don't include supertypes of things here
	  (remove-if #'(lambda (x)
			 (loop for m in all-mixins
			    when (find x (cdr (closer-mop:class-precedence-list m)))
			    return t 
			    finally (return nil)))
		     all-mixins))
	 (stereo-classes (sort clean-mixins #'string< :key #'(lambda (x) (string (class-name x)))))
	 (new-class-name
	  (intern (format nil "~A ~{<<~A>>~^ ~}"  
			  (class-name base-class)
			  (mapcar #'(lambda (x) (string (class-name x))) stereo-classes))
		  ;; See note from 2010-09-18. What I'd like is (of-model (car stereo-classes))
		  ;; But then I won't get unique classes for each UML version. The test cases
		  ;; use various UMLs
		  ;2011-09-23 (lisp-package (of-model base-class))
		  (lisp-package (of-model (car stereo-classes))))))
    (or 
     (find-class new-class-name nil)
     (make-programmatic-class base-class stereo-classes new-class-name :metatype metatype))))

(defun stereotyped-obj-p (obj)
  "Return the stereotypes applied to obj."
  (remove-if-not
   #'stereotype-p
   (closer-mop:class-precedence-list (class-of obj))))

;;; POD I regret switching away from 'cons names' for stereotypes!
;;; MOFI> (stereotype-base-names (find-class '|SysML|:|Rate|))
;;; ("base_ActivityEdge <<Rate>>" "base_Parameter <<Rate>>") So DONT MAKE programmatics!
;;; 2011-02-08 As bad as this might seem, I think it is better than using classes, which 
;;; would be tied to packages. 
(defmemo stereotype-base-names (stereotype-class)
   "See comments on stereotype-base-metaclasses." 
   (mapcar #'(lambda (b) (format nil "base_~A" (class-name b)))
	   (extended-metaclasses stereotype-class)))


;;;=================================================
;;; Finalization stuff (POD some 'model-specific')
;;;=================================================
(defmethod finalize ((class t)) t)

(defmethod finalize ((class closer-mop:forward-referenced-class))
  (finalize (find-class (class-name class))))

(defmethod finalize ((class mm-type-mo))
  "Do closer-mop:finalize-inheritance from most-general to least."
  (closer-mop:finalize-inheritance class))

(defmethod make-accessors ((slot mm-direct-slot-definition) class)
  "Create reader and writer methods for the slot. They either call slot-value or, 
   if :is-derived-p t, one that calls the OCL to derive the value. 
   Return accessor name."
  (let ((class-name (class-name class))
	(fn-name (compile-time-mm-accessor-fn-name slot)))
    (setf (closer-mop:slot-definition-readers slot) (list fn-name))
    (setf (closer-mop:slot-definition-writers slot) (list `(setf ,fn-name)))
    (let* ((gfr (mm-make-gf-reader slot))
	   (reader-fn (coerce (mm-make-reader-fn class-name slot gfr) 'function))
	   (gfw (mm-make-gf-writer slot))
	   (writer-fn (coerce (mm-make-writer-fn slot gfw) 'function)))
      (flet ((add-reader-meth (specializers fn)
	      (add-method 
	       gfr (make-instance 'standard-method :lambda-list '(object) :qualifiers ()
				 :specializers specializers :function fn)))
	     (add-writer-meth (specializers fn)
	       (add-method
		gfw
		(make-instance 'standard-method 
			       :lambda-list '(new-value object) :qualifiers ()
			       :specializers specializers  :function fn))))
	(add-reader-meth (list class) reader-fn)
	(add-writer-meth (list (find-class t) class) writer-fn)))
;;; Only want to do this when there is no reader defined by other means. 
;;; Thus only do it after readers are defined for all objects in schema.
;;; THE ESSENCE OF THE PROBLEM IS THAT THESE THINGS CAN BE NAMED ANYTHING, 
;;; AND THEY WILL INTERFERE WITH READERS DEFINED ON THE PROPERTY! 
;;; See notes from 2012-03-14. 
;    (with-slots (s-opposite) slot
;      (when s-opposite (make-soft-opposite-reader s-opposite)))
    fn-name))

;;; See comments above. This is called at load-model, after all other work
;;; is done. It stops about 15% of readers from being created. 
;;; 2013-12-07 I think "It" in the previous sentence is the check for normal-reader-p.
(defun make-soft-opposite-readers (class)
  "Where appropriate, make readers for soft opposites of direct slots of CLASS." 
  (flet ((normal-reader-p (spec)
	   (dbind (class-name slot-name) spec
	     (let* ((pkg (lisp-package *model*))
		    (reader-name (intern (strcat "%" (string-upcase (c-name2lisp (string slot-name)))) pkg))
		    (gf (ensure-generic-function
			 reader-name
			 :lambda-list '(instance)
			 :generic-function-class 'standard-generic-function)))
	       (find (list (find-class class-name)) 
		     (generic-function-methods gf) 
		     :key #'method-specializers :test #'equal)))))
    (loop for s in (class-direct-slots class) do
	 (with-slots (s-opposite) s
	   (when (and s-opposite (not (normal-reader-p s-opposite)))
	     (make-soft-opposite-reader s-opposite))))))

(defun make-soft-opposite-reader (spec)
  "Make a soft opposite reader for SPEC which is a list (class-name property-name)."
  (dbind (class-name slot-name) spec
    (let* ((pkg (lisp-package *model*))
	   (reader-name (intern (strcat "%" (string-upcase (c-name2lisp (string slot-name)))) pkg))
	   (gf (ensure-generic-function
		reader-name
		:lambda-list '(instance)
		:generic-function-class 'standard-generic-function))
	   (reader-fn (coerce 
		       (closer-mop:make-method-lambda 
			gf
			(closer-mop:class-prototype (find-class 'standard-method))
			`(lambda (instance) 
			     (gethash (cons ',reader-name instance)
				      (soft-opposites (%of-model instance))))
			nil)
		       'function)))
      (export reader-name pkg)
      (add-method 
       gf (make-instance 'standard-method :lambda-list '(object) :qualifiers ()
			 :specializers (list (find-class class-name)) :function reader-fn)))))
    

;;; Note, for stereotyped classes, the class name looks like '|ConnectorEnd <<NestedConnectorEnd>>|
(defmemo! slot-typ (:key #'unique :test #'eq) (class/slot) 
  "Returns the -typ object if the list CLASS/SLOT of form (class-name slot-name) 
   names a slot whose value is a Collection, nil otherwise"
  (dbind (class-name slot-name) class/slot
    (let ((slot (find slot-name (mapped-slots (find-class class-name))
		      :key #'closer-mop:slot-definition-name)))
      (unless (slot-definition-xmi-hidden slot) 
	(let ((mult (slot-definition-multiplicity slot)))
	  (unless (= 1 (cadr mult))
	    (make-instance 'ocl::collection-typ
			   :l-bound (car mult) :u-bound (cadr mult)
			   :ordered-p (slot-definition-is-ordered-p slot)
			   :unique-p t ; POD not in L3! (Is that a modeling choice? Could be.)
			   :base-type (slot-definition-range slot))))))))

;;; POD load ordering makes it difficult to make this a method 
;;; specialized on mm-root-supertype. 
;;; 2009-12-16: suppress-slots is for uml21/uml22 problem work-around, originating
;;;             with make-programmatic-class (only usage). 
(defmethod class-finalize-slots ((class mm-type-mo) &key suppress-export)
  "Finalize inheritance, make accessors, export them, resolve slot-range and -source
   to the class objects the symbol represents, set slot mapped-slots in class object."
  (closer-mop:finalize-inheritance class)
  (let ((*package* (lisp-package *model*))
	(class-name (class-name class)))
    #-sbcl(declare (special *package*))
    (flet ((resolve-source/range (slot)
	     (unless (slot-definition-xmi-hidden slot)
	       (let ((source-name (slot-definition-source slot))
		     (source-class nil))
		 (when (symbolp source-name) ;pod7 simplify?
		   (setf source-class (find-class source-name nil))
		   (if (or (typep source-class 'mm-type-mo)
			   ;; pod7 I just did (setf (find-class)) on the ocl types.
			   ;; I'd like to do the following typep, but during MOF load-model
			   ;; OCL types are not yet defined. Should I defer the load-model
			   ;; of MOF until after OCL is loaded? BTW, any hope of moving ocl-mm
			   ;; and mof-mm into essential load??? That might be the cleanest approach.
			   (typep source-class 'ptypes:|Ptype-type-proxy|))
		       (setf (slot-value slot 'source) source-class)
		       (warn "Unknown type while setting slot source: ~A.~A ~S" 
			     class-name (closer-mop:slot-definition-name slot) source-name))))
	       (let ((range-name (slot-definition-range slot))
		     (range-class nil))
		 (when (symbolp range-name)
		   (setf range-class (find-class range-name nil))
		   (if (or (typep range-class 'mm-type-mo)
			   (typep range-class 'ptypes:|Ptype-type-proxy|)
			   (typep range-class 'ocl:|Ocl-type-proxy|)
			   #+cre(typep range-class 'expo:express-entity-type-mo)
			   #+cre(typep range-class 'tlog:xsd-standard-class))
		       (setf (slot-value slot 'range) range-class)
			 (warn "Unknown type while setting slot range: ~A.~A ~S" 
			       class-name (closer-mop:slot-definition-name slot) range-name)))))))
      (unless suppress-export (export class-name (symbol-package class-name))) ; ODM added last arg to export
      ;; Make accessor, export it and export slot name. 
      (loop for slot in (closer-mop:class-direct-slots class) 
	    for slot-name = (closer-mop:slot-definition-name slot)
	    for accessor = (make-accessors slot class) do
	    (unless suppress-export (export slot-name (symbol-package slot-name))) ; ODM added last arg to export
	    (when (eql *package* (symbol-package accessor)) 
	      (unless suppress-export (export accessor)))
	    (resolve-source/range slot))
      ;; resolve on effective-slots too.
      (loop for slot in (closer-mop:class-slots class)
	    do (resolve-source/range slot))
      (record-mapped-slots-cpl-order class)
      (record-soft-opposites class)
      class)))


(defvar *mofi-make-instance-p* nil "See mofi-make-instance.")

(defun mofi-make-instance (&rest args)
  "Used where slot-definition-default needs to make an object.
   See :after method of initialize-instance LiteralSpecification in uml23-postload.lisp."
  (let ((*mofi-make-instance-p* t))
    (declare (special *mofi-make-instance-p*))
    (let ((result (apply #'make-instance args)))
      (setf (%source-elem result) :mofi-make-instance)
      result)))

;;; 2011-10-10 : This was found to be useful for users using a property name that was renamed in redefinition.
;;; The intention is that it is only called in use of the LW inspector. 
(defmethod slot-missing ((class mm-type-mo) obj slot-name operation &optional new-value)
  (declare (ignore new-value operation))
;  (format *debug-io* "Undefined property of ~A: ~A. ~%Perhaps it has been redefined???~2%" 
;	(string (class-name class))
;	(string slot-name))
  )


