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

;;; Author: Peter Denno
;;; Date: 8/25/97
;;; Purpose: Utilities supporting the EXPRESS-X View construct.
;;;
(in-package :EXPO)

#|

A VIEW-INFO instance has two purposes:
  (1) It holds a list of view-info-partition objects for each view declaration.
  (2) It holds a function (no args) used to create instances of a view at run time.

There is a view-info for each view declaration (or partition) even if one by that
name already exists. View-infos are only overwritten when they correspond in name
and source extents (with same order of arguments).

VIEW-MO is a class meta-object. Instances of the class (classes themselves) are subclasses 
of vi-root-supertype, either directly or through subclassing specified in the express-x. 
View-classes are created by examination of view-infos in compile-views. The function
created by the Express-x view. 
 
A VIEW CLASS ("the entity definition object")
  Contains a hash table (called instances) keyed on qualified bindings. The value 
  is an instance of vi-root-supertype containing the accessors to the source data.
  A view class is much like an entity-class-mo (it has slots that have express-type). 
  View classes are of class view-mo. 
 
A VIEW INSTANCE ("the entity instance object")
  View instances (VIs) are SOMETHING like entity instances, but instead of having
  values in their slots the have closed over reader and write methods. VIs are 
  a subclass of vi-root-supertype. 

COMPILE-MAPPPING is a function that creates view classes and explicit bindings methods.

EVALUATE-VIEW calls the function in the view-method to identify qualified bindings and
create accessors for each qualified binding of the view-class.

