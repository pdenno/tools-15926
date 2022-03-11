
(in-package :cl-user)

(defpackage ptypes
  (:use cl pod closer-mop)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function 
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod
			  #:ensure-class #:ensure-class-using-class)
  (:export
    #:|Boolean|
    #:|Integer|  
    #:|Ptype-type-proxy|
    #:|Real|    ; for UML2.4 and later.
    #:|String|
    #:|UnlimitedNatural|))


;;; Symbols exported by this package implement functions of the OCL Standard Library, generally.
;;; There are other symbol exported, defined in the mof:defmodel :ocl
(defpackage ocl
  (:use cl pod closer-mop)
  (:shadowing-import-from :closer-mop #:standard-class #:ensure-generic-function 
			  #:defgeneric #:standard-generic-function #:defclass #:defmethod
			  #:ensure-class #:ensure-class-using-class)
  (:shadowing-import-from :ptypes "Boolean" "String" "Integer" "UnlimitedNatural" "Real")
  (:export 
    #:-typ  
    #:appropriate-collection-type  
    #:|Bag|
    #:bag-typ-p  
    #:base-type  
    #:boolean-typ  
    #:collection-typ  
    #:|Collection|
    #:compile-constraints
    #:compile-operations
    #:integer-typ  
    #:l-bound  
    #:make-var-decl  
    #:number-typ  
    #:object-typ  
    #:ocl-*  
    #:ocl-+  
    #:ocl--  
    #:ocl-/  
    #:ocl-<  
    #:ocl-<=  
    #:ocl-<>  
    #:ocl-=  
    #:ocl->  
    #:ocl->=  
    #:ocl-all-instances  
    #:ocl-and  
    #:ocl-any  
    #:ocl-append  
    #:ocl-as-bag  
    #:ocl-as-ordered-set  
    #:ocl-as-sequence  
    #:ocl-as-set  
    #:ocl-as-type  
    #:ocl-assert  
    #:ocl-at  
    #:ocl-closure
    #:ocl-collect  
    #:ocl-collect-nested  
    #:ocl-concat  
    #:ocl-constraints  
    #:ocl-constraints-cmof  
    #:ocl-add-after-method
    #:ocl-count  
    #:ocl-div  
    #:ocl-ensure-collection
    #:ocl-error  
    #:ocl-excludes  
    #:ocl-excludes-all  
    #:ocl-excluding  
    #:ocl-exists  
    #:ocl-first  
    #:ocl-flatten  
    #:ocl-for-all  
    #:ocl-has-returned  
    #:ocl-if  
    #:ocl-implies  
    #:ocl-includes  
    #:ocl-includes-all  
    #:ocl-including  
    #:ocl-index-of  
    #:ocl-insert-at  
    #:ocl-intersection  
    #:ocl-is-empty  
    #:ocl-is-in-state  
    #:ocl-is-invalid  
    #:ocl-is-kind-of  
    #:ocl-is-new  
    #:ocl-is-operation-call  
    #:ocl-is-signal-sent  
    #:ocl-is-type-of  
    #:ocl-is-undefined  
    #:ocl-is-unique  
    #:ocl-iterate  
    #:ocl-last  
    #:ocl-metaclass
    #:ocl-nav/collect
    #:ocl-not  
    #:ocl-not-empty  
    #:ocl-one  
    #:ocl-or  
    #:ocl-parse-error  
    #:ocl-parse-incomplete  
    #:ocl-parse-token-error  
    #:ocl-prepend  
    #:ocl-product  
    #:ocl-reject  
    #:ocl-result  
    #:ocl-select  
    #:ocl-set-values-not-unique  
    #:ocl-size  
    #:ocl-sorted-by  
    #:ocl-sub-ordered-set  
    #:ocl-subsequence  
    #:ocl-substring  
    #:ocl-sum  
    #:ocl-symmetric-difference  
    #:ocl-to-integer  
    #:ocl-to-real  
    #:ocl-token-balance-error  
    #:ocl-type  
    #:|Ocl-type-proxy|
    #:ocl-union  
    #:ocl-xor  
    #:ordered-p  
    #:ordered-set-typ-p  
    #:|OclAny|
    #:|OclExpression|
    #:|OrderedSet|
    #:primitive-typ  
    #:%proxy-name
    #:real-typ  
    #:self  
    #:sequence-typ-p  
    #:set-typ-p  
    #:string-typ  
    #:|Sequence|
    #:|Set|
    #:tuple-typ  
    #:typ-d
    #:u-bound  
    #:unique-p  
    #:unlimited-integer-typ  
    #:value  
    #:var-decl  
    #:var-decl--init  
    #:var-decl--name  
    #:var-decl--type  
    #:var-decl-p  
    #:|Variable|
    #:self))

#-sbcl
(shadowing-import '(ocl:-typ ocl:value) :ptypes)

;;; POD 2007-11-13: I think the idea should be that oclu is a surrogate for the package where
;;;                 parsing is happening. In QVT at least, tracking actual package might be 
;;;                 too much effort. oclp:constant-p handles this kind of approach OK. 
(defpackage oclu
  (:use cl pod ocl)
  (:shadowing-import-from :ocl self))

(defpackage oclp
  (:use cl pod-utils ocl oclu)
  (:shadowing-import-from 
   :ocl 
   #:self
   ocl::|and|
   ocl::|attr| 
   ocl::|context| 
   ocl::|def| 
   ocl::|else| 
   ocl::|endif| 
   ocl::|endpackage| 
   ocl::|if| 
   ocl::|implies|
   ocl::|in|
   ocl::|inv|
   ocl::|let| 
   ocl::|not|
   ocl::|oper| 
   ocl::|or|
   ocl::|package|
   ocl::|post|
   ocl::|pre|
   ocl::|then|
   ocl::|self|
   ocl::|xor|
   ;; constant strings
   ocl::|false| 
   ocl::|self| 
   ocl::|true|
   ;; this intentionally does not include infix operators
   ocl::|abs| 
   ocl::|allInstances| 
   ocl::|any| 
   ocl::|append| 
   ocl::|asBag| 
   ocl::|asOrderedSet| 
   ocl::|asSequence| 
   ocl::|asSet| 
   ocl::|at| 
   ocl::|closure| 
   ocl::|collect| 
   ocl::|collectNested| 
   ocl::|concat| 
   ocl::|count| 
   ocl::|div| 
   ocl::|excludes| 
   ocl::|excludesAll| 
   ocl::|excluding| 
   ocl::|exists| 
   ocl::|first| 
   ocl::|flatten| 
   ocl::|floor| 
   ocl::|forAll| 
   ocl::|in| 
   ocl::|includes| 
   ocl::|includesAll| 
   ocl::|including| 
   ocl::|indexOf| 
   ocl::|insertAt| 
   ocl::|intersection| 
   ocl::|intesection| 
   ocl::|invalid| 
   ocl::|isEmpty| 
   ocl::|isOperationCall| 
   ocl::|isSignalSent| 
   ocl::|isUnique| 
   ocl::|iterate| 
   ocl::|last| 
   ocl::|max| 
   ocl::|min| 
   ocl::|mod| 
   ocl::|not| 
   ocl::|notEmpty| 
   ocl::|null|
   ocl::|oclAsType| 
   ocl::|oclIsInState| 
   ocl::|oclIsInvalid| 
   ocl::|oclIsKindOf| 
   ocl::|oclIsNew| 
   ocl::|oclIsTypeOf| 
   ocl::|oclIsUndefined| 
   ocl::|oclType| 
   ocl::|one| 
   ocl::|prepend| 
   ocl::|product| 
   ocl::|reject| 
   ocl::|result| 
   ocl::|round| 
   ocl::|select| 
   ocl::|size| 
   ocl::|sortedBy| 
   ocl::|subOrderedSet| 
   ocl::|subsequence| 
   ocl::|substring| 
   ocl::|sum| 
   ocl::|symmetricDifference| 
   ocl::|toInteger| 
   ocl::|toReal| 
   ocl::|union|
   ;; type strings
   ocl::|Bag| 
   ocl::|Boolean| 
   ocl::|Collection| 
   ocl::|Integer| 
   ocl::|OclAny| 
   ocl::|OclVoid| 
   ocl::|OrderedSet| 
   ocl::|Real| 
   ocl::|Sequence| 
   ocl::|Set| 
   ocl::|String| 
   ocl::|Tuple| 
   ocl::|UnlimitedInteger|)
  (:export 
    #:*accessor-pkg*
    #:init-make-var
    #:model-alias
    #:model-alias-model
    #:*in-scope-models*
    #:*declared-class-context*
    #:ocluintern
    #:ocl-init
    #:ocl2lisp 
    #:uml-ocl2lisp
    #:*scope*))

		
		
