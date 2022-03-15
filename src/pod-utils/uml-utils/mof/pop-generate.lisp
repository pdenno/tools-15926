
(in-package :mofi)

(defgeneric class-assocs (class))

;;; Purpose: directly generate MM enum, class, associations, association ends, operation, and constraint forms 
;;; from a population of M3 objects (from CMOF or UML), typically from a OMG specification or a user's profile.

;;; How to use: (out of date)
;;;             (1) Upload a file. It works on (mut *spare-session-vo*)
;;;                    e.g.: (simple-run-validator  (lpath :data "uml25/UML-20131001.xmi"))
;;;             (2) Set *cmpkg* to name the metamodel under which the uploaded file is an instance. 
;;;             (3) Depending on the goal, you might have to run just-those-owned-by, with suitable arguments.
;;;             (4) (pop-gen tpkg) - where TPKG is the target package.
;;;             (5) Result: (lpath :models "tryme.lisp")

;;; NOTES 
;;;  2010-10-17: As of this date, I got a relative clean read of the UML2.4 infrastructure library
;;;              using  infralib/10-08-15-cleanup.xmi. Which is UML. This I wrote to cmof.lisp
;;;              At the time, I called the UML I was using "PCMOF." Today I am going to rename
;;;              everything in this package that references PCMOF:: to UML23::. What that 
;;;              code represents (second half of this file) is the capability to read UML and 
;;;              generate a mofi:model. 
;;;              Now I want to be able to read CMOF and generate a mofi model. That's the what
;;;              the top half of this file does. 
;;; 2010-later: Not sure whether I'm using the CMOF infralib/10-08-07 or the UML infralib/10-08-15.
;;;             Probably the former, but either way, the 2010-10-17 note may not be relevant.

;;; ToDo: - If it is extending "UML23:Diagram" don't print it. 
;;;       - 2013-12-13: Implement uuid all over the place.
;;;       - 2013-12-13: Implement assoc-ends
;;; 2012-01-10 : Continue sending keep-pkg-info through pop2lisp methods (not just class). 

;;; 2013-11-22 It looks like :keep-pkg-info T is what I used only for ODM. It puts things like
;;; (in-package "ODM-RDFBase") in the output before every def-meta-whatever.

;#-sei.exe (setf *cmpkg* :uml241) ; For MD BPMN Profile
;#-sei.exe(setf *cmpkg* :uml23)  ; UML 23 For Steve Cook files prior to 2012-06-1, then UML22!, UML23 for UPDM 2.0
;(setf *cmpkg* :uml241)

;;; NOTE: You only need to set *cmpkg* when debugging. It gets compiled for :cmof :uml23 and :uml241 by load.lisp.
;;; ======>   DO NOT LEAVE *cmpkg* SET WHEN DOING A CLEAN COMPILE! <========
;;; IN FACT, IT IS BETTER TO NEVER UNCOMMENT THESE. (IN CASE YOU FORGET) JUST RUN THE COMPILATION IN load.lisp
;;; Also, note that anything that uses a cm macro needs to be a method specialized by version (version = :uml23 etc.)

;;; (simple-run-validator  "/home/pdenno/win-pdenno/podenno@gmail.com/modelica-metamodel.mdxml")
;;; (pop-gen :uml241 "mmm" :keep-pkg-info nil :outfile "/local/tmp/tryme.lisp")

;;; (simple-run-validator  (pod:lpath :data "odm/13-11-01/ODM-metamodel-20131101.xmi"))
;;; (pop-gen :uml241 "ODM" :keep-pkg-info t :outfile "/local/tmp/tryme.lisp")

;;; (simple-run-validator  (pod:lpath :data "odm/13-11-01/RDFProfile.xmi"))
;;; (pop-gen :uml241 :rdf-profile :keep-pkg-info nil :outfile "/local/tmp/tryme.lisp")

;;;(simple-run-validator  (pod:lpath :data "odm/13-11-01/OWLProfile.xmi"))
;;; (pop-gen :uml241 :owl-profile :keep-pkg-info nil :outfile "/local/tmp/tryme.lisp")

;;; (simple-run-validator  (pod:lpath :data "upr/mars-2017-08-06.xmi"))
;;;  --- OR ---
;;; (simple-run-validator  (pod:lpath :data "upr/UPR.xmi"))
;;; (pop-gen :uml25 :upr :keep-pkg-info nil :outfile "/local/tmp/tryme.lisp")

(defparameter *keep-pkg-info* nil "Because I'm not passing :keep-pkg-info deep enough!")

(defparameter *pg-objs* nil "PG (pop-gen) objects made. Used for diagnostics.")
(defvar *unique-name-cnt* 0)

