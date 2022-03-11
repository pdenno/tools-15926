
(in-package :mofi)

;;; Purpose: Stuff that would go in mof.lisp but for loading problems!

;;; Problem: I'd like mm-root-supertype to have as its metaclass an abstract metaclass that 
;;; has subclasses for classes, enumerations, datatypes and primitives. 
;;; However, these instances are instances of the subclasses mm-class-mo  mm-enum-mo etc, and
;;; the implementation doesn't seem to understand that this is OK. (Maybe it isn't!).
;;; The root type metaclass is what is used in the def-whatever.
;;; What if (and this is ugly) I just have four disjoint metaclasses, and four mm-class-supertype,
;;; etc. with their methods? 

;;; Everything made with def-mm-class is one of these. N.B. When this is evaluated,
;;; *model* should be set to +MOF+ (which should be #<Model MOF>). The slots (and accessors?)
;;; land in mofi. 2010: Why do I do this?

(defvar *mm-debug-id* 0 "A non-thread-specific annotation for debugging.")

(setf *model* +mof+) ;; 2012-01-15 This is essential!

#-cre
(def-mm-class mm-root-supertype :mofi (:none)
  "Every MOF-based object (class, primitive, datatype, enumeration) has this a superclass."  
   ;; The Model object ot which this class belongs."
   ((|of-model| :range T :multiplicity (1 1) :xmi-hidden T :initarg :of-model)
    ;; line number tracking, from parsing
    (|defined-at| :range T :multiplicity (1 1) :xmi-hidden T :initarg :defined-at)
    ;; file-position tracking, from parsing
    (|token-position| :range T :multiplicity (1 1) :xmi-hidden T :initarg :token-position)
    ;; xmi XML element, from XML parsing
    (|source-elem| :range T :multiplicity (1 1) :xmi-hidden T :initarg :source-elem)
    ;; xmi XML element, from XML parsing
    (|sort-name| :range T :multiplicity (1 1) :xmi-hidden T :initarg :sort-name)
    ;; integer incremented with each object initialized.
    (|debug-id| :range T :multiplicity (1 1) :xmi-hidden T :initarg :debug-id)
    ;; Next two added 2014-08-18. obj-id for turtle, uuid for modelegator
    ;; xmi XML element, from XML parsing
    (|obj-id| :range T :multiplicity (1 1) :xmi-hidden T :initarg :obj-id)
    (|uuid| :range T :multiplicity (1 1) :xmi-hidden T :initarg :uuid)))


;;; 2014-04-26 Why isn't the CRE one a subtype? (And why stink-up this file with it?)

#+cre
(def-mm-class mm-root-supertype :mofi (:none)
  "Every MOF-based object (class, primitive, datatype, enumeration) has this a superclass."  
  ;; The Model object ot which this class belongs."
  ((|of-model| :range T :multiplicity (1 1) :xmi-hidden T :initarg :of-model)
   ;; line number tracking, from parsing
   (|defined-at| :range T :multiplicity (1 1) :xmi-hidden T :initarg :defined-at)
   ;; file-position tracking, from parsing
   (|token-position| :range T :multiplicity (1 1) :xmi-hidden T :initarg :token-position)
   ;; conditions associated with this instance that are identified during validation and reading
   (|conditions| :range T :multiplicity (1 1) :xmi-hidden T :initarg :conditions)
   ;; xmi XML element, from XML parsing
   (|source-elem| :range T :multiplicity (1 1) :xmi-hidden T :initarg :source-elem)
   ;; xmi XML element, from XML parsing
   (|obj-id| :range T :multiplicity (1 1) :xmi-hidden T :initarg :obj-id)
   ;; integer incremented with each object initialized.
   (|debug-id| :range T :multiplicity (1 1) :xmi-hidden T :initarg :debug-id)
   ;; Templates classes are created from template descriptions....
   (|tmpl-desc| :range T :multiplicity (1 1) :xmi-hidden T :initarg :tmpl-desc)))

;;; Added 2013-03-28 (San Antonio)
#-sbcl
(defmethod mofi:%debug-id ((obj t))
  (with-slots (|debug-id|) obj |debug-id|))


(defmethod initialize-instance :after ((obj mm-root-supertype) &key)
  "Set a few tracking slots in the object created, and perhaps track this instance."
  (with-slots (|of-model| |defined-at| |debug-id| |uuid|) obj
    (let ((m (or *population* *model*))) ; *population* if it is bound.
      (setf |of-model| m)
      (setf |defined-at| *line-number*)
      (setf |debug-id| (incf *mm-debug-id*))
      (setf |uuid| (new-uuid))
      (when (typep m 'population)
	(when-bind (install-fn (instance-install-fn m))
	  (funcall install-fn obj)))
      ;; Set default values
      (loop for slot in (mapped-slots (class-of obj))
	 for d-value = (slot-definition-default slot)
	 when d-value do
	   (let ((slot-name (closer-mop:slot-definition-name slot)))
	     (unless (slot-value obj slot-name)
	       (setf (slot-value obj slot-name) 
		     (if (consp d-value) 
			 (let ((val (eval d-value)))
			   (when-bind (slot (find "owner" (class-slots (class-of obj)) 
						  :key #'slot-definition-name :test #'string=))
			     (setf (slot-value val (slot-definition-name slot)) obj))
			   val)
			 d-value))))))))

;;; 2019: Mostly these are handled by umlxxx-postload.lisp
(defmethod print-object ((obj mm-root-supertype) stream)
  (let ((model (of-model (class-of obj))))
    (format stream "<~A:~A, id=~A>" 
	    (or (package-name (lisp-package model))
		(model-name model))
	    (class-name (class-of obj))
	    (%debug-id obj))))

;;; Added 2012-07-30 for searching for objects by xmi:id in lookup-href (TC19 multi-file model)
#-cre
(defmethod xmi-id ((obj mm-root-supertype))
  (when-bind (elem (%source-elem obj))
    (xmi-id elem)))

(defmethod uuid ((obj mm-root-supertype))
  (when-bind (elem (%source-elem obj))
    (uuid elem)))

(eval-when (:load-toplevel)
  (class-finalize-slots (find-class 'mm-root-supertype)))


