;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Package: EXPRESSO; Base: 10 -*-

;;; Copyright (c) 2001 Logicon, Inc.
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

;;; Peter Denno
;;; Date: 2/1/96
;;; Purpose: Utilities used in processing of EXPRESS.
(in-package :expresso)

;;; Do not memoizing this; it uses a global variable.
(defun selects-using (type-name)
  "Returns a list of all SELECT type names that use the argument.
   type-name - A symbol identifying a type."
  (loop for type being the hash-value of (defined-types (schema *expresso*))
        for td = (type-descriptor type)
        when (and (typep td 'select-typ)
                  (find type-name (select-list td)))
        collect type))

(declaim (inline string2accessor-name))
(defun string2accessor-name (string)
  "Returns %<string> a symbol. Where <string> is the arg. OK if sent a symbol."
  (intern (format nil "%~A" (string-upcase string))
	  (lisp-package (schema *expresso*))))

(defmacro with-type-descriptor ((lower &optional upper base-type optional unique) agg &body body)
  "Usage (with-type-descriptor (l u base-type optional unique) agg &body..."
  (with-gensyms (td)
    `(let* ((,td (type-descriptor ,agg))
	    (,lower (l-bound ,td))
	    ,@(when upper     `((,upper     (u-bound   ,td))))
	    ,@(when base-type `((,base-type (base-type ,td))))
	    ,@(when optional  `((,optional  (optional  ,td))))
	    ,@(when unique    `((,unique    (unique    ,td)))))
       ,@body)))

(defun find-direct-slot (class-name slot-name &optional safe)
  "Return the direct slot of the argument class."
  (or (find slot-name
	    (class-direct-slots 
	     (find-class (intern (string class-name) (lisp-package (schema *expresso*)))))
	    :key #'slot-definition-name)
      (unless safe
	(error 'no-attribute-on-entity :entity class-name :attribute slot-name))))

;;; Ha! (lw:lisp-image-name) doesn't work in delivered images either! 
(defun install-dir ()
  "The directory in which expresso is running as a string.
   Sorry, logical pathnames don't work consistently in LW .exe's.
   Contains trailing slash."
  (if (member :sei.exe *features*) 
      #+win32(getenv "EXPOPATH")
      #+(and linux lispworks)(subseq (lw:lisp-image-name)
				    0 (1+ (position #\/ (lw:lisp-image-name) :from-end t)))
      #+(and linux sbcl)"/home/pdenno/projects/expresso/source/" ; pod7-sbcl
      #+win32(getenv "EXPOPATH")
      #+linux(namestring (translate-logical-pathname #P"expo:"))))

(declaim (inline schema-file-name))
(defun schema-file-name ()
  (pod:lpath :tmp (format nil "mexico/schema-~D.~A" 
                     (get-pid) *lisp-file-type*)))

(declaim (inline x-schema-file-name))
(defun x-schema-file-name ()
  (pathname (format nil "~Atmp/x-schema-~D.~A" 
		    (install-dir) (get-pid) *lisp-file-type*)))

(defun redef-is-derived-p (instance slot-name source-entity)
  "Return true if the slot that redefines is derived.
    Args:   
      slot-name - a symbol, the slot name (no '.') that is redefined. 
      source-entity - a symbol, the source entity which does the redefining."
  (let ((found (loop for candidate in (class-slots (class-of instance)) 
                     when (and
                           (eql source-entity (slot-definition-source candidate))
                           (eql slot-name (slot-definition-simple-name candidate)))
                     return candidate)))
    (and found
         (slot-definition-derived found))))

(defmacro suppress-full-entity-print (&body body)
  "Body is executed in an enviroment where only #<entity-number> is printed,
   not #<entity-number>=...."
  `(let ((*inside-entity--print-ref* t))
     ,@body))

(defmacro suppress-full-vi-print (&body body)
  "Body is executed in an enviroment where only #<entity-number> is printed,
   not #<entity-number>=...."
  `(let ((*inside-vi--print-ref* t))
     ,@body))

;;; Tests whether the value is the Express ? (not the Part21 $).
(declaim (inline indeterminate-p))
(defun indeterminate-p (exp)
  (eql exp :?))

(defun write-file-header (stream source-pathname)
  (multiple-value-bind (ignore min hour day month year)
      (get-decoded-time)
    ignore
    (format stream ";;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Package: EU; Base: 10 -*-~%")
    (format stream "~%;;; File created by Express Engine at ~2D:~2,'0D  ~A/~A/~A."
            hour min month day year)
    (format stream "~%;;; ~A" (ee-version))
    (format stream "~%;;; Express Engine is developed as a project on SourceForge.net"))
    (format stream "~%;;; Compilation of ~A" source-pathname)
    (format stream "~2%(in-package :expresso-user)"))

#+Debug
(defmacro back-pointed-to (match-form entity-extent-name accessor)
  "Loop through the instances of entity-extent-name applying accessor to each.
   Return the first match (eql match-form candidate) that you find. "
  (with-gensyms (match-to)
    `(let ((,match-to ,match-form))
       (loop for candidate being the hash-value of (instances (find-eu-class ',entity-extent-name))
             when (eql ,match-to (,accessor candidate nil))
             return candidate))))

;;; This is invoked at run-time from both where-rules and global rules to set
;;; the context of any attribute accesses to the current partial entity type. 
;;; This is only valuable when two or more disjoint supertypes each define an
;;; attribute of the same name. In such cases, if the express code doesn't specify
;;; the actual partial being referenced (through the group qualifier) attributes
;;; are sought in the types *focus-partial-context* (see the accessor closure).
(defmacro with-partial-context (entities &body body)
  `(let ((*focus-partial-context* ',entities))
     ,@body))

(defmacro with-target-dataset ((dataset) &body body)
  "Safely switches the target-dataset while in the scope of the form."
  (with-gensyms (hold)
    `(let (,hold)
       (unwind-protect
           (progn 
             (setf ,hold (get-special target-dataset))
             (set-special target-dataset ,dataset)
             ,@body)
         (set-special target-dataset ,hold)))))

(defmacro with-schema ((schema) &body body)
  "Safely switches the current-schema while in the scope of the form."
  (with-gensyms (hold)
    `(let (,hold)
       (unwind-protect
           (progn 
             (setf ,hold (schema *expresso*))
             (setf (schema *expresso*) ,schema)
             ,@body)
         (setf (schema *expresso*) ,hold)))))


;;; This is used in these places:
;;;  (1) In the print-function for various ids (entity, function...)
;;;  (2) In term-rewrite rules *toplevel-express-id*
;;;  (3) In translate-type methods. 
;;; PODsampson(declaim (inline schema-qualified-namestring))
#+nil ; PODsampson
(defun schema-qualified-namestring (namestring &optional schema)
  (format nil "~@:(~A.~A~)"
	  (short-name (if schema (find-schema schema) (schema *expresso*)))
	  namestring))

;;; PODsampson (declaim (inline schema-qualfied-class-name))
#+nil ; PODsamposn
(defun schema-qualified-class-name (class-name &optional schema)
  "Given a entity or defined type class-name (symbol) as it might appear in p21, 
   return the corresponding actual class name (if such a class exists)."
  (declare (ignore schema)) ; PODsampson find-eu-class :schema schema
  (let ((class (find-class class-name)))
    (unless class
      (express-error bad-entity "There is no entity or defined type ~a" class-name))
    (class-name class)))

;;; PODsampson(declaim (inline strip-schema-qualifier))
#+nil ; PODsampson
(defun strip-schema-qualifier (namestring)
  (setf namestring (string namestring))
  (let ((pos (position #\. namestring :from-end t)))
    (if pos
        (subseq namestring (1+ pos))
      namestring)))

;;; PODsampson (declaim (inline long2short-name))
#+nil ; PODsampson
(defun long2short-name (class-name-symbol)
  (short-name (find-class class-name-symbol))) ; PODsampson find-eu-class

(declaim (inline set-all-slots))
(defun set-all-slots (instance)
  "For all the mapped slots set value to :?"
  (loop for slot in (mofi:mapped-slots (class-of instance)) ; 2012 mofi:
        do (setf (slot-value instance (slot-definition-name slot)) :?))
  instance)

(defun write-statistics (stream dataset &key time-interval)
  (with-slots (unexpected-errors where-rule-errors global-rule-errors
               errors-at-creation inverse-relationship-errors
               attribute-type-errors unique-rule-errors
	       validation-type-in-attr-opt validation-inverse-opt
	       validation-where-rules-opt validation-global-rules-opt
	       validation-unique-opt) *expresso*
    (when dataset
      (let ((schema (find-schema (file-schema dataset))))
        (with-slots (entity-types interned-name) schema
          (let* ((total-types (hash-table-count entity-types))
                 (instantiated-types
                   (loop for type being the hash-value of entity-types
		      with count = 0
		      when (not (zerop (hash-table-count (extent type dataset))))
		      do (incf count)
		      finally (return count)))
                 (total-errors (+ unexpected-errors where-rule-errors global-rule-errors
                                  errors-at-creation inverse-relationship-errors 
                                  attribute-type-errors unique-rule-errors)))
            (when time-interval
              (multiple-value-bind (sec min hr day) (decode-time-interval time-interval)
                (format stream "~%Time to Run:               ")
                (when (plusp day) (format stream " ~D day~:P" day))
                (when (plusp hr)  (format stream " ~D hour~:P" hr))
                (when (plusp min) (format stream " ~D minute~:P" min))
                (when (plusp sec) (format stream " ~D second~:P" sec))))
            (format stream "~%Schema:                     ~A" interned-name)
            (format stream "~%Entity Types in Schema:     ~:D" total-types)
            (format stream "~2%Part 21 File:               ~A" (dataset-pathname dataset))
            (format stream "~%Entities Read:              ~:D" (hash-table-count (instances-ht dataset)))
            (format stream "~%Instantiated Entity Types:  ~:D  (~:D%) ~%" 
                    instantiated-types
                    (if (zerop total-types)
		      0
                      (round (* 100 (/ instantiated-types total-types)))))
            (format stream "~%Total Errors:                      ~5:D"  total-errors)
            (format stream "~%    Errors at entity creation:     ~5:D" errors-at-creation)
            (format stream "~%    EXPRESS program exceptions:    ~5:D" unexpected-errors)
            (format stream "~%    Attribute value type errors:   ~:[ OFF ~;~5:D~]" 
                    validation-type-in-attr-opt attribute-type-errors)
            (format stream "~%    Inverse relationship errors:   ~:[ OFF ~;~5:D~]" 
                    validation-inverse-opt inverse-relationship-errors)
            (format stream "~%    WHERE rule errors:             ~:[ OFF ~;~5:D~]" 
                    validation-where-rules-opt where-rule-errors)
            (format stream "~%    UNIQUE rule errors:            ~:[ OFF ~;~5:D~]"
                    validation-unique-opt unique-rule-errors)
            (format stream "~%    Global rule errors:            ~:[ OFF ~;~5:D~]" 
                    validation-global-rules-opt global-rule-errors)
            (format stream "~%====== ~5:D errors encountered =======================" total-errors)
            (format stream "~%=======================================================")))))))

(defun statistics-string (dataset &key time-interval)
  (with-output-to-string (stream)
    (write-statistics stream dataset :time-interval time-interval)))

(defun copy-entity-attributes (source target)
  "Copy the entity attributes from the source argument entity to the target argument entity.
   This function will handle 'same short named' attributes in differing schema."
  (let ((source-slots (mofi:mapped-slots (class-of source))) ; 2012 mofi:
        (target-slots (mofi:mapped-slots (class-of target)))); 2012 mofi:
    (loop for source-slot in source-slots
          for target-slot = (find (slot-definition-simple-name source-slot) target-slots
                                  :key #'slot-definition-simple-name)
          do (setf (slot-value target (slot-definition-name target-slot))
	       (slot-value source (slot-definition-name source-slot))))))

(defun schema-name-strip-object-reference (schema-name)
  "Given a name like 'AUTOMOTIVE_DESIGN { 1 2 10303 214 0 1 1 1 }' return 'AUTOMOTIVE_DESIGN'.
   Note that it returns NIL when schema-name does not include an object reference. This is good."
  (when-bind (pos (position #\{ schema-name))
    (string-trim '(#\Space) (subseq schema-name 0 pos))))
  
(defun unnest (input &optional accumulator)
  "Return the flat list of the atoms in the input (which is an express aggr).
   E.g.: (flatten ((A,(B,(C),D))) => (a b c d)"
  (cond ((null input) accumulator)
        ((listp input) (mapappend #'unnest input))
	((not (typep input 'express-aggregate)) (cons input accumulator))
	(t
         (let ((val (value input)))
           (unnest (first val)
                   (unnest (rest val) accumulator))))))




