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


;;;
;;; Peter Denno
;;; Date: 2/21/96
;;;
;;; Purpose: Functions to decompose the part21 typed feature structure (TFS)
;;;          and make an instance of the entity described therein.
;;;

(in-package :expo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; P21 file reading
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmethod read-data ((model-file expo:model-file) &key)
  (let ((path (path model-file)))
    (set-special errors-at-creation 0)	;clear error count
    (clear-where-used)
    (let ((*dataset* (ensure-dataset 'express-dataset :pathname path)))
      (set-special last-p21-loaded-dataset *dataset*)
      (clrhash (get-option p21-comments-ht))
      (handler-bind
	  ((error #'(lambda (err)
		      (remove-dataset *dataset* *expresso*)
		      (abort? *expresso* :condition err :model-file model-file))))
	(info-message "~&;;; Parsing P21  (~S)...~%" path)
	(setf *line-number* 1)
	(parse-data path :pass :p21)
	(info-message "~&;;; Resolve references...~%")
	(resolve-p21-references *dataset*)
	(connect-inverses *dataset*)
	(info-message "~2%;;; ********** Read ~D Instances **********~%"
		      (dataset-entity-count *dataset*))
	(setf (dataset *expresso*) *dataset*)
	*dataset*))))

(defun add-where-used (instance user)
  "Indexed by using instance, the value is the user plus previous users."
  (when (eql instance user)
    (info-message "~%~%The entity below uses itself. Validation impossible:~%~a" user))
  (pushnew user (gethash instance (get-special where-used-ht))))

(defun clear-where-used ()
  (clrhash (get-special where-used-ht)))

(defun where-used (use)
  "Returns a list of the users of argument use.
   Args: use - an entity instance."
  (gethash use (get-special where-used-ht)))

;;; POD This would be unnecessary if the  where-used-ht used entity-number
;;; instead of entity!!! (Of course then add-where-used wouldn't work.)
(defun update-where-used-for-new-instance (new-instance entity-number dataset)
  "Used (e.g. in dc-store-entity-cb) to update the where-used database
   replacing references to the old instance with references to the new one. 
   Also UPDATE the user's slots themselves.
   Borrowed code from resolve-p21-references below."
  (let ((old-instance (get-instance entity-number dataset))
        (where-used-ht (get-special where-used-ht))
        (looking-at nil))
    (labels ((update-user 
              (val)
              (typecase val
                (express-array
                 (let ((td (type-descriptor val)))
                   (loop for ix from (l-bound td) to (u-bound td)
                         do (setf (express-aref val ix)
                                  (update-user (express-aref val ix)))))
                 val)
                (express-aggregate
                 (setf (value val) 
                       (loop for elem in (value val)
                             collect (update-user elem)))
                 val)
                (otherwise
                 (cond ((eql old-instance val)
                        new-instance)
                       ((and (not old-instance)
                             (typep val 'p21-entity-ref)
                             (= entity-number (p21-entity-ref--value val)))
                        (add-where-used new-instance looking-at)
                        new-instance)
                       (t val))))))
      (cond (old-instance
             (loop for user in (where-used old-instance)
                   do 
                   ;; Update all the users to point to the new instance.
                   (loop for slot in (mapped-slots (class-of user)) do
                         (let* ((slot-name (slot-definition-name slot))
                                (val (slot-value user slot-name)))
                           (when-bind (updated? (update-user val)) ; updated? always true
                             (setf (slot-value user slot-name) updated?))))))
            (t ; This is a all new entity. 
             (loop for user being the hash-value of 
                   (slot-value dataset 'instances-by-name-ht)
                   do 
                   (setf looking-at user)
                   ;; Update all the users to point to the new instance.
                   (loop for slot in (mapped-slots (class-of user)) do
                         (let* ((slot-name (slot-definition-name slot))
                                (val (slot-value user slot-name)))
                           (when-bind (updated? (update-user val))
                             (setf (slot-value user slot-name) updated?)))))))
      ;; Update the database itself. The new instance is used wherever the
      ;; old instance was used. The old instances is no longer used.
      (when old-instance
        (setf (gethash new-instance where-used-ht) 
              (gethash old-instance where-used-ht))
        (setf (gethash old-instance where-used-ht) nil)
        (loop for key being the hash-key of where-used-ht
              do (subst new-instance old-instance (gethash key where-used-ht)))))))

(defun update-where-used-for-deleted-instance (instance entity-name)
  "Like update-where-used-for-new-instance but for situations where
   instance is being removed. Replace reference to it with a p21-entity-ref struct."
  (let ((p21-ref (make-p21-entity-ref :-value entity-name)))
    (labels ((update-user 
              (val)
              (typecase val
                (express-array
                 (let ((td (type-descriptor val)))
                   (loop for ix from (l-bound td) to (u-bound td)
                         do (setf (express-aref val ix)
                                  (update-user (express-aref val ix)))))
                 val)
                (express-aggregate
                 (setf (value val) 
                       (loop for elem in (value val)
                             collect (update-user elem)))
                 val)
                (otherwise
                 (cond ((eql instance val)
                        p21-ref) ;; This is the actual substitution.
                       (t val))))))
      (loop for user in (where-used instance)
            do 
            ;; Update all the users to point to the p21-ref struct instead of the instance.
            (loop for slot in (mapped-slots (class-of user)) do
                  (let* ((slot-name (slot-definition-name slot))
                         (val (slot-value user slot-name)))
                    (when-bind (updated? (update-user val))
                      (setf (slot-value user slot-name) updated?)))))
      ;; Update the database itself.
      (remhash instance (get-special where-used-ht)))))

#+nil
(defun print-where-used-db ()
  (loop for use being the hash-key of (get-special where-used-ht)
      do (format t "~% ~a used in ~a"
		 (get-name use) 
		 (mapcar #'get-name (gethash use (get-special where-used-ht))))))

(defun resolve-p21-references (dataset &optional arg-instance &key partial-ok)
  "Iterates (Unless an arg-instance are specified as an argument), through every entity
   in the database and resolve the entity references therein. Also calls to build
   the where-used-ht. When partial-ok = t don't complain if reference doesn't exist yet."
  (let ((non-existent nil))
    (labels ((resolve-p21-ref-internal (val user)
	      (typecase val
	        (p21-entity-ref
	         (let ((use (get-instance (p21-entity-ref--value val) dataset)))
		   (when (and (not use) (not  partial-ok))
                     (push val non-existent))
                   (when use (add-where-used use user))
                   (or use val))) ;; POD 11/19/97 return the p21-ref if no entity.
	        ;; POD Not sure that this is a good idea.
	        (p21-enumeration-ref
	         (p21-enumeration-ref--keyword val))
	        (express-array
	         (let ((td (type-descriptor val)))
		   (loop for ix from (l-bound td) to (u-bound td)
		         do (setf (express-aref val ix)
				  (resolve-p21-ref-internal
				   (express-aref val ix)
				   user)))
		   val))
	        (express-aggregate
	         (setf (value val)
		       (loop for elem in (value val)
			     collect (resolve-p21-ref-internal elem user)))
	         val)
	        (otherwise
	         val))))
      ;; ---------
      (flet ((body-internal (entity)
	      (loop for slot in (mapped-slots (class-of entity)) do
		    (let ((slot-name (slot-definition-name slot)))
                      (when-bind (resolved? (resolve-p21-ref-internal 
                                             (slot-value entity slot-name)
                                             entity))
                        (setf (slot-value entity slot-name) resolved?))))))
        (if arg-instance 
            (body-internal arg-instance)
          (loop for entity being the hash-value of (slot-value dataset 'instances-by-name-ht) do
                (body-internal entity)))))
    (when non-existent
      (let* ((nons (delete-duplicates non-existent :test #'= :key #'p21-entity-ref--value))
             (nons (sort nons #'< :key #'p21-entity-ref--value)))
      (info-message "~2%The following entity references are invalid. (No such entity instances exist).~%~
			This must be fixed before validation:~%~a" nons)
      (alert-message "~%The Part 21 file made reference to entity instances which do not exist~%~
			(either because they could not be created or were not defined in the file).~2% ~
			 See the message buffer for details.")))))

(defstruct record-type-name
  (-name))

;;; Purpose: If the value is a select, it might well be very messed up.
;;; This goes to the bottom of nested select-vals and gets the primitive value.
;;; It then sets the record-of-types to the last type encountered PLUS any
;;; defined types (see the pathological case in the Part 21 Technical Corrigendum).
;;;
;;; Arguments: val - any value, could be a messed up select.
(defun fix-selects (val)
  (labels ((recurse-to-primitive-value (val)
            (cond ((not (typep val 'select-value)) val)
                  (t (recurse-to-primitive-value (value val)))))
	   (filter-types (record-of-types)
	     `(,@(loop for type in (butlast record-of-types) ; PODsampson find-eu-class / eu intern
		       as tdesc = (find-class (intern type (lisp-package (schema *expresso*))))
		       unless (typep (type-descriptor tdesc) 'select-typ)
		       collect (short-name tdesc))
	       ,(euintern (first (last record-of-types))))))
    (cond ((not (typep val 'select-value)) val)
	  (t ;;(break "fix-selects ~S" val)
	     (make-instance 'select-value 
                            :value (recurse-to-primitive-value (value val))
                            :record-of-types (filter-types (record-of-types val))))))
  )


;;; Purpose: Determine the initarg keywords corresponding to the
;;;          values found in the part 21 data read. This algorithm
;;;          works regardless of the ordering of slots in the programmatic
;;;          CLOS object, but depends on the ordering of direct slots in
;;;          the component CLOS object.
;;;
;;; Args: class - the programmatic class corresponding to the complete p21
;;;               record read. 
;;;       component-name  - a entity name called out in the p21 data.
;;; Value: The effective slots from the component class
;;;        OR (when the effective slot is override) 
;;;        
(defun component-eslots (class component-name)
  ;; FLET Function: entity-eslots
  ;; Purpose: Return a list of eslots for the argument component name.
  ;; Approach: Since the correct ordering is found in the direct slot
  ;;           for the simple entity, match the direct slot name with simple-name.
  ;; Args: component-name - An entity type name declared in the express.
  ;;       eslots - effective slots from the complete programmatic class
  ;;               corresponding to the p21 entity.
  (flet ((sort-eslots (component-name eslots)
	  (loop for dslot in (class-direct-slots (find-class component-name)) ; PODsampson find-eu-class
		for eslot = (find (slot-definition-name dslot) eslots
				  :key #'slot-definition-simple-name)
		if eslot collect eslot
		;; If it wasn't found it is because it isn't in the
		;; programmatic class. (Because it was overridden).
		;; POD There must be some better way of doing this!
		;; For example, put an attribute in the slot indicating
		;; that it is overriden.
		else collect (list component-name 
				   (slot-definition-name dslot)))))
    ;; ------
    ;; Note that the class-slots of the class (a programmatic class) 
    ;; does not include the redefined slots. So no problem here.
    (let ((slots (remove-if    ;; get effectives slots for a single component. 
		  (complement
		   #'(lambda (slot) 
		       (eql component-name 
			    (slot-definition-source slot))))
		  ;; POD Remove the recorded-type slot. (But not derived slots).
		  ;; (If recorded-type wasn't first this would crash. That is
		  ;; why I know it is OK!
		  (class-slots class))))
      (sort-eslots component-name slots))))

;;; Args:
;;;    string: a string, that if it is an express string, will
;;;            begin and end with a single quote character.
;;; Value: the argument with the delimiting single quotes stripped
;;;        or nil if false.
(declaim (inline express-string-p))
(defun express-string-p (string)
  (when (stringp string)
    (let ((index-last (- (length string) 1)))
      (if (and
	   (char-equal (char string 0) #\')
	   (char-equal (char string index-last) #\'))
	  (subseq string 1 index-last)
	nil))))

;;; ------------------------------
;;; this GF and its methods need to be moved elsewhere
(defgeneric convert-value (exp-type p21-value &key &allow-other-keys))

(defmethod convert-value :around (type value &key)
  (declare (ignore type))
  (cl:case value
    ((:? :*) value)
    (t (call-next-method))))

(defmethod convert-value (type value &rest opts)
  (warn "While reading P21 data at line: ~A:~% The value '~A' is invalid as an instance of type ~A."
	*line-number* value (p11-string type "" :text))
  :?)

(defmethod convert-value ((type string-typ)  value &key) value)

(defmethod convert-value ((type number-typ)  value &key) value)

(defmethod convert-value ((type boolean-typ) value &key)
  (make-p21-boolean-ref
   :-value (string-downcase value)
   :-keyword value))

(defmethod convert-value ((type logical-typ) value &key)
  (make-p21-logical-ref
   :-value (string-downcase value)
   :-keyword value))

(defmethod convert-value ((type enum-typ) value &key)
  (make-p21-enumeration-ref
   :-value (string value)
   :-keyword value))

(defmethod convert-value ((type select-typ) value &key)
  value)

(defmethod convert-value ((type select-typ) (value p21p::p21-entity-ref) &key)
  (make-p21-entity-ref :-value (p21p::entity-name value)))

(defmethod convert-value ((type select-typ) (value p21p::p21-typed-parameter) &key)
  (labels ((decompose-value (val)
	     (typecase val
	       (p21p::p21-typed-parameter
		(with-slots (p21p::param-type p21p::param-value) val
		  (push p21p::param-type *recorded-type*)
		  (decompose-value p21p::param-value)))
	       (t val))))
    (let ((dval (decompose-value value)))
      (cond ((typep dval 'p21p::p21-entity-ref) dval)
	    ((null *recorded-type*) dval)
	    (t (make-instance 'select-value
		 :value dval
		 :record-of-types (nreverse *recorded-type*)))))))

(defmethod convert-value ((type express-defined-type-mo) value &key)
  (convert-value (type-descriptor type) value))

(defmethod convert-value ((type forward-referenced-class) value &key)
  (convert-value
   (find-class (class-name type)) ; PODsampson find-eu-class 
   value))

(defmethod convert-value ((type bag-typ) value &key)
  (with-slots (l-bound u-bound base-type) type
    (let ((nvals (loop for val in value
		       collect (convert-value base-type val))))
      (make-instance 'express-bag
	:value nvals
	:type-descriptor type))))

(defmethod convert-value ((type list-typ) value &key)
  (with-slots (l-bound u-bound base-type) type
    (let ((nvals (loop for val in value
		       collect (convert-value base-type val))))
      (make-instance 'express-list
	:value nvals
	:type-descriptor type))))

(defmethod convert-value ((type set-typ) value &key)
  (with-slots (l-bound u-bound base-type) type
    (let ((nvals (loop for val in value
		       collect (convert-value base-type val))))
      (make-instance 'express-set
	:value nvals
	:type-descriptor type))))


;;; Purpose: Return the integer corresponding to the argument
;;;          Part 21 binary value.
;;; Args: bin-string - the P21 binary string without the extra double quotes.
;;;                    A p21 binary is a hexadecimal value with a preceding
;;;                    number of missing digits to fill out a 4.
;;;                    "30" = 0; "31" = 1; "0" = nil ; "23B" = 59 "092A" = 92Ax
(defun p21binary2int (bin-string)
  (cond ((<= (length bin-string) 1)
	 nil)
	(t
	 (read-from-string (concatenate 'string "#x" (subseq bin-string 1))))))
	

(defun analyze-for-override (eslot eslots)
  "Purpose: Checks whether * was used properly.
   During reading of p21 data a :* (ommitted parameter) was encountered 
   in the argument attribute eslot. Here we make sure some slot in an
   included subtype redefines the value with a DERIVED attribute."
  (let* ((eslot-redefined-by (slot-definition-redefined-by eslot))
         (eslot-simple-name  (slot-definition-simple-name eslot))
         (subtype-slot 
          (find eslot eslots
                :test #'(lambda (eslot elem)
                          (declare (ignore eslot))
                          (and (eql (slot-definition-source elem) eslot-redefined-by)
                               (eql (slot-definition-simple-name elem) eslot-simple-name))))))
    (unless (and subtype-slot (slot-definition-derived subtype-slot))
      (express-error
       bad-entity
       "An ommitted parameter was used but the entity does not redefine the attribute ~s with a DERIVED attribute."
       (symbol-name (slot-definition-simple-name eslot))))))
	 
(defun enum2keyword (string)
  "Purpose: Return a keyword corresponding to the argument string
            enumeration .RED. --> :RED"
  (kintern (string-trim "." string)))

(defun keyword2enum (keyword)
  (format nil ".~A." keyword))
