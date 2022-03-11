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
;;; Date: 9/24/98

(in-package :expresso)

;;;
;;; Purpose:
;;; Define the metaobjects for express-x meta-information and behavior.


;;;===============================================================================
;;; VIEW-INFO
;;;===============================================================================
;;; POD Given what I said in defview.lsp about there being a view-info for each view 
;;; (and partition???) encountered in the express-x, index by name (as below) does 
;;; not make sense.

;;; Contains the information describing a View.
;;; This is used to store the incremental information collected by VIEW declarations.
;;; POD Maybe this should be a subclass of standard-method? If so, specializers
;;; will have to be a class.
;;;
;;; The func slot contains function for the population of the extent, they
;;; all (each partitions) have to be run to fully populate the extent. 
;;; They take no arguments.
;;; (arguments are implied by the specializers). 

;;; view-infos are not metaobjects!
(defclass view-info ()
  ((name :accessor name :initarg :name)
   (max-args :accessor max-args)
   (partitions :accessor partitions :initform nil)))

(defmethod print-object ((class view-info) stream)
  (with-slots (name) class
    (print-unreadable-object (class stream :type nil :identity nil)
      (format stream "view-info ~A" name))))

(defclass view-info-partition ()
  ((name :initarg :name :accessor name)
   (project-is-scalar :initform nil :accessor project-is-scalar)
   (specializers :accessor specializers :initform nil)
   (func :accessor func :initform nil)
   (slots :accessor slots :initform nil) ; A list of view-slot-infos
   (identified-by :accessor identified-by :initform nil)))

(defmethod print-object ((class view-info-partition) stream)
  (with-slots (name) class
    (print-unreadable-object (class stream :type nil :identity nil)
      (format stream "view-info-partition ~A" name))))

