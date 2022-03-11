
(in-package :mofi)


;;; POD These are typically in the x-essential-load.lisp too. Not sure why both places.

(ensure-model :ptypes
  :force t :verbose t
  :features '(:always)
  :model-class 'essential-lexical-model
  :nicknames '("PrimitiveTypes.xmi"
	       "PrimitiveTypes.cmof"))


 (ensure-model 
  :ocl :force t
  :features '(:always)
  :model-class 'essential-lexical-model
  :reserved-words ; Clause 7.4.9
  '("and"
    "attr" 
    "context" 
    "def" 
    "else" 
    "endif" 
    "endpackage" 
    "if" 
    "implies"
    "in"
    "inv"
    "let" 
    "not"
    "oper" 
    "or"
    "package"
    "post"
    "pre"
    "then"
    "self"
    "xor")
  :constant-strings
  '("false" 
    "self" 
    "true")
  :operator-strings
  '("abs" ; this intentionally does not include infix operators
    "allInstances" 
    "any"
    "append" 
    "asBag" 
    "asOrderedSet" 
    "asSequence" 
    "asSet" 
    "at" 
    "collect" 
    "collectNested" 
    "concat" 
    "count" 
    "div" 
    "excludes" 
    "excludesAll" 
    "excluding" 
    "exists" 
    "first" 
    "flatten" 
    "floor" 
    "forAll" 
    "in" 
    "includes" 
    "includesAll" 
    "including" 
    "indexOf" 
    "insertAt" 
    "intersection" 
    "intesection" 
    "invalid" 
    "isEmpty" 
    "isOperationCall" 
    "isSignalSent" 
    "isUnique" 
    "iterate" 
    "last" 
    "max" 
    "min" 
    "mod" 
    "not" 
    "notEmpty" 
    "oclAsType" 
    "oclIsInState" 
    "oclIsInvalid" 
    "oclIsKindOf" 
    "oclIsNew" 
    "oclIsTypeOf" 
    "oclIsUndefined" 
    "oclType" 
    "one" 
    "prepend" 
    "product" 
    "reject" 
    "result" 
    "round" 
    "select" 
    "size" 
    "sortedBy" 
    "subOrderedSet" 
    "subsequence" 
    "substring" 
    "sum" 
    "symmetricDifference" 
    "toInteger" 
    "toReal" 
    "union"))

