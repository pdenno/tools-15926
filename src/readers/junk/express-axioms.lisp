

;;; Purpose: Create axiomatic form from mexico express form. 
;;; Date: 2012-04-18

(in-package :iso15926-2)

(defun reset-15926-mofi-members ()
  "mofi:members does not include EntityTypes (which are computed), so I pick up the
  Schema object and reset model.members to (%schema-element Schema). Then I can do
  debugging with mm-find-instance. Return T if you do something."
  (when-bind (model (mofi:find-model :15926-2))
    (setf (mofi::mut *spare-session-vo*) model)
    (when (find-if #'(lambda (x) (typep x 'mex:|ScopedId|)) (coerce (mofi:members model) 'list))
      (when-bind (schema (find-if #'(lambda (x) (typep x 'mex:|Schema|)) (mofi:members model)))
	(let* ((elems (mex:%schema-elements schema))
	       (len (length elems)))
	(setf (slot-value model 'mofi:members)
	      (make-array (1+ len) :initial-contents (cons schema elems) :fill-pointer (1+ len)))))
      t)))

(defmemo-equal dash-to-camel! (name)
  (dash-to-camel name))       

(declaim (inline camel-name))
(defun camel-name (named-type)
  (intern (dash-to-camel! (mex:%local-name (mex:%id named-type)))))

(defun mex2ax ()
  "Toplevel to generate axioms."
  (if-bind (model (mofi:find-model :15926-2))
    (progn
      (ensure-trie-db :15926-2)
      (with-trie-db (:15926-2)
	(reset-15926-mofi-members)
	(let* ((members (coerce (mofi:members model) 'list))
	       (entity-types (remove-if-not #'(lambda (x) (typep x 'mex:|EntityType|)) members)))
	  (loop for e in entity-types do 
;	       (trie-add `(|instance| ,(camel-name e) |NonNullSet|)) ; needed for BinaryPredicate disjoint, at least.
	       (mex2ax-subclass e)
	       (mex2ax-abstract e)
	       (mex2ax-oneof e))
	  (mex2ax-roles entity-types))
	(format t "~3%")
	(format t "~{~%~A~}" (sort (trie-query-all '(|subclass| ?x ?y)) #'string< :key #'second))
	(format t "~{~%~A~}" (sort (trie-query-all '(|instance| ?X |Abstract|)) #'string< :key #'second))
	(format t "~{~%~A~}" (sort (trie-query-all '(|disjoint| ?x ?y)) #'string< :key #'second))
	(format t "~{~%~A~}" (sort (trie-query-all '(=> ?x ?y)) #'string< :key #'caadr))))
    (error "Load Part 2 EXPRESS (using MEXICO injector) before running this.")))

(defun mex2ax-subclass (e)
  "Output subclass axioms."
  (when-bind (supers (mex:%subtype-of e))
    (loop for s in supers with sub = (camel-name e)
       do (trie-add `(|subclass| ,sub ,(camel-name s))))))

(defun mex2ax-abstract (e)
  "Output abstract axioms"
  (when (eql :true (mex:%is-abstract e))
    (trie-add `(|instance| ,(camel-name e) |Abstract|))))

(defun mex2ax-oneof (e)
  "Output ONEOF constraints."
  (loop for c in (mex:%subtype-constraints e) do
       (typecase c
	 (mex:|ONEOFConstraint|
	      (loop for pair in (pod:pairs (mapcar #'camel-name (mex:%collection c)))
		 do (trie-add `(|disjoint| ,(car pair) ,(cadr pair)))))
	 (mex:|ANDConstraint| (error "There are no AND constraints in 15926-2"))
	 (t (warn "WHat is this: ~A?" c)))))

(defun mex2ax-roles (entity-types)
  "Output role constraints."
  ;; Some pre-processing used by the called functions.
  (let* ((single-entity-types (mapcar #'mex:%declares entity-types))
	 (all-attrs (mapappend #'mex:%declares single-entity-types)))
    (loop for a in all-attrs do
	 (trie-add `(entity-declares-attr 
		     ,(camel-name (mex:%of-entity a))
		     ,(intern (format nil "has~A" (dash-to-camel (mex:%local-name (mex:%id a)))))))
	 (unless (eql :list-type (parse-type (mex:%attribute-type a)))
	   (trie-add `(entity-attr-type-opt
		       ,(camel-name (mex:%of-entity a))
		       ,(intern (format nil "has~A" (dash-to-camel (mex:%local-name (mex:%id a)))))
		       ,(parse-type (mex:%attribute-type a))
		       ,(if (eql (mex:%is-optional a) :true) :optional :mandatory)))))
  (mex2ax-roles-implies-possessor-type)
  (mex2ax-roles-implies-attr-type single-entity-types)
  (mex2ax-roles-implies-attr-exists single-entity-types)
  (mex2ax-roles-implies-attr-uniqueness single-entity-types)))

;;; There are no nested aggregate types and no SELECTS in 15926-2! Thus this is cheezy.
(defun parse-type (type)
  "Return the type symbol of the argument attribute ATTR."
  ;(setf *zippy* type)
  (typecase type
    (mex:|IntegerType| '|ExpressInteger|)
    (mex:|RealType| '|ExpressReal|)
    (mex:|BooleanType| '|ExpressBoolean|)
    (mex:|LogicType| '|ExpressLogical|)
    (mex:|BinaryType| '|ExpressBinary|)
    (mex:|StringType| '|ExpressString|)
    (mex:|LISTType| ; mex:|ConcreteAggregationType| 
	 :list-type);(parse-type (mex:%member-type type)))
    (mex:|ConcreteAggregationType| (break "Only have LIST types?"))
    (t (camel-name type))))

;;; This is weaker than ideal because names are not unique.
;;;
;;; a - (=> (hasApproved ?x ?y) (instance ?x Approval))
;;; b - (=> (and (Approval ?x) (hasApproved ?x ?y)) (instance ?Y Relationship)) 
;;;
;;; Dealing with same-named properties:
;;;  For type (a) we use a disjunction on the type of the possessor in the consequent.
;;;  For type (b) we use the class of the possessor in the antecedent.
;;;
;;; This is type (a) first role, ?X, in consequent
(defun mex2ax-roles-implies-possessor-type ()
  "Output axioms that infer instance type from possesion of the property."
  ;; Several entity types may define an attribute of same name, so we need to do some work.   
  (loop for attr-name in (remove-duplicates (mapcar #'third (trie-query-all '(entity-declares-attr ?X ?Y)))) do
       (let ((types (mapcar #'second (trie-query-all `(entity-declares-attr ?e ,attr-name)))))
	 (cond ((null types) (error "huh?"))
	       ((single-p types)
		(trie-add `(=> (,attr-name ?X ?Y) (|instance| ?X ,(car types)))))
	       (t 
		(trie-add `(=> (,attr-name ?X ?Y) 
			       (|or| ,@(mapcar #'(lambda (x) `(|instance| ?X ,x)) types)))))))))

;;; This is weaker than ideal because names are not unique.
;;; This is type (b) second role, ?Y, in consequent, antecedent is a conjunction (always - for simplicity).
(defun mex2ax-roles-implies-attr-type (single-entity-types)
  "Output axioms that infer the type possessed from possesion of the property."
  ;; Several entity types may define an attribute of same name, so we need to do some work.
  (loop for e in single-entity-types 
        for ename = (camel-name e) do
       (loop for query in (trie-query-all `(entity-declares-attr ,ename ?a))
             for attr = (third query)
	     for type = (fourth (trie-query `(entity-attr-type-opt ?e ,attr ?t ?opt))) ; won't have it if list
	  when type do (trie-add `(=> (|and| (|instance| ?X ,ename) (,attr ?X ?Y)) (|instance| ?Y ,type))))))


;;; c - (=> (Approval ?x) (exists ?y (hasApproved ?x ?y))  
(defun mex2ax-roles-implies-attr-exists (single-entity-types)
  "Output axioms that infer the existence of a mandatory property when an instance of the type exists."
  (loop for e in single-entity-types 
        for ename = (camel-name e) do
       (loop for query in (trie-query-all `(entity-attr-type-opt ,ename ?a ?t :mandatory))
	     for attr = (third query) do
	    (trie-add `(=> (|instance| ?X ,ename) (|exists| (?Y) (,attr ?X ?Y)))))))
  

;;; d - (=> (and (Approval ?x) (hasApproved ?x ?y) (hasApproved ?x ?z)) (equal ?y ?z))	     
(defun mex2ax-roles-implies-attr-uniqueness (single-entity-types)
  "Output axioms that infer the uniqueness a property when an instance of the type exists."
  (loop for e in single-entity-types 
        for ename = (camel-name e) do
       (loop for query in (trie-query-all `(entity-attr-type-opt ,ename ?a ?t ?opt))
	     for attr = (third query) do
	    (trie-add `(=> (and (|instance| ?X ,ename) 
				(,attr ?X ?Y)
				(,attr ?X ?Z))
			   (|equal| ?Y ?Z))))))
