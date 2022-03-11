
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
;;; Date: 10/24/96
;;;
;;; Purpose: Functions relating to testing domain rules, global rules, and inverses.
;;;
(in-package :expresso)

(defun check-all (population)
  "Runs all categories of tests."
  (declare (special mofi::*model*))
  (let ((mofi::*population* population)) ; PODsampson useful?
    (with-done-message ("********** Run All Rules ")
      (when (get-option validation-unique-opt)
	(dbg-message :validate 1 "~%Check-All: Check Uniques")
	(check-uniques population))
;;; 2009-08-31 Current thinking is that this is pointless. Let the inverses
;;;            be created as they will, and catch the errors more generally.
;;;   (when (get-option validation-inverse-opt)
;;;	(dbg-message :validate 1 "~%Check-All: Check Inverses")
;;;	(check-inverses population))
      (when (get-option validation-type-in-attr-opt)
	(dbg-message :validate 1 "~%Check-All: Check Type in Attributes")
	(check-type-in-attributes population))
      (when (get-option validation-where-rules-opt)
	(dbg-message :validate 1 "~%Check-All: Run WHERE Rules")
	(run-where-rules population))
      (when (get-option validation-global-rules-opt)
	(dbg-message :validate 1 "~%Check-All: Run Global Rules")
	(run-global-rules population)))))

(defun check-uniques (population)
  (info-message "~2%;;;;;;;; Checking Unique Constraints ;;;;;;;;~3%")
  (loop for inst across (mofi:members population) do
    (dbg-message :validate 2 "~&  Inst: ~S~%" inst)
       (with-slots (dataset) population
	 (loop for class-name in (express-class-list (class-of inst))
	    for class = (find-class class-name)
	    for uniqueness-fns = (uniqueness class)
	    when uniqueness-fns
	    do (check-uniqueness dataset inst class uniqueness-fns)))))

