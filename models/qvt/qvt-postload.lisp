
(in-package :qvt)

(defmethod print-object ((obj |RelationalTransformation|) stream)
    (with-slots (|name| |rule|) obj
      (format stream "<qvt:RelationalTransformation ~A (~A rules)>" 
	      |name| (length |rule|))))

(defmethod print-object ((obj |Relation|) stream)
  (with-slots (|name| |isTopLevel|) obj
    (format stream "<qvt:~ARelation ~A>" (if (eql |isTopLevel| :true) "top " "") |name|)))

(defmethod print-object ((obj |RelationDomain|) stream)
  (with-slots (|rootVariable| |typedModel|) obj
    (if (and |rootVariable| |typedModel| (%owner obj))
	(format stream "<qvt:RelationDomain ~A (of ~A)>"
		|rootVariable|
		(%name (%owner obj)))
	(call-next-method))))

(defmethod print-object ((obj |ObjectTemplateExp|) stream)
    (with-slots (|bindsTo| |referredClass| mofi:|debug-id|) obj
      (format stream "<qvt:ObjectTemplateExp ~A:~A, id=~A)>" |bindsTo| |referredClass| mofi:|debug-id|)))

(defmethod print-object ((obj |PropertyTemplate|) stream)
    (with-slots (|referredProperty| mofi:|debug-id|) obj
      (format stream "<qvt:PropertyTemplate ~A, id=~A)>" |referredProperty| mofi:|debug-id|)))

(defmethod print-object ((obj |WhereExpression|) stream)
  (with-slots (|owner|) obj
    (with-slots (|name|) |owner|
      (format stream "<qvt:WhereExpression (of ~A)>" |name|))))

(defmethod print-object ((obj |WhenExpression|) stream)
  (with-slots (|owner|) obj
    (with-slots (|name|) |owner|
      (format stream "<qvt:WhenExpression (of ~A)>" |name|))))

(defmethod print-object ((obj |RelationDomainAssignment|) stream)
  (with-slots (|owner| mofi:|debug-id|) obj
    (format stream "<qvt:RelationDomainAssignment (of ~A of ~A), id=~A>" 
	    (if (typep |owner| '|WhenExpression|) "WHEN" "WHERE") 
	    (qvt:%name (qvt:%owner |owner|))
	    mofi:|debug-id|)))

(defmethod print-object ((obj |TypedModel|) stream)
    (with-slots (|name| |usedPackage|) obj
      (format stream "<qvt:TypedModel ~A:~A>" |name| |usedPackage|)))

(defmethod print-object ((obj |Function|) stream)
    (with-slots (|name|) obj
      (format stream "<qvt:Function ~A>" |name|)))

(defmethod print-object ((obj |Key|) stream)
    (with-slots (|identifies| |part|) obj
      (format stream "<qvt:Key ~A(~{~A~^,~})>" |identifies| |part|)))

      






