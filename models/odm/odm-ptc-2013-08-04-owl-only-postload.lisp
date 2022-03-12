
(in-package :odm)


(defmethod print-object ((obj |IRI|) stream)
  (with-slots (|iriString|) obj
    (format stream "#<IRI ~S, id=~A>"  
	    |iriString|
	    (mofi:%debug-id obj))))

(defmethod print-object ((obj |Triple|) stream)
  (if-debugging (:triples 1)
    (with-slots (|RDFsubject| |RDFpredicate| |RDFobject|) obj
      (format stream "~S ~S ~S" |RDFsubject| |RDFpredicate| |RDFobject|))
    (call-next-method)))


