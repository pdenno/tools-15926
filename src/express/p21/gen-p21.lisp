
;;; Copyright (c) 2003 Northrop Grumman
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

(in-package :EXPRESSO)

;;; =======================================================;
;;; Stuff from express-metaobjects moved here in 2009. 
;;; =======================================================

;;; ====================================================
;;; ============= PART 21 PRINTING =====================
;;; ====================================================

;;; Purpose: Print as a Part 21 entity instance.
;;; 
;;; Internal mapping:
;;;  - All inherited attributes shall appear sequentially prior to the
;;;    explicit attributes of any entity.
;;;  - The attributes of a supertype entity shall be inherited in the
;;;    order they appear in the supertype entity itself.
;;;  - If the supertype entity is itself a subtype of another entity,
;;;    then the attributes of the higher supertype entity shall be
;;;    inherited first.
;;;  - When multiple supertype entities are specified, the attributes
;;;    of the supertype entities shall be processed in the order
;;;    specified in the SUPTYPE OF expression.
;;;
;;; External mapping:
;;;  - Each entity data type in the evaluated set for the entity instance,
;;;    including any abstract supertypes, shall appear as a SIMPLE_RECORD
;;;    within the parentheses of the SUBSUPER_RECORD. (so even if it
;;;    doesn't supply a datum it appears, e.g. mixin-no-data())
;;;  - The data types in the SUBSUPER_RECORD are ordered alphabetically
;;;    by their keyword.
;;;  
;;; Approach: Determine whether internal or external mapping applies;
;;;   that is whether the type is or is not a *single* navigation of
;;;   the type hierarchy. If internal-mapping, sort the slots as described
;;;   above and print. If external-mapping, get each types contribution
;;;   sort and print.

#| 2009-09-03 This ***POTENTIALLY USEFUL*** P21 stuff is comment out until I 
   can re-integrate it (keep it from interferring with the xmi-hidden notion of mapped slots. 
(defvar *mapped-slots-memo* (make-hash-table) "Memoize mofi:mapped-slots for EXPRESS.")

;;; POD mapped-slots is currently not a good name. This only pertains to Part 21,
;;; Though I'd like to add something akin to xmi-hidden...
(defmethod mofi:mapped-slots ((class instantiable-express-entity-type-mo))
  "Effective slots minus those not mapped  in part-21 and set the type of slots whose 
   type is redefined by an explicit subtype. Note that we can't use eql 
   (e.g. in value string, which compares mapped-slots
   with (class-slots class)) because mapped-slots is a cache, that might not be
   up to date with class-slots, which might be updated (by finalize-inheritance?)"
  (or (gethash class *mapped-slots-memo*)
      (let ((slots (closer-mop:class-slots class)))
	(labels ((slot-is-redefinition-of (slot accum)
		   (flet ((one-step-path-to-source (slot)
			    (loop for candidate in slots
			       with name = (slot-definition-simple-name slot)
			       with source = (slot-definition-source slot)
			       when (and (eql name (slot-definition-simple-name candidate))
					 (eql source (slot-definition-redefined-by candidate)))
			       return candidate)))
		     (let ((redefinition-of (one-step-path-to-source slot)))
		       (cond ((not redefinition-of) accum)
			     (t
			      (slot-is-redefinition-of redefinition-of (cons redefinition-of accum))))))))
	      ;; PODsampson ... should be done in make-programmatic-class (no accesors either)
	      ;;   (set-type-as (original-slot redefining-slot))
	      ;;   ;; Per TC 11.2.8 The encoding of a slot doesn't change with its redefinition,
	      ;;   ;; however the type of its value, of course, does change.
	      ;;   (setf (slot-definition-encode-as original-slot)
	      ;;	 (slot-definition-range original-slot))
	      ;;   (setf (slot-definition-range original-slot)
	      ;;	 (slot-definition-range redefining-slot)))) 
	  (setf (gethash class *mapped-slots-memo*)
		(loop for slot in slots
		   as slot-inv = (slot-definition-inverse slot)
		   as slot-der = (slot-definition-derived slot)
		   for original-slot = (first (slot-is-redefinition-of slot nil))
		   unless (or original-slot slot-inv slot-der)
		   collect slot
;		   when original-slot do
;		     (set-type-as original-slot slot)
		     ))))))
|#
  
(defmethod entity-type-prints-internal-p ((entity-class-object instantiable-express-entity-type-mo))
  (let ((leaves (relative-leaves (express-class-list entity-class-object))))
    (if (null (second leaves))
        (first leaves)
      nil)))

;;; End of 2009 move.

;;; =================================
;;; Methods to write P21
;;; =================================