(defun check-type-in-attributes (population)
  "Loop through every value of every instance and determine whether it is of a
   type required by the entity definition."
  (info-message "~2%;;;;;;;; Checking Entity Attribute Types ;;;;;;;;;;;;~3%")
  (let (current-entity)
    (labels ((exp-check-type (val base-types slot)
              (typecase val
                (express-array
                 (let ((td (type-descriptor val)))
                   (loop for ix from (l-bound td) to (u-bound td)
                         do (exp-check-type (express-aref val ix) base-types slot))))
                (express-aggregate
                 (loop for elem in (value val)
                       do (exp-check-type elem base-types slot)))
                (otherwise 
                 (unless (find val base-types :test #'express-typep)
                   (let ((type-names (loop for x in base-types collect (p11-string x "" :text))))
		     (warn 'exp-violates-type
			   :instance current-entity :class (class-of current-entity)
			   :slot slot :value val :value-type type-names
			   :slot-range (mofi:slot-definition-range slot))))))))
      (loop for inst across (mofi:members population)
	    do (setf project-http::*zippy* inst) (dbg-message :validate 2 "~&  Instance: ~S~%" inst)
	       (loop for slot in (mofi:mapped-slots (class-of inst)) ; 2012 mofi:
		     as slot-name = (slot-definition-name slot)
		     as slot-opt? = (slot-definition-optional slot)
		     as val = (slot-value inst slot-name)
		     as types = (remove-if #'(lambda (x) (typep x 'select-typ))
					   (collect-underlying-types 
					    (slot-definition-range slot)))
		     if (and (not slot-opt?) (eql val :?))
		     do  (warn 'exp-missing-mandatory :instance inst :class (class-of inst) :slot slot)
		     else do (setf current-entity inst)
			     (exp-check-type val types slot)
			     (setf current-entity nil))))))

;;; Currently this is only called at top level.
;;; Note that entity WHERE rules can not be run at instance creation
;;; because they might rely on functions that need a population.
;;; (Seems strange that this is so, huh?)
(defun run-where-rules (population)
  (info-message "~2%;;;;;;;; Checking Entity WHERE Rules ;;;;;;;;;;;;~3%")
  (with-slots (dataset) population
    (loop for val being the hash-value of (instances-ht dataset)
       do (domain-rules val))))

(defun run-global-rules (population)
  (info-message "~2%;;;;;;;; Checking Global Rules ;;;;;;;;;;;;~3%")
  (with-slots (dataset) population
    (loop for rule being the hash-value of (global-rules (mofi:model-n+1 population))
       using (hash-key rule-name) do
	 (dbg-message :validate 1 "~&Running Global RULE ~A ...~%" rule-name)
	 (funcall rule dataset))))

;;; All the work is done in :after methods generated from the Express.
(defmethod domain-rules ((instance t))
  t)


#| PODsampson is this really necessary?
;;; POD could do better than pass 4 args into the flet function.
(defun check-inverses (population)
  "Purpose: Do a ONE DIRECTIONAL check of consistency. That is, check
            that the value(s) in the inverse slot indeed name entities
            (of the correct type) that have this entity in the slot
            referenced in the inverse slot."
  (info-message "~2%;;;;;;;; Checking Inverses ;;;;;;;;;;;; ~%")
  (flet ((check-one-inverse
	  (iname entity-name type slot)
	  ;; iname - name (integer) of the entity possessing the inverse slot.
	  ;; entity-name - name (ref) of the thing referenced in the inverse slot.
	  ;; type - type that referenced entity-name should be.
	  ;; slot - symbol, the slot in entity-name
	  (let ((explicit (get-instance (p21-entity-ref--value entity-name) population)))
	    (unless explicit
	      (express-error bad-inverse
	       "references a non-existent entity ~A as an inverse."
	       entity-name))
	    (unless (typep explicit type)
	      (express-error bad-inverse
	       "requires an entity of type ~A but~%~A~%isn't that type."
	       type explicit))
	    (let ((slot-val (slot-value explicit slot)))
	      (cond ((typep slot-val 'express-aggregate)
		     ;; This one if EXPLICIT SLOT is an aggregate...
		     (unless (find iname (value slot-val) :key #'p21-entity-ref--value)
		       (express-error bad-inverse
			"references #~a in inverse attribute ~A but~%~A~%doesn't reference back."
			entity-name slot explicit)))
		    ;; ...otherwise this one.
		    ((/= iname (p21-entity-ref--value (slot-value explicit slot)))
		     (express-error bad-inverse
		       "references ~a in inverse attribute ~A but~%~A~%doesn't reference back."
		       entity-name slot explicit)))))))
    (loop for entity-type being the hash-value of (entity-types (schema *expresso*))
	  do (loop for slot in (remove-if-not #'(lambda (x) (slot-value x 'inverse))
					      (class-direct-slots entity-type))
		   as sname = (slot-definition-name slot)
		   do (loop for name being the hash-key of (extent entity-type population)
			    for entity being the hash-value of (extent entity-type population)
			    for contents = (and (slot-exists-p entity sname)
						(slot-boundp entity sname)
						(slot-value entity sname))
			    with inverse-data = (slot-value slot 'inverse)
			    with type = (first inverse-data)
			    with eslot = (second inverse-data) ;; explicit slot.
			    do (handler-case
				   (let ((*current-entity* entity))
				     (declare (special *current-entity*))
				     (when contents
				       (if (typep contents 'express-aggregate)
					   (loop for val in (value contents)
						 do (check-one-inverse name val type eslot))
					 (check-one-inverse name contents type eslot))))
				 (bad-inverse (err)
				   (info-message "~&Error (during inverse relationship checking): ~A~%"
						 err))))))))
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Code to check that the type of a complex entity is valid.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
;;; Purpose: This is a second approach to determining whether
;;; a complex entity type is a valid collection of types. 
;;; (The first approach, calculating the evaluated set and then
;;; checking whether the entity read is in that set, is not feasible
;;; for large information models.) ANDOR is 2**n
;;;

;;; POD does this comment make any sense?:
;;;                      *Candidate* is a free variable so that the same
;;;                      'es-' constraint functions arg lists can be used as
;;;                      used in complete evaluated set computation.
;;; POD 11/13/98 There is some hope for this. It was using relative-leaves
;;;              in place of type-is-p21-internal-p. Relative-leaves had a flaw.
;;; POD 9/24/99 This is having a problem on edge_loop (which inherits from path and loop).
(defun valid-complex-type-p (candidate)
  "The toplevel function to determine whether a complex entity data type
   is valid WRT constraint rules.
   Args: candidate - a conditioned type list."
  (let ((*candidate* candidate))
    (catch 'invalid-complex-type
      (when (supporting-supertypes candidate) ;; you didn't get them all.
	(throw 'invalid-complex-type nil))
      (and
       ;; First make sure that for every abstract type in the candidate
       ;; a non-abstract subtype of it is also in the type-list.
       (loop for abs in (remove-if (complement #'mofi:abstract-p) candidate :key #'find-class)
	     unless (find-if (complement #'mofi:abstract-p)
			     (mapcar #'find-class (subtypes abs)))
	     return nil
	     finally (return t))
       ;; Secondly every component component's constraint must pass.
       (loop for type in candidate
	     for constraint = (supertype-constraint (find-class type))
	     do (VARS type)
	     when constraint do (funcall constraint)
	     finally (return t))))))

(eval-when (eval load)
  (memoize 'valid-complex-type-p :test #'equal :key #'identity))

;;; I think the trick to actually making this work is to project out
;;; all of the subtypes that are not relevant to the test at hand.
;;; Currently every function returns what it matches on.

(defun es-and (arg1 arg2)
  "When both arguments are true, returns the merged type list
   if this list matches the candidate."
  (cond ((and arg1 arg2)
         (let* ((arg1 (if (symbolp arg1) (list arg1) arg1))
                (arg2 (if (symbolp arg2) (list arg2) arg2))
                (result (remove-duplicates (append arg1 arg2))))
           (cond ((= (length result)
                     (length (intersection *candidate* result)))
                  result)
                 (t (throw 'invalid-complex-type nil)))))
        (t
         (throw 'invalid-complex-type nil))))

(defun es-andor (arg1 &optional (arg2 nil)) 
  (declare (ignore arg1 arg2))
  t)

(defun es-oneof (types)
  "Returns the found match if there is at most one match, otherwise fails."
  (let ((found
         (loop for type in (flatten types)
               when (and (symbolp type)
                         (find type *candidate*))
               collect type
               when (and (listp type)
                         (= (length type)
                            (length (intersection *candidate* type))))
               collect type)))
    ;; If nothing found that's OK. ABSTRACT forces it to be ONEOF, not ONEOF.
    (cond ((null found) t)
          ((not (cdr found)) found)
          (t (throw 'invalid-complex-type nil)))))

#|
;;; POD types that were not one of their ANDORed subtypes were failing ES-ANDOR.
;;; ES-ANDOR should only say that something in the candidate is valid  because
;;; it was ANDORed onto the type. ....But of course, this takes things 'backwards'
;;; asking to justify what is in candidate. 1/20/98 I made this an no-op by ORing
;;; the original intersection with t.
(defun es-andor (arg1 &optional (arg2 nil))
  (let ((arg1 (if (symbolp arg1) (list arg1) arg1))
	(arg2 (if (symbolp arg2) (list arg2) arg2)))
    (or (intersection *candidate* (append arg1 arg2)) t)))
|#

;;; This one is hard to debug!!!
(defun compose-andor (g added-type)
  "return a function which is es-andor( g(x) ANDORed-type)."
  #'(lambda ()
      (funcall #'es-andor (funcall g) added-type)))


;;;===============================================================================

;;; step b: Add to the supertype-expresion the implicit ANDOR constraints, (that is, those
;;;         entity datatypes that reference the supertype in their subtype-of expression but
;;;         are not found in the supertype's supertype-constraint expression).
(defun step-b ()
  "One part of evaluated-set that is still required (for support 
   of the subtypes function. This attaches implicit ANDOR subtypes to the
   supertype constraint clause."
   (loop for subtype-class being the hash-value of (entity-types (schema *expresso*))
         for subtype-class-name = (class-name subtype-class) do
         (loop for supertype in (mapcar #'find-class (subtype-of subtype-class)) ; PODsampson find-eu-class
                for expression = (supertype-expression supertype)
                unless (find subtype-class-name (flatten expression))
	        do
	        (let ((constraint (supertype-constraint supertype)))
	          (cond (constraint
		         (setf (supertype-constraint supertype)
			       (compose-andor constraint subtype-class-name))
		         (setf (supertype-expression supertype)
			       `(es-andor ,expression ,subtype-class-name)))
		        (t
		         (setf (supertype-constraint supertype)
                               ;; The FOR doesn't bind the variable, it sets it.
                               (let ((scn subtype-class-name))
			         #'(lambda () (es-andor scn))))
		         (setf (supertype-expression supertype)
			       (list 'es-andor subtype-class-name))))))))

(defmethod no-applicable-method ((gf express-generic-function-mo) &rest function-args)
  (declare (ignore function-args))
  (break "2007-04-03: This isn't still used, is it?")
  :?)

#+pod7
(defmethod no-applicable-method ((gf express-x-generic-function-mo) &rest function-args)
  (let* ((arg (first function-args)) ;pod7 was vi-root-supertype
         (entity (if (typep arg 'entity-root-supertype) (entity-id arg (entity-dataset arg)) arg)))
    (error 'attribute-not-in-view :attribute (subseq (symbol-name (generic-function-name gf)) 1)
	   :view entity)))