(defun ensure-view-info (name)
  (make-instance 'view-info :name name))

(defmethod shared-initialize :after ((class view-info) slot-names &rest initargs)
  (declare (ignore initargs slot-names))
  (pushnew class (view-infos (schema *expresso*))))

(defclass view-slot-info ()
  ((name :initarg :name :reader name)
   (express-type :initarg :express-type :reader express-type)
   (schema :initarg :schema :reader schema)
   (updateable-p :initarg :updateable-p :reader updateable-p)))


(defmethod print-object ((class view-slot-info) stream)
  (with-slots (name) class
    (print-unreadable-object (class stream :type nil :identity nil)
      (format stream "view-slot-info ~A" name))))
   

;;;===============================================================================
;;; VIEW
;;;===============================================================================
;;; Class meta-object for classes created by the view. Such classes
;;; have a class-name = view-info.name and have a slot for each element
;;; of the corresponding view-info. A view-mo class is a subclass if 
;;; the VIEW used the EXTENDS clause to inherit.
(defclass view-mo (express-standard-class)  
  ())

(defmethod print-object ((class view-mo) stream)
  (print-unreadable-object (class stream :type nil :identity nil)
    (format stream "view-mo ~A" (class-name class))))

(defmethod validate-superclass ((class view-mo)
				(superclass standard-class))
  t)

#-cre
(defun ensure-view-class (name x-eval &key (direct-superclasses (list (find-eu-class 'vi-root-supertype))))
 (or (find name (views (x-schema x-eval)) :key #'class-name)
     (let ((view (make-instance 'view-mo :name name :direct-superclasses direct-superclasses)))
       (push view (x-schema x-eval))
       view)))
  
;;; All view classes are a subclass of this, so that we can define
;;; methods on their creation, for registration, for example. 
(defclass vi-root-supertype ()
  ()
  (:metaclass view-mo))

(defmethod express-finalize ((class view-mo))
  (finalize-inheritance class)
  (mapcar #'finalize-inheritance (class-direct-subclasses class))
  class)

#+debug
(defmethod print-object ((instance vi-root-supertype) stream)
  (write-entity instance stream :p21 
                :dataset (find-if #'(lambda (x) (typep x 'x-evaluation))
                                  (get-special datasets))))

;;; ------------ SLOT DEFINITION

(defclass view-direct-slot-definition (standard-direct-slot-definition)
    ((express-type :initarg :express-type
		   :accessor slot-definition-express-type :initform nil)
     (updateable-p :initarg :updateable-p
                   :accessor slot-definition-updateable-p :initform nil)))

(defclass view-effective-slot-definition (standard-effective-slot-definition)
    ((express-type :initarg :express-type
		   :accessor lot-definition-express-type :initform nil)
     (updateable-p :initarg :updateable-p 
                   :accessor slot-definition-updateable-p)
     (simple-name :accessor slot-definition-simple-name)))

(defmethod initialize-instance :after ((slot view-effective-slot-definition)
				       &rest initargs &key class name)
  (declare (ignore initargs class))
  (setf (slot-definition-simple-name slot) name))

(defmethod direct-slot-definition-class 
  ((class view-mo)
   #-(or LispWorks4.1 LispWorks4.2) &rest
   initargs)   
  (declare (ignore initargs))
  (find-class 'view-direct-slot-definition))

(defmethod effective-slot-definition-class 
  ((class view-mo)
   #-(or LispWorks4.1 LispWorks4.2) &rest
   initargs)
  (declare (ignore initargs))
  (find-class 'view-effective-slot-definition))

#+LispWorks
(defmethod compute-slots :around ((class view-mo))
  "Note that Kiczales remarks that portable implementations should
   not be doing this. It sets the location slot"
  (compute-slots-lispworks-internal class (call-next-method)))

;;Should not be necessary...
;(defmethod compute-slots ((class view-mo))
;  (let* ((all-slots (mapappend #'class-direct-slots
;			       (class-precedence-list class)))
;	 (all-names (remove-duplicates
;		     (mapcar #'slot-definition-name all-slots))))
;    (setf (class-slots class)
;          (mapcar #'(lambda (name)
;                      (compute-effective-slot-definition
;                       class
;                       name
;                       (remove name all-slots
;                               :key #'slot-definition-name
;                               :test-not #'eq)))
;                  all-names))))

(defmethod compute-effective-slot-definition ((class view-mo) name d-slots)
  (let ((e-slot (call-next-method)))
    (setf (slot-definition-range e-slot)
          (slot-definition-range (first d-slots)))
    (setf (slot-definition-updateable-p e-slot)
          (slot-definition-updateable-p (first d-slots)))
    e-slot))

;;; In express-entity-type-mo this is a slot accessor. 
(defmethod mapped-slots ((view view-mo))
  "Return the mapped slots of a view (name is weird for parallelism)."
  (class-slots view))

;;; This is the generic function subclass used for accessors to view attributes.
(defclass express-x-generic-function-mo (standard-generic-function)
  ()
  (:metaclass funcallable-standard-class))

(defclass info ()
  ((name :initarg :name :reader name)
   (schema :accessor schema)
   (target :initarg :target :accessor target)
   (identified-by :initarg :identified-by :reader identified-by)
   (partition :initarg :partition :reader partition)
   (subtype-of :initarg :subtype-of :reader subtype-of)
   (has-direct-subtypes :accessor has-direct-subtypes :initform nil)
   (sources :initarg :sources :reader sources)
   (locals  :initarg :locals  :accessor locals)
   (instantiation-loop :initarg :instantiation-loop :reader instantiation-loop)
   (predicate :initarg :predicate :accessor predicate)
   (project :initarg :project :accessor project))
  (:default-initargs
   :identified-by nil :instantiation-loop nil :project nil))

(defmethod shared-initialize :after ((info Info) slot-names &rest initargs)
  "Store the info in the hash-table on expresso-options. It is indexed by Info 
   subtype-of (if it is a subtype) or name otherwise."
  (declare (ignore initargs))
  (with-slots (schema name partition) info
    (let ((sch (schema *expresso*)))
      (setf schema (euintern (name sch)))
      (setf (gethash (euintern "~A.~A" name partition) (map-infos sch))
	    info))))

;;;===============================================================================
;;; MAP-INFO
;;;===============================================================================
;;; MAP-INFO became necessary when subtyping of MAPs was implemented. The MAP-INFO
;;; now just collects information for the subsequent compilation of MAPs by compile-maps.
;;; A map-info contains the information of a map partition. There is a map-info for
;;; each partition in the schema.
(defclass map-info (Info) ())

(defmethod print-object ((obj Map-Info) stream)
  (with-slots (name partition) obj
    (print-unreadable-object (obj stream :type nil :identity nil)
      (format stream "map-info ~A.~:[NO-PARTITION~;~:*~A~]" name partition))))

;;; POD This is not sufficient! It is a work-around for the fact that our
;;; map subtyping implementation clashes with our map partition implementation 
;;; (don't try to use both simultaneously, please.)
(defun find-map-info (name x-schema)
  (loop for map-info being the hash-value of (map-infos x-schema)
        when (eql name (name map-info)) ;; return first... the work-around.
        return map-info))

;;;===============================================================================
;;; DEP-MAP-INFO
;;;===============================================================================
;;; DEP-MAP-INFO became necessary when the new DEPENDENT_MAP was introduced.
(defclass dep-map-info (Info) ())

(defmethod print-object ((obj dep-map-info) stream)
  (with-slots (name partition) obj
    (print-unreadable-object (obj stream :type nil :identity nil)
      (format stream "dep-map-info ~A.~:[NO-PARTITION~;~:*~A~]" name partition))))

(defun find-dep-map-info (name x-schema)
  (gethash name (map-infos x-schema)))

;;;===============================================================================
;;; MAP
;;;===============================================================================
;;; p14-map: a class (not a meta-class, its instances are not classes) that contains the 
;;; push and pull functions for mapping.
(defclass p14-part ()
  ((name          :initarg :name          :reader name)
   (predicate     :initarg :predicate     :accessor predicate :initform nil)
   (identified-by :initarg :identified-by :reader identified-by)
   (access-params :initarg :access-params :reader access-params)
   (param-types   :initarg :param-types   :reader param-types)
   (map-info      :initarg :map-info      :reader map-info)
   (binding-instance-function :initarg :binding-instance-function :accessor binding-instance-function)
   (mapcall-function :initarg :mapcall-function :accessor mapcall-function)
   (executor      :initarg :executor      :accessor executor :initform nil)
   (binding-calls :reader binding-calls   :initform (make-hash-table :test #'equal))))

#-cre
(defmethod find-map ((name symbol) x-schema &key partition create)
  (when (and partition create)
    (error "find-map: :partition and :create are mutually exclusive"))
  (let ((map (gethash name (maps x-schema)))
	(fname (and partition (euintern "~A.~A" name partition))))
    (cond ((null map)
	   (when create
	     (setf map (make-instance 'p14-map :name name))
	     (setf (gethash name (maps x-schema)) map)
	     map))
	  (partition
	   (find fname (partitions map) :key #'name))
	  (t map))))

#-cre
(defmethod find-map ((info Info) x-schema &key partition create)
  (with-slots (name (part partition)) info
    (when (and partition create)
      (error "find-map: :partition and :create are mutually exclusive"))
    (let ((map (gethash name (maps x-schema)))
	  (fname (and partition (euintern "~A.~A" name part))))
      (cond ((null map)
	     (when create
	       (setf map (make-instance 'p14-map :name name))
	       (setf (gethash name (maps x-schema)) map)
	       map))
	    (partition
	     (find fname (partitions map) :key #'name))
	    (t map)))))

(defmethod binding-call-count ((map p14-part))
  (hash-table-count (binding-calls map)))

(defmethod clear-bindings ((part p14-part))
  (with-slots (binding-calls) part
    (clrhash binding-calls)))

(defmethod binding ((part p14-part) x-eval &optional partition &rest params) 	 
  "Run the binding-instance-function for the argument partition"
  (declare (ignore partition))          ;not needed at this level 	 
  (with-slots (binding-instance-function) part 	 
    (apply binding-instance-function x-eval params))) 	 

(defmethod mapcall ((part p14-part) x-eval &optional partition &rest params)
  (declare (ignore partition))
  (dbg-message :exx 4 "~%mapcall-part ~S: ~S ~S ~S" part x-eval partition params)
  ;; Let's not wrap this in a handler-case etc. If there is an error we need to see it now,
  ;; because such errors typically concern mistakes in the user's express-x, and the message
  ;; should be meaningful in that context. 
  (let ((val (apply (mapcall-function part) x-eval params)))
    (dbg-message :exx 4 "~%mapcall-part ~S: returning: ~S" part val)
    val))

;; x-part
(defclass x-part (p14-part) ())

(defmethod print-object ((obj x-part) stream)
  (with-slots (name) obj
    (print-unreadable-object (obj stream :type nil :identity nil)
      (format stream "X-PART ~A" name))))

(defmethod initialize-instance :after ((map x-part) &key)
  "Store the x-part instance."
  (with-slots (name) map
    (dbg-message :exx nil "~&X-PART ~A~%" name)))

(defmethod evaluate ((part x-part) x-eval)
  (with-slots (executor) part
    (when executor
      (funcall executor x-eval))))

;; --------------------------------------------------
;; x-dep-part
(defclass x-dep-part (p14-part) ())

(defmethod print-object ((obj x-dep-part) stream)
  (with-slots (name) obj
    (print-unreadable-object (obj stream :type nil :identity nil)
      (format stream "dep-map ~A" name))))

(defmethod initialize-instance :after ((map x-dep-part) &key)
  "Store the x-part instance."
  (with-slots (name) map
    (dbg-message :exx nil "~&DEP-MAP ~A~%" name)))

(defclass p14-map ()
    ((name
      :initarg :name
      :reader   name)
     (access-params
      :initarg :access-params
      :accessor access-params
      :initform nil)
     (param-types
      :initarg :param-types
      :accessor param-types
      :initform nil)
     (supermap
      :initarg :supermap
      :accessor supermap
      :initform nil)
     (submaps
      :initarg :submaps
      :accessor submaps
      :initform nil)
     (partitions
      :initarg :partitions
      :accessor partitions
      :initform nil)
     )
  )

(defmethod clear-bindings ((map p14-map))
  (with-slots (partitions) map
    (loop for part in partitions
	  do (clear-bindings part))))

(defmethod binding ((map p14-map) x-eval &optional part-name &rest params)
  "Run the binding-instance-function for each parition, or if specified, the part-name."
  (with-slots (partitions) map
    (if part-name
	(let ((part (find part-name partitions :key #'(lambda (x) (partition (map-info x))))))
	  (apply #'binding part x-eval nil params))
	(loop for part in partitions
	      as val = (apply #'binding part x-eval nil params)
	      when val return val))))

;;; This is called by funcall-map, which is itself called by a binding instance fn.
;;; It runs a explicit binding fn (code generated from the .exx).
(defmethod mapcall ((map p14-map) x-eval &optional part-name &rest params)
  (with-slots (partitions submaps) map
    (dbg-message :exx 4 "~%mapcall-map: ~S ~S ~S ~S" map x-eval part-name params)
    (if part-name
	(let ((part (find part-name partitions :key #'(lambda (x) (partition (map-info x))))))
	  (if part (apply #'mapcall part x-eval nil params)
	      (loop for sub in submaps
		    as val = (apply #'mapcall sub x-eval part-name params)
		    when val return val)))
	(or (loop for sub in submaps
		  as val = (apply #'mapcall sub x-eval nil params)
		  when val return val)
	    (loop for part in partitions
		  as val = (apply #'mapcall part x-eval nil params)
		  when val return val)))))

;;; --------------------------------------------------
(defclass x-map (p14-map) ())

(defmethod print-object ((obj x-map) stream)
  (with-slots (name) obj
    (print-unreadable-object (obj stream :type nil :identity nil)
      (format stream "x-map \"~A\"" name))))

(defmethod evaluate ((map x-map) x-eval)
  (with-slots (partitions) map
    (loop for part in partitions
	  do 
          (evaluate part x-eval))))

;;; --------------------------------------------------
(defclass x-dep-map (p14-map) ())

(defmethod print-object ((obj x-dep-map) stream)
  (with-slots (name) obj
    (print-unreadable-object (obj stream :type nil :identity nil)
      (format stream "x-dep-map \"~A\"" name))))
