
(in-package :ptypes)

;;; Puppose: Define primitive types for integration with lisp (typep) and 
;;;          models (UML, MOF) that need these.

(defclass |Ptype-type-proxy| (standard-class) ; POD !!!!
   ((|proxy-name| :reader %proxy-name :initarg :proxy-name)))

#+sbcl
(defmethod validate-superclass ((class |Ptype-type-proxy|) (superclass standard-class))
  t)

(defmethod print-object ((obj |Ptype-type-proxy|) stream)
  (with-slots (|proxy-name|) obj
    (format stream "{PTYPE ~A}" |proxy-name|)))

;;; These methods are to make this fake thing look like an M2 class too.
(defmethod mofi:enum-values ((obj |Ptype-type-proxy|)) nil)
(defmethod mofi:abstract-p ((obj |Ptype-type-proxy|)) nil)
(defmethod mofi:primitive-type-p ((obj |Ptype-type-proxy|)) t)
(defmethod mofi:mapped-slots ((obj |Ptype-type-proxy|)) nil)
;;; 2008-06-18
(defmethod class-direct-subclasses ((obj |Ptype-type-proxy|)) nil)
(defmethod mofi:%of-model ((obj |Ptype-type-proxy|)) (mofi:find-model :ptypes))
(defmethod mofi:of-model ((obj |Ptype-type-proxy|)) (mofi:find-model :ptypes))

(defmacro deftype-ptype (name)
  (with-gensyms (obj)
  `(unless (find-class ',name nil) ; avoid duplicates types
     (setf (get ',name 'mofi:mof-type-proxy) t) ; so mofi:mapped-slots doesn't process.
     (let ((,obj (make-instance '|Ptype-type-proxy| :proxy-name ',name :name ',name))) ; 2010-10-03 added :name
       (setf (get ',name 'mofi:mof-type-proxy) ,obj)
       (vector-push ,obj (mofi:types (mofi:find-model :ptypes)))
       (setf (find-class ',name) ,obj)))))

;;;================ Primitive Types ================
(deftype-ptype |String|)
(deftype |String| () 'string)
(deftype-ptype |Integer|)
(deftype |Integer| () 'integer)
(deftype-ptype |Real|)
(deftype |Real| () 'number)

(deftype-ptype |UnlimitedNatural|)
(deftype |UnlimitedNatural| () '(or integer (member :*)))

(deftype-ptype |Boolean|)
(deftype |Boolean| () '(member :true :false))

(setf (slot-value (mofi:find-model :ptypes) 'mofi:types)
      (make-array 5
		  :fill-pointer 5
		  :initial-contents
		  (list
		   (find-class 'ptypes:|Boolean|)
		   (find-class 'ptypes:|String|)
		   (find-class 'ptypes:|Integer|)
		   (find-class 'ptypes:|UnlimitedNatural|)
		   (find-class 'ptypes:|Real|))))

(setf (slot-value (mofi:find-model :ptypes) 'mofi:packages)
      (list
       (make-instance 'mofi:mm-package-mo
		      :of-model (mofi:find-model :ptypes)
		      :name "PTYPES"
		      :owned-element
		      (list
		       (find-class 'ptypes:|Boolean|)
		       (find-class 'ptypes:|String|)
		       (find-class 'ptypes:|Integer|)
		       (find-class 'ptypes:|UnlimitedNatural|)
		       (find-class 'ptypes:|Real|)))))

		  