(defmacro make-pg-instance (&rest args)
  (with-gensyms (obj)
    `(let ((,obj (make-instance ,@args)))
       (push ,obj *pg-objs*)
       ,obj)))

;;; ==========================================
;;; "Parametric model stuff"
;;; ==========================================
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro cmsym (string) `(intern ,string *cmpkg*))
  (defmacro cmfun (string) `(symbol-function ',(intern string *cmpkg*)))
  (defmacro cmfuncall (string &rest args) `(funcall (symbol-function ',(intern string *cmpkg*)) ,@args)))

(defparameter *updated-ocl-model* nil
  "The model name from which we will borrow updated OCL. Nil if none.")

;;; For CMOF/infralib: (just-those-owned-by)
;;; For  UML/infralib: (just-those-owned-by 
;;;	                  (mm-find-instance :predicate #'(lambda (x) (and (typep x 'uml23:|Package|)
;;;							                   (string= (uml23:%name x) "Constructs")))
;;;			   :model (mut *spare-session-vo*))
;;;                       #'uml23:%name))
(defmethod just-those-owned-by ((version (eql #.*cmpkg*))
				&optional 
				  (owner (mm-find-instance 
					  :predicate 
					  #'(lambda (x) 
					      (and (typep x '#.(cmsym "Package"))
						   #|(or 
						   (string= (cmfuncall "%NAME" x) "Submission Diagrams")
						   (string= (cmfuncall "%NAME" x) "BPMN 2")) |#))
					  :model (mut *spare-session-vo*)))
				  (owner-fn (cmfun "%OWNER")))
  "Remove from mut.members everything that isn't in the Constructs package."
  (unless owner (error "Could not find Package 'Submission Diagrams/BPMN2.'"))
  (labels ((is-owned-by-p (obj ow)
	     (cond ((null (funcall owner-fn obj)) nil)
		   ((eql (funcall owner-fn obj) ow) t)
		   (t (is-owned-by-p (funcall owner-fn obj) ow)))))
    (with-vo (mut)
      (let ((objs
	     (remove-if-not
	      #'(lambda (obj) (is-owned-by-p obj owner))
	      (coerce (members mut) 'list))))
	(setf (slot-value mut 'members)
	      (make-array (length objs) 
			  :adjustable t 
			  :fill-pointer (length objs) 
			  :initial-contents objs))))
    (values)))

(defmethod just-those ((version (eql #.*cmpkg*)))
  "Another throw-away, this one for Conrad's BPMN profile"
  (let* ((all-members (coerce (members (mut *spare-session-vo*)) 'list))
	 (those (loop for o in all-members
		   when (typep o '#.(cmsym "Stereotype")) collect o))
	 (owner-fn (cmfun "%OWNER")))
    (labels ((is-owned-by-those-p (obj)
	       (cond ((null (funcall owner-fn obj)) nil)
		     ((member (funcall owner-fn obj) those) t)
		     (t (is-owned-by-those-p (funcall owner-fn obj))))))
      (let* ((owned-by-those
	      (remove-if-not 
	       #'(lambda (obj) (is-owned-by-those-p obj))
	       all-members))
	     (result (append those owned-by-those)))
	(setf (slot-value (mut *spare-session-vo*) 'members)
	      (make-array (length result) 
			  :adjustable t 
			  :fill-pointer (length result) 
			  :initial-contents result))))))

;;; ==========================================
;;; Implementation proper
;;; ==========================================
(defclass pg-abstract ()
  ((name :initarg :name :reader name)
   (model :initarg :model :initform nil)
   (inherit :initarg :inherit :initform nil)
   (doc :initarg :doc :initform nil)
   (xmi-id :initarg :xmi-id :initform nil :reader xmi-id)
   (uuid-id :initarg :uuid-id :initform nil)
   (package-info :initarg :package-info :initform nil :reader package-info)))

(defmethod initialize-instance :after ((obj pg-abstract)  &key)
  (with-slots (name inherit) obj
      (when (member nil inherit) 
	(warn "~A: Nil in inherit!" name)
	(setf inherit (remove-if #'null inherit)))))

(defmethod print-object ((obj pg-abstract) stream)
  (with-slots (name) obj
    (format stream "#<~A ~A>" (class-name (class-of obj)) name)))

;;; These will be NAMED by their xmi-id (def-meta-assoc <xmi-id>...
(defclass pg-assoc (pg-abstract)
  ((metatype :initarg :metatype) ; Whether it is an assoc or extension(owned-ends :initarg :owned-ends), not .metaclass .
   (member-ends :initarg :member-ends :reader member-ends)
   (owned-ends :initarg :owned-ends :initform nil :reader owned-ends)
   (navigable-owned-ends :initarg :navigable-owned-ends :initform nil)
   (derived-p :initarg :derived-p :initform nil)   ; NYI
   (abstract-p :initarg :abstract-p :initform nil) ; NYI
   (generalizes :initarg :generalizes :initform nil) ; NYI, I don't see this in the diagram!
   (is-require-p  :initarg :is-required-p :initform nil) ; NYI
   (assoc-ends :initarg :assoc-ends))) ; not serialized, but so used to serialize ends below it

;;; These will be NAMED by their xmi-id (def-meta-assoc-end <xmi-id>...
(defclass pg-assoc-end (pg-abstract)
  ((visibility :initarg :visibility)
   (aggregation :initarg :aggregation :initform :none)
   (type :initarg :type)
   (redefined-property :initarg :redefined-property :initform nil)
   (multiplicity :initarg :multiplicity)))

(defclass pg-ptype (pg-abstract) 
  ())

(defclass pg-enum (pg-abstract) 
  ((vals :initarg :vals)))

(defclass pg-class (pg-abstract) 
  ((slots :initarg :slots)
   (object :initarg :object)))

(defclass pg-stereotype (pg-class) 
  ())

(defclass pg-abstract-con/op (pg-abstract) 
  ((class :initarg :class)
   (body  :initarg :body)
   (obody :initarg :obody :initform nil)
   (status :initarg :status :initform nil)
   (edit  :initarg :edit :initform nil)))

(defclass pg-operation (pg-abstract-con/op)
  ((params :initarg :params)
   (pre :initarg :pre)
   (post :initarg :post)))
   
(defclass pg-constraint (pg-abstract-con/op) ())

(defgeneric pop2lisp (obj &key tpkg &allow-other-keys)
  (:documentation "Convert an object to a form.")
  (:method ((obj ptypes:|Ptype-type-proxy|) &key tpkg)
    (intern (string (ptypes::%proxy-name obj)) tpkg))
  (:method ((obj number) &key tpkg)
    (declare (ignore tpkg))
    obj)
  (:method ((obj (eql '*)) &key tpkg)
    (declare (ignore tpkg))
    -1)
  (:method ((obj t) &key tpkg)
    (declare (ignore tpkg))
    (warn "NYI: ~A" obj))
  ;; This one for Alf.
  (:method ((obj mm-type-mo) &key tpkg)
    (declare (ignore tpkg))
    (class-name obj)))

(defgeneric p2l-op-is-slot-deriv-p (op)
  (:documentation "Return t if the operation is the attribute derivation."))

(defgeneric p2l-sort-properties (obj model)
  (:documentation "Return a list of the properties of OBJ, a cmof:|Class| sorted alphabetically by name."))

(defgeneric pop2lisp-comments (obj))
(defgeneric class-ocl-updates (class typ))

(defun find-package-fail (pkg-name)
  (or (find-package pkg-name)
      (error "In find-package, pkg does not exist: ~A" pkg-name)))

#+nil(defun pkg-info2lisp-pkg (pinfo tpkg)
  "Return the lisp package named by PINFO, a uml package. 
   If no such package exists, create one."
  (let* ((names (full-pkg-info *cmpkg* pinfo tpkg))
	 (pkg-name (format nil "~{~A~^-~}" names)))
    (or (find-package pkg-name)
	(make-package pkg-name :use '(:pod-utils :ptypes :ocl :mofi :cl)))))

;;; =============================================
;;; CMOF to MOFI Model code
;;; =============================================

(defmacro bool (name x)
  `(eql :true (,(intern (strcat "%" (string-upcase (c-name2lisp name))) *cmpkg*) ,x)))

(defmacro has (name x)
  `(,(intern (strcat "%" (string-upcase (c-name2lisp name))) *cmpkg*) ,x))

;;; This one should probably first check for a non-nil value.
(defmacro hasv (name x)
  `(ocl:value (,(intern (strcat "%" (string-upcase (c-name2lisp name))) *cmpkg*) ,x)))

(defparameter *pod-unnamed-cnt* 0 "Used to give unique names to unnamed slots.")
(declaim (inline next-pod-name))
(defun next-pod-unnamed ()
  (format nil "POD-UNNAMED-~A" (incf *pod-unnamed-cnt*)))

;;; 2013-11-13. This was a defun. I'm lost on how this was supposed to be invoked for multiple metamodels.
;;; I think I need a pop-gen METHOD for each metamodel

(defmethod pop-gen ((version (eql #.*cmpkg*))
		    tpkg &key 
			   (model (mut *spare-session-vo*))
			   (outfile (pod:lpath :models "tryme.lisp" ))
			   (keep-pkg-info nil))
  "Top-level function to print CMOF as def-meta- forms. 
   TPKG is the mofi:model name into which code will be generated.
   keep-pkg-info is used to put e.g. (in-package 'ODM-RDFBase') in front of every definition.
   This is used where there are multiple objects with the same simple name. (e.g. ODM)." 
  (setf *pod-unnamed-cnt* 0)
  (setf *pg-objs* nil)
  (setf *unique-name-cnt* 0)
  (pop-gen-fix-inheritances version model) ; has side-effects!
  (unless (find-package tpkg) (make-package tpkg :use '(:cl :mofi)))
  (flet ((getem (type)
	   (sort (remove-if-not  #'(lambda (x) (typep x type)) (coerce (members model) 'list))
		 #'string< 
		 :key (cmfun "%NAME"))))
    (with-open-file (stream outfile :direction :output :if-exists :supersede :if-does-not-exist :create)
      (format stream ";;; Automatically created by pop-gen at ~A." (now))
      (format stream "~%;;; Source file is ~A" (slot-value *spare-session-vo* 'phttp::filename))
      (format stream "~2%(in-package ~S)~2%" tpkg)
      (let ((classes (getem '#.(cmsym "Class"))))
	;#.(format t "~% compiling to ~S, *cmpkg* = ~S" (cmsym "Class") *cmpkg*) #.(break "here")
	(when keep-pkg-info
	  (loop for p in (getem '#.(cmsym "Package")) do (write-defpackages version p tpkg stream)))
	(loop for p in (getem '#.(cmsym "PrimitiveType")) do (pop2lisp p :tpkg tpkg :stream stream :model model :version version))
	(loop for e in (getem '#.(cmsym "Enumeration"))   do (pop2lisp e :tpkg tpkg :stream stream :model model :version version))
	(loop for a in (getem '#.(cmsym "Association")) do (pop2lisp a :tpkg tpkg :stream stream :model model :version version))
	(loop for a in (assocs-without-class) do (real-pprint version a stream)) ; probably none
	;; Classes prints associations too.
	(loop for c in classes do (pop2lisp c :tpkg tpkg :stream stream :model model :keep-pkg-info keep-pkg-info :version version))
	(loop for p in (getem '#.(cmsym "Package")) do (pop2lisp p :tpkg tpkg :stream stream :model model :version version))
	(pprint-prolog version stream tpkg model classes keep-pkg-info))))
  outfile)

(defun assocs-without-class ()
  "Return the pg-assoc objects that own all their ends."
  (loop for obj in *pg-objs*
       when (and (typep obj 'pg-assoc) 
		 (= (length (owned-ends obj)) (length (member-ends obj))))
       collect obj))

;;; POD Currently this, and everything else, isn't implementing hierarchical namespaces. 
;;; Used with keep-pkg-info = t (odm.lisp style output). 
(defmethod write-defpackages ((version (eql #.*cmpkg*)) package tpkg stream)
  "Write a defpackage for every CMOF/UML Package. MAKE THE PACKAGES TOO."
  (let ((name (format nil "~A-~A" tpkg (cmfuncall "%NAME" package))))
    (format stream "~%(defpackage ~S (:use :pod-utils :ptypes :ocl :mofi :cl))"  name)
    (unless (find-package name)
      (make-package name :use '(:pod-utils :ptypes :ocl :mofi :cl)))))

(declaim (inline obj2xmiid))
(defun obj2xmiid (obj model)
  "Return the xmiid of OBJ in MODEL."
  (gethash-inv obj (xmiid2obj-ht (processing-results model))))


(defmethod pop2lisp ((ptype #.(cmsym "PrimitiveType")) &key tpkg (stream *standard-output*) name-only-p model version)
  (declare (ignore model version))
  (let ((name (name-only-symbol ptype tpkg *keep-pkg-info*)))
    (if name-only-p
	name
	(let ((*package* (find-package tpkg)))
	  #-sbcl(declare (special *package*))
	  (real-pprint version (make-pg-instance 'pg-ptype :name name :model tpkg :xmi-id (obj2xmiid ptype model)) stream)
	  (format stream "~2%")))))

(defmethod pop2lisp ((enum #.(cmsym "Enumeration")) &key tpkg (stream *standard-output*) name-only-p model version)
  "Print a CMOF/UML:Class as a def-meta-class, def-meta-constraints and def-meta-operations."
  (declare (ignore model version))
  (let ((name (name-only-symbol enum tpkg *keep-pkg-info*)))
    (if name-only-p
	name
	(let ((*package* (find-package tpkg)))
	  #-sbcl(declare (special *package*))
	  (real-pprint
	   version
	   (make-pg-instance 
	    'pg-enum
	    :name name
	    :model tpkg 
	    :inherit (p2l-inherit enum tpkg version)
	    :vals (mapcar #'(lambda (x) (name-only-symbol x tpkg *keep-pkg-info*)) (hasv "ownedLiteral" enum)) ; POD 2016 and untested
	    :xmi-id (obj2xmiid enum model)
	    :doc (pop2lisp-comments enum))
	   stream)
	  (format stream "~2%")))))

(defmethod pop2lisp ((assoc #.(cmsym "Association")) &key tpkg model name-only-p)
  "Print a CMOF/UML:Association as a def-meta-assoc."
  (flet ((end-info (end) ; (<class-name> <end-name>) OR (xmi-id <end-name>)
	   (list (or (pop2lisp (cmfuncall "%CLASS" end) :name-only-p t :tpkg tpkg)
		     (obj2xmiid end model))
		 (cmfuncall "%NAME" end))))
    (let ((name (if-bind (n (cmfuncall "%NAME" assoc)) 
			 (name-only-symbol assoc tpkg *keep-pkg-info*)
			 (intern (format nil "unamed-assoc-~A" (incf *unique-name-cnt*)) tpkg))))
      (if name-only-p
	  name
	  (let ((*package* (find-package tpkg)))
	    #-sbcl(declare (special *package*))
	     (make-pg-instance 
	      'pg-assoc
	      :name name
	      :metatype (if (typep assoc '#.(cmsym "Extension")) :extension :association)
	      :xmi-id (obj2xmiid assoc model)
	      :model tpkg 
	      :owned-ends (if (typep assoc '#.(cmsym "Extension"))
			      (list (end-info (has "ownedEnd" assoc)))
			      (mapcar #'end-info (hasv "ownedEnd" assoc)))
	      :member-ends (mapcar #'end-info (hasv "memberEnd" assoc))
	      :navigable-owned-ends (mapcar #'end-info (hasv "navigableOwnedEnd" assoc))
	      :assoc-ends (sort (mapcar #'(lambda (x) (compute-assoc-end x model tpkg)) 
					(if (typep assoc '#.(cmsym "Extension")) 
					    (list (has "ownedEnd" assoc))
					    (hasv "ownedEnd" assoc)))
				#'string<
				:key #'xmi-id)))))))

#| Full sized example (from SysML) could also be a uml:Property. 
 <ownedEnd xmi:type="uml:ExtensionEnd"
   xmi:id="_SysML_-Ports%2526Flows-E_extension_Invo...n_InvocationOnNestedPortAction"
   xmi:uuid="eb1ecd30-1f7a-40f7-a07b-cbbf678179fc"
   name="extension_InvocationOnNestedPortAction"
   visibility="public"
   aggregation="composite"
   type="_SysML_-Ports%2526Flows-InvocationOnNestedPortAction"
   association="_SysML_-Ports%2526Flows-E_extension_InvocationOnNestedPortAction_base_InvocationAction">
      <redefinedProperty xmi:idref="_SysML_-Blocks-E_e..._base_Element-extension_ElementPropertyPath"/>
      <lowerValue xmi:type="uml:LiteralInteger"
               xmi:id="_SysML_-Ports%2526Flows-E_exten...ension_InvocationOnNestedPortAction-_lowerValue"
               xmi:uuid="97882509-51fe-4d6a-ae25-ce950921bb50"/>
  </ownedEnd>
|#



(defgeneric compute-assoc-end (end model tpkg))

(defmethod compute-assoc-end ((end #.(cmsym "Property")) model tpkg)
  "Create a pg-assoc-end for ends owned by the Association (or Extension). 
   These will be the only thing persisting information of the associate-owned ends."
  (make-pg-instance
   'pg-assoc-end
   :xmi-id (obj2xmiid end model) ; Use THIS as object name. 
   :name (cmfuncall "%NAME" end) ; This is not unique. 
   :type (pop2lisp (cmfuncall "%TYPE" end) :name-only-p t :tpkg tpkg)
   :visibility (when-bind (v (cmfuncall "%VISIBILITY" end)) (kintern v))
   :aggregation (when-bind (a (cmfuncall "%AGGREGATION" end)) (kintern a))
   :redefined-property (when-bind (r (has "redefinedProperty" end)) (obj2xmiid r model))
   :multiplicity (list (or (cmfuncall "%LOWER" end) 1)
		       (if-bind (u (cmfuncall "%UPPER" end)) (if (eql u '*) -1 u) 1))))

(defun pkg-or-owning-pkg (obj)
  "Return the OBJ if it is a package, otherwise, return the owning package of OBJ."
  (loop until (typep obj (cmsym "Package")) do
       (setf obj (cmfuncall "%OWNER" obj)))
  obj)

;;; POD Currently this, and everything else, isn't implementing hierarchical namespaces. 
#+nil(defun name2symbol (obj tpkg)
  "Return the namespace-qualified name of the object."
    (let* ((name (cmfuncall "%NAME" obj))
	   (pkg  (pkg-or-owning-pkg obj))
	   (pname (format nil "~A-~A" tpkg (cmfuncall "%NAME" pkg))))
      (intern name pname)))

;;; These are what get called by pop2lisp :name-only-p = t
(defmacro name-only-sym-mac (obj-type ns-access)
  `(defmethod name-only-symbol ((obj ,obj-type) tpkg keep-pkg-info)
     (when-bind (name (cmfuncall "%NAME" obj))
       (let ((result
	      (if keep-pkg-info
		  (if-bind (ns ,ns-access) 
			   (intern name (find-package-fail 
					 (format nil "~A-~A" tpkg 
						 (cmfuncall "%NAME" (pkg-or-owning-pkg ns)))))
			   (intern name tpkg))
		  (intern name tpkg))))
	 (or result (error "name-only-symbol returning nil"))))))

(name-only-sym-mac #.(cmsym "Class")       (cmfuncall "%NAMESPACE" obj))
(name-only-sym-mac #.(cmsym "Constraint")  (cmfuncall "%NAMESPACE" obj))
(name-only-sym-mac #.(cmsym "Property")    (cmfuncall "%NAMESPACE" (cmfuncall "%CLASS" obj)))
(name-only-sym-mac #.(cmsym "Enumeration")  (cmfuncall "%NAMESPACE" obj))
(name-only-sym-mac #.(cmsym "EnumerationLiteral")  (cmfuncall "%NAMESPACE" obj))
(name-only-sym-mac #.(cmsym "Association") (cmfuncall "%NAMESPACE" obj))
(name-only-sym-mac #.(cmsym "PrimitiveType") (cmfuncall "%NAMESPACE" obj))

(defmethod name-only-symbol ((obj mm-type-mo) tpkg keep-pkg-info)
  (class-name obj))

(defmethod p2l-inherit ((class #.(cmsym "Class")) tpkg version)
  "Auxillary function for Class p2l, returns list of superclass names."
  (p2l-inherit-internal class tpkg version))

(defmethod p2l-inherit ((enum #.(cmsym "Enumeration")) tpkg version)
  "Auxillary function for Class p2l, returns list of superclass names."
  (p2l-inherit-internal enum tpkg version))

(defun p2l-inherit-internal (obj tpkg version)
  (mapcar #'(lambda (x) (name-only-symbol x tpkg *keep-pkg-info*))
	  (when-bind 
	      (inh (ecase version  ; 2012-02-24 nothing in stereotypes?
		     (:cmof (cmfuncall "%SUPER-CLASS" obj))
		     ((or :uml25 :uml4sysml12 :uml241 :uml23)
		      (make-instance 
		       'ocl:|Set|
		       :value (mapcar '#.(cmsym "%GENERAL")
				      (ocl:value (cmfuncall "%GENERALIZATION" obj)))))))
	    (ocl:value inh))))


;;; Currently this is used for Stereotypes too. (Stereotypes are classes). 
(defmethod pop2lisp ((class #.(cmsym "Class")) &key tpkg (stream *standard-output*) name-only-p model keep-pkg-info version)
  "Print a CMOF/UML:Class as a def-meta-class, def-meta-constraints and def-meta-operations."
  (declare (ignore model))
  (let ((name (name-only-symbol class tpkg *keep-pkg-info*))
	(*package* (if keep-pkg-info ; POD probably want this on enums, primitive types etc. too.
		       (find-package (format nil "~A-~A" tpkg 
					     (cmfuncall "%NAME" (cmfuncall "%NAMESPACE" class))))
		       (find-package tpkg))))
    #-sbcl(declare (special *package*))
    (if name-only-p
	name
	;; Otherwise write to STREAM the class, its operations and constraints."
	(let ((cform (make-pg-instance 
		      (if (eql version :cmof) 			
			  'pg-class
			  (typecase class
			    (#.(cmsym "Stereotype") 'pg-stereotype) ; 2011-09-07 commented out for CMOF/fuml
			    (#.(cmsym "Class") 'pg-class)))
		      :name name
		      :object class
		      :model tpkg
		      :inherit (p2l-inherit class tpkg version)
		      :slots (mapcar #'(lambda (x) 
					 (pop2lisp x :tpkg tpkg :keep-pkg-info keep-pkg-info :version version :model model))
				     (p2l-sort-properties class model))
		      :doc (pop2lisp-comments class)
		      :xmi-id (obj2xmiid class model) 
		      ;; 2013-11-22 see notes. I can't see why NamedElement.namespace would have a value!
		      ;; Thus I have changed this to an OR added Element.owner
		      :package-info (or (cmfuncall "%NAMESPACE" class) (cmfuncall "%OWNER" class))))
	      ;; Rules owned by the class are constraints
	      (rforms (remove-if #'null
				 (mapcar #'(lambda (x) (pop2lisp x :tpkg tpkg :version version))
					 (sort (ocl:value (cmfuncall "%OWNED-RULE" class))
					       #'string< :key (cmfun "%NAME")))))
	      ;; Operations owned by the class have rules that are the parts (pre, body, post) of the operation. 
	      (oforms (remove-if #'null
				 (mapcar #'(lambda (x) (pop2lisp x :tpkg tpkg :version version))
					 (sort (ocl:value (cmfuncall "%OWNED-OPERATION" class))
					       #'string< :key (cmfun "%NAME"))))))
	  (real-pprint version cform stream :keep-pkg-info keep-pkg-info)
	  ;(format stream "~%")
	  (when rforms (loop for r in rforms do (format stream "~%") (real-pprint version r stream)))
	  (when oforms (loop for o in oforms do (format stream "~%") (real-pprint version o stream)))
	  (loop for a in (sort (class-assocs cform) #'string< :key #'name) 
	        do (real-pprint version a stream))))))



;;; Both association ends could be owned by classes, but of course we want the 
;;; Declaration to appear only once. So we print it with the first class-owned end in member ends.
(defmethod class-assocs ((class pg-class))
  "Return the pg-assoc objects that is the first class-owned association end."
  (let ((class-name  (name class)))
    (loop for obj in *pg-objs*
       when (and (typep obj 'pg-assoc) 
		 (eql class-name 
		      (caar (remove-if-not #'symbolp (member-ends obj) :key #'car))))
       collect obj)))

(defmethod pop2lisp ((rule #.(cmsym "Constraint")) &key tpkg model version)
  (declare (ignore model))
;;; 2014-04-11 commenting out when
;  (when #-updm t ; this doesn't do anything useful. Further inspection revealed that UPDM doesn't have useful OCL!
;	#+updm (string= "OCL2.0" (car (ocl:value (cmfuncall "%LANGUAGE" (cmfuncall "%SPECIFICATION" rule)))))
	(let* ((op-body (with-output-to-string (str)
			  (cl-ppcre:regex-replace-all 
			   "&lt;" 
			   (cl-ppcre:regex-replace-all 
			    "&gt;"
			    (format str "~{~A~^~%~}" 
				    (ocl:value (cmfuncall "%BODY" (cmfuncall "%SPECIFICATION" rule))))
			    ">") "<")))
	       (class (pop2lisp (cmfuncall "%CONTEXT" rule) :tpkg tpkg :name-only-p t :version version))
	       (const (make-pg-instance 
		       'pg-constraint
		       :name (name-only-symbol rule tpkg *keep-pkg-info*)
		       :class class
		       :doc (with-output-to-string (str)
			      (format str "~{~A~^~%~}" 
				      (mapcar (cmfun "%BODY") (hasv "ownedComment" rule))))
		       :body  op-body)))
	  (when-bind (nop (and *updated-ocl-model*
			       (find (cmfuncall "%NAME" rule)
				     (class-ocl-updates (cmfuncall "%CONTEXT" rule) :constraints)
				     :test #'string= :key #'operation-name)))
	    (with-slots (edit status body obody) const
	      (setf edit (or (editor-note nop) ""))
	      (setf status (or (operation-status nop) :rewritten))
	      (setf body (operation-body nop))
	      (setf obody op-body)))
	  const))

#|
;; Messed up from updm?
#+updm  (when #+updm nil  #-updm (typep (cmfuncall "%SPECIFICATION" rule) #.(cmsym "OpaqueExpression"))
      #+updm(with-slots (edit status body obody) const
	      (setf obody body)
	      (setf body "true")
	      (setf status :ignored)
	      (setf edit "Specification is opaque. (See original-body.)")))
    const))
|#

(defmethod class-ocl-updates ((class #.(cmsym "Element")) type)
  "Look through another model, which may have better OCL.
   Return a list of ocl-operation objects from the updated-ocl-model
   for CLASS (a cmof:|Class| object)."
  (when-bind (up-class (find-class (intern (cmfuncall "%NAME" class)
					   (lisp-package (find-model *updated-ocl-model*))) nil))
    (remove-if-not ; sometimes I forget to set :operation-status
     #'(lambda (x) (or (original-body x)
		       (not (eql :original (operation-status x)))))
     (ecase type
       (:operations  (type-operations  up-class))
       (:constraints (type-constraints up-class))))))

(declaim (inline no-nonsense-name))
(defun no-nonsense-name (str)
  "If STR is like this: 'javamethod.1' return 'javamethod' else return STR."
  (mvb (success vec)
      (cl-ppcre:scan-to-strings "^(.*)\\.\\d" str)
    (if success (aref vec 0) str)))

;;; Confusing: Operations have rules, which are the pre, post, and body of the operation.
;;;            When I call pop2lisp on a rule, it is defining a constraint.
;;;          Class.ownedOperation -- operations
;;;          Class.ownedRule -- constraint
;;; POD 2012-02-23 grabbing pre and post, but not using them yet. 
(defmethod pop2lisp ((op #.(cmsym "Operation")) &key tpkg version)
  "Translate an operation."
  (declare (ignore version))
  (flet ((spec-body (x) (when x (ocl:value (cmfuncall "%BODY" (cmfuncall "%SPECIFICATION" x))))))
    (let* ((op-body (format nil "~{~A~^~%~}" (spec-body(cmfuncall "%BODY-CONDITION" op))))
	   (op-pre (loop for p in (ocl:value (cmfuncall "%PRECONDITION" op))
		       collect (spec-body p)))
	   (op-post nil)
	   (pg-op 
	    (when op-body
	      (make-pg-instance 
	       'pg-operation ; POD 2017 added intern tpkg
	       :name (intern (format nil (if (p2l-op-is-slot-deriv-p op) "~A.1" "~A") (cmfuncall "%NAME" op)) tpkg)
	       :class (pop2lisp (cmfuncall "%CLASS" op) :tpkg tpkg :name-only-p t)
	       :doc (format nil "~{~A~^~%~}" (mapcar (cmfun "%BODY") (hasv "ownedComment" op)))
	       :body op-body
	       :pre op-pre
	       :post op-post
	       ;;fUML     "Comments botched in this version of fUML."
	       :params (mapcar #'(lambda (x) (pop2lisp x :tpkg tpkg))
			       (hasv "ownedParameter" op))))))
      (when pg-op
	(when-bind (nop (and *updated-ocl-model*
			     (find (cmfuncall "%NAME" op)
				   (class-ocl-updates (cmfuncall "%CLASS" op) :operations)
				   :test #'string= 
				   :key #'(lambda (x) (no-nonsense-name (operation-name x))))))
	  (with-slots (edit status body obody) pg-op
	    (setf edit (or (editor-note nop) ""))
	    (setf status (or (operation-status nop) :rewritten))
	    (setf body (operation-body nop))
	    (setf obody op-body)))
	pg-op))))

(defmethod p2l-op-is-slot-deriv-p ((op #.(cmsym "Operation")))
  "Return t if the operation is the attribute derivation."
  (when-bind (attr (find (cmfuncall "%NAME" op) (ocl:value (cmfuncall "%OWNED-ATTRIBUTE" (cmfuncall "%CLASS" op)))
			 :key (cmfun "%NAME") :test #'string=))
    (eql :true (cmfuncall "%IS-DERIVED" attr))))

;;; Here I don't have the quote on the name. (I put it on when I print.)
(defmethod pop2lisp ((p #.(cmsym "Parameter")) &key tpkg version)
  "Return a make-instance 'ocl-parameter form."
  (declare (ignore version))
  `(make-instance 'ocl-parameter 
		  :parameter-name ,(if (eql (cmfuncall "%DIRECTION" p) :return) 
				       nil 
				       (intern (cmfuncall "%NAME" p) tpkg))
		  :parameter-type ,(pop2lisp (cmfuncall "%TYPE" p) :tpkg tpkg :name-only-p t)
		  :parameter-return-p ,(if (eql (cmfuncall "%DIRECTION" p) :return) t nil)))

;;; (setf ccc (mm-find-instance :id 1354))
;;; :is-derived-union-p :is-readonly-p :is-composite-p :is-ordered-p 
;;; :is-derived-p :default :subsetted-properties :opposite :documentation
(defmethod pop2lisp ((prop #.(cmsym "Property")) &key tpkg keep-pkg-info version model)
  "Print a slot."
  `(,(name-only-symbol prop tpkg keep-pkg-info)
     :xmi-id ,(obj2xmiid prop model)
     :range ,(or (pop2lisp (cmfuncall "%TYPE" prop) :tpkg tpkg :name-only-p t) 
		 (if keep-pkg-info t '#.(cmsym "Element"))) ; POD only works for UML! 
     :multiplicity (,(pop2lisp (or (and (fboundp '#.(cmsym "%LOWER-VALUE"))
					(cmfuncall "%LOWER-VALUE" prop))
				   (cmfuncall "%LOWER" prop)))
		    ,(let ((u (pop2lisp (or (and (fboundp '#.(cmsym "%UPPER-VALUE"))
						 (cmfuncall "%UPPER-VALUE" prop))
					    (cmfuncall "%UPPER" prop)))))
			  (if (eql u :*) -1 u)))
     ,@(when (bool "isDerivedUnion" prop) (list :is-derived-union-p t))
     ,@(when (bool "isReadOnly" prop) (list :is-readonly-p t))
     ,@(when (bool "isComposite" prop) (list :is-composite-p t))
     ,@(when (bool "isOrdered" prop) (list :is-ordered-p t))
     ,@(when (bool "isDerived" prop) (list :is-derived-p t))
     ,@(if (eql version :cmof)
	   (when (has "default" prop) 
	     (list :default (let ((val (has "default" prop)) num?)
			      (cond ((and (cl-ppcre:scan "^[+,-]?[0-9]+.?[0-9]*$" val)
					  (numberp (setf num? (read-from-string val))))
				     num?)
				    ((string= val "") val) ; 2012 ??? What about strings that should remain string?
				    (t (intern val :keyword))))))
	   ;; UMLs #. here is only for compilation "default" DNE in UML (and need something for 'has').
	   (when-bind (val (has #.(if (eql *cmpkg* :cmof) "default" "defaultValue") prop))
	     (when-bind (non-nil (pop2lisp val :tpkg tpkg)) ; seasonality...unusual MD editing bug???
	       (list :default (pop2lisp val :tpkg tpkg)))))
     ,@(when (hasv "subsettedProperty" prop) ; not enough to surpress the nil.
	     (when-bind (results
			 (sort 
			  (remove-if #'null
				     (mapcar #'(lambda (x)
						   (list 
						    (pop2lisp (cmfuncall "%CLASS" x) :tpkg tpkg :name-only-p t)
						    (intern (or (cmfuncall "%NAME" x) (next-pod-unnamed)))))
					     (hasv "subsettedProperty" prop))
				     :key #'car)
			  #'string< :key #'car))
	       (list :subsetted-properties results)))
     ,@(when-bind (opp (when-bind (opp (cmfuncall "%OPPOSITE" prop))
			 (if (typep opp '#.(cmsym "Property")) opp nil)))
		  (if-bind (name (cmfuncall "%NAME" opp))
			   (when-bind (c (cmfuncall "%CLASS" opp))
				    (list :opposite
					  (list (pop2lisp c :tpkg tpkg :name-only-p t)
						(intern name))))
			   (warn "Unnamed opposite property.")))
     ,@(when (hasv "ownedComment" prop) ; not enough to suppress the nil.
	     (list :documentation
		    (with-output-to-string (str)
		      (format str "~{~A~^~%~}" 
			      (mapcar (cmfun "%BODY") (hasv "ownedComment" prop))))))
     ,@(when (hasv "redefinedProperty" prop)
	     (let ((redef (car (ocl:value (cmfuncall "%REDEFINED-ELEMENT" prop)))))
	       (list :redefined-property
		     (list (pop2lisp (cmfuncall "%CLASS" redef) :tpkg tpkg :name-only-p t)
			   (intern (cmfuncall "%NAME" redef))))))))


;;; OCL of opposite UML (and I'm using i infralib/10-08-15-cleanup.xmi for CMOF).
;;; if owningAssociation->isEmpty() and association->notEmpty() and association.memberEnd->size() = 2 
;;;         then let otherEnd = (association.memberEnd->excluding(self))->any() in 
;;;           if otherEnd.owningAssociation->isEmpty() then otherEnd else Set{} endif 
;;;         else Set {} endif
#+nil
(defun tryme-opposite (self)
  "Definition of opposite directly out of UML23 (source above)."
  (OCL-IF (OCL-AND (OCL-AND (OCL-IS-EMPTY (UML23:%OWNING-ASSOCIATION SELF)) ; this property not owned by association
			    (OCL-NOT-EMPTY (UML23:%ASSOCIATION SELF)))      ; but there IS an association.
		   (OCL-= (OCL-SIZE (UML23:%MEMBER-END (UML23:%ASSOCIATION SELF))) ; Binary associations only
			  2))
	  (LET ((UML23::|?otherEnd|
		  (OCL-ANY (OCL-EXCLUDING (UML23:%MEMBER-END (UML23:%ASSOCIATION SELF))
					  SELF)
			   #'(LAMBDA (OCLU::%VAR-293) OCLU::%VAR-293))))          ; Got the otherEnd
	    (OCL-IF (OCL-IS-EMPTY (UML23:%OWNING-ASSOCIATION UML23::|?otherEnd|)) ; Other end is not owned by...
		    UML23::|?otherEnd|                                            ; ...the association. (WHY ???)
		    (MAKE-INSTANCE '|Set| :VALUE NIL)))
	  (MAKE-INSTANCE '|Set| :VALUE NIL)))


;;; Properties are ordered. I would lose them here if they weren't already
;;; alphabetical. (They are in 2.4.1.) 
(defmethod p2l-sort-properties ((class #.(cmsym "Class")) model)
  "Return a list of the properties of OBJ, a cmof/uml:|Class| sorted alphabetically by name."
  (sort 
   (loop for obj across (members model)
      when (and (typep obj '#.(cmsym "Property"))
		(eql class (cmfuncall "%CLASS" obj)))
      collect obj)
   #'string<
   :key (cmfun "%NAME")))
     
(defmethod pop2lisp-comments ((obj #.(cmsym "Element")))
  "Concatenate and format comments."
  (when-bind (comments (ocl:value (cmfuncall "%OWNED-COMMENT" obj)))
    (apply #'concatenate 'string
	    (loop for c in comments collect (cmfuncall "%BODY" c)))))

(defmethod pop2lisp ((obj #.(cmsym "Package")) &key tpkg stream name-only-p model version)
  (declare (ignore version))
  (if name-only-p
      (intern (cmfuncall "%NAME" obj) tpkg)
      (let ((*package* (find-package tpkg)))
	#-sbcl(declare (special *package*))
	(format stream "~2%(def-meta-package ~S ~S ~S ~%   (~{~S~^~%    ~}) :xmi-id ~S)"
		(intern (cmfuncall "%NAME" obj) tpkg)
		;; owner, ownedElement will be resolved to a mm-type-object/mm-package-mo on model-load. 
		(when-bind (owner (cmfuncall "%OWNER" obj))
		  (pop2lisp owner :name-only-p t :tpkg tpkg))
		tpkg
		(mapcar #'(lambda (x) (pop2lisp x :name-only-p t :tpkg tpkg))
			(remove-if-not #'(lambda (x) (or ; remove PackageImport...
						      (typep x '#.(cmsym "Class"))
						      (typep x '#.(cmsym "PrimitiveType"))
						      (typep x '#.(cmsym "Enumeration"))
						      (typep x '#.(cmsym "Package"))))
				       (when-bind (oe (cmfuncall "%OWNED-ELEMENT" obj))
					 (ocl:value oe))))
		(obj2xmiid obj model)))))

;;; =============================================
;;; UML version-specific to MOFI Model code
;;; =============================================
;;; 2014-04-08 This isn't version-specific!

(defmethod pop2lisp ((obj #.(cmsym "OpaqueExpression")) &key tpkg)
  "Guess at the value of a OpaqueExpression"
  (declare (ignore tpkg))
  (let* ((val (car (ocl:value (cmfuncall "%BODY" obj))))   ; POD 2014-04-08 see below for old one.
	 (num? (if (and (stringp val) (not (char= #\# (char val 0)))) (read-from-string val) val)))
    (cond ((numberp num?) num?)
	  ((string= val "") val)
	  ((null val) nil)
	  (t (kintern val)))))


(defmethod pop2lisp ((obj #.(cmsym "ValueSpecification")) &key tpkg)
  "Guess at the value of a ValueSpecification"
  (declare (ignore tpkg))
  (let* ((val (cmfuncall "%VALUE" obj))   ; POD 2010-10-17 How does this work?
	 (num? (if (and (stringp val) (not (char= #\# (char val 0)))) (read-from-string val) val)))
    (cond ((numberp num?) num?)
	  ((string= val "") val)
	  ((null val) nil)
	  (t (kintern val)))))



(defmethod pop2lisp ((obj #.(if (eql *cmpkg* :cmof) 
				'(eql :never)
				(intern "InstanceValue" *cmpkg*))) &key tpkg)
  "Read an instance value."
  (declare (ignore tpkg))
  (pop2lisp (cmfuncall "%INSTANCE" obj)))

(defmethod pop2lisp ((obj #.(cmsym "EnumerationLiteral")) &key tpkg)
  (declare (ignore tpkg))
  (kintern (cmfuncall "%NAME" obj)))

;;;==========================================================
;;; Stuff to merge updated OCL -- Not used in CMOF yet.
;;;==========================================================
(defmethod class-ocl-updates ((class #.(cmsym "Element")) type)
  "Look through another model, which may have better OCL.
   Return a list of ocl-operation objects from the updated-ocl-model
   for CLASS (a cmof/uml:|Class| object)."
  (when-bind (up-class (find-class (intern (cmfuncall "%NAME" class) 
					   (lisp-package (find-model *updated-ocl-model*))) nil))
    (remove-if-not ; sometimes I forget to set :operation-status
     #'(lambda (x) (or (original-body x)
		       (not (eql :original (operation-status x)))))
     (ecase type
       (:operations  (type-operations  up-class))
       (:constraints (type-constraints up-class))))))

;;;==========================================================
;;; Printing -- Both UML and CMOF
;;;==========================================================
(defun split-at (lis splitters)
  "Return a list of sublists where the sublists start with the splitter."
  (let ((pos (cons 0 (remove-if #'null (mapcar #'(lambda (x) (position x lis)) splitters)))))
    (loop for p on pos
	  collect (subseq lis (car p) (cadr p)))))

(defgeneric real-pprint (version obj stream &key &allow-other-keys))

(defmethod real-pprint :around (version obj stream &key)
   (with-slots (name) obj
     (let ((*package* (if (typep obj 'pg-assoc-end) *package* (symbol-package name))))
       (call-next-method))))

(defmethod real-pprint ((version (eql #.*cmpkg*)) (obj pg-ptype) stream &key)
  "Print a def-meta-enum very prettily."
  (declare (ignore version))
  (with-slots (name model inherit xmi-id) obj
    (format stream "~2%(def-meta-primitive ~S (:model ~S :superclasses ~S :xmi-id ~S))"
	     name model inherit xmi-id)))

(defmethod real-pprint ((version (eql #.*cmpkg*)) (obj pg-enum) stream &key)
  "Print a def-meta-enum very prettily."
  (declare (ignore version))
  (with-slots (name model inherit vals doc xmi-id) obj
    (format stream "~2%(def-meta-enum ~S (:model ~S :superclasses ~S ~%   :xmi-id ~S)~%   (~{~S~^ ~})~%   ~S)"
	     name model inherit xmi-id vals 
	    (string-trim '(#\Space) (format-to-size doc 70 "   ")))))

(defmethod real-pprint ((version (eql #.*cmpkg*)) (obj pg-assoc) stream &key)
  "Print a def-meta-assoc very prettily; print its association-owned ends too."
  (with-slots (name model member-ends metatype owned-ends xmi-id assoc-ends) obj
    (format stream "~2%(def-meta-assoc ~S" xmi-id)
    (format stream "      ~%  :name ~S" name)
    (format stream "      ~%  :metatype ~A" (case metatype (:association ":association") (t ":extension")))
    (format stream "      ~%  :member-ends (~{~S~^~%                ~})" member-ends)
    (format stream "      ~%  :owned-ends  (~{~S~^ ~}))" (mklist owned-ends))
    ;; Only the association-owned ends were created. 
    (loop for e in assoc-ends do (real-pprint version e stream :assoc xmi-id))))

(defmethod real-pprint ((version (eql #.*cmpkg*)) (obj pg-assoc-end) stream &key assoc)
  (with-slots (xmi-id name type multiplicity aggregation visibility redefined-property) obj
    (format stream "~2%(def-meta-assoc-end ~S"  xmi-id)
    (format stream " ~%    :type ~S" type)
    (format stream " ~%    :multiplicity ~S" multiplicity)
    (format stream " ~%    :association ~S" assoc)
    (when name (format stream " ~%    :name ~S" name))
    (unless (eql :none aggregation) (format stream " ~%    :aggregation ~S" aggregation))
    (when visibility  (format stream " ~%    :visibility ~S" visibility))
    (when redefined-property (format stream " ~%    :redefined-property ~S" redefined-property))
    (format stream ")")))

(defmethod real-pprint ((version (eql #.*cmpkg*)) (obj pg-class) stream &key keep-pkg-info)
  (with-slots (name model inherit package-info doc slots xmi-id) obj
    (format stream "~2%;;; =========================================================")
    (format stream "~%;;; ====================== ~A" name)
    (format stream "~%;;; =========================================================")
    (when keep-pkg-info 
      (format stream "~%(in-package ~S)" (package-name (symbol-package name))))
    (format stream "~%(def-meta-class ~S ~%   (:model ~S :superclasses ~S ~%    :packages ~S ~%    :xmi-id ~S)~% ~S"
	    name model inherit (full-pkg-info version package-info model) xmi-id 
	    (string-trim '(#\Space) (format-to-size doc 70)))
    (real-pprint-slots slots stream)
    (format stream ")")))

(defmethod find-base-type ((version (eql #.*cmpkg*)) base-property)
  "Return the classifier symbol X for the property base_X."
  (let ((as (cmfuncall "%ASSOCIATION" base-property)))
    ;; I think I could also just look for the non-ExtensionEnd. Would that be safer?
    (when-bind (m-end (car (set-difference (ocl:value (cmfuncall "%MEMBER-END" as))
					   (if (typep as '#.(cmsym "Association"))
					       (list (cmfuncall "%OWNED-END" as)) 
					       (ocl:value (cmfuncall "%OWNED-END" as))))))
      (if-bind (typ (cmfuncall "%TYPE" m-end)) ; POD 2013-12-30 if added for SysML1.2 processing
	(class-name typ)
	(intern (subseq (cmfuncall "%NAME" m-end) 5) (lisp-package (mofi:%of-model m-end)))))))

(defmethod real-pprint ((version (eql #.*cmpkg*)) (obj pg-stereotype) stream &key keep-pkg-info)
  (declare (ignore keep-pkg-info))
  (with-slots (name model inherit package-info doc slots xmi-id object) obj
    (let* ((non-base-slots (remove-if #'(lambda (x) (cl-ppcre:scan "^base_" (string (car x)))) slots))
	   ;; POD This really ought to be done when the object is created!
	   (extends (mapcar #'(lambda (x) (find-base-type version x))
			    (mapcar #'(lambda (x)
					(find x (ocl:value (cmfuncall "%OWNED-ATTRIBUTE" object))
					      :test #'string= :key (cmfun "%NAME")))
				    (mapcar #'car (set-difference slots non-base-slots))))))
      #+md-bpmn(fix-inherit (if (string= name "ResourceParameter") (reverse inherit) inherit))
      (when (and (null inherit) (null extends))
	(warn "~A: Both :superclasses and :extends are null!" name))
      (format stream "~2%;;; =========================================================")
      (format stream "~%;;; ====================== ~A" name)
      (format stream "~%;;; =========================================================")
      (format stream "~%(def-meta-stereotype ~S ~%   (:model ~S :superclasses ~S :extends ~S~% :packages ~S ~% :xmi-id ~S)~% ~S"
	      name model #+md-bpmn fix-inherit #-bpmn inherit extends 
	      (full-pkg-info version package-info model) xmi-id
	      (string-trim '(#\Space) (format-to-size doc 70)))
      (real-pprint-slots slots stream) ; 2013-12-17 was non-base-slots
      (format stream ")"))))
	    
(defun real-pprint-slots (slots stream &key)
  "Print a def-meta-class very prettily."
    (format stream "~%  (")
    (loop for s on slots do
	 (format stream "(")
	 (loop for line on (split-at (car s) '(:range :subsetted-properties :opposite :documentation)) do
	      (loop for tkns on (car line) do
		   (if (keywordp (car tkns))
		       ;; Next line needs work: Can't handle keywords with #\: in them. 
		       (let ((str (string-downcase (string (car tkns)))))
			 (if (find #\Space str)
			     (format stream ":|~A|" str) 
			     (format stream ":~A" str))) 
		       (format stream "~S" (car tkns)))
		   (when (eql (car tkns) :documentation)
		     (format stream "~%    ")
		     (setf (second tkns)
			   (string-trim '(#\Space) (format-to-size (second tkns) 70 "     "))))
		   (when (cdr tkns) (format stream " ")))
	      (when (cdr line) (format stream "~%    ")))
	 (format stream ")")
	 (when (cdr s) (format stream "~%   ")))
    (format stream ")"))

(defmethod real-pprint ((version (eql #.*cmpkg*)) (obj pg-constraint) stream &key)
  "Print a def-meta-constraint very prettily."
  (declare (ignore version))
  (with-slots (name class doc body status obody edit) obj
    (format stream "~%(def-meta-constraint ~S ~S ~%   ~S"
	    name class (string-trim '(#\Space) (format-to-size doc 70 "   ")))
    (format stream "~%   :operation-body~%   ~S" body)
    (when edit 
      (format stream "~%   :operation-status ~A~%" 
	      (format nil ":~A" (string-downcase (string status))))
      (format stream "   :editor-note ~S~%" edit)
      (format stream "   :original-body~%   ~S" obody))
    (format stream ")")))

(defmethod real-pprint ((version (eql #.*cmpkg*)) (obj pg-operation) stream &key)
  "Print a def-meta-operation very prettily."
  (declare (ignore version))
  (with-slots (name class doc body status obody edit params) obj
    (format stream "~%(def-meta-operation ~S ~S ~%   ~S"
	    name class (string-trim '(#\Space) (format-to-size doc 70 "   ")))
    (format stream "~%   :operation-body~%   ~S" body)
    (format stream "~%   :parameters") (real-pprint-params params stream)
    (when edit
      (format stream "    :operation-status ~A~%" 
	      (format nil ":~A" (string-downcase (string status))))
      (format stream "    :editor-note ~S~%" edit)
      (format stream "    :original-body~%    ~S~%" obody))
    (format stream ")")))

(defun real-pprint-params (params stream)
  "Print the chunk of codes for parameter."
  (format stream "~%   (list")
  (loop for ps on params do ; 2011-07-31 was (cdr params)
       (dbind (ig1 ig2 ig3 pname ig4 ptype ig5 return-p) (car ps)
	 (declare (ignore ig1 ig2 ig3 ig4 ig5))
	 (format stream " (make-instance 'ocl-parameter :parameter-name ~A :parameter-type '~S"
		 (if pname (format nil "'~S" pname) "NIL")
		 ptype)
	 (format stream "~%                        :parameter-return-p ~S)"
		 return-p))
       (when (cdr ps) (format stream "~%         ")))
  (format stream ")~%"))

(defmethod full-pkg-info ((version (eql #.*cmpkg*)) package tpkg)
  "Return a list of symbols, starting at root of the package structure
   that ends with PACKAGE-INFO."
  (labels ((fpi-aux (p accum)
	     (if-bind (owner (cmfuncall "%OWNER" p))
		      (fpi-aux owner (cons (intern (cmfuncall "%NAME" owner) tpkg) accum))
		      accum)))
    (fpi-aux package (list (intern (cmfuncall "%NAME" package) tpkg)))))
  

(defmethod pprint-prolog ((version (eql #.*cmpkg*)) stream tpkg model classes keep-pkg-info)
  "Write miscellaneous information."
  (format stream "~2%(in-package :mofi)~2%")
  (let ((*package* :mofi))
    (format stream
	    (strcat
	     "~%(with-slots (abstract-classes ns-uri ns-prefix) *model*"
	     "~%     (setf abstract-classes "))
    (format stream  "~%        '(~{~S~^~%          ~}))"
	    (loop for c in classes 
	       when (eql :true (cmfuncall "%IS-ABSTRACT" c))
	       collect (name-only-symbol c tpkg keep-pkg-info)))
    (format stream "~%     (setf ns-uri ~S)" 
	    (or (ns-uri model) 
		(format nil "http://modelegator.nist.gov/~A" tpkg)))
    (format stream "~%     (setf ns-prefix ~S))" 
	    (or (ns-prefix model)
		(string tpkg)))))
	  
(defmethod pprint-ensure-model ((p population))
  "pprint (what is roughly) the ensure-model form, suitable for framing."
  (with-slots (ns-prefix ns-uri documentation) p
    (pprint
     `(mofi:ensure-model ,(kintern ns-prefix) :force t :verbose t
			 :features '(:miwg)
			 :nicknames '(,ns-prefix ,ns-uri)
			 :depends-on-models '(:ocl)
			 :documentation ,documentation
			 :model-class ',(if (profile-p p) 'mofi::profile 'mofi:essential-compiled-model)
			 :ns-prefix ,ns-prefix
			 :ns-uri ,ns-uri
			 :classes-path 
			 (pod:lpath 
			  :models
			  ,(format nil "~A.lisp" ns-prefix))))))

(defmethod calculate-cpl-thru-%general ((class #.(cmsym "Class")))
  "Return the CLP for CLASS (a UML:Class) using the %general derived attribute."
  (let ((accum (list class)))
    (labels ((cpl (c)
	       (if (null c)
		   nil
		   (when-bind (gens (remove-if #'(lambda (x) (typep x 'mm-type-mo)) 
					       (ocl:value (cmfuncall "%GENERAL" c))))
		     (setf accum (append accum gens))
		     (mapcar #'cpl gens)))))
    (cpl class)
    (sort (remove-duplicates accum)
	  #'(lambda (x y) (member x (cpl y)))))))

(defmethod calculate-cpl-thru-%general ((class t))
  nil)

(defmethod pop-gen-fix-inheritances ((version (eql #.*cmpkg*)) (p population))
  "Where a class definition declares a class and superclasses of the class as
   direct superclasses, remove the superclasses (and warn)."
  (loop for c across (members p)
        when (typep c '#.(cmsym "Class")) do
       (fix-inherit-aux version c)))

;;; Note that it uses the derived slot general, but makes changes to ordinary slot generalization.
(defmethod fix-inherit-aux ((version (eql #.*cmpkg*)) c)
  "Remove redundant superclasses from the uml:Class.general slot."
  (when-bind (gens (cmfuncall "%GENERAL" c)) ; Added 2013-11-22. Probably the wrong thing to do...I'm lost!
    (let ((gens (remove-if #'(lambda (x) (typep x 'mm-type-mo)) (ocl:value gens))))
      (when (cdr gens)
	(let ((cpls (mapcar #'calculate-cpl-thru-%general gens)))
	  ;; Each gen should contribute a CPL that isn't a subset of another CPL. 
	  (loop for g in gens
	     for cpl in cpls
	     for others = (remove cpl cpls) do
	       (when g ; gens from other profiles represented by their mm-type-mo.
		 (loop for o in others
		    when (every #'(lambda (x) (member x o)) cpl) do
		      (format t "~% Class ~A isn't needed in generalization to general ~A." c g)
		      (let ((ization (cmfuncall "%GENERALIZATION" c)))
			(setf (slot-value c '#.(cmsym "generalization"))
			      (make-instance 'ocl:|Set| 
					     :value 
					     (remove g (ocl:value ization)
						     :key #'(lambda (x) (cmfuncall "%GENERAL" x))))))))))))))


; (setf ppp (xml-document-parser (pod:lpath :data "bpmn/magicdraw/bpmn-profile-very-clean.xml")))
; (clean-md ppp)
; (xmlu:write-node ppp *standard-output*)
#+nil
(defun clean-md (xml-doc)
  "Clean MagicDraw BPMN XMI (19MB) of associations and icons."
  (depth-first-search 
   xml-doc
   #'fail
   #'xml-children
   :do #'(lambda (node)
	   (when (dom:element-p node)
	     (setf (xml-children node)
		   (remove-if #'(lambda (x)
				  (or 
				   (xml-typep x "icon")
				   (xml-typep-3 x '|http://schema.omg.org/spec/XMI/2.1|::|Association|)
				   (and (dom:element-p x)
					(string= "MagicDraw_Profile" (xml-prefix (xml-name x))))))
			      (xml-children node)))))))
   




				
