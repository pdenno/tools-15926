
;;; Purpose: Get thing rolling

(in-package :mofi)

(defmethod (setf %owner) :after (val (obj T))
  "Automatically update the inverse slot |ownedElement|."
  (if-bind (set (%owned-element val))
    (pushnew-last obj (value set))
    (setf (%owned-element val)
	  (make-instance 
	   'ocl:|Set| 
	   :value (list obj)
	   :typ-d (make-instance 'ocl::collection-typ
				 :unique-p t 
				 :base-type 'ocl:|OclAny|))))) ; would like Element, but don't have it.
					       
(defmethod %defined-at ((obj T))
  "Fallback method used when called with non-mm-root-supertype object."
  (values "?"))

(defmethod (setf %defined-at) (val (obj T))
  "Fallback method used when called with non-mm-root-supertype object."
  (declare (ignore val)))

(defmethod %token-position ((obj T))
  "Fallback method used when called with non-mm-root-supertype object."
  (values "?"))

(defmethod (setf %token-position) (val (obj T))
  "Fallback method used when called with non-mm-root-supertype object."
  (declare (ignore val)))

