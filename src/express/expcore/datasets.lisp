;;; -*- Mode: Lisp; Package: EXPRESSO;  -*-

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


;;; Purpose: Implement datasets and entity instance management.
;;;
;;; Peter Denno
;;; Date: 1/13/99
;;;       2009-08-29 : Partial integration with mofi:population. 
;;;

(in-package :expresso)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Data set management.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro with-dataset ((dataset) &body body)
  "Safely switches the current-dataset while in the scope of the form."
  (with-gensyms (hold)
    `(let (,hold)
       (unwind-protect
           (progn 
             (setf ,hold (dataset *expresso*))
             (setf (dataset *expresso*) ,dataset)
             ,@body)
         (setf (dataset *expresso*) ,hold)))))

;;;
;;; Abstract Dataset
;;;
(defclass abstract-dataset ()
  ((name :accessor name :initarg :name)
   (instances-by-name-ht :initform (make-hash-table :size 10000)
			 :reader instances-ht)
   (names-by-instance-ht :initform (make-hash-table :size 10000) :reader names-by-instance-ht)
   (instances-by-type-ht :initform (make-hash-table)) ;; POD might not use with x-evaluations.
   (max-name
    ;; The p21 concept: #<name> where <name> is a natural num.
    :initform 0 :accessor max-name)
   (pristine-p
    ;; If NIL let user know when quitting that it isn't saved....
    :accessor pristine-p :initform t)
   (user-id
    ;; Additional identification for multi-user usage.
    :accessor user-id :initarg :user-id :initform "common")))

(defmethod extent ((type express-entity-type-mo) (dataset abstract-dataset) &key)
  (with-slots (instances-by-type-ht) dataset
    (or (gethash type instances-by-type-ht)
	(setf (gethash type instances-by-type-ht)
	      (make-hash-table :size 1000)))))

(defmethod extent ((class-name symbol) dataset &key schema)
  ;; If we send in the schema (a symbol) it is because we haven't schema-qualified the class-name.
  (declare (ignore schema)) ; PODsampson added
  (let ((class (find-class class-name))) ; PODsampson find-eu-class and more detail
    (if (typep class 'built-in-class)
        (error 'simple-express-error 
               :format-string "Extent called with built-in ~A.~%Check the order of arguments to map calls."
	       :format-arguments (list class-name))
      (extent class dataset))))

(defmethod print-object ((dataset Abstract-Dataset) stream)
  (print-unreadable-object (dataset stream :type t)
    (prin1 (name dataset) stream)))

(defmethod dataset-entity-count ((dataset abstract-dataset))
  "Returns the number of entities stored in a dataset."
  (hash-table-count (slot-value dataset 'instances-by-name-ht)))

;;;
;;; EXPRESS Dataset
;;;
(defclass express-dataset (abstract-dataset)
  ((dataset-pathname :initarg :dataset-pathname :accessor dataset-pathname :initform nil)
   (filename :accessor filename :initarg :filename) ; from the p21 file...
   (file-description :accessor file-description :initarg :file-description :initform "")
   (uniqueness-hash-tables :initform (make-hash-table))  ;; Each entry (indexed by classes which have hash tables) is a hashtable itself.
   (file-schema :accessor file-schema :initarg :file-schema))) ; a misnomer. the schema associated.

;;; POD Actually, this should not inherit the instances-by-type-ht, it is not used.
(defclass target-express-dataset (express-dataset) ()
  (:default-initargs
   :filename		"target express data"
   :file-description	"target express data"))

;;; X-evaluation: an object that records the source datasets, source schema, and view schema
;;; of an express-x evaluation. These are created when needed. The motivations 
;;; for this object are: (1) eliminate the dependency between binding instances and views/maps;
;;; these things properly belong to an evaluation wrt some dataset. They belong here.
;;; (2) alleviate the problems related to having to have set correctly the current-dataset 
;;; Should it be the target now? the source? who knows? ;^) (3) enable easier pull mapping 
;;; by allowing one to set the views slots to only those views that are to be evaluated. 
(defclass x-evaluation (abstract-dataset)
  ((evaluated-p :initform nil :accessor evaluated-p) ; T means that it is evaluated against the source data referenced here.
   ;; x-schema, the schema_view or schema_map which produced the views
   (x-schema :initarg :x-schema :accessor x-schema)
   ;; binding->val is execution specific, keyed to the view or map definition objects.
   ;; each value is also a hash table -- keyed by the binding and containing the value 
   ;; of the view under that binding. 
   (binding->val :initform (make-hash-table) :accessor binding->val)
   ;; indexed by view (or map) object.
   (obj-evaluated-p :initform (make-hash-table) :reader obj-evaluated-p)
   ;; Source-dataset will be the current dataset when called from the gui.
   (source-datasets :initarg :source-datasets :accessor source-datasets)))

(defmethod extent ((type express-entity-type-mo) (x-eval X-Evaluation) &key)
  (with-slots (instances-by-type-ht) (first (source-datasets x-eval))
    (or (gethash type instances-by-type-ht)
        (setf (gethash type instances-by-type-ht)
              (make-hash-table :size 1000)))))

(defmethod file-schema ((obj X-Evaluation))
  ;; this is an accessor on express-dataset.  here it is only a reader
  (with-slots (x-schema) obj
    (string-downcase (target-schema-name x-schema))))

(defmethod file-description ((obj X-Evaluation))
  ;; this is an accessor on express-dataset.  Here it is only a reader
  "Data from EXPRESS-X evaluation")

(defmethod remove-dataset :around ((dataset abstract-dataset) (frame t) &key)
  (declare (ignore frame))
  (clear-dataset dataset)
  (setf (source-datasets *expresso*) (remove dataset (source-datasets *expresso*)))
  (setf (datasets *expresso*) (remove dataset (datasets *expresso*)))
  (when (eql dataset (target-dataset *expresso*))
    (setf (target-dataset *expresso*) nil))
  (call-next-method))

(defmethod remove-dataset ((dataset express-dataset) (frame t) &key)
  "Remove the instances from every entity type extent."
  (with-slots (instances-by-name-ht uniqueness-hash-tables) dataset
    (let ((schema (find-schema (file-schema dataset))))
      (when schema
	(loop for instance being the hash-value of instances-by-name-ht using (hash-key name)
	      do (loop for class-name in (express-class-list (class-of instance))
		       for class = (find-class class-name) ; PODsampson find-eu-class
		       when class do (remhash name (extent class dataset)))))
      (loop for ht being the hash-value of uniqueness-hash-tables
	    do (clrhash ht))
      (clrhash uniqueness-hash-tables))))

(defmethod remove-dataset ((dataset target-express-dataset) (frame t) &key)
  nil)

(defmethod remove-dataset ((dataset t) (frame t) &key)
  "In case removed while there was no dataset."
  nil)

(defmethod clear-dataset ((dataset express-dataset))
  (with-slots (uniqueness-hash-tables) dataset
    (loop for ht being the hash-value of  uniqueness-hash-tables
	  do (clrhash ht))))

(defmethod clear-dataset ((dataset x-evaluation))
  (with-slots (evaluated-p x-schema binding->val obj-evaluated-p source-datasets) dataset
    (setf evaluated-p nil)
    (setf x-schema nil)
    (clrhash obj-evaluated-p)
    (setf source-datasets nil)
    (loop for ht being the hash-value of binding->val 
          when (typep ht 'hash-table) do (clrhash ht))
    (clrhash binding->val)))

(defmethod clear-dataset :around ((dataset abstract-dataset))
  (with-slots (instances-by-name-ht names-by-instance-ht instances-by-type-ht max-name pristine-p) dataset
    (clrhash instances-by-name-ht)
    (clrhash names-by-instance-ht)
    (clrhash instances-by-type-ht)
    (setf instances-by-name-ht (make-hash-table))
    (setf names-by-instance-ht (make-hash-table))
    (setf instances-by-type-ht (make-hash-table))
    (setf pristine-p t)
    (setf max-name 0))
  (call-next-method)
  dataset)

;;;---- Express-dataset subclass -----
(defmethod initialize-instance :after ((dataset express-dataset) &key)
  (unless (and (slot-boundp dataset 'name) (name dataset))
    (when-bind (pathname (dataset-pathname dataset))
      (setf (name dataset)
	    (format nil "~A.~A" (pathname-name pathname) (pathname-type pathname))))))

(defmethod add-dataset (dataset (frame Expresso))
  (with-accessors ((datasets datasets)) frame ; with-accessor for cgtk???
    (setf datasets (remove dataset datasets))
    (setf datasets (cons dataset datasets)))
  dataset)

(defun find-dataset (&key name pathname type user-id schema (errorp t))
  "Returns the dataset if it exists or nil otherwise."
  (when pathname (setf pathname (namestring pathname)))
  (macrolet ((winnow-ds (test) `(setf datasets (remove-if (complement #'(lambda (x) ,test)) datasets))))
    (let ((datasets (datasets *expresso*)))
      (when type     (winnow-ds (typep x type)))
      (when name     (winnow-ds (string-equal (name x) name)))
      (when user-id  (winnow-ds (string-equal (user-id x) user-id)))
      (when schema   (winnow-ds (string-equal (file-schema x) schema)))
      (when pathname (winnow-ds (let ((pn (dataset-pathname x)))
				  (and pn (string-equal (namestring pn) pathname)))))
      (unless (= 1 (length datasets))
        (if errorp
            (error 'dataset-lookup-failure 
                   :criteria (append (when name (list :name name))
				     (when pathname (list :pathname pathname))
                                     (when type (list :type type))
				     (when user-id (list  :user-id user-id))
				     (when schema (list :schema schema))))
          nil))
      (first datasets))))

(defun ensure-dataset (type &key name pathname file-schema user-id source-datasets x-schema)
  "Create new or return existing with the argument name.
   Args: name - a string.
         type - either express-dataset, target-express-dataset or x-evaluation." 
  (let ((dataset (or (and name (find-dataset :name name :type type :user-id user-id :errorp nil))
                     (and pathname (find-dataset :pathname pathname :type type :errorp nil)))))
    (if dataset
        (clear-dataset dataset)
      (setf dataset
            (if (eql type 'x-evaluation)
                (make-instance type :name name :source-datasets source-datasets :x-schema x-schema)
              (make-instance type :name name :user-id user-id :dataset-pathname pathname :file-schema file-schema))))
    (when x-schema (setf (x-schema dataset) x-schema))
    (when source-datasets (setf (source-datasets dataset) source-datasets))
    (add-dataset dataset *expresso*)
    dataset))

(defun default-express-dataset ()
  "POD This is bogus. Returns any express dataset."
  (break "default-express-dataset"))

;;;---------------------------------------------------------------------------------------
;;; Instance management
;;;---------------------------------------------------------------------------------------
(defun handle-uniqueness-derived-access-error (condition)
  (info-message "~%~% Can't check uniqueness of this entity because")
  (info-message "~% access of a DERIVED attribute failed. ~% (~a)" condition)
  (info-message "~% It could be due to reference to an entity not yet defined.")
  (info-message "~% You might try turning off uniqueness checking. ~% ~a" condition)
  (throw 'next-entity nil))

(defmethod store-instance ((instance entity-root-supertype) &optional name &key allow-overwrite dataset)
  "Store the instance at the index. 
   Store at each simple entity type (in the class objects) also.
   Args: INSTANCE - a entity-root-supertype object
         NAME - the entity_instc_name (part21 terminology)"
  (dbg-message :data 3 "~%Storing instance ~S ~@[with name ~S ~]into dataset ~S"
	       instance name dataset)
  ;; Add to hash tables.
  (when dataset
    (with-slots (instances-by-name-ht names-by-instance-ht instances-by-type-ht max-name) dataset
      (let ((name (or name (1+ max-name)))
	    (count (hash-table-count instances-by-name-ht)))
	(unless allow-overwrite
	  (when-bind (existing (get-instance name dataset))
	    (express-error bad-entity
			   "While trying to add ~A~%An instance #~D already exists in this dataset:~%~A" 
			   instance name existing)))
	(setf max-name (max max-name name))
	(setf (gethash instance names-by-instance-ht) name)
	(setf (gethash name instances-by-name-ht) instance)
        (setf (gethash instance (instance-dataset-ht *expresso*)) dataset)
	(when (and (zerop (mod count 500)) (not (zerop count)))
	  (info-message "~&*** ~:D instances created.~%" count))
	(loop for class-name in (express-class-list (class-of instance))
	      for class = (find-class class-name) ; PODsampson find-eu-class
	      do (setf (gethash name (extent class dataset)) instance))
	)))
  instance)

(defun check-uniqueness (dataset instance class uniqueness-fns)
  "Check that the argument instance does not collide with another instance at the argument uniqueness-key.
    ARGS: instance - an entity instance.
          class    - An Express-entity-type-mo (not instantiable)
          uniqueness-fn - a list of functions that return a list whose car is the rule label and whose
                          cdr is the key at which this instance is to be stored."
  (loop for fn in uniqueness-fns
        with uniqueness-ht = (dataset-uniqueness-ht dataset class)
	for result = (funcall fn instance)
	for key    = (rest result)
	for collision? = (gethash key uniqueness-ht) ; using entity-id allows re-definition.
	for collision  = (when (and collision? (not (= (entity-id instance dataset) (entity-id collision? dataset)))) collision?)
	if collision
	  do (incf-option unique-rule-errors)
	     (info-message "~&Instance #~D fails uniqueness rule ~A of entity type ~A.~
                            ~%  It conflicts with Instance #~A.~%"
			   (entity-id instance dataset) (symbol-name (first result))
			   ;; PODsampson class-name was short-name
			   (symbol-name (class-name class)) (entity-id collision dataset)) 
        else do (setf (gethash key uniqueness-ht) instance)
	))


(defmethod dataset-uniqueness-ht ((dataset express-dataset) class)
  "Returns a hash table that shall be indexed by the UNIQUEness constraints on the argument class."
  (let ((tables (slot-value dataset 'uniqueness-hash-tables)))
    (or (gethash class tables)
        (setf (gethash class tables) (make-hash-table :test #'equal)))))

(defun get-instance (name dataset)
  (with-slots (instances-by-name-ht) dataset
    (gethash name instances-by-name-ht)))

(defun get-instance-wherever (name)
  "This is not foolproof!"
  (loop for dataset in (datasets *expresso*)
        do (when-bind (instance (get-instance name dataset))
             (return-from get-instance-wherever instance))))

(defmethod entity-id (instance dataset)
  "Returns the number used in p21 #<number> syntax."
  (if dataset
      (with-slots (names-by-instance-ht) dataset
	(or (gethash instance names-by-instance-ht)
	    -1))
      -1))

(defmethod entity-dataset (instance)
  "Probably just used in diagnostic routines."
  (loop for ds in (datasets *expresso*)
        when (plusp (entity-id instance ds))
        return ds))

(defun remove-instance (instance dataset)
  "Remove an instance from both instances-by-name-ht and names-by-instance-ht."
  (with-slots (instances-by-name-ht names-by-instance-ht) dataset
    (let ((key (entity-id instance dataset)))
      (remhash key instances-by-name-ht)
      (remhash instance names-by-instance-ht))))

(defmethod write-db ((stream (eql t)) encoding &rest opts)
  (apply #'write-db *standard-output* encoding opts))

(defmethod write-db ((stream String) encoding &rest opts)
  (apply #'write-db (pathname stream) encoding opts))

(defmethod write-db :around ((path Pathname) encoding &rest opts)
  (with-open-file (stream path :direction :output :if-exists :supersede)
    (apply #'write-db stream encoding :filename path opts)))

(defmethod instance-dataset ((instance entity-root-supertype))
  (gethash instance (instance-dataset-ht *expresso*)))

(defun next-free-id (dataset &optional (starting-at 1))
  (loop for i from starting-at to (+ starting-at 1050)
        unless (get-instance i dataset) return i))


(defmethod extent ((class instantiable-express-entity-type-mo) dataset &key)
  (let ((tables
	 (sort ;; Do intersection by smallest population first...
	  (loop for type in (express-class-list class)
		collect (extent (find-class type) dataset)) ; PODsampson find-eu-class
	  #'< :key #'hash-table-count)))
    (loop for table in (rest tables)
	  with instances = (ht2list (first tables))
	  when (null instances) return nil
	  do (setf instances (intersection instances (ht2list table)))
	  finally (return instances))))
