
(in-package :oclp)

(defvar *ocl-pkg* (find-package :ocl))
(defvar *oclu-pkg* (find-package :oclu))
(defvar *qvt-parsing* nil "T if parsing a QVT file.")

(defparameter *in-scope-models* (list (mofi:find-model :ocl))
  "List of models to search for attribute names, type names, used to
   disambiguate the reference of a token in attribute-p, constant-p etc.")

#+nil
(defun tryme ()
  (let ((mofi:*model* (mofi:find-model (mofi:modern-uml))))
    (let ((oclp::*in-scope-models* 
	   (list (mofi:find-model (mofi:modern-uml))
		 (mofi:find-model :ocl)))
	  (text "self.value.type = self.variable.type"))
      (set-debugging :parser 5)
      (format t "~%~A" text)
      (oclp::ocl2lisp text #|:class-context (find-class 'uml:|Element|)|#))))

#+nil
(defun tryme-all ()
  "This is great to have!"
  (clear-debugging)
  (let ((mofi:*model* (mofi:find-model (mofi:modern-uml))))
    (declare (special mofi:*model*))
    (let ((oclp:*in-scope-models* (list (mofi:find-model :ocl) 
					(mofi:find-model (mofi:modern-uml)))))
    (declare (special oclp:*in-scope-models*))
      (loop for class across (mofi:types (mofi:find-model (mofi:modern-uml))) do
	    (ocl:compile-constraints class)
	    (ocl:compile-operations class)))))

;;; 2007-11-24 This was string-upcase
(declaim (inline ocluintern))
(defun ocluintern (str)
  (intern str *oclu-pkg*))



(defun in-ocl-stdlib-p (symbol)
  "Returns the lisp function named by the symbol, if it names one, otherwise nil."
  (cdr 
   (assoc 
    symbol 
    '((|implies| . ocl-implies) (|isNew| . ocl-is-new) (|isUndefined| . ocl-is-undefined) 
      (|isInvalid| . ocl-is-invalid) (|asType| . ocl-as-type) (|isTypeOf| . ocl-is-type-of) 
      (|isKindOf| . ocl-is-kind-of) (|isInState| . ocl-is-in-state) (|allInstances| . ocl-all-instances) 
      (|hasReturned| . ocl-has-returned) (|result| . ocl-result) (|isSignalSent| . ocl-is-signal-sent) 
      (|isOperationCall| . ocl-is-operation-call) (|div| . ocl-div) (|size| . ocl-size) 
      (|closure| . ocl-closure) (|concat| . ocl-concat) 
      (|substring| . ocl-substring) (|toInteger| . ocl-to-integer) (|toReal| . ocl-to-real) 
      (|includes| . ocl-includes) (|excludes| . ocl-excludes) (|count| . ocl-count) (|includesAll| . ocl-includes-all) 
      (|excludesAll| . ocl-excludes-all) (|isEmpty| . ocl-is-empty) (|notEmpty| . ocl-not-empty) 
      (|sum| . ocl-sum) (|product| . ocl-product) (|union| . ocl-union) 
      (|symmetricDifference| . ocl-symmetric-difference) (|flatten| . ocl-flatten) (|asSet| . ocl-as-set) 
      (|asOrderedSet| . ocl-as-ordered-set) (|asSequence| . ocl-as-sequence) (|asBag| . ocl-as-bag) 
      (|append| . ocl-append) (|prepend| . ocl-prepend) (|insertAt| . ocl-insert-at) 
      (|subOrderedSet| . ocl-sub-ordered-set) (|at| . ocl-at) (|indexOf| . ocl-index-of) 
      (|first| . ocl-first) (|last| . ocl-last) (|union| . ocl-union) (|intersection| . ocl-intersection) 
      (|subsequence| . ocl-subsequence) (|exists| . ocl-exists) (|forAll| . ocl-for-all) 
      (|isUnique| . ocl-is-unique) (|any| . ocl-any) (|one| . ocl-one) (|collect| . ocl-collect) 
      (|select| . ocl-select) (|reject| . ocl-reject)  (|collectNested| . ocl-collect-nested) 
      (|sortedBy| . ocl-sorted-by) (|if| . ocl-if) (|and| . ocl-and) (|or| . ocl-or) (|xor| . ocl-xor) 
      (|not| . ocl-not) (|including| . ocl-including) (|excluding| . ocl-excluding) (|abs| . abs)
      (|floor| . floor) (|round| . round) (|max| . max) (|min| . min) (div . ocl-div) (|mod| . mod)
      (|iterate| . ocl-iterate) (|oclType| . ocl-type) (< . ocl-<) (> . ocl->) (<> . ocl-<>)
      (<= . ocl-<=) (>= . ocl->=)))))

(defun operator-p (sym)
  "Returns true if SYM is an operator defined in the UML MM, or the OCL standard library,
   or if it is one of the conventional, single-character operators. (So this should 
   include ALL the non-infix operators encountered in a parse. Operators are not a problem.)"
  (and (not (string-const-p sym)) ; and this condition added 2012-02-24 
       (loop for m in *in-scope-models* with str = (string sym)
	  when (find str (mofi:operator-strings m) :test #'string=) return m)))

(defun infix-operator-p (sym)
  (member sym `(#\+ #\- #\* #\/ #\< #\> :less-great :less-equal :great-equal '|and| '|or| '|xor| '|implies|)))


;;; sortedBy, any, one, collectNested, are not in section 7.7 as a collection operation
(defun collection-operator-p (sym) 
  (member sym '(|exists| |forAll| |isUnique| |any| |one| |closure| |collect| |select| |reject| 
		|sortedBy| |collectNested| |iterate|)))

;;; POD 2016-10-26 created. Maybe hopeless.
(defun avoid-nav/collect-p (str)
  (member str '("<>" "size" "includes" "excludes" "includesAll" "excludesAll" "isEmpty" "notEmpty"
		"max" "min" "sum" "product" "asSet" "asOrderedSet" "asSequence" "asBag" "flatten")
	  :test #'string=))

;;; POD without the class spec, this is a rather weak test. It iterates over all models. 
(defun attribute-p (str &optional class)
  "Returns true if STR (a string) names an attribute. If CLASS, a symbol, is specified, 
   STR must be an attribute of the argument class."
  (flet ((find-attr (str class-obj)
	   (or 
	    (find str (mofi:mapped-slots class-obj) 
		  :key #'closer-mop:slot-definition-name :test #'string=)
	    (and (typep class-obj 'mofi:mm-type-mo)
		 (find str (mofi:soft-opposite-slots class-obj) :test #'string=
		       :key #'(lambda (x) (second (mofi:slot-definition-soft-opposite (car x)))))))))
    (and (not (string-const-p str)) ; and this condition added 2012-02-24 
	 (if class
	     (loop for m in *in-scope-models*
		for class-obj = (find-class (intern (string class) (mofi:lisp-package m)) :errorp nil)
		when (and class-obj (find-attr str class-obj))
		do (return-from attribute-p t))
	     ;; The weak part...
	     (loop for slot in '(mofi:types mofi:inherited-types) do
		  (loop for vec in (mapcar #'(lambda (m) (funcall slot m)) *in-scope-models*) do
		       (loop for class-obj across vec
			  when (find-attr str class-obj)
			  do (return-from attribute-p t))))))))

(defun variable-p (str &optional (scope *scope*))
  "Returns true if STR (a string) names a variable in SCOPE (which defaults to *scope*)."
  (and (stringp str) ; pod7 this test now means its not a reserved word or operator.
       (or (assoc :variable (gethash str (%%ids scope)))
	   (and (%%parent scope) (variable-p str (%%parent scope))))))

(let ((var-num 0))
  (defun make-var ()
    "Used to gensym variable, for easy file diffs."
    (intern (format nil "%VAR-~A" (incf var-num)) :oclu))
  (defun init-make-var () (setf var-num 0))
)

;;; POD The existence of UnlimitedInteger is questionable. My approach has been
;;; to use the uml.lisp class for PrimitiveTypes where it exists. Is that OK?
;;; 2008 I think allowing type-p in here was a mistake. 
(defun constant-p (tkn)
  "Returns T if the TKN names a constant in some *in-scope-models*.
   Recall that reserved words of OCL (which may include constants) are interned."
  (and
   (not (string-const-p tkn)) ; and this condition added 2012-02-24 
   (or 
    (keywordp tkn) ; pod fix - these still need package qualifier (2008 are they enums???)
					;2008(type-p tkn)
    ;; It names a constant-string. In OCL this is = ('true' 'false' 'self')
    (loop for m in *in-scope-models*
       when (and (typep m 'mofi::lexical-model-mixin)
		 (member tkn (mofi:constant-strings m) :test #'string=))
       return t))))

(defun type-p (tkn)
  "Returns the model containing type TKN if TKN names a type in some *in-scope-models*."
  (and
   (not (string-const-p tkn)) ; and this condition added 2012-02-24 
   (loop for slot in '(mofi:types mofi:inherited-types) do
	(loop for m in *in-scope-models*
	   when (find tkn (funcall slot m) :test #'string= :key #'class-name)
	   do (return-from type-p  m)))))

;;; POD This one needs work!  It is also used to indicate a Datatype, (for scoping enumerations).
;;; See 7.4.2., example Gender::male. 
(defun package-p (str)
  "Returns the mm-package-mo named by STR, or nil if none." 
  (and
   (not (string-const-p str)) ; and this condition added 2012-02-24 
   (loop for m in *in-scope-models* do
	(loop for p in (mofi:packages m)
	   when (string-equal str (mofi:name p)) ; 2014 string= --> string-equal (for QVT)
	   do (return-from package-p p)))
   nil))

#+debug
(defun tryme (&optional (testcase 1))
  (set-debugging :parser 5)
  (set-debugging :lexer 5)
  (oclp:ocl2lisp 
   (case testcase
     (1 "self.mustBeOwned() implies owner->notEmpty()")
     (2 "self.outgoing->size() = 1")
     (3 "ownedElement->union(ownedElement->collect(e | e.allOwnedElements()))")
     (4 "ownedElement->union(ownedElement->collect(allOwnedElements()))")
     (5 "true")
     (6 "if true then 1 else 3 endif")
     (7 "-3.23 + 5")
     (8 "-3.23 / 5")
     (9 "(self->lowerBound() = 0 or self->lowerBound() = 1) and self->upperBound() = 1")
     (10 "(source.oclIsKindOf(Pseudostate) and source.kind = #fork) implies (guard->isEmpty() and trigger->isEmpty())")
     (11 "memberEnd->reject(ownedEnd)"))
     :debug-p t))

(defvar *accessor-pkg* nil "The package in which accessors should be interned.")

(defun accessor-pkg ()
  "Return the package in which accessors should be interned."
  (or *accessor-pkg*
      (mofi:lisp-package mofi:*model*)))