(defmethod write-entity ((obj express-aggregate) stream (enc (eql :p21)) &key dataset)
  (when (printing-derived-p) (setf dataset nil))
  (princ "(" stream)
  (loop for sublis on (value obj)
	do (write-entity (first sublis) stream enc :dataset dataset :name-only t)
	when (rest sublis) do (princ "," stream))
  (princ ")" stream))

(defmethod write-entity ((obj express-array) stream (enc (eql :p21)) &key dataset)
  (princ "(" stream)
  (with-type-descriptor (l-bound u-bound) obj
    (loop for index from l-bound to (1- u-bound)
	  for elem = (express-aref obj index)
	  do (write-entity elem stream enc :dataset dataset :name-only t)
	  unless (eql index (1- u-bound))
	  do (princ "," stream)))
  (princ ")" stream))

(defmethod write-db (stream (enc (eql :p21)) &key comments raw-data (dataset nil)
			    filename file-description)
  (let (schema)
    (when dataset
      (setf schema (if (typep dataset 'express-dataset)
		       (find-schema (file-schema dataset))
		     ;; It's a x-evaluation
                     (find-schema (target-schema-name (x-schema dataset)))
		     #|(find-if #'(lambda (x) (typep x 'map-schema))
			      (get-special schemas))|# )))
    (unless file-description
      (setf file-description (file-description dataset)))
    (when schema
      (unless raw-data
	(format stream "ISO-10303-21;~%")
	(format stream "HEADER;~%")			;start header section
	(let ((p21-author        (get-option pref-p21-author-opt))
	      (p21-address       (get-option pref-p21-address-opt))
	      (p21-organization  (get-option pref-p21-organization-opt))
	      (p21-authorization (get-option pref-p21-authorization-opt)))
	  (multiple-value-bind (sec min hour day month year)
	      (decode-universal-time (get-universal-time))
	    (format stream "FILE_DESCRIPTION(('~A'),'2;1');~%"
		    (or file-description "no description"))
	    (format stream "FILE_NAME(~2%/* FILENAME          */   '~A',~%" 
		    (if filename (namestring filename) ""))
	    (format stream              "/* CREATION DATE     */   '~A-~2,'0D-~2,'0D T~2,'0D:~2,'0D:~2,'0D',~%" 
		    year month day hour min sec)
	    (format stream              "/* AUTHOR            */   (~@{~A~^,~}),~%"
		    (if (char-equal (char p21-author 0) #\')
			p21-author
		      (format nil "'~A'" p21-author))
		    (if (char-equal (char p21-address 0) #\')
			p21-address
		      (format nil "'~A'" p21-address)))
	    (format stream              "/* ORGANIZATION      */   ~A,~%" p21-organization)
	    (format stream              "/* PROCESSOR VERSION */   '~A',~%" (ee-version))
	    (format stream              "/* PROCESSOR         */   'Expresso',~%")
	    (format stream              "/* AUTHORIZATION     */   '~A');~2%" p21-authorization)
	    (format stream "FILE_SCHEMA(('~a'));~%" (file-schema dataset)))
	(format stream "ENDSEC;~%")			;end header section
	(format stream "DATA;~%")))			;start data section
      (with-schema (schema)
	(format stream "/* ~D instances */~%" (dataset-entity-count dataset))
	(loop with comments-ht = (get-option p21-comments-ht)
	      for key from 1 to (max-name dataset)
	      for instance = (get-instance key dataset)
	      as comment = nil
	      when instance
	        do (when (and comments (setf comment (gethash key comments-ht)))
		     (format stream "~%~A" comment))
		(write-entity instance stream enc :dataset dataset)
		(terpri stream)))
      (unless raw-data
	(format stream "ENDSEC;~%")			;end data section
	(format stream "END-ISO-10303-21;~%")))))

;;; PODsampson heavily rewritten, go to the original for help.
(defun search-for-type-record (goal express-type)
  "2009 (guessing): Follow through a select list starting with EXPRESS-TYPE for the type GOAL."
  (setf express-type (if (classp express-type) express-type (find-class express-type))) 
  (depth-first-search  express-type 
		       #'(lambda (x) (eql x goal))
		       #'(lambda (x)
			   (let ((td (type-descriptor (if (classp x) x (find-class x)))))
			     (typecase td
			       (select-typ (select-list td))
			       (express-defined-type-mo (list td)) 
			       (list express-type))))  
		       :tracking t))

;;; POD I am not certain that searching is a sufficient means to specify nested keywords,
;;; but then I don't know how one could create a value nested like that either! 
;;; (Only can get one from p21 data read in ?!?)
(defmethod write-entity ((obj defined-value) stream (enc (eql :p21)) &key express-type)
  ;; Here record-of-types should be a single symbol.
  (with-slots ((val value) record-of-types) obj
    (when (typep val 'p21-boolean-ref) (setf val (p21-boolean-ref--value val)))
    (when (typep val 'p21-logical-ref) (setf val (p21-logical-ref--value val)))
    (let* ((real-record 
	    (mapcar #'string
		    (if express-type ; PODsampson was (find-eu-class x)
			(remove-if #'(lambda (x) 
				       (setf x (if (classp x) x (find-class x)))
				       (typep (type-descriptor x) 'select-typ))
				   (search-for-type-record record-of-types express-type))
			(list record-of-types))))
	   (simple-value
	    ;; Borrowed from value-string...not quite
	    (cond ((eql val :?) "$")
		  ((null val) "$") ; POD 2009 PODsampson may be temporary.
		  ((eql val :t) ".T.")
		  ((eql val :f) ".F.")
		  ((eql val :u) ".U.")
		  ((keywordp val)(format nil ".~A." val))
		  ((stringp val) (format nil "'~A'" val))
		  (t val))))
      (format stream "~{~A(~}~A~{~*)~}" real-record simple-value real-record))))

;;; The only way to create a 'select-value' is to read one in. Things that print
;;; like this (with nested KEYWORDS), can be created as defined-values, which can
;;; complete the type path.
(defmethod write-entity ((obj select-value) stream (enc (eql :p21)) &key)
  (let* ((types (record-of-types obj))
	 (val (value obj))
	 (simple-value
	  ;; Borrowed from value-string...
	  (cond ((eql val :?) "$")
		((keywordp val)
		 (format nil ".~A." val))
		((stringp val)
		 (format nil "'~A'" val))
		(t val))))
    (format stream "~{~A(~}~A~{~*)~}" types simple-value types)))

;;; added 2009-06-12
(defmethod write-entity ((obj T) stream (enc (eql :p21)) &key)
  (if (null obj)
      (format stream "")
      (format stream "error:(obj=~A)" obj)))

;;; This can be called by the DataCreator for an entity which is not part
;;; of a dataset (only possible if the entity is DERIVED, and the user has
;;; asked to see derived values). 
(defmethod write-entity ((obj entity-root-supertype) stream (enc (eql :p21))
			 &key name-only)
  (let ((dataset (instance-dataset obj)))
    (cond ((and name-only dataset) (format stream "#~D" (entity-id obj dataset)))
          (t
           (when dataset (format stream "#~D=" (entity-id obj dataset))) ; (see note)
           (let* ((class (class-of obj))
                  (internal-name (entity-type-prints-internal-p class)))
             (if internal-name
                 ;; Internal mapping #1=A($,$,$);
                 (let ((types (p21-precedence-order internal-name)))
                   (format stream "~A(~{~A~^,~})" (first (last types))
                           (loop for otypes on types ; PODsampson was find-eu-class
                                 append (attribute-data (find-class (first otypes)) :p21
                                                        :instance obj 
                                                        :dataset (unless (printing-derived-p) dataset)))))
               ;; ...else external mapping #1=(A($,$,$)B($,$)); 
               (let* ((direct-classes (express-class-list class))
                      (all-classes (append direct-classes (supporting-supertypes direct-classes))))
                 (princ #\( stream)
                 (loop for component-name in (sort all-classes #'string<)
                       as component-class = (find-class component-name)
                       as component-short-name = (string (short-name component-class))
                       do (format stream "~A(~{~A~^,~})" component-short-name
                                  (attribute-data component-class enc :instance obj
                                                  :dataset (unless (printing-derived-p) dataset)))
                       )
                 (princ #\) stream))))
           (princ ";" stream)))))

(defmethod attribute-data ((component-class express-entity-type-mo) (enc (eql :p21))
			   &key instance dataset)
  (finalize-inheritance component-class)
  (let* ((component-class-name (class-name component-class))
	 (dslots (class-direct-slots component-class))
	 (eslots (mofi:mapped-slots (class-of instance))))
    (setf eslots (loop for eslot in eslots
		       when (find eslot dslots
				  :test #'(lambda (eslot dslot)
					    (and (eql (slot-definition-name dslot)
						      (slot-definition-simple-name eslot))
						 (eql component-class-name
						      (slot-definition-source eslot)))))
		       collect eslot))
    (loop for esls on eslots
	  as eslot = (first esls)
	  as slot-name = (slot-definition-name eslot)
	  as redefined-by = (slot-definition-redefined-by eslot)
	  ;; According to section 11.2.8 of the 21-TC the value
	  ;; should be printed if the redefinition is explicit.
	  ;; That is, print * if the redefinition is DERIVED only.
	  if (and redefined-by
		  (find redefined-by (express-class-list (class-of instance)))
		  (redef-is-derived-p instance (slot-definition-simple-name eslot) redefined-by))
	  collect "*"
	  else if (not (slot-boundp instance slot-name))
	  collect "$" ; PODsampson was "?"
	  else if (and (typep (slot-value instance slot-name) 'entity-root-supertype)
                       (not (printing-derived-p)))
	  collect (format nil "#~A" (entity-id (slot-value instance slot-name) dataset))
	  else collect (write-entity (slot-value instance slot-name) nil enc
				     :dataset (unless (printing-derived-p) dataset)
                                     :name-only t :express-type (slot-definition-range eslot)))))

(defmethod write-entity ((val p21-boolean-ref) stream (enc (eql :p21)) &key)
  (with-slots (-keyword) val
    (ecase -keyword
      (:t (princ ".T." stream))
      (:f (princ ".F." stream)))))

(defmethod write-entity ((val p21-logical-ref) stream (enc (eql :p21)) &key)
  (with-slots (-keyword) val
    (ecase -keyword
      (:t (princ ".T." stream))
      (:f (princ ".F." stream))
      (:u (princ ".U." stream)))))

(defmethod write-entity ((val string) stream (enc (eql :p21)) &key)
  (princ #\' stream)
  (loop for i from 0 below (length val)
	as ch = (char val i)
	do (princ ch stream)
	when (char= ch #\')
	do (princ #\' stream))
  (princ #\' stream))

(defmethod write-entity ((val integer) stream (enc (eql :p21)) &key)
  (princ val stream))

(defmethod write-entity ((val real) stream (enc (eql :p21)) &key)
  (princ val stream))

(defmethod write-entity ((val symbol) stream (enc (eql :p21)) &key)
  (cond ((eql val :t)  (princ ".T." stream))
	((eql val :f)  (princ ".F." stream))
	((eql val :?)  (princ "$" stream))
	((eql val :*)  (princ "*" stream)) ; POD 2009 how does :* get into the data ?!?!
	((eql val t)   (princ ".T." stream))
	((null val)    (princ "$" stream))
	(t             (format stream ".~A." val))))

(defmethod write-attribute (sdef (obj Entity-Root-Supertype) stream (enc (eql :p21)) &key)
  (let ((val (slot-value obj (slot-definition-name sdef))))
    (cond ((eql val :?)   (princ #\$ stream))
	  ((null val)     (princ "$" stream)) ; PODsampson was "?"
	  ((eql val :t)   (princ ".T." stream))
	  ((eql val :f)   (princ ".F." stream))
	  ((eql val :u)   (princ ".U." stream))
	  ((keywordp val) (format stream ".~A." val))
	  ((stringp val)  (format stream "'~A'" val))
	  (t              (princ val stream)))))

#+podsampson
(defmethod save-data ((model-file part21-file) stream &key filename)
  (when dataset
    (write-db stream enc :filename (or filename "stdout")
	      :dataset (resulting-object model-file)
              :comments (get-option rw-write-p21-comments-opt)
              :raw-data (not (get-special rw-write-p21-header-opt))
              :file-schema (file-schema dataset)
              :file-description (file-description dataset)))
  (info-message "~2%********** Done Writing P21 ********~%"))

#+express-x
(defmethod write-entity ((vi vi-root-supertype) stream (enc (eql :p21))
			 &key dataset source-dataset name-only)
  (declare (ignore source-dataset))
  (flet ((get-vi-value (vi attr)
	   (if (slot-boundp vi attr)
	       (funcall (first (slot-value vi attr))) ; slots are accessors
	       (funcall vi)
;	     (funcall (first vi))	; this one if SELECT is just a value.
	     )))
    (cond (name-only (format stream "#V~D" (entity-id vi dataset)))
	  (t
	    (let* ((class (class-of vi))
		   (slots (class-direct-slots class)))
	      (format stream "#V~a=~a(" 
		      (entity-id vi dataset) 
		      (class-name (first (class-direct-superclasses class))))
	      (cond (slots
		     (suppress-full-vi-print
		      (suppress-full-entity-print
		       (loop for slot-sublis on slots
			     for slot = (first slot-sublis)
			     for slot-name = (slot-definition-name slot)
			     when (slot-boundp vi slot-name) 
			     do (write-entity (get-vi-value vi slot-name) stream :p21
					      :dataset dataset :name-only t)
			     (if (cdr slot-sublis)
				 (princ "," stream)
			       (princ ");" stream))))))
		    (t
		     (suppress-full-vi-print
		      (suppress-full-entity-print
		       (format stream "~a" (get-vi-value vi :simple-value)))))))))))

;;; Only used in GUI???
#+iface-cgtk
(defmethod write-entity ((ref p21-entity-ref) stream (enc (eql :p21))
			 &key dataset source-dataset name-only)
  (let ((ds (or dataset (dataset *frame*))))
    (when-bind (e (get-instance (p21-entity-ref--value ref) ds))
      (write-entity e stream enc :dataset dataset 
                    :source-dataset source-dataset :name-only name-only))))
