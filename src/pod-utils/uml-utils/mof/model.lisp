
;;; Purpose: Model management -- collects all the details of the model (the files defining it,
;;;          the package in which it resides, other files that must be loaded with it).     

(declaim #+sbcl(sb-ext:muffle-conditions style-warning))

(in-package :mofi)

(defparameter *essential-model-names* '(:PTYPES :OCL :MOFI :QVT :CMOF :PCMOF :UML211 :UML22 :UML23 :UML241 :uml25 :uml4sysml12
					:SYSML12 :SYSML13  :SYSML14 :QUDV :OPL :ODM :RDF-PROFILE :OWL-PROFILE :RDF-LIBRARY
					:XSD-LIBRARY :OWL-LIBRARY
					:UML-PROFILE-L2-20090901 :UML-PROFILE-L2-20110701 :UML-PROFILE-20131001 ; not L2 any more
					:FUML :ALF :BPMN :BPMN-P :BPMNPRO :UPDM :UPDM21 :PPLAN
					:ISO15926-2 :SOAML :MMT-TEMPLATES :EMERSON-TEMPLATES :MMTC
					:UPR :UPRA
					"15926-2" 
                                        "AP233" "ODM" "MEXICO" "MOSScm" :ECM
					"MMM" "ORDERS" "DELFOR" "DELJIT" "DESADV" "INVOIC" "CATAIR" "204" 
                                        "IFTMIN" "IFTMBF" "IFTMBC" "IFTMCS" "CUSCAR" "309" "IFTMAN" "IFTSTA"
					"RECADV" "315" "214" "EDI"  "MossDataElements" "315" :TC3-PROFILE
					:DES)
  "Names of models that the running system keeps, and cannot be modified by the user. ")

(defvar *essential-models* nil "A list of models that are shared among users.")

(defvar *models* nil "Dynamically bound to a user's list of models. Used by find-model, at least.")

