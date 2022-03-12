
;;; Peter Denno
;;; Date: 2009-06-15 or so
;;;
;;; Purpose: Read a ISO 10303-28 file into a mofi:population. 
;;;
;;; Copyright Peter Denno, 2009

(in-package :expo)

#|
 (make-instance 'part28-file
      :path #P"sei:data;demo;ap233-part28-sample-file.xml"
      :short-name "sample"
      :of-project (current-app *expresso*))))
|#

(defmethod mofi:model-name ((model express-schema)) (interned-name model))
;(defmethod mofi:depends-on-models ((model express-schema)) nil)

(defvar *mmm* nil "debugging parsed xml.")			 
(defvar *zippy* nil "debugging.")			 

(defun tryme ()
  (pushnew (find-schema :ap233) mofi:*essential-models*)
  (p28-to-model-instance 
   :file #P"sei:lib;ap233-testbed;sample.xml"
   :model-n+1 (find-schema :ap233)
   :instance-xqdm *mmm*))

#+nil
(defun smallme ()
  (pushnew (find-schema :ap233) mofi:*essential-models*)
  (with-debugging (:exp 3)
    (p28-to-model-instance 
     :file #P"sei:lib;ap233-testbed;small.xml"
     :model-n+1 (find-schema :ap233))))

;;; References (not necessarily forward) to other instances.
(defstruct unresolved-entity-ref (:-id))

