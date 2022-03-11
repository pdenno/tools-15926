
;;; Automatically generated from the UML Metamodel by UML Testbed tools on 2007-12-11 17:30:17
;;; Load this file with ensure-model and load-model, not load
;;; Before editing, consider whether edits belong in the generator rather than here.

(in-package "SimpleUML")


(def-mm-class |Association| "SimpleUML" (|PackageElement|)
   ""
  ((|destination| :range |Class| :multiplicity (1 1))
   (|source| :range |Class| :multiplicity (1 1))))


(def-mm-class |Attribute| "SimpleUML" (|UMLModelElement|)
   ""
  ((|owner| :range |Class| :multiplicity (1 1))
   (|type| :range |Classifier| :multiplicity (1 1))))


(def-mm-class |Class| "SimpleUML" (|Classifier|)
   ""
  ((|attribute| :range |Attribute| :multiplicity (0 -1))
   (|forward| :range |Association| :multiplicity (0 -1))
   (|general| :range |Class| :multiplicity (0 -1))))


(def-mm-class |Classifier| "SimpleUML" (|PackageElement|)
   ""
  ())


(def-mm-class |Package| "SimpleUML" (|UMLModelElement|)
   ""
  ((|elements| :range |PackageElement| :multiplicity (0 -1))))


(def-mm-class |PackageElement| "SimpleUML" (|UMLModelElement|)
   ""
  ((|namespace| :range |Package| :multiplicity (1 1))))


(def-mm-class |PrimitiveDataType| "SimpleUML" (|Classifier|)
   ""
  ())


(def-mm-class |UMLModelElement| "SimpleUML" (mof:|NamedElement|)
   ""
  ((|kind| :range |String| :multiplicity (1 1))))


(with-slots (mofi::abstract-classes) *model*
    (setf mofi::abstract-classes '(|Classifier|))) 

;;; End of Output