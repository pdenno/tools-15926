;;; Copyright (c) 2007 Peter Denno
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


(in-package :p11p)

;;; Purpose: Scope management functions. 
;;; 
;;;   Identifiers have type -- the type of object named by the identifier 
;;;   Scopes have type -- the MM type that provides a scoping environment for identifiers.
;;;   Function add-type is at the intersection of the two, it adds an identifier type to a scope object.

#|
The subtypes of Scope in the EXPRESS(-X) MM are:
(|CommonScope|  -- Abstract
 |LocalScope| -- Abstract
 |GlobalRule| 
 |EntityType|
 |SelectType|
 |Schema|
 |NamedType|   -- Abstract
 |DefinedType|  -- Abstract
 |EnumerationType| 
 |Procedure|
 |Function|
 |Algorithm| -- Abstract
 |AlgorithmScope|  -- Abstract
 |Query|
 |SpecializedType|
 |MapSpec| 
|#

(defmethod initialize-instance :after ((obj |Scope|) &key)
  (setf (%%ids obj) (make-hash-table :test #'equal))
  (when (%%parent obj)
    (push obj (%%children (%%parent obj)))))

;pod7 p11p:*p11-reserved-words*
(defmethod initialize-instance :after ((obj |Schema|) &key)
  (setf (%id obj) (%name obj)) ; PODTT
  (loop for name in (mofi:reserved-words (mofi:find-model :mexico)) do
	; for iname = (p11uintern name) do PODTT commented
	(add-type name obj :reserved) ; PODTT was iname PODsampson s-u
	(make-scoped-id name :force-scope obj)) ; PODTT was iname PODsampson s-u
  (loop for name in 
	(append
	'("ABS" "ACOS" "ASIN" "ATAN" "BLENGTH" "COS"
	  "EXISTS" "EXP" "FORMAT" "HIBOUND" "HIINDEX" "LENGTH"
	  "LOBOUND" "LOINDEX" "LOG" "LOG2" "LOG10" "NVL" 
	  "ODD" "ROLESOF" "SIN" "SIZEOF" "SQRT" "TAN" "TYPEOF"
	  "USEDIN" "VALUE" "VALUE_IN" "VALUE_UNIQUE")
	(mapcar #'string (mofi:enum-values (find-class '|BinaryOperator|)))
	(mapcar #'string (mofi:enum-values (find-class '|UnaryOperator|)))
	;; PODTT effective methods -- might be going away. 
	'("Equal" "StringEqual" "LogicalEqual" "ListEqual" "BagEqual" "EnumEqual" "ArrayEqual" "BinaryEqual"        
	  "EntityValueEqual"  "Add" "BagAdd" "BagUnion" "ListAppend" "BinaryAppend" "SetAdd" "SetUnion" 
	  "StringAppend" "ListAddFirst" "ListAddLast" "Subtract"  "BagDifference" "BagRemove" "Greater" 
	  "LogicalGreater" "StringGreater" "EnumGreater" "BinaryGreater" "Less" "StringLess" "LogicalLess" 
	  "EnumLess"  "BinaryLess" "Unequal" "ArrayUnequal" "BagUnequal" "EnumUnequal" "ListUnequal" 
	  "EntityValueUnequal" "BinaryUnequal" "LogicalUnequal"  "StringUnequal" "GreaterEqual" 
	  "EnumGreaterEqual"  "LogicalGreaterEqual" "StringGreaterEqual" "BinaryGreaterEqual"        
	  "LessEqual" "EnumLessEqual" "LogicalLessEqual" "StringLessEqual" "BinaryLessEqual" "Subset" 
	  "EntityInstanceEqual" "BagInstanceEqual" "ListInstanceEqual" "EntityInstanceUnequal" 
	  "BagInstanceUnequal" "ListInstanceUnequal" "RealDivide" "Multiply" "Intersection" "Substitute"))
	do (add-type name obj :function))) ; PODsampson s-u was string

(defmethod print-object ((obj |Scope|) stream)
  (format stream "|Scope ~A (a ~A)|" 
	  (if (slot-exists-p obj '|id|)
	      (if-bind (id (%id obj)) 
	       (if (typep id '|ScopedId|) (%local-name id) id)
	       "[unnamed]")
	      "[unnamed]")
	  (class-name (class-of obj))))

(defmethod print-object ((obj |Schema|) stream)
  (format stream "|Scope ~A (a ~A)|" (%name obj) (class-name (class-of obj))))

(defclass fake-scoped-id (|ScopedId|)
  ()
  (:metaclass mofi::mm-type-mo))

(defparameter *scoped-ids* (make-hash-table :test #'equal) "ID objects keyed by (p11u:name . |Scope|)")

(defun make-scoped-id (name &key (scope *scope*) force-scope) ; only specify scope in lookup-scope-id
 "Make a |ScopeId| using SCOPE to determine the scope in which it is defined. 
  Set %defining-scope to SCOPE.
  This gets called for references too. It is essentially memoized by name and defining-scope, 
  but does the additional work of seting the defining-scope if it isn't set and in the %ids of SCOPE."
 (let* ((uname (string-upcase name)) ; PODsampson s-u
	(scope-of (or force-scope (exp-token-scope uname :start-scope scope))) ; PODTT was iname 
	(key (cons uname scope-of)) ; pod wasteful, uniqueify. PODTT was iname 
	(id 
	 (or 
	  (gethash key *scoped-ids*) 
	  (setf (gethash key *scoped-ids*)
		(typecase scope-of
		  (|Schema|
		   (make-instance '|ScopedId| :local-name name ; PODTT :old-type :schema-scoped-id
				  :token-position (token-position *token-stream*)))
		  ((or |SpecializedType| |EntityType| #|PODTT |MapSpec||#)
		   (make-instance '|ScopedId| :local-name name ; PODTT :old-type :type-scoped-id
				  :token-position (token-position *token-stream*)))
		  ((or |QueryExpression| |Function| |RepeatStatement| |GlobalRule| |ForEachExpression|) 
		   (make-instance '|ScopedId| :local-name name :defining-scope scope ;PODTT :old-type :local-id
				  :token-position (token-position *token-stream*)))
		  (t ; NUMBER etc names a type, thus I'd like a scope for it...
		   (warn "POD, review this? sname = ~A scope = ~A" name scope)
		   (make-instance 'fake-scoped-id :local-name name :defining-scope :express)))))))
   (unless (typep id '|AttributeRef|)
     (when (and (null (%defining-scope id))
		(gethash uname (%%ids (or force-scope scope)))) ; PODTT was iname PODsampson (s-u name)
       (setf (%defining-scope id) (or force-scope scope))))
   id))

(defmethod add-type (name (scope |Scope|) type)
  "Used in the first pass of parsers to add ids to the %%ids hash table of a %%scope (recording their type). 
   %%ids is keyed by the id and lists all the declaration types that the id is in that scope. 
   Records the file-position of the declaration, but this is only accurate when the token 
   was the last thing read."
   (with-slots (|%ids|) scope
    (pushnew (cons type (token-position name)) (gethash (string-upcase name) |%ids|) :test #'equal)
    (when (and (eql type :attribute) (%%parent scope))
      (add-type (string-upcase name) (%%parent scope) :attribute)))) ; PODsampson

(defun find-child-scope (&key name contains (scope *scope*))
  "Find a |Scope| that is a direct child of *scope* and contains NAME or satisfies the parameters 
   specified in CONTAINS. NAME names a scope (or is nil, and can be either a ScopedID or a string). 
   CONTAINS.INAME is a name found in it. CONTAINS is a list of:
   (<a symbol representing a Scope type> <token or 'p11u::anonymous-repeat> <token-postition>)."
    (cond (name
	   (let ((name (typecase name (string name) (|ScopedId| (%local-name name)))))
	     (or 
	      (find name (%%children scope)
		    :test #'string-equal
		    :key #'(lambda (x)
			     (let ((id (%id x)))
			       (if (typep id 'mexico:|ScopedId|) (%local-name id) id))))
	      (error 'scope-error 
		     :text (format nil "Could not find scope with name: ~A." name)))))
	  (contains
	   (dbind (itype name token-pos) contains ; itype is |QueryExpression| or |RepeatStatement|
	    (or 
	     (depth-first-search scope 
				 #'(lambda (c)
				     (and (typep c itype)
					  ;; PODTT was iname ; PODsampson s-u
					  (member token-pos (gethash (string-upcase name) (%%ids c))
						  :key #'cdr :test #'=)))
				 #'%%children
				 :on-fail nil)
	     (error 'scope-error
		    :text (format nil "Could not find scope of type ~A containing ~A at position ~A."
				  itype name token-pos))))))) ; PODTT was iname

(defun make-scoped-id-alias (name id) ; name is probably always "SELF"
  (setf (gethash (cons name *scope*) *scoped-ids*) id)) ; PODTT was (p11uintern name)

;;; Return AN object created by make-scoped-id, thus this resolves references and, 
;;; therefore, except for references to SELF and other ConstantRefs, can only be used 
;;; in post-processing. 
(defun name2scoped-id (name &key (scope *scope*) all) ; :all is for diagnostics
  (let (collect)
    (if all
	(progn
	  (depth-first-search 
	   scope 
	   #'(lambda (x) (declare (ignore x)) nil) 
	   #'%%children 
	   :do #'(lambda (s)
		   (when-bind (found (name2scoped-id-aux name :scope s :error-p nil))
			      (pushnew found collect))))
	  collect)
      (name2scoped-id-aux name :scope scope))))

(defun name2scoped-id-aux (name &key scope (error-p t))
  (loop for s = scope then (%%parent s)
     ;; pod wasteful PODTT was (p11uintern name) 
     ;; 2009-06-23 replaced by the equally wasteful ;^) string-upcase
	for key = (cons (string-upcase name) s) with hit = nil while s 
	when (setf hit (gethash key *scoped-ids*)) return hit
	finally 
	(when error-p 
	  (error 'scope-error
		 :text (format nil "Failed to find name '~A' in scope ~A." name scope)))))

(defun cleanup-scoped-ids ()
  (loop for id being the hash-value of *scoped-ids* using (hash-key key)
	unless (%defining-scope id) do
	;(warn "Line ~A: ScopedId does not specify namespace: ~A." (%defined-at id) id)
	(remhash key *scoped-ids*)))

(defvar *allow-inheritance-from-other-schema* nil)
(defmethod exp-token-scope (name &key (start-scope *scope*) (error-p t)
			(inherit-p *allow-inheritance-from-other-schema*))
  "Return the |Scope| object for the argument NAME."
  (let ((result 
	 (loop for scope = start-scope then (%%parent scope) while scope
	       when (gethash (string-upcase name) (%%ids scope)) return scope))) ; PODsampson s-u
    ;; In Express-x, look in source and target schema inherited EntityTypes.
    (when (and (null result) inherit-p)
      (setf result
	    (find (string name) (%%inherited-objects (schema-scope start-scope))
		  :key #'(lambda (x) (%local-name (%id x)))
		  :test #'string-equal)))
    (when (and error-p (null result))
      (error 'scope-error 
	     :text (format nil "Could not find scope for identifier ~A.~%Start scope is ~A." name start-scope)))
    result))

(defun find-scope-upward (scope test)
  "Look upward from SCOPE for first scope passing TEST an function of one argument."
  (loop for s = scope then (%%parent s)	while s
	until (funcall test s)
	finally (return s)))

(defun schema-scope (scope)
  (find-scope-upward scope #'(lambda (x) (typep x '|Schema|))))

;;;============================================================
;;; Token type (in a given scope)
;;;============================================================
(defun token-all-types (name scope)
  "Name is a string or p11uinterned, if a reserved word."
  (gethash (string-upcase name) (%%ids scope))) ; PODsampson s-u

(defmethod token-is (name type (scope symbol) &key)
  (warn "~% scope is ~A" scope)
  nil)

(defmethod token-is (name type (scope |Scope|) &key)
  "NAME is an identifier. TYPE is a keyword: :entity, :function 
   :procedure :enum-val :constant :type :variable :parameter"
  (when (typep name 'string) (setf name (string-upcase name))) ; PODsampson s-u
  (with-slots (|%ids| |%parent|) scope
    (or 
     (and (hash-table-p |%ids|)
	  (member type (gethash name |%ids|) :key #'car))
     (when |%parent| (token-is name type |%parent|)))))

(defun entity-p (name)
  (token-is name :entity *scope*))

(defun enum-val-p (name)
  (token-is name :enum-val *scope*))

(defun constant-p (name)
  (or (member name '(const_e pi self #\? "?") :test #'equal) ; PODsampson added "?" 
      (token-is name :constant *scope*)))

(defun function-p (name)
  (or (member name (mofi:operator-strings mofi:*model*) :test #'string-equal) 
      (token-is name :function *scope*)))

(defun procedure-p (name)
  (or (member name '(insert remove))
      (token-is name :procedure *scope*)))

(defun type-p (name)
  (or (member name '(binary boolean integer logical number real string
			array bag list set))
	 (token-is name :type *scope*)))

(defun type-label-p (name)
  (token-is name :type-label *scope*))

(defun local-p (name)
  (token-is name :variable *scope*))

(defun parameter-p (name)
  (token-is name :parameter *scope*))

(defun variable-p (name)
  (or
   (local-p name)
   (parameter-p name)))

;;; POD -- Here I am trying to deal with the issue of an attribute referenced in 
;;;        a function, global rule, or entity definition refers through navigation
;;;        to an attribute in any entity. 
(defun attribute-p (name &optional (scope *scope*))
  (when scope
    (or (token-is name :attribute scope)
	(when-bind (parent (%%parent scope))
	  (token-is name :attribute parent)))))


;;; pod7 from injector/post-process.lisp

;;; POD 2007-02-09 was defmemo
(defun lookup-referenceable (id) 
  "ID is a ScopedID. Returns the object which has this as its %id."
  (when-bind (type-name (car (member (%local-name id) 
				     (mofi:reserved-words (mofi:find-model :mexico))
				     :test #'string-equal)))
    (break "fred")
    (return-from lookup-referenceable (intern type-name (find-package :ap209))))
;;;					      (mofi:lisp-package (schema *expresso*)))))
  ;; POD was (%schema-elements (%defining-scope id)) now (%%children (p11p::schema-scope *scope*)) 
  ;; POD was (eql (%id obj) id)) now (string-equal (%local-name (%id obj)) (%local-name id)) 
  ;; POD append nasty here, as is everything else.
  (loop for obj in (append (%%children (p11p::schema-scope (or (%defining-scope id) *scope*)))
			   (when *allow-inheritance-from-other-schema*
			     (%%inherited-objects (p11p::schema-scope *scope*))))
	when (and (or (typep obj '|NamedType|)
		      (typep obj '|Function|)
		      ;PODTT(typep obj '|MapSpec|)
		      )
		  (string-equal (string (%local-name (%id obj))) (string (%local-name id))))
	do (return-from lookup-referenceable obj)
	finally ; last-minute fix-up.
	(cond ((and ;(typep id '|ScopedId|) 
		;pod8mex (eql (%old-type id) :local-id)
		(typep (%defining-scope id) '|Function|) ; PODTT was (p11uintern (%local-name...
		(token-is (%local-name id) :type-label (%defining-scope id)))
	       (make-instance '|ActualTypeConstraint| 
			      :label id :for-function (%defining-scope id)))
	      ((typep (%defining-scope id) '|GlobalRule|) ; it's an extent named in the head of the rule.
	       (loop for obj across (mofi:members (find-class '|NamedType|)) ; pod7 mistake!
		     with name = (%local-name id)
		     when (string-equal name (%local-name (%id obj))) 
		     do (return-from lookup-referenceable obj)
		     finally (error "Could not find referenceable for id ~A." id)))
	      (t (error "Could not find referenceable for id ~A." id)))))
