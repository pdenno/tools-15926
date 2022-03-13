
(in-package :mofi)

;;; Purpose: A central collection of model declarations. 

;;; See also ocl/ocl-load.lisp. Not sure what the intended relationship was (bootstrapping?)
(ensure-model :ptypes
  :force t :verbose t
  :features '(:always)
  :model-class 'essential-lexical-model
  :nicknames '("PrimitiveTypes.xmi"
	       "PrimitiveTypes.cmof"
	       "http://www.omg.org/spec/PrimitiveTypes.xmi"  ; this one mine, for Alf.
	       "http://www.omg.org/spec/UML/20110701/PrimitiveTypes.xmi" ; 2012, this one for 2.4.1
	       "http://www.omg.org/spec/UML/20120801/PrimitiveTypes.xmi" ; this one for 2.5 beta
	       "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi" ; This one for 2.5
	       "http://www.omg.org/spec/UML/2.5/PrimitiveTypes.xmi")      ; This one for 2.5
  :postload-path (pod:lpath :mylib "uml-utils/ocl/ptypes.lisp")
  :ns-uri   "PrimitiveTypes.cmof"
  :href-uri  "http://www.omg.org/spec/PrimitiveTypes.xmi"
  :ns-prefix "primitive-types"
  :model-types '("primitives"))

;;; This is also in ocl/ocl-load.lisp
(ensure-model :ocl
  :force t :verbose t
  :features '(:always)
  :model-class 'essential-lexical-model
  :nicknames '("OCL")
  :postload-path (pod:lpath :mylib "uml-utils/ocl/types.lisp") ; <====== Different!
; :package-use-list '(:cl :pod :mofi :ptypes)
  :reserved-words ; 2012-01-01 Clause 7.5.9
  '("and" "body" "context" "def" "derive" "else" "endif" "endpackage" "false" "if" "implies" 
    "in" "init" "inv" "invalid" "let" "not" "null" "or" "package" "post" "pre" "self" "static" "then" "true" "xor")
;;;:reserved-words ; Clause 7.4.9
;;;'("and" "attr" "context" "def" "else" "endif" "endpackage" "if" "implies" "in" "inv" "let" 
;;;    "not" "oper" "or" "package" "post" "pre" "then" "self" "xor")
  :constant-strings
  '("false" "self" "true")
  :operator-strings ; this intentionally does not include infix operators
  '("abs" "allInstances" "any" "append" "asBag" "asOrderedSet" "asSequence" "asSet" 
    "at" "closure" "collect" "collectNested" "concat" "count" "div" "excludes" "excludesAll" 
    "excluding" "exists" "first" "flatten" "floor" "forAll" "in" "includes" "includesAll" 
    "including" "indexOf" "insertAt" "intersection" "intesection" "invalid" "isEmpty" "isOperationCall" 
    "isSignalSent" "isUnique" "iterate" "last" "max" "min" "mod" "not" "notEmpty" "null" "oclAsType" "oclIsInState" 
    "oclIsInvalid" "oclIsKindOf" "oclIsNew" "oclIsTypeOf" "oclIsUndefined" "oclType" "one" "prepend" 
    "product" "reject" "round" "select" "size" "sortedBy" "subOrderedSet" "subsequence" "substring" 
    "sum" "symmetricDifference" "toInteger" "toReal" "union")
  :ns-prefix "OCL"
  :model-types '("OCL"))

(ensure-model 
 :mofi 
 :force t :verbose t
 :features '(:always)
 :model-class 'essential-compiled-model
 :classes-path (pod:lpath :models "mof/mof-mm.lisp")
 :ns-prefix "MOFI")

(ensure-model :xmi21
  :force t :verbose t
  :features '(:always)
  :model-class 'exchange-model
  :nicknames 
  '("http://schema.omg.org/spec/XMI/20100901" ; This IS on the document .pdf 'Standard Document URL'
    "http://schema.omg.org/spec/XMI/2.1") ; 2013-02-27 I don't see this on the document .pdf. 2013-04-09 but using it!
  :documentation "Serves mostly to define a package and nicknames."
  :ns-prefix "XMI")


(ensure-model :xmi211
  :force t :verbose t
  :features '(:always)
  :model-class 'exchange-model
  :nicknames 
  '("http://schema.omg.org/spec/XMI/2.1.1")
  :documentation "Serves mostly to define a package and nicknames."
  :ns-prefix "XMI")

(ensure-model :xmi24
  :force t :verbose t
  :features '(:always)
  :model-class 'exchange-model
  :nicknames 
  '("http://www.omg.org/spec/XMI/20100901"
    "http://www.omg.org/spec/XMI/2.4")
  :documentation "Serves mostly to define a package and nicknames."
  :ns-prefix "XMI")

(ensure-model :xmi241
  :force t :verbose t
  :features '(:always)
  :model-class 'exchange-model
  :nicknames 
  '("http://www.omg.org/spec/XMI/20110701" ; See email from Ed S. 2013-04-08
    "http://www.omg.org/spec/XMI/2.4.1")
  :documentation "Serves mostly to define a package and nicknames."
  :ns-prefix "XMI")

