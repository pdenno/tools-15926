
(in-package :expo)


;;; Purpose: The superclass of all instantiated entity types. 
;;; This was moved from express-metaobjects because that file
;;; needed to be loaded before this could be evaluated.

(defclass entity-root-supertype ()
  ;; The P28 or XMI etc from which this object was defined. 
  ((mofi::|source-elem| :initform nil :accessor mofi:%source-elem :xmi-hidden T
	 :source entity-root-supertype)
   (mofi::|debug-id| :initform nil :accessor mofi:%debug-id :xmi-hidden T 
	 :source entity-root-supertype)
   (mofi::|sort-name| :initform nil :accessor mofi:%sort-name :xmi-hidden T 
	 :source entity-root-supertype))
  (:metaclass express-entity-type-mo))

(defmethod initialize-instance :after ((instance entity-root-supertype) &key)
  "New for 2009-05 merged MOF/Expresso usage."
  (when mofi:*population*
    (funcall (mofi:instance-install-fn mofi:*population*) instance)))

#+nil
(defmethod describe-object ((obj entity-root-supertype) stream)
  "This is a CL method. In LW, it will be called by the inspector, 
   because the inspector is unsure how to handle the metaclass."
  (format stream "~&Description of object ~S:~%" obj)
  ;(write-entity obj stream :p21)
  (loop for eslot in (class-slots (class-of obj))
        for name = (slot-definition-name eslot)
;       for sname = (slot-definition-simple-name eslot)
    do (format stream "~%  ~S:   ~A" 
	       name
	       (if (slot-boundp obj name)
		   (format nil "~S" (slot-value obj name))
		   "<Unbound>")))
  (terpri stream))

(defmethod print-object ((instance entity-root-supertype) stream)
  (declare (ignore instance))
  (if-debugging (:any 1)
      (write-entity instance stream :p21 :dataset (instance-dataset instance))
    (call-next-method)))

(defmethod schema ((instance entity-root-supertype))
  "Returns the schema to which the argument entity instance belongs."
  (symbol-name (schema (first (class-direct-superclasses (class-of instance))))))

;;; Set all the mapped slots to :?
(defmethod initialize-entity ((entity entity-root-supertype))
  (loop for slot in (mofi:mapped-slots (class-of entity)) do
        (setf (slot-value entity (slot-definition-name slot)) :?))
  entity)