(eval-when (:compile-toplevel :load-toplevel :execute)
(let ((unique-names (make-hash-table :test #'equal)))
  (defun unique-name (name)
    "A slight nicer version of gensym (lower numbers, sequential on NAME)."
    (let ((name (string name)))
      (if-bind (count (gethash name unique-names))
	       (progn
		 (setf (gethash name unique-names) (1+ count))
		 (format nil "~A-~A" name (1+ count)))
	       (progn 
		 (setf (gethash name unique-names) 0)
		 name)))))
)

;;;===============================================================================================
;;; Model definition - a container for types, constraints and operations. 
;;; The concrete types:
;;;    - COMPILED-MODEL : anything model read in (XMI, or EXPRESS Schema). It defines types.
;;;    - ESSENTIAL-COMPILED-MODEL : a compiled model read in at system initialization. Retained
;;;                                 by the system, because it is part of the system (UML, SysML, etc).    
;;;    - ESSENTIAL-LEXICAL-MODEL  : an essential-compiled-model that also records grammatical properties 
;;;                                 of the Mn+1 model for use in parsing of Mn models. 
;;;    - POPULATION               : An model whose elements are instances of another model.
;;;                                 It does not define types. It has 'members' that are instances
;;;                                 of its Population.model-n+1
;;;===============================================================================================
(defclass abstract-model () 
  (;; The name of the model. It is set by initialization code, not directly. 
   (model-name :reader model-name :initarg :name :initarg :force)
   ;; An alternative name, typical of QVT mapping
   (nicknames :accessor nicknames :initarg :nicknames :initform nil)
   ;; Models that this model depends on. 
   (documentation :initform "" :initarg :documentation)
   ;; Types inherited by this model.
   (inherited-types :reader inherited-types :initform #())
   ;; Mostly documentation, the thing read to create the model. 
   (source-file :initarg :source-file :initform nil)
   ;; Models which this one makes reference to for definitions of types. 
   (depends-on-models :reader depends-on-models :initform nil :initarg :depends-on-models)
   ;; Lisp package object in which symbols in this model are interned. 
   (lisp-package :accessor lisp-package :initform nil
		 :initarg :package-use-list :initarg :shadow-list :initarg :shadowing-import-from)
   ;; An object that collects information about errors found in the model, relations
   ;; between object created and the xmi read, etc. See mofi::processing-results.
   (processing-results :accessor processing-results :initarg :processing-results :initform nil)
   ;; Populations of CMOF and profiles have these, Look for <cmof:Tag name="org.omg.xmi.nsPrefix" .../>
   (ns-prefix :reader ns-prefix :initform nil :initarg :ns-prefix)
   ;; Populations of CMOF and profiles have these, Look for <cmof:Tag name="org.omg.xmi.nsURI" .../>
   ;; Unlike cl:package nicknames, this doesn't have to be unique. 
   (ns-uri :reader ns-uri :initform nil :initarg :ns-uri)
   ;; URI by which other metamodels may reference this one. 
   (href-uri :reader href-uri :initform nil :initarg :href-uri)
   ;; Names of types of model (e.g. "UML") -- can't use package nicknames for this because duplicates.
   (model-types :reader model-types :initarg :model-types :initform nil)
   ;; The model to which this population conforms (excluding extending profiles)
   (model-n+1 :reader model-n+1 :initform nil :initarg :model-n+1))
  (:default-initargs 
      :force nil :shadow-list nil 
      :shadowing-import-from '(:ocl "Boolean" "String" "Integer" "UnlimitedNatural" "Real")
      :name (unique-name "UNNAMED-MODEL")))

;;; POD Remember :afters are least-specific first. Good. 
(defmethod initialize-instance :after ((m abstract-model) &key name force)
  "Set the model's name."
  (when (member (string name) '("CL" "POD") :test #'string=)
    (error "Invalid model name: ~A" name))
  (with-slots (model-name depends-on-models) m
    (setf depends-on-models 
	  (mapcar #'(lambda (s) (if (typep s 'abstract-model) s (find-model s)))
		  depends-on-models))
    (setf model-name (if force name (unique-name name)))))

(defmethod print-object ((obj abstract-model) stream)
  (with-slots (model-name) obj
    (format stream "#<Model ~A (abstract)>" model-name)))

;;; A model that defines a new lisp package. The Abstract-model.lisp-package
;; is set to this new package (typically named by Abstract-model.name
(defclass interning-model-mixin ()
  ())

(defmethod initialize-instance :after ((m interning-model-mixin) &key force
				       (package-use-list '(:cl :pod :ptypes :ocl :mofi))
				       shadow-list shadowing-import-from 
				       nicknames)
  (with-slots (lisp-package model-name) m
      (unless force (warn "An interning model, ~A, is not creating a package???" model-name))
;;; Hyperspec (delete-package):
;;;    "The package object is still a package (i.e., packagep is true of it) 
;;;     but package-name returns nil. ...The consequences of invoking any other 
;;;     package operation on package once it has been deleted are unspecified."
      (when-bind (p (find-package model-name)) 
	(unless (or (eql p (find-package :mofi)) 
		    (eql p (find-package :ptypes)) 
		    (eql p (find-package :ocl)) 
		    (member p 
			    (remove-if #'null
				       (mapcar #'(lambda (x) 
						   (when-bind (m (find-model x :error-p nil))
						     (lisp-package m)))
					       *essential-model-names*)))
		    #+qvt(typep m (intern "QVT-POPULATION" :qvt))) ; 2014 Not necessary, but often the *current-package*, so...
	  (delete-package p)))
      (let ((package (or (find-package model-name) (make-package model-name :nicknames nicknames))))
	(setf lisp-package package)
	(when shadow-list (shadow shadow-list package))
	(when shadowing-import-from 
	  (let* ((from-package (find-package (car shadowing-import-from)))
		 (symbols (mapcar #'(lambda (x) (intern x from-package)) (cdr shadowing-import-from))))
	    (shadowing-import symbols package)))
	(shadowing-import '(%of-model %defined-at %token-position %source-elem %debug-id) package)
	(use-package package-use-list package))))


;;; A "model" such as XMI, which describes an exchange form.
;;; Currently this does nothing more than defines a package
;;; and its nicknames
(defclass exchange-model (abstract-model interning-model-mixin)
  ())

(defmethod print-object ((obj exchange-model) stream)
  (with-slots (model-name) obj
    (format stream "#<Model ~A (exchange)>" model-name)))

;;; A model whose native representation is used to produce the implementational model.
;;; ...at least that's the idea. I might hand-write the models in the -paths too.
;;; Examples: MOF, UML, SysML (which are also essential-compiled-model)
(defclass compiled-model (abstract-model interning-model-mixin)
  (;; Types defined by this model.
   (types :reader types :initform (make-array 200 :adjustable t :fill-pointer 0))
   ;; Associations defined by this model.
   (assocs :reader assocs :initform (make-array 200 :adjustable t :fill-pointer 0))
   ;; Association-owned ends (properties) defined by this model.
   (assoc-ends :reader assoc-ends :initform (make-array 200 :adjustable t :fill-pointer 0))
   ;; Types inherited by this model.
   (inherited-types :initform (make-array 200 :adjustable t :fill-pointer 0))
   ;; A list of mm-package-mo that organize the types into packages. 
   (packages :initform nil :reader packages)
   ;; Path to file defining UML (typically created by uml2clos.lisp or cmof2clos.lisp).
   (classes-path :initarg :classes-path :initform nil)
   ;; Path to file defining OCL constraints. These are created from OCL-synax
   ;; definitions defined in the model in classes-path. And written by ppclos.lisp.
   (constraints-path :initarg :constraints-path :initform nil)
   ;; Path to file of stuff needed to be done before loading.
   (preload-path :initarg :preload-path :initform nil)
   ;; Path to file of stuff needed to be done after loading. This might go away. 
   (postload-path :initarg :postload-path :initform nil)
   ;; Strings naming operators (OCL operators and operators called in constraints, for example). 
   (operator-strings :initarg :operator-strings :accessor operator-strings :initform nil)
   ;; A list of names of abstract classes, used to set the class's abstract-p slot. 
   ;; pod should be called abstract types... better, should not be recorded.
   (abstract-classes :initform nil)
   ;; An list of direct slot objects that are declared derived, but for which no derivation specified.
   (derived-slots-no-fn :reader derived-slots-no-fn :initform nil)
   ;; pretty-name: can't make it a nickname because of possible package collisions
   (pretty-name :reader pretty-name :initform nil :initarg :pretty-name)))

(defmethod print-object ((obj compiled-model) stream)
  (with-slots (model-name types) obj
    (format stream "#<Model ~A types:~A>" model-name 
	    (fill-pointer types))))

;;; Models that the running system keeps, and cannot be modified by the user. 
(defclass essential-model-mixin (interning-model-mixin)
  ())


(defmethod initialize-instance :after ((m essential-model-mixin) &key)
  (with-slots (model-name) m
    (unless (member (string model-name) *essential-model-names* :test #'string=)
      (error "Invalid model name: ~A" model-name))
    (setf *essential-models* (remove model-name *essential-models* :key #'model-name :test #'equal))
    (pushnew (kintern model-name) *features*)
    (push m *essential-models*)))

;; A model which has these lexical properties (e.g. PTYPES, QVT, EXPRESS). 
(defclass lexical-model-mixin () ; pod7 was %%scope
  (;; Reserved words of concrete syntax (used in OCL, QVT, for example)
   (reserved-words :reader reserved-words :initarg :reserved-words :initform nil)
   ;; Constant string of the concrete syntax (used in OCL, for example)
   (constant-strings :reader constant-strings :initarg :constant-strings :initform nil)))

;;; Examples: MOF, UML, SysML
(defclass essential-compiled-model (compiled-model essential-model-mixin) ())

(defvar +MOF+ (make-instance 'essential-compiled-model :name :MOFI :force t))

(defvar *model* +MOF+
  "Dynamically bound to the current model, but for bootstrapping, set to the M3 model.")

(defvar *population* nil "Dynamically bound to a population, in situations where *model*
   may be bound to the Mn+1 model. DO NOT SETF THIS.")

;;; A model whose mm-type-mo's are specialized to mm-type-mo--select so that
;;; it can handle the intensively duplicated references to supertypes found
;;; in mapping select types to classes. 
(defclass essential-compiled-select-model (essential-compiled-model) ())

;;; MEXICO, QVT, OCL, ALF
(defclass essential-lexical-model
    (essential-compiled-model lexical-model-mixin) ())

;;; A Population is a Model whose instances (Population.members) are governed by another model. 
;;; The model that 'govern' this model is the Model in its model-n+1 slot (only one).
;;; also be a model in its Model.depends-on-models slot. 
(defclass population (abstract-model)
  (;; The model xmi
   (model-xmi :reader model-xmi :initform nil :initarg :model-xmi)
   ;; profile extensions (href strings describing them)  to which the population conforms.
   (profiles-used :reader profiles-used :initform nil :initarg :profiles-used)
   ;; The instances comprising the model.
   (members :reader members :initform (make-array 300 :adjustable t :fill-pointer 0))
   ;; A function called, when 'instance tracking', to install the instance somewhere.
   ;; A function of one argument, the instance.
   (instance-install-fn :reader instance-install-fn :initarg 
			:instance-install-fn :initform #'population-install-fn)
   (soft-opposites :initform (make-hash-table :test 'equal) :reader soft-opposites)
   ;; Some arguments to control reading (passed through ensure-model, e.g. for cre/15926-2).
   (read-args :initarg :read-args :initform nil)))

(defmethod initialize-instance :after ((m population) &key read-args)
  "Populations look to the lisp package of the model-n+1, primarily."
  (with-slots (lisp-package model-n+1 source-file model-name) m
    (unless (typep m 'interning-model-mixin)
      (setf lisp-package (lisp-package model-n+1)))
    ;; This is so that we can use ensure-model in essential-load.lisp
    ;; Used particularly for MIWG reference xmi. 
    (when (and source-file (member model-name *essential-model-names*))
      (setf *essential-models* (remove model-name *essential-models* :key #'model-name :test #'equal))
      (push m *essential-models*)
      ;; For exp-populations this one doesn't do much. 
      ;; 2010-05-29: Used to get model-n+1, now that is 'discovered' by xmi2model-instance. 
      (apply #'xmi2model-instance :file source-file :pop-obj m read-args))))

(defun population-install-fn (obj)
  "A function called by initialize-instance :after -- this one installs OBJ
   in Population.members slot."
  (vector-push-extend obj (members *population*)))

(defmethod print-object ((m population) stream)
  (with-slots (model-name model-n+1 members) m
    (format stream "#<Population ~A (of ~A) members:~A>" 
	    model-name 
	    (model-name model-n+1)
	    (fill-pointer members))))

;;; POD Still quick an dirty.
(defmethod profile-p ((m population))
  "Return T if the population describes a profile."
  (when-bind (e (aref (members m) 0))
    (string= "Profile" (class-name (class-of e)))))

(defclass privileged-population (population essential-model-mixin)
  ())

;;; A population created from the valid.xmi of a MIWG test case. 
(defclass tc-population (population) 
  ())

(defmethod print-object ((m tc-population) stream)
  (with-slots (model-name model-n+1 members) m
    (format stream "#<TC-Population ~A (of ~A) members:~A>" 
	    model-name 
	    (model-name model-n+1)
	    (fill-pointer members))))

;;; OCL parsing, where *in-scope-model* legitimately includes populations, 
;;; because these can define new operator-strings. 
;;; (In QVT, for example, operator-strings are defined by the population being
;;; the user's qvt transformation defs). But by definition, they don't define types. 

(defvar +empty-array+ (make-array 100 :adjustable t :fill-pointer 0))
(defmethod types ((m population)) +empty-array+)

(defclass abstract-profile ()
  ())

(defclass profile (essential-compiled-model abstract-profile)
  ;; for simplicity, this will remain a symbol naming a model for find-model (e.g. :uml25)
  ((model-n+1 :initarg :model-n+1 :reader model-n+1)))

;;;; a user-profile is not a profile because it isn't essential (bad names!)
(defclass user-profile (compiled-model abstract-profile)
  ;; URI used for href referencing of the profile. See also href-uri on defclass model
   ((href-uri :reader href-uri :initform "" :initarg :href-uri)
   ;; Population will be available and useful for resolving hrefs. 
   (from-population :reader from-population :initarg :from-population :initform nil)))

(defmethod print-object ((obj profile) stream)
  (with-slots (model-name types) obj
    (format stream "#<Profile ~A types:~A>" model-name 
	    (fill-pointer types))))

(defun ensure-model (suggested-name &rest initargs &key (model-class 'compiled-model) verbose
		     suppress-load (features '(:always)) inherit-from &allow-other-keys)
  "If model with name NAME exists, remove it. make-instance with INIT-ARGS. Return new Model"
  (let ((mk-args (loop while initargs for key = (pop initargs) for val = (pop initargs)
		       unless (member key '(:model-class :suppress-load :features :inherit-from :verbose))
		       collect key and collect val)))
    (when (or (intersection features *features*)
	      (member :always features))
      ;(format t "~2%=================== Loading model ~A ===================~2%" suggested-name)
      (let ((m (apply #'make-instance model-class :name suggested-name mk-args)))
	;; 2009-02-25 I add this to remove same-name model.
	(setf *models* (remove (model-name m) *models* :key #'model-name :test #'equal))
	(push m *models*) ; 2009-02-25 was pushnew. I don't know why.
	(when (eql :mofi suggested-name) (setf +mof+ m))
	(unless suppress-load (load-model m :inherit-from inherit-from :verbose verbose))
	m))))

(defgeneric load-model (model &key &allow-other-keys))

(defmethod load-model :around ((m abstract-model) &key verbose)
  "Start or start over loading definitions of model NAME (a keyword)."
  (clear-model m)
  (let ((*model* m))
    (declare (special *model*))
    (call-next-method)
    (when verbose
      (format t "~2%=================== Loaded model ~A ===================~2%" m))))

(defmethod load-model :around ((m compiled-model) &key)
  (let ((*model* m))
    (declare (special *model*))
    (with-slots (postload-path) m
      (call-next-method) 
      (when postload-path (load postload-path)))))

(defmethod load-model ((m compiled-model) &key inherit-from)
  "Do class- and assoc-related initialization."
  (let ((*package* (lisp-package m)))
    #-sbcl(declare (special *package*))
    (with-slots (preload-path classes-path) m
      (when preload-path (load preload-path)) ;pod8 moved here from the :around method
      (when classes-path 
	(load classes-path) ; little reason to compile it -- no code.
	;; Do this before class-finalize-slots. Needed to make accessors.
	(set-derived-slot-no-fn m)
	(load-model-compiled-finalize-classes m)
	(when inherit-from (load-model-compiled-import-readers m inherit-from))
	(load-model-compiled-resolve-owners m)
	(load-model-compiled-resolve-assocs m)
	(unless (or (eql m +mof+)              ;; ocl:compile-constraints not yet defined
		    (eql m (find-model :ocl))) ;; (and no constraints anyway).
	  (let ((oclp:*in-scope-models* (list (find-model :ocl) (find-model :ptypes) m)))
	    (declare (special oclp:*in-scope-models*))
	    (loop for class across (types m) 
	       do (ocl:compile-operations class)
	       do (ocl:compile-constraints class)))
	  (loop for class across (types m) 
	     do (make-soft-opposite-readers class))))
      m)))

(defun load-model-compiled-finalize-classes (m)
  "Sets Model.types Finalize classes."
  (with-slots (types abstract-classes) m
    (loop for class across types
       do (class-finalize-slots class))
    (loop for class across types do
	 (update-subsetted-properties-from-redefinition class) ; 2009-07-27
	 (compute-derived-union-sources class))
    ;; pod7 can't this go away? Replace with abstract-p on the class?
    (loop for cname in abstract-classes
       do (setf (abstract-p (find-class cname)) t))))

(defun load-model-compiled-import-readers (m inherit-from)
  "Import reader methods from Models this Model inherits from."
  (loop for im-name in inherit-from
     for im = (find-model im-name) 
     with ivec = (inherited-types m) 
     with pkg = (lisp-package m) do
       (loop for ty across (types im) do
	    (vector-push-extend ty ivec)
	    (loop for slot in (closer-mop:class-direct-slots ty) do
		 (import (car (closer-mop::slot-definition-readers slot)) pkg)))))

(defun load-model-compiled-resolve-owners (m)
  "Resolve package owners and ownedElement"
  (with-slots (packages) m
    (loop for p in packages do
	 (with-slots (owner owned-element) p
	   (when (and owner (symbolp owner))
	     (setf owner (or (find-class owner nil) (find owner packages :key 'name))))
	   (unless (class-p (car owned-element))
	     (setf owned-element
		   (mapcar #'(lambda (x)
			       (or (find-class x nil) 
				   (find x packages :key 'name)))
			   owned-element)))))))

(defun load-model-compiled-resolve-assocs (m)
  "Link associations to association-ends."
  (with-slots (assocs assoc-ends) m
    (loop for a across assocs do
	 (with-slots (owned-ends) a
	   (setf owned-ends
		 (loop for oe in owned-ends
		       for end = (find (car oe) assoc-ends :key #'xmi-id :test #'string=)
		       unless end do (error "No such association end: ~A" (car oe))
		       collect end))))
    (loop for ae across assoc-ends 
	  for a = (find (association ae) assocs :key #'xmi-id :test #'string=)
          unless a do (error "No such association: ~A" (association ae))
	  do (with-slots (association) ae (setf association a)))))


;;; POD The problem with this def-mm-class identifies what is specialized, 
;;; which might be another stereotype, rather than the class extended.
;;; The direct-superclasses of these objects (specializing another stereotype) is wrong,
;;; as is the extended-metaclasses.
(defmethod load-model :after ((m abstract-profile) &key)
  "Iterate through extended-metaclasses slot, which currently contains symbols or nil
   and replace those with all direct and inherited objects from the extended-metaclasses slot."
  (with-slots (types) m
    (loop for stype across types
	  when (stereotype-p stype) do
	  (let ((metaclasses
		 (mapcar #'(lambda (x) (if (symbolp x) (find-class x) x))
			 (loop for c in (closer-mop:class-precedence-list stype)
			       when (stereotype-p c) append (extended-metaclasses c)))))
	    (setf (slot-value stype 'extended-metaclasses) (remove-duplicates metaclasses))
	    ;; I make these now only so there is something to look at in the browser
	    ;; even before a file is loaded. There will possibly be more of these created
	    ;; through reading files.
	    ;; 2011-04-26 Forget it
	    #|(loop for m in metaclasses do
		  (find-programmatic-class m stype))|#))))

;;; pod7 I don't know what it wrong here. 
;;; Error says I'm getting a list for slot-definition-source but I don't see it.
(defmethod set-derived-slot-no-fn ((m compiled-model))
  "This set the slot Model.derived-slot-no-fn, which is used in the changelog
   and in generating the reader method on the slot."
  (with-slots (derived-slots-no-fn) m
    (setf derived-slots-no-fn
;	  (sort 
	   (loop for class across (types m) append
		 (loop for slot in (closer-mop:class-direct-slots class)
		       when (and (slot-definition-is-derived-p slot)
				 (not (slot-definition-is-derived-union-p slot))
				 (not (member (format nil "~A.1" (closer-mop:slot-definition-name slot))
					      (type-operations class)
					      :key #'operation-name
					      :test #'string=)))
		       collect slot)))))
;	   #'string<
;	   :key #'(lambda (x) (string (class-name (slot-definition-source x))))))))

(defmethod evaluate-defaults ((m compiled-model))
  "Some defaults are lisp forms that cannot be evaluated during load (they may reference
   a class that has not yet been defined) evaluate these now.")
  

(defmethod load-model :around ((m lexical-model-mixin) &key)
  (let ((*model* m))
    (declare (special *model*))
    (with-slots (reserved-words lisp-package) m
      (loop for word in reserved-words do 
	    (export (intern word lisp-package) lisp-package)))
    (call-next-method)))

(defmethod load-model ((m abstract-model) &key) m)

(defun record-mapped-slots-cpl-order (class)
  "Set the class's mapped-slots slot to non-hidden slots listed in
   class precedence list-, and then alphabetical-, order."
  (let ((cpl (closer-mop:class-precedence-list class)))
    (setf (slot-value class 'mapped-slots)
	  (sort (remove-if #'slot-definition-xmi-hidden
			   (closer-mop:class-slots class))
		#'(lambda (x y)
		    (let ((pos-x (position (slot-definition-source x) cpl))
			  (pos-y (position (slot-definition-source y) cpl)))
		      (cond ((null pos-x) nil) ; error, warned above?
			    ((null pos-y) nil) ; error, warned above?
			    ((<  pos-x pos-y) t)
			    ((>  pos-x pos-y) nil)
			    (t (string< (closer-mop:slot-definition-name x) 
					(closer-mop:slot-definition-name y))))))))))

(defun record-soft-opposites (class)
  "Set the class's soft-opposite-slots to a list of form ((slot-name . source-class)...)
   This information can be used, for example, to speed up instance-reader post-processing."
  (let ((pkg (lisp-package (of-model class))))
    (with-slots (soft-opposite-slots) class
      (loop for slot in (mapped-slots class) do
	   (when-bind (soft (slot-definition-soft-opposite slot))
	     (pushnew (cons slot (intern (strcat "%" (string-upcase (c-name2lisp (string (second soft))))) pkg))
		      soft-opposite-slots :test #'equal))))))

(defmethod clear-model :around ((m compiled-model))
  "Clean up most knowledge of the model (stuff that came from reading its XMI) 
   Returns model."
  (loop for c across (types m) do
	(setf (type-operations c) nil)
	(setf (type-constraints c) nil))
  (call-next-method))

(defmethod clear-model :around ((m user-profile))
  (declare (ignorable m))
  ;(with-slots (classes-path) m (setf classes-path nil))
  )

(defmethod clear-model ((m abstract-model)) m)
(defmethod clear-model ((m lexical-model-mixin)) m)
(defmethod clear-model ((m population)) (with-slots (members) m (setf (fill-pointer members) 0)) m)
(defmethod clear-model ((m compiled-model))
  (with-slots (types) m
    (setf (fill-pointer types) 0))
  m)

(defmethod unintern-model ((m abstract-model))
  "Make sure the classes generated by model M are never again found."
  (with-package-iterator (generator-fn (lisp-package m) :external)
    (loop     
       (mvb (more? symbol acc pkg) (generator-fn)
	 (declare (ignore acc pkg))
	 (unless more? (return))
	 (when (find-class symbol nil)
	   (setf (find-class symbol) nil))))))

(defmethod unintern-model ((m population))
  "Avoids doing the symbol unintern of the method on abstract-model"
  ())

;;; The *models* thing is used extensively by the mof-browser. Seems to be lexically bound. 	 
;;; 2012-10-30 Added :use-ns-prefix. Now this could reall be cleaned up!
(defun find-model (id &key (models (append *essential-models* *models*)) 
		           (error-p t) 
                           (session-too nil))
  "Return the model object with NAME, or NICKNAME, or which has package (think MEXICO) PKG."
  (when session-too 
    (with-vo (session-models) (setf models (append models session-models))))
  (if-bind (model 
	    (or (find id models :key #'model-name :test #'string=)
		(find id models :key #'nicknames 
		      :test #'(lambda (x y) (member x y :test #'string=)))))
	   model
	   (when error-p (error "Cannot find model ~A" id))))

(defun modern-uml () ; Should only used in diagnostics!
  "Return the model-name of the preferred UML version. 
   Modern-uml is used in the UML browser, for example." 
  :uml241)

;;; This is used for order they are displayed in the 'class browser' too.
(defun all-umls ()
  "Returns loaded UMLs, most recent FIRST."
  '(:uml25 :uml241 :uml23))

(defun canonical-files ()
  "Returns a sorted list of the file names found in the canonical directory, 
   where only those of form tc<number> are returned."
  (let ((cvs (namestring (pod:lpath :testlib "pod-utils/uml-utils/models/miwg/canonical/CVS/"))))
    (sort 
     (remove-duplicates
      (remove-if-not 
       #'(lambda (x) (cl-ppcre:scan "^tc\\d+[a-z]?(-profile)?$" x))
       (mapcar #'pathname-name
	       (remove-if #'(lambda (x) (string= cvs (namestring x)))
			  (cl-fad:list-directory (pod:lpath :testlib "pod-utils/uml-utils/models/miwg/canonical/")))))
      :test #'string=)
     #'<
     :key #'(lambda (x) 
	      (read-from-string
	       (mvb (success vec) (cl-ppcre:scan-to-strings "^tc(\\d+)[a-z]?(-profile)?$" x)
		 (declare (ignore success))
		 (aref vec 0)))))))

(defun find-tc-canonical (name)
  "Return the filename for NAME (which is 'tc1' 'tc2'...) naming a 
   testcase valid canonical XML file."
  (probe-file
   (merge-pathnames 
    (make-pathname :name (string-downcase (string name)) :type "xmi")
    (pod:lpath :testlib "pod-utils/uml-utils/models/miwg/canonical/"))))

(declaim #+sbcl(sb-ext:unmuffle-conditions style-warning))