(defvar *p28id2entity* (make-hash-table :test #'equal) "keyed by XML 'ref' attributes, value is express obj.")
(defvar *p28entity2id* (make-hash-table) "keyed by express obj, value is XML 'ref' attributes")
(defvar *p28-anon-ids* 100000 "Used where P28 doesn't define an ID for the object.")

(defclass express-population (mofi:population)
  ((dataset :initform 
	    (clear-dataset (ensure-dataset 'express-dataset :name "validator"))
	    :reader dataset)))

;;; Based on sysml-population-install-fn, Setting the "name" (p21 notion)
;;; has to be done later. 
(defun express-population-install-fn (obj)
  "A function called by initialize-instance :after -- this one installs OBJ
   in Population.members slot, and in the express dataset."
  (unless mofi::*suppress-install*
    (vector-push-extend obj (mofi:members mofi:*population*))))

(defun p28-to-model-instance (&key model-n+1 instance-xqdm file (force nil) model-n)
  "Toplevel function to parse 10303-28 XML and instantiate a Mn+1 Model (MODEL-N+1) with 
   the population defined in FILE, returning the Mn Model object."
  (dbg-message :time 1 "~%Start process: ~A" (now))
  (let ((doc (or instance-xqdm (xml-utils:xml-document-parser file)))
	(models-governing (list (mofi:model-name  model-n+1))))
    (setf *results* (make-instance 'processing-results))
    (setf *mmm* doc) ; for future execution, while debugging.
    (dbg-message :time 1 "~%XML Read complete: ~A" (now))
    (with-slots (mofi::conditions) *results*
      (setf (fill-pointer mofi::conditions) 0)
      (setf model-n
	    (ensure-model (pathname-name file) :force force
			  :model-class 'express-population
			  :source-file file
			  :processing-results *results*
			  :instance-install-fn #'express-population-install-fn
			  :documentation (format nil "Read from ~A on ~A" file (now))
			  :model-n+1 model-n+1
			  :depends-on-models models-governing)))
      (setf *mm-debug-id* 0)
      (let ((mofi:*model* model-n+1)
	    (mofi:*population* model-n))
	(declare (special *model* *population*))
	;; Set of (model-under-test *spare-session-vo*) is to allow ocl:allInstances to function...but its IFFY!
	(setf (model-under-test *spare-session-vo*) *population*)
	(setf mofi::*debug-population* *population*)
	(with-slots (mofi:members) *population*
	  (setf (fill-pointer mofi:members) 0)
	  (clrhash *p28id2entity*)
	  (clrhash *p28entity2id*)
	  (setf *p28-anon-ids* 100000)
	  ;(clear-debugging)
	  (with-debugging (:exp 0)
	    (p28-read-doc doc))
	  (p28-post-process model-n)
	  (dbg-message :time 1 "~%Created ~A Elements: ~A" (fill-pointer mofi:members) (now))
	  (let ((progress t)) 
	    (loop for i from 1 to 7 while progress do
		  (dbg-message :time 1 "~%Start Propagate: ~A" (now))
		  (setf progress nil))))
      (dbg-message :time 1 "~%Post-processing completed: ~A" (now))
      model-n)))

;;; POD and how is AND/OR described?!?!
(defun p28-elem-class (elem)
  "Return the programmatic class (if an entity type is referenced by ELEM), 
   or the defined type (if a defined typ is referenced by ELEM)."
  (mvb (success array) 
      (cl-ppcre:scan-to-strings "([a-z,A-Z,0-9,_]+)(-wrapper)?" (xml-elem-name elem))
    (if success
	(let ((class-name (intern (string-upcase (aref array 0)) :ap233)))
	  (if (and (eql (find-package :ap233) (symbol-package class-name)) 
		   (find-class class-name nil))
	      (if (aref array 1) ; then had '-wrapper'; it is a defined type.
		  (find-class class-name)
		  (find-programmatic-class (list class-name)))
	      (warn "I don't know this class: ~A" class-name)))
	(error "Cannot parse class name."))))

(defun p28-read-doc (doc)
  "Read the document creating instances for the 'top-level' XML content."
  (loop for elem in (xml-utils:xml-children (car (xml-utils:xml-children doc)))
         when (dom:element-p elem) do
          (when-bind (pclass (p28-elem-class elem))
	    (p28-make-entity-instance pclass elem))))

(defun p28-post-process (population)
  "Perform all post processing tasks of reading P28, including resolving entity references etc."
  (p28-resolve-entity-ref population)
  (connect-inverses (dataset population)))

(defmethod p28-resolve-entity-ref ((m mofi:population))
  "Resolve entity references."
  (loop for obj across (mofi:members m) 
     do (p28-resolve-entity-ref obj)))

(defmethod p28-resolve-entity-ref ((m entity-root-supertype))
  "Loop through the mapped slots of a type, resolving entity references."
  (loop for slot in (mofi::mapped-slots (class-of m))
        for slot-name = (slot-definition-name slot) do 
        (setf (slot-value m slot-name)
	      (p28-resolve-entity-ref (slot-value m slot-name))))
  m)

;;; POD wasteful list construction.
(defmethod p28-resolve-entity-ref ((agg express-aggregate))
  (setf (value agg)
	(loop for elem in (value agg)
	     collect (p28-resolve-entity-ref elem)))
  agg)

(defmethod p28-resolve-entity-ref ((ref unresolved-entity-ref))
  (let ((id (unresolved-entity-ref--id ref)))
    (or 
     (gethash id *p28id2entity*)
     (warn "Reference made to an entity ID '~A' not found in the file."))))

(defmethod p28-resolve-entity-ref ((m T))
  m)

(defun connect-inverses (dataset)
  "Maphash through all the inverse slots and set existing instances
   according to the description in the slot-definition inverse slot."
  (flet ((add-inv (source target eslot)
          "Add the SOURCE to the SLOT of the the TARGET instance.
              source - the instance to be added.
              target - a target instance.
              eslot  - the effective-slot in the target where the source will be added."
          (let ((type (mofi:slot-definition-range eslot))
                (name (slot-definition-name eslot)))
            (when (and (get-option rw-ignore-optional-opt)
                       (eql target :?))
              (return-from add-inv nil))
            (cond ((typep type 'aggregation-typ)
                   (cond ((null (slot-value target name))
                          (setf (slot-value target name)
				(make-one type (list source))))
                         ;; Aggregate, at least one value already added.
                         ;; Do in-place update.
                         (t
                          (let ((agg (slot-value target name)))
                            (setf (value agg)
                                  (if (typep type 'set-typ)
                                      ;; POD to be truely painful should test be
                                      ;; express-entity-equal?
                                      (remove-duplicates (cons source (value agg)))
                                    (cons source (value agg))))))))
                  (t ;; Not aggregate just put it there.
		   (setf (slot-value target name) source))))))
    ;;----------------
    ;; 'SOURCE' is the thing that already has the value; it is named by the islot's slot-definition-inverse.
    ;; (The islot.inverse contains instructions of how to get the value for the islot. 
    ;; For example Representation_context.representations_in_context instructions are:
    ;;    SET[1:?] OF Representation FOR context_of_items;
    ;; (inverse-slots schema) is an INVERSE slot (islot). It is a TARGET of the value in the SOURCE.
    (loop for class being the hash-value of (entity-types (schema *expresso*)) 
	 do (finalize-inheritance class)
	 (loop for islot in (class-direct-slots class) do
	      (when-bind (inverse (slot-definition-inverse islot)) ; then need to fill this slot.
		(let ((source-class-name (first inverse))
		      (source-slot-name (second inverse)))
		  (flet ((lookup-eslot (obj)
			   (find (compose-slot-name ; amazingly wasteful (and called in aggs). 
				  (slot-definition-source islot)
				  (slot-definition-name islot))
				 (class-slots (class-of obj))
				 :key #'slot-definition-name)))
		    ;; Loop through instances (sources), for each instance in the slot (a TARGET)
		    ;; update it with the source. 
		    (loop for source being the hash-value of (extent (find-class source-class-name) dataset)
		       for one-or-agg = (funcall (string2accessor-name (symbol-name source-slot-name))
						 source nil)
		       do 
			 (typecase one-or-agg
			   (express-aggregate
			    (loop for elem in (value one-or-agg) do 
				 (when-bind (eslot (lookup-eslot elem))
				 (add-inv source elem eslot))))
			   (otherwise 
			    (when-bind (eslot (lookup-eslot one-or-agg))
			      (add-inv source one-or-agg eslot))))))))))))

(declaim (inline elem-children))
(defun elem-children (elem)
  "Return the dom:element-p children of ELEM."
  (remove-if
   (complement #'(lambda (x) (dom:element-p x)))
   (xml-utils:xml-children elem)))

(defun xml-string (elem)
  "Return the node XML serialization."
  (with-output-to-string (s)
    (let (#+nil(*default-namespaces*
	   (append (list 
		    (cons "ap233" 
			  (find-package "http://www.tc184-sc4.org/10303/-233/tech/systems_engineering"))
		    xmlp-ignore::*default-namespaces*))))
      (xml-utils:xml-write-node elem s))))

(defun p28-make-entity-instance (pclass entity-elem &key (warn-p t))
  "Create an instance of PCLASS (a programmatic CLOS class object) from ELEM (dom:element-p). 
   Populate the slots of the instance from values found in the children of ELEM."
  (dbg-message :exp 3 "~2% entity-elem = ~A" (xml-string entity-elem))
  (let ((initargs (initarg-pairs entity-elem pclass))
	(id (xml-get-attr entity-elem "id")))
    (when warn-p (unless id (warn "No ID for ~A" (xml-string entity-elem))))
    (dbg-message :exp 3 "~2%(make-instance ~A ~{~S ~})" pclass initargs)
    (let ((inst (apply #'make-instance pclass initargs)))
      (setf (gethash id *p28id2entity*) inst)
      (setf (mof:%source-elem inst) entity-elem)
      (with-slots (dataset) mofi:*population*
	(if id
	  (mvb (success array) (cl-ppcre:scan-to-strings "id-([0-9]+)" id)
	    (if success
		(progn 
		  (setf id (read-from-string (aref array 0)))
		  (if (numberp id) 
		      (if (< id 100000)
			  (setf (gethash inst *p28entity2id*) id)
			  (warn "ID in reserved range; ~A" id))
		      (warn "Cannot parse ID ~S" id)))
		(warn "Expecting ID like id-([0-9]+): ~S" id)))
	  (setf id (incf *p28-anon-ids*)))
	(when (numberp id) (store-instance inst id :dataset dataset)))
      inst)))

(defun initarg-pairs (entity-elem pclass)
  "Return a list of 2 element lists of form (<initarg-keyword> <value>) from data
   obtained as the children of ENTITY-ELEM. In this conformance class of P28, a child element
   names an express attribute, and its child content is the value of that attribute.
   If the content is string content, use it directly. If it is instead an element, 
   it is either an entity reference, an aggregate, or a named data type."
  (loop for c in (elem-children entity-elem) ; child tag names an attribute, child content is the attr value.
        for slot = (or (p28-find-slot pclass (xml-elem-name c))
		       (warn "Cannot find slot in ~A named ~A." 
			     (class-name pclass) (xml-elem-name c)))
        for typ = (and slot (slot-definition-range slot))
        for attr-name = (slot-definition-name slot) ; for debugging.
        when typ append (list (car (slot-definition-initargs slot))
			      (p28-parse-content typ (xml-utils:xml-children c) attr-name))))

(defun p28-find-slot (pclass slot-name)
    "PCLASS is a instantable-express-entity-type-mo, SLOT-NAME is a string naming slot.
     Return the effective-slot of that name."
    (or
     (find slot-name
	   (closer-mop:class-slots pclass)
	   :key #'slot-definition-simple-name
	   :test #'string-equal)
     (error "Cannot parse slot-name: ~A" slot-name)))

;;;  "CONTENT is a list of  xqdm objects. TYP is the type descriptor indicating how the element content 
;;;   should be interpreted. The function returns an object of the TYP (a string, a number, an 
;;;   unresolved-entity-ref, an aggregate or a 'select value' (see express-metaobjects.lisp 
;;;   expo:defined-value / expo:select-value)." 
(defmethod p28-parse-content :around ((typ T) content attr-name)
  (dbg-message :exp 3 "~2%typ = ~A attr = ~A ~%content=~{~A~%~}" 
  	       typ attr-name (mapcar #'xml-string (mklist content)))
  (let ((result (call-next-method)))
    (dbg-message :exp 3 "result = ~S" result)
    result))

(defmethod p28-parse-content :around ((typ simple-typ) content attr-name)
  (if (or (null content) (single-p content))
      (call-next-method)
      (warn "Expected simple type content: ~A = ~A"  attr-name (xml-string content))))

(defmethod p28-parse-content ((typ string-typ) val attr-name)
  (when val
    (setf val (car val))
    (if (stringp val) val (warn "Expected string content: ~A = ~A" attr-name val))))

(defmethod p28-parse-content ((typ number-typ) val attr-name)
  (when val
    (setf val (read-from-string (car val)))
    (if (numberp val) val (warn "Expected number content: ~A = ~A" attr-name val))))

(defmethod p28-parse-content ((typ logical-typ) val attr-name)
  (when val
    (setf val (car val))
    (cond ((string-equal val "TRUE") :t)
	  ((string-equal val "FALSE") :f)
	  ((string-equal val "UNKNOWN") :u)
	  (t (warn "Expected logical content: ~A = ~A" attr-name val)))))

(defmethod p28-parse-content ((typ enum-typ) val attr-name)
  (when val
    (kintern (car val))))

(defmethod p28-parse-content ((typ symbol) content attr-name)
  "Content here is element content. May be an entity reference or in-line definition."
  (when content
    (if-bind (class (find-class typ nil))
       (p28-parse-content class content attr-name)
       (warn "I don't know this typ: ~A" typ))))

(defmethod p28-parse-content ((typ express-defined-type-mo) content attr-name)
  (setf content (remove-if-not #'(lambda (x) (dom:element-p x)) content))
  (when content
    (if-bind (ref (xml-get-attr (car content) "ref")) ; POD not much checking...
     (make-unresolved-entity-ref :-id ref)
     (p28-make-defined-type-value typ (car content)))))

(defmethod p28-parse-content ((typ express-entity-type-mo) content attr-name)
  (setf content (remove-if-not #'(lambda (x) (dom:element-p x)) content))
  (when content
    (if-bind (ref (xml-get-attr (car content) "ref")) ; POD not much checking...
      (make-unresolved-entity-ref :-id ref)
      (p28-make-entity-instance (p28-elem-class (car content)) (car content) :warn-p nil))))

(defun p28-make-defined-type-value (class elem)
  "CLASS is an express-defined-type-mo. ELEM is content."
  (let ((val (car (xml-utils:xml-children elem)))
	(btypes (base-types class)))
    (make-one class
	      (cond ((intersection btypes '(:number :integer :real))
		     (setf val (read-from-string val))
		     (if (numberp val) val (warn "Expected a number. Got ~A" (car (xml-utils:xml-children elem)))))
		    ((member :string btypes) val)
		    ((intersection btypes '(:logical :boolean))
		     (cond ((string-equal val "true") :t)
			   ((string-equal val "false") :f)
			   ((string-equal val "unknown") :u)
			   (t (warn "Expected a logical. Got ~A" (car (xml-utils:xml-children elem))))))
		    (t (error "I don't know what to do with this type: ~A" btypes))))))

;;; Point of (list x) is that some calls expect multiple children ???
(defmethod p28-parse-content ((typ aggregation-typ) content attr-name)
  (when content
    (unless (some #'(lambda (x) (dom:element-p x)) content)
      (error "I don't know what to do with this aggregate: ~A" content)) ; POD NYI
    (let ((agg-content (remove-if-not #'(lambda (x) (dom:element-p x)) content))
	  (base-type (base-type typ)))
      (make-one typ (mapcar #'(lambda (x) (p28-parse-content base-type (list x) attr-name))
				  agg-content)))))

(defmethod p28-parse-content ((typ logical-typ) content attr-name)
  (let ((val (car content)))
    (cond ((string-equal val "true") :t)
	  ((string-equal val "false") :f)
	  ((string-equal val "unknown") :u)
	  (t (warn "Expected a logical: ~A = ~A" attr-name val)))))

(defmethod p28-parse-content ((typ boolean-typ) content attr-name)
  (let ((val (car content)))
    (cond ((string-equal val "true") :t)
	  ((string-equal val "false") :f)
	  (t (warn "Expected a Boolean: ~A = ~A" attr-name val)))))


(defmethod p28-parse-content ((typ T) content attr-name)
  (warn "I don't know what I'm doing here. typ = ~A~%content= ~A" typ (xml-string content)))


    

   


  
		