|#
(defun bind-inst-debug-msg (partition-name sources)
  (warn "don't use bind-inst-debug-msg")
  `(dbg-message :exx 5 "~%Executing push map ~a on ~{~a ~}" 
         ',partition-name ',sources))

;;; We are not maintaining a instances-by-type for vi; It is in the x-evaluation.
(defmethod store-instance ((vi vi-root-supertype) &optional name &key target-dataset)
  (dbg-message :exx 5 "~%Storing instance ~S ~@[with name ~S ~]into dataset ~S"
	       vi name target-dataset)
  (with-slots (instances-by-name-ht names-by-instance-ht max-name) target-dataset
    (let ((name (or name (1+ max-name))))
      (setf max-name (max name max-name))
      (setf (gethash name instances-by-name-ht) vi)
      (setf (gethash vi names-by-instance-ht) name))
    vi))

(defun get-vi-instance (name)
  ;; this was using target-dataset
  (get-instance name (dataset *expresso*)))

;;;===============================================================================
;;; DEFINITION (DEFVIEW)
;;;===============================================================================
;;; This macro operates on the defview coming out of the translator.
;;; It puts information into the view-info for eventual use by compile-views.
;;; A view-info has slots :name :methods :specializers :slots 
;;; If slots is nil then it is a 'value-type-body', i.e. it doesn't create a virtual
;;; entity, it creates a virtual value.

#| THIS COMMENT REFERS TO THE FUNCTION CREATED:
   "This function when called by evaluate-view loops through the instances in the exents
    defined in the FROM clause and produces a view instance (stored in a hash table 
    associated with the view) for each qualifying binding. The instance is hash-keyed 
    by the binding instances. The instance contains accessors closed over by the 
    qualifying bindings."
|#


(defmacro defview (extent-name &body body)
  (with-gensyms (view-info view-info-part)
    (let (param-gensym-assoc)
      `(let ((,view-info (ensure-view-info ',extent-name)))
         ,@(loop for partition in body
                 for partition-name = (first partition)
                 for source-extents = (second (member :source partition))
                 for identified-by  = (second (member :identified-by partition))
                 for pre-predicate  = (second (member :predicate partition))
                 for predicate      = (if (or (atom pre-predicate) (atom (first pre-predicate)))
                                          pre-predicate
                                        (cons 'and pre-predicate))
                 for assignments  = (second (member :project partition))
                 for specializers = (mapcar #'third source-extents)
                 ;; schema might not be known yet, so can't use schema-qualified-class-name, etc.
                 for partial-context = (mapcar #'(lambda (x)
                                                   (compose-partition-name
							     (name2initials (string (second x)))
							     (third x)))
                                               source-extents)
                 do
                 (setf param-gensym-assoc (mapcar #'(lambda (p) (list (gensym) (first p)))
                                                  source-extents))
                 collect
                 `(let ((,view-info-part (make-instance 'view-info-partition 
                                                        :name ',partition-name)))
                    (push ,view-info-part (partitions ,view-info))
                    (setf (identified-by ,view-info-part) ',identified-by)
                    (setf (project-is-scalar ,view-info-part) ,(atom assignments))
                    (setf (specializers ,view-info-part) ',specializers)
                    ,(cond ((atom assignments)
                            ;; The SELECT body is just a value. Not assignments.
                            `(setf 
                              (func ,view-info-part)
                              #'(lambda (x-eval)
				  (let ((source-dataset (first (source-datasets x-eval))))
				    ,(iterate-test-act
				      source-extents
				      predicate
				      ;; This is the action
				      `(let ,param-gensym-assoc                                     
					 (with-partial-context ,partial-context
					  ,(substitute-gensyms
					    param-gensym-assoc
					    `(setf (gethash ,(if identified-by
								 `(list ,@identified-by)
							       `(list ,@(mapcar #'first source-extents)))
							    (gethash (ensure-view-class ',extent-name x-eval)
								     (binding->val x-eval)))
						   #'(lambda () ,assignments))))))))))
                           (t  ; The SELECT body has assignments.
                            `(progn ;; Make view-slot-infos. Push them into the view-info
                               (setf (slots ,view-info-part)
                                     (list ,@(loop for slot in assignments
                                                   for slot-name = (first slot)
                                                   for slot-expression = (second (member :expression slot))
                                                   for slot-type = (second (member :type slot))
                                                   for slot-schema = (second (member :schema slot))
                                                   collect `(make-instance 'view-slot-info
                                                                           :name ',slot-name
                                                                           :express-type ,slot-type
                                                                           :updateable-p ,(compute-view-slot-updateability 
                                                                                           slot-expression)
                                                                           :schema ',slot-schema))))
                               (setf 
                                (func ,view-info-part)
                                #'(lambda (x-eval)
                                    (let ((source-dataset (first (source-datasets x-eval))))
                                      ,(iterate-test-act
                                        source-extents
                                        predicate
                                        ;; This is the action
                                        (let ((arg (gensym)))
                                          `(let ,param-gensym-assoc                                     
                                             (check-in-vi ; <------------
                                              x-eval
                                              ,@(substitute-gensyms
                                                 param-gensym-assoc
                                              ; &rest body
                                                 :index (if identified-by
                                                            `(list ,@identified-by)
                                                          `(list ,@(mapcar #'first source-extents)))
                                                 :view-extent
                                                 `(ensure-view-class ',extent-name x-eval)
                                                 :view-class
                                                 `',(compose-partition-name extent-name partition-name)
                                                 :keyword-value-pairs
                                                 `(list
                                                   ,@(loop for slot in assignments
                                                           for slot-name = (first slot)
                                                           for slot-expression = (second (member :expression slot))
                                                           append
                                                           (list
                                                            (kintern slot-name)
                                                            `(list
                                                              ;; The READER
                                                              #'(lambda () 
                                                                  (with-partial-context ,partial-context
                                                                    (x-coerce-type 
                                                                     ',(compose-partition-name extent-name partition-name)
                                                                     ',slot-name
                                                                     ,slot-expression
                                                                     ',(interned-name (schema *expresso*)))))
                                                              ;; The WRITER (or error msg generator)
                                                              ,(if (compute-view-slot-updateability slot-expression)
                                                                   `#'(lambda (,arg)
                                                                        (with-partial-context ,partial-context
                                                                          (setf ,slot-expression ,arg)))
                                                                 `#'(lambda (,arg)
                                                                      (declare (ignore ,arg))
                                                                      (info-message "~%Attempted write on non-writable view instance attribute"))))))))))))))))))))))))


(defun compute-view-slot-updateability (expression)
  "Returns T if the slot expression is updateable (i.e. if it is a forward path throuhg entities.
   The approach is cheezy (does each nested function look like eu::%<whatever> ?) because methods
   have not yet been defined for everthing that might be accessed here."
  (when (consp expression)
    (loop for fname = (first expression)
          do (setf expression (first (cdr expression)))
          unless (and (eql +eu-pkg+ (symbol-package fname))
                      (char= #\% (elt (symbol-name fname) 0)))
          return nil
          unless (consp expression)
          return t)))

(defun substitute-gensyms (gensym-assoc &rest form)
  "This thing is necessary when creating closures containing loop variables.
   (Loop variables are set, not bound)."
  (loop for substitution in gensym-assoc
        with result = form do
        (setf result
              (subst (first substitution) (second substitution) result))
        finally (return result)))

#| This needs work  
(defmacro def-inline-view (source-extents predicate result-expression)
  `,(loop for source in source-extents
          for loop-form =
          `(loop for ,(first source) being the hash-value of (extent ',(second source)) nconc :exp)
          with result = nil
          do
          (setf result
                (if result
                    (subst loop-form :exp result)
		  loop-form))
	  finally
	  (setf result
		(subst `(when ,predicate (list ,result-expression))
		       :exp result))
	  (return result)))
|#

;;;===============================================================================
;;; VIEW EVALUATION
;;;===============================================================================
(defun compile-views (x-schema)
  "A function to create the view classes from view-infos.
   It gets called after all the view-infos have been created. For example,
   after loading a file with (read-schema file :exx). It also creates the
   explicit binding methods."
  ;; Define the views (objects representing the extent)
  (setf (views x-schema)
          (loop for info in (view-infos x-schema)
                for info-name = (name info)
                with view
                do
                (setf (max-args info)
                      (loop for part in (partitions info) 
                            maximize (if (identified-by part) 
                                         (length (identified-by part))
                                       (length (specializers part)))))
                collect
                (setq view
                      (ensure-class info-name ; POD subtyping view NYI (see :direct-superclasses)
				    :direct-superclasses (list (find-class 'vi-root-supertype))
				    :metaclass (find-class 'view-mo)))
                do
                (create-explicit-binding info view)
                (loop for info-part in (partitions info)
                      for part-class-name = (compose-partition-name info-name (name info-part))
                      with view-part
                      do
                      (setq view-part
                            (ensure-class part-class-name
					  :direct-superclasses (list view)
					  :direct-slots 
					  (mapcar #'(lambda (slot)
						      (list :name (name slot)
							    :initargs (list (kintern (name slot)))))
						  (slots info-part))
					  :metaclass (find-class 'view-mo)))
	              (finalize-inheritance view-part)
                      (view-define-accessors view-part)
                      (loop for view-slot-info in (slots info-part)
                            for type = (express-type view-slot-info)
                            for dslot = (find-direct-slot part-class-name (name view-slot-info))
                            do (setf (slot-definition-updateable-p dslot) (updateable-p view-slot-info))
                            if (symbolp type)
                            do (setf (slot-definition-range dslot) (safe-find-eu-class type))
                            else do (setf (slot-definition-range dslot) type))))))
  
(defun find-view (name)
  "This will probably be much different soon."
  (find-eu-class name))

(defun create-explicit-binding (info view)
  "Defines an explicit mapping method."
    ;; POD As far as I can see there need only be one method, since
    ;; these things just look up the value. 
    (let* ((name (name info))
           (specializers
            (loop for i from 1 to (1+ (max-args info)) ; pod added x-eval (thus 1+)
                  collect (find-class t)))
           (formal-args (mapcar #'(lambda (x) x (gensym)) specializers)))
      (dbg-message :exx 0 "~%view call method ~a ~a" name (length specializers))
      (add-method 
       (ensure-generic-function name :lambda-list formal-args)
       (make-instance 'standard-method
                      :lambda-list formal-args
                      :qualifiers ()
                      :specializers specializers
                      :function
                      #'(lambda (x-eval &rest args)
                          (evaluate-view view x-eval)
                          (let ((result (explicit-binding-access view args x-eval)))
                            ;; Its a closure if it the view select returns a scalar (no attrs)
                            (cond ((listp result)
                                   (mapcar #'(lambda (x) 
                                               (if #+LispWorks (sys:closurep x) ; (typep x 'low:closure)
						   #+Allegro   (typep x 'excl::closure)
                                                   (funcall x)
                                                 x))
                                           result))
                                  (t (if #+LispWorks (sys:closurep result) ; (typep result 'low:closure)
           			         #+Allegro   (typep result 'excl::closure)
                                         (funcall result)
                                       result)))))))))

(defun explicit-binding-access (view args x-eval)
  "Evaluate an explicit binding.
    view - a view class
    args - a list of the arguments to the explicit binding call. "
  ;; Loop through all the keys 
  (cond ((find :exp-wildcard args) ; Partial binding 
         (let* ((keys (loop for key being the hash-key of (gethash view (binding->val x-eval))
                            collect key))
                (valid-keys
                 (loop for arg in args
                       for index from 0
                       unless (eql arg :exp-wildcard)
                       do (setf keys 
                                (delete-if (complement #'(lambda (key) 
                                                           (equal (nth index key) arg))) keys))
                       finally #-(or Allegro cmu sbcl) return #-(or Allegro cmu sbcl) keys
		       #+(or Allegro cmu sbcl) (RETURN keys))))
           (or
            (loop for key in valid-keys
                  with ht = (gethash view (binding->val x-eval))
                  collect (gethash key ht))
            :?)))
        (t ; All arguments specified.
         (or (gethash args (gethash view (binding->val x-eval))) :?))))

(defun view-define-accessors (view) 
  "Define readers and writers with names %<slot-name> so that view instances
   can be used like entity instance slots. The difference is that there is
   on level of indirection here -- this runs the instances methods."
  (flet ((reader-func (slot-name)
          (finalize `(lambda (vi ignore) 
		       (declare (ignore ignore))
		       (funcall (first (slot-value vi ',slot-name))))))
         (writer-func (slot-name)
          (finalize `(lambda (new-value vi ignore)
		       (declare (ignore ignore))
		       (funcall (second (slot-value vi ',slot-name)) new-value)))))
    (loop for slot in (class-slots view) ;; POD should it be direct slots???
          for slot-name = (slot-definition-name slot)
          for fn-name = (string2accessor-name (symbol-name slot-name))
          for reader-gf = (ensure-generic-function
                           fn-name :lambda-list '(object gqualifier) 
                           :generic-function-class 'express-x-generic-function-mo)
          for writer-gf = (ensure-generic-function
                           `(setf ,fn-name)
                           :lambda-list '(new-value object gqualifier)
                           :generic-function-class 'express-x-generic-function-mo)
	do 
          (add-method
           reader-gf
           (make-instance 'standard-method
                          :lambda-list '(object gqualifier)
                          :qualifiers ()
                          :specializers (list view (find-class t))
                          :function (reader-func slot-name)))
	  (add-method
           writer-gf
           (make-instance 'standard-method
                          :lambda-list '(new-value object gqualifier)
                          :qualifiers ()
                          :specializers (list (find-class t) view (find-class t))
                          :function (writer-func slot-name))))))

(defun evaluate-view (view-class x-eval)
  "This calls every partition function to produce all values in the binding->val"
  (unless (gethash view-class (obj-evaluated-p x-eval))
    (handler-bind ((error #'handle-general-express-x-error)) ; 2007-09-28 was expresso-error
      (setf (gethash view-class (obj-evaluated-p x-eval)) t)
      (let ((view-info (find (class-name view-class) (view-infos (x-schema x-eval)) :key #'name)))
        (loop for part in (partitions view-info)
              do 
              (dbg-message :exx 0 "~%Calling ~a~:[~a~;.~a~] ~a" 
			   (class-name view-class) (name part) (or (name part) " ") (specializers part))
              (funcall (func part) x-eval))))))

(defun evaluate-views (x-evaluation)
  (with-slots (evaluated-p x-schema source-datasets binding->val) x-evaluation
    (declare (ignorable source-datasets))
    (when (typep x-schema 'map-schema) ; POD I *think* this is what is necessary.
      (loop for view in (views x-schema) do
            (unless (gethash view binding->val)
              (setf (gethash view binding->val) (make-hash-table :test #'equal)))
            #+GUI (dbg-message :exx 0 "~2% Evaluating Express data ~a into view dataset ~a"
                               (name (first source-datasets)) (name x-evaluation))
            (evaluate-view view x-evaluation))
      (setf evaluated-p t))))

#| No longer used ???
(defun funcall-view (view args)
  "Call the explicit binding function created by create-explicit-binding which is called when
   the view is compiled. That function does a hash-table lookup on an evaluated view."
  (handler-bind ((expresso-error #'handle-general-express-x-error))
    (let ((val (apply view args)))
      ;; POD This might be entirely bogus. It is so that explicit binding with all arguments returns
      ;; just a value, whereas with _ (wildcard) it returns an aggregate of some sort. Bogus.
      val)))
|#

;;;===============================================================================
;;; MAPS
;;;===============================================================================
(defmacro defmap (id dependent-p subtype-of target &body body)
  `(progn
     ,@(loop for partition in body with collect = nil do
	     (dbind (partition-name &key sources identified-by predicate 
				    instantiation-loop locals project) partition
	      (push `(make-instance ',(if dependent-p 'dep-map-info 'map-info)
		      :name ',id
		      :partition ',partition-name
		      :subtype-of ',subtype-of
		      :target ',(copy-list target) 
		      :sources ',sources
		      :identified-by ',identified-by
		      :predicate ',predicate
		      :locals ',locals
		      :instantiation-loop ',instantiation-loop
		      :project ',(copy-list project)) collect))
	      finally return collect)))


;;;===============================================================================
;;; Map Evaluation
;;;===============================================================================
(defun map-merge-with-parents (map-info x-schema)
  " Complete x-map-info objects by gathering info from parents:
     (0) Each subtype appends the LOCAL clauses from its supertypes
     (1) Each subtype appends the WHERE clauses from its supertypes
     (2) Each subtype appends the SELECT clause assignments from its supertypes.
     (3) Each subtype 'meshes' the target types from its supertypes.
    Returns: N/A."
  (flet ((merge-predicates (pred-1 pred-2)
          (cond ((and (eql 'and (first pred-1))
                      (eql 'and (first pred-2)))
                 (append '(and) (rest pred-1) (rest pred-2)))
                (t ; Never anything but ???
		 (error 'cant-merge-predicates :pred1 pred-1 :pred2 pred-2)
		 ))))
    (when-bind (parents (loop for parent in (map-info-supertypes map-info x-schema)
                              collect (find-map-info parent x-schema)))
      (loop for parent in parents 
            for ppred = (predicate parent)
            for pproj = (project parent) do
            (unless (atom ppred)
              (setf (predicate map-info)
                    (merge-predicates ppred (predicate map-info))))
            ;; Do not add (multiply) statements from the parent of the parent.
            (unless (atom pproj)
              (loop for stmt in pproj
                    do (pushnew stmt (project map-info) :test #'equal))))
      (setf (target map-info)
            (map-mesh-targets
             (loop for info in (cons map-info parents)
                   append (target info))))
      (setf (locals map-info)
	    (loop for info in (append parents (list map-info))
		  append (locals info)))
      ;; So that it looks like lisp...
      (let ((predicate (predicate map-info)))
        (unless (or (atom predicate)
                    (atom (first predicate)))
          (setf (predicate map-info)
                (cons 'and (predicate map-info))))))))


(defun map-mesh-targets (targets)
  "A subtype MAP may specialize the target type defined in its supertype or specify
   additional target entity types. This function takes the target entity list specification
   of all related MAPs and 'merges' them. Where the two bind a type to the same parameter, the 
   subtype may specialize that type, where only one binds the parameter the type bound is added 
   to the list of target types to be created."
   (flet ((params (x) (first x))
          (schema (x) (second x))
          (agg-or-entity (x) (third x))
          (types  (x) (fourth x)))
     (let ((schemas (remove-duplicates (loop for target in targets collect (schema target)))))
       (loop for schema in schemas ; partitioning by schema.
             for schema-targets = (remove-if (complement #'(lambda (x) (eql (schema x) schema))) targets) append
             (loop for param in (remove-duplicates (loop for target in schema-targets append (params target)))
                   ;; We are now iterating through each unique parameter, look for what it is bound to. 
                   ;; schema-targets is like a database of targets for the given schema. 
                   collect (list (list param)
                                 schema
                                 (agg-or-entity (first schema-targets))
                                 (remove-duplicates
                                  (loop for target in schema-targets
                                        when (find param (params target))
                                        append (types target)))))))))

(defun map-info-supertypes (map-info x-schema &optional accum)
  "Return the list of supertypes (the name symbol) of a map-info. A supertype is a map-info that
   is related to the argument through the SUBTYPE OF clause of the MAP declaration."
  (let ((subtype-of (subtype-of map-info)))
    (cond ((not subtype-of)
	   accum)
	  (t (map-info-supertypes (find-map-info subtype-of x-schema)
				  x-schema (cons subtype-of accum))))))

(defun map-info-parent-with-sources (map-info x-schema)
  "Returns the map-info (object) that is a supertype of the argument map-info (object) and
   has the SOURCES clause."   
  (if (sources map-info)
      map-info
    (loop for parent-name in (map-info-supertypes map-info x-schema)
	  for parent = (find-map-info parent-name x-schema)
	  when (sources parent) 
	  return parent)))

(defun map-info-connect-subtypes (x-schema)
  "Set the has-direct-subtypes of each map-info."
  (with-slots (map-infos) x-schema
    (loop for map-info being the hash-value of map-infos
          for subtype-of = (subtype-of map-info)
          for parent = (when subtype-of (find-map-info subtype-of x-schema))
	  do (cond ((and subtype-of (null parent))
		    (error 'undefined-supertype-in-map :map-name (name map-info) :supertype-name subtype-of))
		   (parent (push (name map-info) (has-direct-subtypes parent)))))))


(defvar *zippy* nil "diagnostics")

;;;============================================================================
;;; Compile Maps
;;;============================================================================
(defun compile-maps (x-schema)
  "Create 'merged' map-info objects and from these create x-map objects containing 
   executor and binding-instance functions."
  (dbg-message :exx 5 "~3%================ New Compilation ===================================")
  (map-info-connect-subtypes x-schema)
  (dbg-message :exx 5 "~%Connect Subtypes.")
  (loop for map-info being the hash-value of (map-infos x-schema)
	do (map-merge-with-parents map-info x-schema)
	   (dbg-message :exx 5 "~%Parent merge.")
	   (with-slots (name partition subtype-of identified-by target predicate locals project
			     #|instantiation-loop|#) map-info
	     (let* ((sources  (mapcar #'first (sources (map-info-parent-with-sources map-info x-schema))))
		    (stypes (loop for (name scm ent) in (sources (map-info-parent-with-sources map-info x-schema))
				 for schema = (and scm (for-schema (alias-find scm *expresso* 
                                                                               :key #'interned-alias-name :error t)))
				 if schema collect `(,name ,(euintern "~@:(~A.~A~)" (short-name schema) ent))
				 else collect `(,name ,ent))))
	       (labels ((add-partial-bindings (form)
			  (cond ((member form sources)
				 (values form (second (assoc form stypes))))
				((null form) nil)
				((listp form)
				 (let (context nform)
				   (setq nform (loop for sform in form
						     as val = (multiple-value-bind (value ctx)
								  (add-partial-bindings sform)
								(setf context (or context ctx))
								value)
						     collect val))
				   (if context
				       `(with-partial-context (,context) ,nform)
				     nform)))
				(t form))))
		 (let* ((partition-name (compose-partition-name name partition))
			(key (if identified-by 
				 `(list ,@identified-by)
			       `(list ,@sources)))
			(value `(list ,@(loop for nam in target
					      as name = (caar nam)
					      append `(',name ,name))))
			(params 
			 (if identified-by
			     (mapcar #'(lambda (x) (declare (ignore x)) (gensym "VAR")) (cdr key))
			   (mapcar #'(lambda (x) (make-symbol (string x))) (rest key))))
			(param-types (loop for type in (mapcar #'second stypes) ; 2007 (name type) in stypes
					   when (member type '("string" "integer" "real")
							:test #'string-equal)
					   do (setf type (intern (string type) :cl))
					   collect type))
			;;(iloop (first instantiation-loop))
			(map (find-map map-info x-schema :create t)))
		   ;; don't change this to (typep map 'p14-map), we're
		   ;; only interested in maps that are p14-map.  If
		   ;; it's a subtype of p14-map then we want to leave
		   ;; it alone
		   (when (eql (type-of map) 'p14-map)
		     (change-class map (etypecase map-info
					 (dep-map-info 'x-dep-map)
					 (map-info     'x-map))))
		   (when subtype-of
		     (let ((smap (find-map subtype-of x-schema :create t)))
		       (cond ((null (supermap map)) (setf (supermap map) smap))
			     ((not (eql smap (supermap map)))
			      (error "~S does not match ~S" smap (supermap map))))
		       (pushnew map (submaps smap) :key #'name)))
		   (setf project (add-partial-bindings project))
		   (push (make-instance
			  (etypecase map-info
			    (dep-map-info 'x-dep-part)
			    (map-info     'x-part))
			  :name partition-name
			  :predicate predicate
			  :identified-by identified-by
			  :access-params (mapcar #'caar target)
			  :param-types param-types
			  :map-info map-info
			  :binding-instance-function
			  (binding-instance-fn :scalar :project stypes predicate target name partition
					       locals project key value)
;			  (if instantiation-loop
;			      (binding-instance-fn :loop :project stypes predicate target name partition
;						   locals project key value :iloop iloop)
;			    (if (eql :copy-to-target-dataset (first project))
;				(binding-instance-fn :scalar :copy stypes predicate target name partition
;						     locals project key value)
;			      (binding-instance-fn :scalar :project stypes predicate target name partition
;						   locals project key value)))
			  :mapcall-function (mapcall-fn params predicate locals name partition key map-info x-schema)
			  :executor
                          (unless (typep map-info 'dep-map-info) 
                            (when-bind (sources (sources map-info)) ; Here sources must be NATIVE.
                              (executor-fn sources name partition x-schema))))
			 (partitions map))))))))

;;-------------------------------------------------------------------------------------------------
;;; BINDING-INSTANCE-FNS -  methods that return functions that are run once per binding instance.
;;;                         (They are called by executor, when not a dmap). 
;;-------------------------------------------------------------------------------------------------

(defgeneric binding-instance-fn (scalar-loop project-copy sources predicate target
				 map partition locals project key value &key &allow-other-keys))

; scalar project
(defmethod binding-instance-fn ((scalar-loop (eql :scalar)) (project-copy (eql :project))
                                sources predicate target map partition locals project key value &key)
  (dbg-message :exx 4 "~%Binding-Instance-FN: [Scalar Project]")
  (dbg-message :exx 4 "~%   sources:   ~S" sources)
  (dbg-message :exx 4 "~%   predicate: ~S" predicate)
  (dbg-message :exx 4 "~%   target:    ~S" target)
  (dbg-message :exx 4 "~%   map:       ~S" map)
  (dbg-message :exx 4 "~%   partition: ~S" partition)
  (dbg-message :exx 4 "~%   locals:    ~S" locals)
  (dbg-message :exx 4 "~%   project:   ~S" project)
  (dbg-message :exx 4 "~%   key:       ~S" key)
  (dbg-message :exx 4 "~%   value:     ~S" value)
  (let* ((partition-name (compose-partition-name map partition))
	 (snames (loop for (name) in sources collect name))
	 (fname (intern (format nil "BINDING-INSTANCE-SCALAR-PROJECT--~A--~A" map partition) :eu))
	 (form `(defun ,fname (x-eval ,@snames)
		  (when (and ,@(loop for (name type) in sources
				     collect `(or (eql ,name :?) (typep ,name ',type))))
		    (dbg-message :exx 2 ,(format nil "~~%~A (~~{~~S~~^ ~~})" fname) (list ,@snames))
		    (dbg-message :exx 5 ,(format nil "~~%  Key:  (~{~S~^ ~})" key))
		    (dbg-message :exx 5 ,(format nil "~~%  Args: (~{~S~^ ~})" snames))
		    (dbg-message :exx 5 "~%  Vals: ~S" (list ,@snames))
		    (let ((source-dataset (first (source-datasets x-eval))))
		      (or ,(x-map-hash-get key map partition)
                          ,(let ((lform (defmap-let-form target :in-loop-p nil)))
			    `(let* ,locals
			      (if (let (val-p)
				    (dbg-message :exx 4 ,(format nil "~~%  pred: ~S" predicate))
				    (dbg-message :exx 4 ,(format nil "~~%  pred: ~{~S=~~S~^; ~}" snames) ,@snames)
				    (setf val-p ,predicate)
				    (dbg-message :exx 4 "~%  pred-val=~S" val-p)
				    val-p)
				  (let* ,lform
				    ,@(when lform
				       (loop for sform in lform
					     collect `(dbg-message :exx 5 "~% target ~A => ~S"
						       ',(first sform) ,(first sform))))
				    ,(x-map-hash-set key map partition value)
				    ,@project
				    (dbg-message :exx 3 ,(format nil "~~%  value: ~S=~~S" value) ,value)
				    ,value))))))))))
    (dbg-message :exx 5 "~2% Scalar Project Binding Instance Fn ~A:" partition-name)
    (dbg-pprint :exx 5 form)
    (eval form)
    (symbol-function fname)
    ;;(finalize form)
    ))

; loop project
;(defmethod binding-instance-fn ((scalar-loop (eql :loop)) (project-copy (eql :project))
;                                sources predicate target map partition locals project key value &key iloop)
;  (dbg-message :exx 4 "~%Binding-Instance-FN: [Loop Project] ~S ~S ~S ~S ~S ~S ~S ~S"
;	       sources predicate target map partition project key value)
;  (let* ((partition-name (compose-partition-name map partition))
;	 (snames (loop for (name) in sources collect name))
;	 (fname (intern (format nil "BINDING-INSTANCE-LOOP-PROJECT--~A--~A" map partition) :eu))
;	 (loop-var   (second (member :var iloop)))
;	 (loop-exp   (second (member :exp iloop)))
;	 (loop-index (second (member :index iloop)))
;	 (form `(defun ,fname (x-eval ,@snames)
;		  (when (and ,@(loop for (name type) in sources
;				     collect `(or (eql ,name :?) (typep ,name ',type))))
;		    (dbg-message :exx 3 ,(format nil "~~%~A (~~{~~S~~^ ~~})" fname) (list ,@snames))
;		    (let ((source-dataset (first (source-datasets x-eval))))
;		      (or ,(x-map-hash-get key map partition)
;			  (let ,(append (defmap-let-form target :in-loop-p t) locals)
;			    (when ,predicate
;			      ,(x-map-hash-set key map partition value)
;			      (loop for ,loop-var in (value ,loop-exp)
;				    for ,loop-index from 1 do
;				    (progn
;				      ,@(push-new-target-agg-element target loop-index)
;				      ,@project))
;			      (dbg-message :exx 3 ,(format nil "~~%~A value: ~~S" fname) ,value)
;			      ,value))))))))
;    (dbg-message :exx 5 "~2% Loop Project Binding Instance Fn ~A:" partition-name)
;    (dbg-pprint :exx 5 form)
;    (eval form)
;    (symbol-function fname)
;    ;;(finalize form)
;    ))

;; scalar copy
;(defmethod binding-instance-fn ((scalar-loop (eql :scalar)) (project-copy (eql :copy))
;                                sources predicate target map partition locals project key value &key)
;  (dbg-message :exx 4 "~%Binding-Instance-FN: [Scalar Copy] ~S ~S ~S ~S ~S ~S ~S ~S"
;	       sources predicate target map partition project key value)
;  (let* ((partition-name (compose-partition-name map partition))
;	 (snames (loop for (name) in sources collect name))
;	 (fname (intern (format nil "BINDING-INSTANCE-SCALAR-COPY--~A--~A" map partition) :eu))
;	 (form `(lambda (x-eval ,@snames)
;		  (when (and ,@(loop for (name type) in sources
;				     collect `(or (eql ,name :?) (typep ,name ',type))))
;		    (dbg-message :exx 3 ,(format nil "~~%~A (~~{~~S~~^ ~~})" fname) (list ,@snames))
;		    (let ((source-dataset (first (source-datasets x-eval))))
;		      (or ,(x-map-hash-get key map partition)
;			  (let ,(append (defmap-let-form target) locals)
;			    (when ,predicate
;			      ,(x-map-hash-set key map partition value)
;			      (copy-entity-attributes ,@snames ,(caaar target))
;			      (dbg-message :exx 3 ,(format nil "~~%~A value: ~~S" fname) ,value)
;			      ,value))))))))
;    (dbg-message :exx 5 "~2% Scalar Copy Binding Instance Fn ~A:" partition-name)
;    (dbg-pprint :exx 5 form)
;    (eval form)
;    (symbol-function fname)
;    ;;(finalize form)
;    ))


;;;------------ Functions that build code segments --------------------------------

;;; This function gets called in executing a push-map. It iterates through all the
;;; values in the extent, calling the binding instance function.
(defun executor-fn (sources map-name partition x-schema)
  (dbg-message :exx 4 "~%Executor-FN: ~S ~S ~S~2%" sources map-name partition)
  (let* ((full-name (compose-partition-name map-name partition))
	 (fname (intern (format nil "EXECUTOR--~A--~A" map-name partition) :eu))
	 (form `(defun ,fname (x-eval)
		 (dbg-message :exx 2 ,(format nil "~~%~A" fname))
		 (let ((source-dataset (first (source-datasets x-eval))))
		   ,(iterate-test-act sources t
		     (map-build-execute-order map-name partition (mapcar #'first sources) x-schema))))))
    (dbg-message :exx 5 "~2% Executor Fn ~A:" full-name)
    (dbg-pprint :exx 5 form)
    (eval form)
    (symbol-function fname)
    ;;(finalize form)
    ))

(defun x-map-hash-set (key map partition value)
  "Expands to a form that sets the key of a particular map instances ht to the argument value."
  `(setf (gethash ,key (binding-calls (find-map ',map (x-schema x-eval) :partition ',partition))) ,value))

(defun x-map-hash-get (key map partition)
  "Expands to a form that sets the key of a particular map instances ht to the argument value."
  `(gethash ,key (binding-calls (find-map ',map (x-schema x-eval) :partition ',partition))))

(defun predicate-with-debug-msg (predicate source-extents)
  (dbg-message :exx 4 "~&Predicate-With-Debug-Msg: ~S ~S" predicate source-extents)
  `(,@(if (atom predicate) `(and ,predicate) predicate)
      (progn
	(dbg-message :exx 5 "~2% WHERE succeeds: ~{~%~a~}" 
		     (list ,@(mapcar #'first source-extents)))
	t)))

(defun defmap-let-form (targets &key in-loop-p)
 "Returns forms creating the instances (if not in a loop) and aggregates (if in a loop)."
 (flet ((make-entity-form (entities schema)
	  `(with-schema ((for-schema 
                          (alias-find ',schema *expresso* 
                                      :key #'interned-alias-name :error t)))
	     (store-instance (set-all-slots (make-entity-instance ',entities)) nil :dataset x-eval)))
        (make-agg-form (entities schema)
	  `(with-schema ((for-schema 
                          (alias-find ',schema *expresso* 
                                      :key #'interned-alias-name :error t)))
	     (make-instance 'express-aggregate :type-descriptor ,(second (second (member :base-type entities)))))))
   ;;-------------
   (loop for target in targets
        for vars = (first target)
        for schema = (second target)
        for scalar-p = (third target)
        for entities = (fourth target)
        when (not in-loop-p)
	  append (loop for var in vars collect `(,var ,(make-entity-form entities schema)))
        when (and in-loop-p (eql scalar-p :scalar))
	  append (loop for var in vars collect `(,var nil))
        when (and in-loop-p (eql scalar-p :agg))
	  append (loop for var in vars collect `(,var ,(make-agg-form entities schema))))))

(defun push-new-target-agg-element (targets loop-index)
  "This function is only called for bodies that are entity instantiation loops. However, 
   it permits some of the assignments to be invarient to the loop index (executed once).
   It creates an entity instance for the current iteration of the loop and pushes it into
   the aggregate. If the lhs is invarient wrt the loop it is wrapped in (when (= 1 <loop-index>)).
   Note that defmap-let-form does not make the entity instance when in a loop. It is made here. "
  (loop for target in targets
        for vars = (first target)
        for schema = (second target)
        for scalar-p = (third target)
        for entities = (fourth target)
        for base-type = (second (second (member :base-type entities)))
        when (eql scalar-p :agg)
        append (loop for var in vars
                     collect `(setf (express-aref ,var ,loop-index)
                                    (with-schema ((for-schema 
                                                   (alias-find ',schema *expresso* 
                                                               :key #'interned-alias-name :error t)))
                                      (store-instance ;; was make-entity-instance...
                                       (set-all-slots (make-entity-instance ,base-type))) nil :dataset x-eval)))
        when (eql scalar-p :scalar)
        append (loop for var in vars
                     collect `(when (= ,loop-index 1)
                                (with-schema ((for-schema 
                                               (alias-find ',schema *expresso* 
                                                           :key #'interned-alias-name :error t)))
                                  (setf ,var
                                        (store-instance ;; was make-entity-instance...
					 (set-all-slots (make-entity-instance ',entities))) nil :dataset x-eval))))))


(defun map-build-execute-order (topmost partition sources x-schema)
  "Args: topmost - the name of the topmost MAP of this type.
         partition - the partition symbol."
  (dbg-message :exx 3 "~%map-build-execute-order (~S ~S ~S)" topmost partition sources)
  `(or
    ,@(loop for map-info-name in (reverse (cons topmost (map-info-topdown-subtypes topmost x-schema)))
            collect `(dbg-funcall :exx 4 #'binding
				  (find-map ',map-info-name (x-schema x-eval))
                                  x-eval ,(when partition `',partition) ,@sources))))

(defun map-info-topdown-subtypes (map-name x-schema &optional accum)
  (let ((subtypes (has-direct-subtypes (find-map-info map-name x-schema)))) ; map-name is value in :name attribute.
    (if (null subtypes) nil
      (append accum subtypes
	      (mapappend #'(lambda (name) (map-info-topdown-subtypes name x-schema)) subtypes)))))

;;; The calling sequence. Things in +...+ are methods generated from the .exx.
;;; 
;;; (1) push-evaluate-maps    --- runs everything, called from the GUI etc.
;;; (2) evaluate (map)        --- poorly named! just calls evaluate (partition)
;;; (3) evaluate (partition)  --- just call the x-part's executor-fn +executor+
;;; (4) funcall +executor+    --- Loops through extents, calling binding on the map, partition name, and data
;;; (5) binding               --- Calls the +binding-instance-fn+ found in the slot of the partition named (a symbol) as an argument
;;; (6) +binding-instance-fn+ --- A few kinds: scalar, loop, scalar copy.
;;; 
;;; Scalar:
;;;  -  Either does lazy evaluation using the hash-table in the x-part's binding-calls slot.
;;;  -  ...or runs the body of the project, which might call funcall-map 
;;;     (with args and name of a map, acccess-param (the @ thing) and partition name) to do a mapcall.
;;; 
;;; 
;;; (7) funcall-map           --- calls mapcall with the map object, x-eval and args, and handles creating 
;;;                           the return value using knowledge of the access-param, 
;;; 
;;; (8) mapcall               --- like "binding" (above) in a way, but calls the +mapcall-fn+
;;; (9) +mapcall-fn+          --- if no wildcards, calls binding on the arguments...
;;;                           ...otherwise loops through wildcards and extents calling binding.
;;;---------------------
;;; Data structures:
;;;   map-schema - (get-special schemas)...has slots for maps and map-infos
;;;   map-info   - used to compile map, and has the partition name as a symbol (useful)
;;;   x-map      - (in the maps slot of the schema) partitions, supermaps, submaps, 
;;;   x-part     - in the partitions of an x-map, binding instance fn, mapcall-fn, executor-fn, binding-calls, access-param
;;;   binding-calls - a hash table keyed on FROM arguments with values being the result of running the +binding-instance-fn+.
;;;
(defun push-evaluate-maps (x-eval)
  (with-slots (x-schema) x-eval
    (clear-bindings x-schema)
    (with-slots (maps source-schema-name target-schema-name) x-schema
      (let ((source-schema (find-schema source-schema-name))
            (target-schema (find-schema target-schema-name)))
        (unless source-schema (error 'express-x-no-referenced-schema
				     :schema-type :source
				     :schema-name source-schema-name))
        (unless target-schema (error 'express-x-no-referenced-schema
				     :schema-type :target
				     :schema-name target-schema-name))
        (setf (dataset *expresso*) x-eval)
        (handler-bind ((error #'handle-general-express-x-error)) ; 2007-09-28 was expresso-error
          (with-schema (target-schema)
	    (loop for map being the hash-value of maps 
		  when (typep map 'x-map)
		  do (dbg-message :exx nil "~%Evaluating map ~a" (name map))
		     (evaluate map x-eval))))
        x-eval))))

(defun funcall-map (name partition access-param x-eval &rest args)
  "Find the explicit binding function named name.parition and call it. 
   If an access-param (the @ thing) exists return the target entity it references, 
   otherwise return a list of target entities."
  (let ((map (find-map name (x-schema x-eval) :partition partition)))
    (unless map (error 'unknown-map :name name))
    #-SBCL
    (dbg-message :exx 4 "~%FunCall-Map ~@[~A@~]~A<~A>(~{~A~^, ~})" access-param (name map)
		 (type-of map) args)
    (let ((val (apply #'mapcall map x-eval partition  args)))
      (unless val ;; Unhandled mapcall...
        (setf val (list access-param :express_x_mapping_failure))
;       (error 'mapcall-unhandled :map-name name :partition partition :params (copy-list args))
        (let ((pparams (loop for p in args
                             if (typep p 'entity-root-supertype)
                             collect (format nil "#~A" (entity-id p (instance-dataset p)))
                             else collect p)))
;	  #+LispWorks
;	  (break "~%Error: FunCall-Map ~A~@[\~A~](~{~S~^ ~}) does not map ~{~S~^ ~}."
;		 name partition pparams pparams)
          (info-message
           "~%Error: FunCall-Map ~A~@[\~A~](~{~S~^ ~}) does not map ~{~S~^ ~}."
           name partition pparams pparams)))
      (dbg-message :exx 4 "~%FunCall-Map ~A<~A> access-params = ~S [~S]" (name map) (type-of map)
		   (access-params map) access-param)
      (dbg-message :exx 5 "~%FunCall-Map ~A<~A> returned ==> ~S" (name map) (type-of map) val)
      ;; The map call should either be called with an access parameter or with a wildcard.
      (unless (or access-param (find :exp-wildcard args))
        (error 'invalid-map-target-in-call :map-name name :target access-param))
      (cond (access-param
	     (unless (getf val access-param)
	       (error 'invalid-map-target-in-call :map-name name :target access-param))
	     (let ((ret-val (getf val access-param)))
	       (dbg-message :exx 5 "~%FunCall-Map returning: ~S" ret-val)
	       ret-val))
            (t
             (let* ((len (/ (length val) 2))
		    (ret-val (make-instance 'express-list
			       :type-descriptor 
			       (make-instance 'list-typ  :l-bound len :u-bound len
				 :base-type (make-instance 'generic-typ))
                               :value (loop for (id value) on val by #'cddr
					    do (declare-ignore id)
                                            collect value))))
	       (dbg-message :exx 5 "~%FunCall-Map returning: ~S" ret-val)
	       ret-val))))))


;;; POD This one could stand some optimization, it appends lots of nils.
(defun mapcall-fn (params predicate locals map partition key map-info x-schema)
  "Generate the map call (explicit binding) function."
  (dbg-message :exx 4 "~%Explicit-binding-FN: ~S ~S ~S ~S ~S ~S" params predicate
	       map partition key map-info)
  (let* ((partition-name   (compose-partition-name map partition))
	 (fname (intern (format nil "MAPCALL--~A--~A" map partition) :eu))
	 (form `(defun ,fname (x-eval ,@params)
                  (dbg-message :exx 2 ,(format nil "~~%~A (~~{~~S~~^ ~~})" fname) (list ,@params))
		  (let ((source-dataset (first (source-datasets x-eval))))
		    (or (and (not (find :exp-wildcard (list ,@params)))
			     (binding (find-map ',map (x-schema x-eval))
				      x-eval ,(when partition `',partition) ,@params)
			     )
		       ,(iterate-test-collect
		         (sources (map-info-parent-with-sources map-info x-schema))
		         `(and ,@(mapcar #'(lambda (accessor param)
					     `(or (eql ,param :exp-wildcard) (eql ,accessor ,param)))
				         (rest key) params)
			       (let ,locals
                                 (let ((val-p ,predicate))
				   (dbg-message :exx 4 ,(format nil "~~%~A predicate=~~S" fname) val-p)
				   val-p)))
			 `(binding (find-map ',map (x-schema x-eval))
				   x-eval ,(when partition `',partition) ,@(rest key))
			 ))))))
    (dbg-message :exx 5 "~2% Explicit Binding Fn ~A:" partition-name)
    (dbg-pprint :exx 5 form)
    (eval form)
    (symbol-function fname)
    ;;(finalize form)
    ))

#+Debug
(defun finalize (lambda)
  (eval `(function ,lambda)))

;;;===============================================================================
;;; Utilities
;;;===============================================================================
(defun compose-partition-name (map-name partition-name)
  (euintern "~A.~A" map-name partition-name))

(defun x-coerce-type (view-class-name slot-name value schema)
  "The translated expression of a view accessor is a lisp type (e.g. a list rather than an
   express aggregate. This function wraps around the expression in the accessor (see defview macro)
   and ensure that what is actually returned is an express type."
  (let ((type (slot-definition-range (find-direct-slot view-class-name slot-name nil schema))))
    (cond ((typep type 'aggregation-typ)
           (make-one type value))
          ((typep type 'boolean-typ)
           (if value
               (make-p21-boolean-ref :-value ".T." :-keyword :t)
             (make-p21-boolean-ref :-value ".F." :-keyword :f)))
          ((typep type 'logical-typ)
           (cond ((eql value :?) ;; POD ??? :? -> Unknown ???
                  (make-p21-logical-ref :-value ".U." :-keyword :u))
                 ((null value)
                  (make-p21-logical-ref :-value ".F." :-keyword :f))
                 (t
                  (make-p21-logical-ref :-value ".T." :-keyword :t))))
          ((null value)
           :?)
          (t
           value))))

(defun source-network (vi x-eval)
  "Returns the list of entities from which the argument virtual instance was created."
    (loop for subclass in (class-direct-superclasses (class-of vi))
          return
          (loop for instance being the hash-value of (extent subclass x-eval) using (hash-key key)
                when (eql vi instance)
                return key)))

(defun iterate-test-act (source-extents predicate action)
  (let ((predicate (predicate-with-debug-msg predicate source-extents)))
    `,(loop for (var schema type) in source-extents 
            for loop-form =  `(loop for ,var being the hash-value of 
                                    (extent ',type source-dataset 
                                            :schema (and ',schema (for-schema (alias-find ',schema *expresso* 
                                                                                          :key #'interned-alias-name
                                                                                          :error t))))
				    do (dbg-message :exx 5 "~&Loop Iter Value: ~S~%" ,var)
				       :exp)
            with result = nil
            do (setf result (if result (subst loop-form :exp result) loop-form))
            finally (setf result (subst `(when ,predicate ,action) :exp result))
            ;; POD The substitution is temporary
            (return (subst :? '? result)))))

(defun iterate-test-collect (source-extents predicate action)
  "Similar to iterate-test-act, but collects result."
  (let ((predicate (predicate-with-debug-msg predicate source-extents)))
    `,(loop for (var schema type) in source-extents
            for loop-form = `(loop for ,var being the hash-value of 
                                   (extent ',type source-dataset 
                                           :schema (and ',schema (for-schema (alias-find ',schema *expresso* 
                                                                                         :key #'interned-alias-name
                                                                                         :error t))))
				   append :exp)
            with result = nil
            do (setf result (if result (subst loop-form :exp result) loop-form))
            finally (setf result (subst `(when ,predicate (list ,action)) :exp result))
            ;; POD The substitution is temporary
            (return (subst :? '? result)))))

(defmacro set-vi-value (vi attr val)
  "Set the value of a view instances argument attribute.
       vi   - an instance of the view.
       attr - an attribute containing closed-over accessors.
       val  - the value to set it to."
  `(if (slot-boundp ,vi ,attr)
       (funcall (second (slot-value ,vi ,attr)) ,val)
     (funcall (second ,vi) ,val))) ; this one if SELECT is just a value.

(defmethod extent ((class view-mo) (x-eval x-evaluation) &key)
  "Returns a hash table of the extent of the view type."
  (let ((binding->val (binding->val x-eval)))
    (or (gethash class binding->val)
        (setf (gethash class binding->val) (make-hash-table)))))

;#+Debug
;(defun show-view (name &optional (suppress-full nil))
;  (break "Need to be fixed. Uses with-dataset.")
;  (when-bind (class (find-eu-class name))
;    (let ((ht (instances class)))
;      (loop for key being the hash-key of ht using (hash-value val) do
;            (suppress-full-entity-print
;              (suppress-full-vi-print
;                (format t "~% ~a(" name)
;                (loop for key-part in key
;                      do (with-dataset ((instance-dataset key-part))
;                           (format t "~a " key-part)))))
;            (with-dataset ((instance-dataset val))
;              (if suppress-full
;                  (suppress-full-entity-print
;                    (suppress-full-vi-print
;                      (format t ")  =  ~a" val)))
;                (format t ")   =  ~a" val)))))))

;(defmethod show-map ((map (eql :all)) x-schema &optional (stream *standard-output*))
;  "Print all maps (in precedence order where applicable). "
;  (let ((toplevels (loop for map-info being the hash-value of (map-infos x-schema)
;                         when (null (subtype-of map-info)) collect map-info)))
;    (loop for toplevel in toplevels
;        do 
;        (show-map toplevel x-schema stream)
;        (loop for child in (map-info-topdown-subtypes (name toplevel) x-schema)
;              do (show-map (find-map (find-map-info child x-schema) x-schema) x-schema stream)))))

;(defmethod show-map ((map-info Map-Info) x-schema &optional (stream *standard-output*))
;  (with-slots (name partition) map-info
;    (let* ((map-name (euintern "~A.~A" name partition))
;           (map (find-map map-name x-schema)))
;      (unless map (error "~% THERE IS NO MAP ~A !!!" map-name))
;      (show-map map x-schema))))

;(defmethod show-map ((map-info Dep-Map-Info) x-schema &optional (stream *standard-output*))
;  (with-slots (name partition) map-info
;    (let* ((map-name (euintern "~A.~A" name partition))
;           (map (find-map map-name x-schema)))
;      (unless map (error "~% THERE IS NO DEP-MAP ~A !!!" map-name))
;      (show-map map x-schema))))

;(defmethod show-map ((map X-Part) x-schema &optional (stream *standard-output*))
;  "Print an individual map."
;  (declare (ignore x-schema))
;  (format stream "~2%MAP ~a " (name map))
;  (format stream "~%   Completed binding calls: ~D~%" (binding-call-count map))
;  (loop for bc-key being the hash-key of (binding-calls map)
;        for ds = (entity-dataset (first bc-key)) ; TOTALLY SLOW!
;        for i from 1 to 20 do 
;          (format stream "(~{#~A~})" (mapcar #'entity-id bc-key ds)))
;  (format stream "~%   Access Parameters ~A" (access-params map))
;  (when-bind (executor (executor map))
;    (format stream "~%   EXECUTOR FUNCTION:------------------------------------------------------------")
;    (pprint executor))
;  (format stream "~%   BINDING INSTANCE FUNCTION:----------------------------------------------------")
;  (pprint (binding-instance-function map))
;  (format stream "~%   MAPCALL FUNCTION:----------------------------------------------------")
;  (pprint (mapcall-function map)))

;(defmethod show-map ((map X-Dep-Part) x-schema &optional (stream *standard-output*))
;  "Print an individual dep-map."
;  (declare (ignore x-schema))
;  (format stream "~2%DEP-MAP ~a " (name map))
;  (format stream "~%   Completed binding calls: ~D~%" (binding-call-count map))
;  (loop for bc-key being the hash-key of (binding-calls map)
;        for ds = (entity-dataset (first bc-key)) ; TOTALLY SLOW!
;        for i from 1 to 20 do 
;          (format stream "(~{#~A~})" (mapcar #'entity-id bc-key ds)))
;  (format stream "~%   Access Parameters ~A" (access-params map))
;  (when-bind (executor (executor map))
;    (format stream "~%   EXECUTOR FUNCTION:------------------------------------------------------------")
;    (pprint executor))
;  (format stream "~%   BINDING INSTANCE FUNCTION:----------------------------------------------------")
;  (pprint (binding-instance-function map))
;  (format stream "~%   MAPCALL FUNCTION:----------------------------------------------------")
;  (pprint (mapcall-function map)))

  

;;; POD Note we still are not checking to set indeterminate values on 'overwrite'.
(defun check-in-vi (x-eval &key index view-extent view-class keyword-value-pairs)
  (with-slots (max-name names-by-instance-ht instances-by-name-ht binding->val) x-eval
    (unless (gethash index (gethash view-extent binding->val))
      (let ((vi (apply #'make-instance view-class keyword-value-pairs))
            (name (setf max-name (1+ max-name))))
        (setf (gethash vi names-by-instance-ht) name)
        (setf (gethash name instances-by-name-ht) vi)
        (setf (gethash index (gethash view-extent binding->val)) vi)))))

(defun not-mapped (x-eval &key (verbose t) (stream *standard-output*))
  "Determine what was not mapped."
  (let ((hit-list (make-hash-table)))
    (loop for map being the hash-value of (maps (x-schema x-eval)) do
          (loop for part in (partitions map) do
                (loop for key being the hash-key of (binding-calls part) do
                      (loop for key-part in key do
                            (setf (gethash key-part hit-list) t)))))
    (format stream "~2%")
    (loop for ds in (source-datasets x-eval)
          with count = 0 do
          (with-dataset (ds)
            (loop for si being the hash-value of (slot-value ds 'instances-by-name-ht) do
                  (unless (gethash si hit-list)
                    (incf count)
                    (when verbose
                      (format stream "~% Not mapped:")
                      (write-entity si stream :p21 :dataset ds)))))
          finally #-(or SBCL CMU) do
          (format stream "~% ~D entities were not mapped." count))))

(defun handle-general-express-x-error (condition)
  (cond (*production*
         (info-message "~%Error during express-x evaluation:~%~A" condition)
         (throw 'next-express-x-task nil))
        (t
	 (info-message "~%Error during express-x evaluation:")
         (info-message "~3% ~A" condition)
         #+(and CAPI (not EXPO-CGTK)) 
	 (break "See the Expresso message buffer for the error."))))


#+DEBUG
(defun doit ()
  (let* ((target-dataset-name "target_datset")
         (source-dataset (find-dataset :name "source.stp"))
         (x-schema (find-schema "PART_MAPS"))
         (x-evaluation (ensure-dataset 'x-evaluation :name target-dataset-name :x-schema x-schema
                                       :source-datasets (list source-dataset))))
    (push-evaluate-maps x-evaluation)))

              