(ensure-model :xmi25
  :force t :verbose t
  :features '(:always)
  :model-class 'exchange-model
  :nicknames 
  '("http://www.omg.org/spec/XMI/20131001") ; added 2013-11-22 for UML25
  :documentation "Serves mostly to define a package and nicknames."
  :ns-prefix "XMI")

(defun all-xmis ()
  "Return a list of all xmi packages."
  '(:xmi25 :xmi241 :xmi24 :xmi211 :xmi21))

(mofi:ensure-model 
 :cmof :force t :verbose t
 :nicknames '("CMOF 2.0"
	      "http://schema.omg.org/spec/CMOF"
              "http://schema.omg.org/spec/MOF/2.0/cmof.xml")
 :features '(:always)
 :depends-on-models '(:ocl)
 :documentation "Generated from infralib/10-08-15-cleanup.xmi (which is a metamodel specified in UML).
                 updated with OCL from uml23 only where appropriate. (I hope!)"
 :model-class 'mofi:essential-compiled-model
 :classes-path (pod:lpath :models "cmof/cmof.lisp")
 :postload-path (pod:lpath :models "cmof/cmof-postload.lisp")
 :ns-uri "http://schema.omg.org/spec/MOF/2.0/"
 :href-uri "http://schema.omg.org/spec/MOF/2.0/cmof.xml"
 :ns-prefix "cmof")

;;; 2010-06-19: New rule: The first nickname of a model shall be "pretty"
;;;             For motivation, see miwg/validator.lisp/coverage statistics.
;;; 2010-07-30: New rule: The second nickname shall be the one used in XMI serialization. 
;;; 2011-06-20: (Salt Lake City) Changed nickname UML.xmi to UML.xml (ONLY FOR 2.3). NOPE
;;; 2022 :uml241 is enough for CRE???

#+nil(mofi:ensure-model 
 :uml23 :force t  :verbose t
 :model-class 'mofi:essential-compiled-model
 :nicknames '("UML 2.3" 
	      "http://www.omg.org/spec/UML/20090901"           ;<---- Use this one for xmlns.
	      "http://www.omg.org/spec/UML/20090901/UML.xmi")  ;<---- Use this one for hrefs with 
 :features '(:miwg :cre)
 :depends-on-models '(:ocl)
 :documentation "Produced from http://www.omg.org/cgi-bin/doc?ptc/09-09-23 (Updated UML 2.3 L3.merged.xmi)
                CMOF_file (1194956 bytes)"
 :classes-path (pod:lpath :models "uml/uml23.lisp")
 :postload-path (pod:lpath :models "uml/uml23-postload.lisp")
 :ns-uri "http://www.omg.org/spec/UML/20090901"
 :href-uri "http://www.omg.org/spec/UML/20090901/UML.xmi"
 :ns-prefix "uml"
 :model-types '("UML"))

(mofi:ensure-model 
 :uml241 :force t  :verbose t
 :model-class 'mofi:essential-compiled-model
 :nicknames '("UML 2.4.1" 
	      "http://www.omg.org/spec/UML/20110701"
	      "http://www.omg.org/spec/UML/20110701/UML.xmi") 
 :features '(:miwg :cre)
 :depends-on-models '(:ocl)
 :documentation "Retrieved from http://www.omg.org/spec/UML/2.4.1/ Validator-generated version
  created 2012-01-22, back-filling edits from 2.3."
 :classes-path (pod:lpath :models "uml/uml241.lisp")
 :postload-path (pod:lpath :models "uml/uml241-postload.lisp")
 :ns-uri   "http://www.omg.org/spec/UML/20110701"
 :href-uri "http://www.omg.org/spec/UML/20110701/UML.xmi"
 :ns-prefix "uml"
 :model-types '("UML"))

(ensure-model 
 :qvt :force t :verbose t
 :model-class 'mofi:essential-lexical-model
 :features '(:qvt) ; is that an 'and'?
 :classes-path (pod:lpath :models "qvt/qvt-mm.lisp")
 :postload-path (pod:lpath :models "qvt/qvt-postload.lisp")
 :nicknames '("QVT" "Not applicable" "Also not applicable")
 :documentation "Implemented to specification ptc/07-07-07 with updates for ptc/11-01-01"
 :reserved-words
  '("checkonly"  ; Clause 7.13.2
    "domain" 
    "enforce" 
    "extends"
    "function" ; pod added this one
    "implementedby"
    "import" 
    "key"   ; ...and their example violates the rule that they can't be used as identifers??? 
    "opposite"
    "overrides"
    "primitive" 
    "query"
    "relation"
    "top"
    "transformation"
    "when"
    "where")
 :href-uri "http://www.omg.org/spec/QVT/20091201.QVTRelation.xml"
 :ns-uri "http://www.omg.org/spec/QVT/1.1"
 :ns-prefix "QVT")



