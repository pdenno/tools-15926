
;;; Automatically generated from the UML Metamodel by UML Testbed tools on 2008-01-06 17:18:22
;;; Load this file with ensure-model and load-model, not load
;;; Before editing, consider whether edits belong in the generator rather than here.

(in-package "SimpleRDBMS")



(def-mm-CLASS |Column| "SimpleRDBMS" (|RelationalModelElement|)
   ""
  ((|foreignKey| :range |ForeignKey| :multiplicity (0 -1))
   (|key| :range |Key| :multiplicity (0 -1))
   (|owner| :range |Table| :multiplicity (1 1))
   (|type| :range |String| :multiplicity (1 1))))


(def-mm-CLASS |ForeignKey| "SimpleRDBMS" (|RelationalModelElement|)
   ""
  ((|column| :range |Column| :multiplicity (0 -1))
   (|owner| :range |Table| :multiplicity (1 1))
   (|refersTo| :range |Key| :multiplicity (1 1))))


(def-mm-CLASS |Key| "SimpleRDBMS" (|RelationalModelElement|)
   ""
  ((|column| :range |Column| :multiplicity (0 -1))
   (|owner| :range |Table| :multiplicity (1 1))))


(def-mm-CLASS |PrimitiveDataType| "SimpleRDBMS" NIL
   ""
  ((|name| :range |String| :multiplicity (1 1))))


(def-mm-CLASS |RelationalModelElement| "SimpleRDBMS" NIL
   ""
  ((|name| :range |String| :multiplicity (1 1))))


(def-mm-CLASS |Schema| "SimpleRDBMS" (|RelationalModelElement|)
   ""
  ((|tables| :range |Table| :multiplicity (0 -1))))


(def-mm-CLASS |Table| "SimpleRDBMS" (|RelationalModelElement|)
   ""
  ((|column| :range |Column| :multiplicity (0 -1))
   (|foreignKey| :range |ForeignKey| :multiplicity (0 -1))
   (|key| :range |Key| :multiplicity (0 -1))
   (|schema| :range |Schema| :multiplicity (1 1))))

;;; End of Output