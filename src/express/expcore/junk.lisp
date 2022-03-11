

;;; POD modified 2009-06-12 to capture non-entity types.
(defmethod base-types-aux ((typ select-typ) &optional accum)
  (let* ((utypes (collect-underlying-types typ))
	 (etypes (remove-if (complement #'(lambda (x) (typep x 'entity-root-supertype))) utypes))
	 (dtypes (set-difference utypes etypes)))
	 (type-names )))
    (append
     accum
     (mapappend #'base-types-aux dtypes)
     (mapappend #'base-types-aux utypes))


(defun remove-redefinition-of (slots)
  "Remove from the list of express-direct-slot-definitions those that
   are overridden by a definition introduce by SELF/<group>.<slot-name>"
  (loop for slot in slots
        for slot-name = (slot-definition-name slot)
        for source = (if (slot-boundp slot 'source) (slot-value slot 'source) :dataset)
        unless (find-if #'(lambda (s) ;; Same named slot that has it as a redefinition-of
                            (and 
                             (eql slot-name (slot-definition-name s))
                             (eql source (slot-value s 'redefinition-of))))
                        slots)
        collect slot))

(defun set-redefined-by (eff-slots)
  "Sets the redefined-by slot if the slot is in fact redefined in the Complex Entity Data Type.
   5/19/98 It sets it to the NEAREST slot that it redefines.
   Args: eff-slots- a list of e-eff-slot-definitions that all have the same *simple* name." 
  (when (cdr eff-slots)
    (loop for slot in eff-slots
          for slot-source = (slot-definition-source slot)
          for supertype-names = (reverse (butlast (p21-precedence-order slot-source))) do
          (loop for supertype in supertype-names
                for on-path = (find supertype eff-slots :key #'slot-definition-source)
                when on-path
                do
                (setf (slot-value on-path 'redefined-by) slot-source)
                and return nil)))
  eff-slots)


