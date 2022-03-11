
;;; Purpose: Perform type-checking, OCL validation, and checking for 
;;;          cycles of uml:owned-member, where applicable.
;;; Date : 2006-09-22
(in-package :mofi)

#+sei
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *valpkg* :uml23 "UML package for the following 3 macros") 
  (defmacro usym (string) `(intern ,string *valpkg*))
  (defmacro ufuncall (string &rest args) `(funcall (symbol-function ',(usym (string-upcase string))) ,@args))
  (defmacro ufun (string) `(symbol-function ',(usym string)))
)

(setf *zippy* '())
(defun warn- (type &rest args)
  "'Abbreviated warn' don't create the object."
  ;;(declare (ignore ignore))
  (push (list type args) *zippy*)
  (with-vo (mut)
    (let ((count-ht (count-conditions (processing-results mut))))
      (if-bind (count (gethash type count-ht))
	       (setf (gethash type count-ht) (1+ count))
	       (setf (gethash type count-ht) 1)))))

(defgeneric validate (m &key collections-p run-cmof-p))
	       
(defmethod validate ((model population) &key (collections-p t) run-cmof-p)
  "Toplevel function for validation."
  (dbg-message :time 1 "~%Start validate: ~A" (now))
  #+sei(when (eql (find-model *valpkg*) (model-n+1 model))
	 (validate-no-ownership-cycles model)) ; sets diffing-possible
  (dbg-message :time 1 "~%v-no-ownership-cycles: ~A" (now))
  (validate-not-abstract model)
  (dbg-message :time 1 "~%v-not-abstract: ~A" (now))
  (with-vo (phttp:diffing-possible)
    (when phttp:diffing-possible
      (validate-slotwise model :collections-p collections-p :run-cmof-p run-cmof-p)))
  (dbg-message :time 1 "~%v-slotwise: ~A" (now)))

(defun validate-not-abstract (model)
  "Check whether any of the instances created are abstract."
  (loop for obj across (members model) 
       when (abstract-p (class-of obj))
       do (warn 'mof-creates-abstract-class :elem (%source-elem obj) 
		:class (class-of obj) :object obj))) ; class used as key.

;;; New for 2013-12-29
(declaim (inline temp-obj-p))
(defun temp-obj-p (obj)
  "Return T if OBJ isn't part of user population."
  (and (typep obj 'mm-root-supertype) 
       (minusp (mofi:%debug-id obj))))

(defmemo base-slots (class)
   "Return the 'base_' slots (from stereotypes) of class CLASS."
   (mapcar #'slot-direct-slot
	   (remove-if-not #'(lambda (x) (string= "base_" x))
			  (class-slots class)
			  :key #'(lambda (x) 
				   (let ((name (string (slot-definition-name x))))
				     (subseq name 0 (min (length name) 5)))))))


;;; POD This really isn't quite sufficient; it may miss some situations where
;;; there really should be a value, but...
(declaim (inline stereotype-multi-base-p))
(defun stereotype-multi-base-p (obj slot)
  "Returns T if SLOT is a 'base_' slot and at lease one 'base_' slot of OBJ has a value."
  (let ((bslots (base-slots (class-of obj))))
    (and (member (slot-direct-slot slot) bslots)
	 (some #'(lambda (s) (funcall (car (slot-definition-readers s)) obj)) bslots))))


(defun validate-slotwise (model &key (collections-p t) run-cmof-p)
  "Check for missing mandatory value, incorrect multiplicity, wrong type specified for attribute
   and OCL constraint violations"
  (macrolet ((warn! (type object source slot &optional range value value-type)
	      `(warn ',type :object ,object :class ,source :slot ,slot
		     ,@(when range (list :slot-range range))
		     ,@(when value (list :value value))
		     ,@(when value-type (list :value-type value-type)))))
  (flet ((value-symbol (v)
	   (typecase v
	     ((or symbol string) (intern (string v) (lisp-package *model*)))
	     (mm-root-supertype  (intern (string (class-name (class-of v))) 
					 (lisp-package *model*))))))
    (let ((*model* model))
      (declare (special *model*))
      (with-slots (members) model
	(dbg-message :time 1 "~%Start specific validation tests: ~A" (now))
	(loop for obj across members ; 2012-10-03 don't test pure stereotypes.
	      for class = (class-of obj)
	      unless (or (typep obj 'mm-type-mo) (stereotype-p class) (temp-obj-p obj)) do 
	      (loop for slot in (mapped-slots class)
		    for source = (slot-definition-source slot) ; pod7 or effective-source?
		    for range = (slot-definition-range slot)
		    for val = (funcall (mm-accessor-fn-name slot) obj)
		    do (dbind (lower upper) (slot-definition-multiplicity slot)
			 (cond ((not (typep source 'mm-type-mo))
				(warn 'mof-class-not-found :object obj :class-name source))
			       ((null val) ; 2013-12-07 See notes; Nicolas reported opposite of composite...
				(unless (or (zerop lower) ; ...should not be fixed here.
					    (stereotype-multi-base-p obj slot)) ; 2013-12-30
				    (warn! mof-missing-mandatory obj source (slot-direct-slot slot))))
			       ((or (typep val 'ocl:|Collection|)
				    (and (not collections-p) (listp val)))
				(let* ((ocl-value (if collections-p (ocl:value val) val))
				       (len (length ocl-value)))
				  (unless (or 
					   (not (numberp lower))
					   (<= lower len upper) (and (<= lower len) (= upper -1)))
				    (warn! mof-violates-multiplicity obj source (slot-direct-slot slot)))
				  (when val ; If mandatory, will be pickup up above
				    (loop for v in ocl-value 
					  unless (or (null v) (mm-typep v range)) ; POD HUH?
					  do 
					    (warn! mof-violates-type obj source (slot-direct-slot slot)
						    range v (value-symbol v))))))
			       (t (when val ; If mandatory, will be pickup up above
				    (unless (mm-typep val range) 
				      (warn! mof-violates-type obj source (slot-direct-slot slot)
					     range val (value-symbol val)))))))))
	(dbg-message :time 1 "~%Start OCL validation tests: ~A" (now))
	(loop for obj across members ; 2012-10-03 don't test pure stereotypes.
	      unless (or (typep obj 'mm-type-mo) (stereotype-p (class-of obj))) do 
	      (let ((t1 0))
		(when-debugging (:time 5) (setf t1 (get-universal-time)))
		(ocl:ocl-constraints obj)
		(when run-cmof-p (ocl:ocl-constraints-cmof obj))
		(dbg-message :time 5 "~% ~A obj = ~A" (- (get-universal-time) t1) obj)))
	(dbg-message :time 1 "~%End validation: ~A" (now)))))))

;;; Make sure *debug-population* is set. Usually better than this is to simply run the lisp
;;; found in the constraint body against the instance. 
#+nil
(defun tryme ()
  (let ((tbnl:*session* (slot-value *spare-session-vo* 'project-http::tbnl-session))
	(*results* (make-instance 'processing-results))
	(*model* (find-model (modern-uml)))
	(instance (mm-find-instance :id 51)))
    (declare (special (tbnl:*session* *results* *model*)))
    (ocl:ocl-constraints instance)))

;;; Remember that this used to check for uml types, and "alternate-uml".
(defun mm-typep (val type)
  "Like cl:typep but adds a few types."
  (cond ((eql type (find-class 'ptypes:|UnlimitedNatural|))
	 (or (eql val '*) (integerp val)))  ; POD why '* and :* below !?!?!
	((eql type (find-class 'ptypes:|Boolean|))
	 (or (eql val :true) (eql val :false)))
	((eql type (find-class 'ptypes:|String|))
	 (stringp val))
	((eql type (find-class 'ptypes:|Integer|))  
	 (integerp val))
	;; 2014-03-26 added this one
	((eql type (find-class 'ptypes:|Real|))  
	 (numberp val))
	((enum-p type) (member val (enum-values type)))
	;; POD It's referencing a UML MM object (test data is probably a meta-model).
	((typep val 'mofi::mm-type-mo) t) ; I'm just letting it happen....
	((typep val 'ptypes:|Ptype-type-proxy|) t) ; ...similar
	((typep val type) t)
	((eql type (find-class (intern "Element" (lisp-package *model*)) nil)) T))) ; "UML's type T"

#+nil
(defun find-an-ocl-error (&optional (index 0))
  (aref (remove-if-not #'(lambda (x) (typep x 'ocl-execution-error)) 
		       (conditions (processing-results (mut *spare-session-vo*))))
	index))


;;; This is what uml::Element:no_own_self() should do, but instead that constraint
;;; causes a stack overflow while following the loop!
#+sei
(defun validate-no-ownership-cycles (model)
  "Check for cycles of uml::Element.ownedElement."
  (let (cycles)
    (loop for obj across (members model) 
       for result = nil 
       unless (or (typep obj (usym "Package"))
		  (stereotype-p (class-of obj))) do
	 (setf result 
	       (depth-first-search 
		obj
		#'(lambda (x) (declare (ignore x)) (gather-duplicates (tree-search-path)))
		#'(lambda (x) (ocl:value (ufuncall "%owned-element" x)))
		:tracking t))
       ;; can be redundant identification of the error.
	 (unless (eql result :fail)
	   (unless (find result cycles :test #'intersection)
	     (push result cycles))))
    (when cycles 
      (with-vo (phttp:diffing-possible) (setf phttp:diffing-possible nil))
      (loop for err in cycles  do (warn 'uml-ownership-cycle :cycle err)))))
	 
