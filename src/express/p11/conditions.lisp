

(in-package :p11p)

(def-parse-error scope-error ()
  ()
  (:report (lambda (err stream)
	     (with-slots (pod::text) err ; PODTT
		  (format stream "Line ~A: ~A" *line-number* pod::text))))) ; PODTT

(def-parse-error parse-invalid-base-type (parse-error-with-token)
  ((definition :initarg :definition)
   (token :initarg token))
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (if definition
		      (format stream "While parsing ~A, the token '~A' is not a valid base_type."
				  definition token)
		      (format stream "While parsing token = ~A (no definition), invalid base type error."
				 token))))))

(def-parse-error parse-invalid-bi-constant (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is not a valid built_in_constant."
			   definition token)))))

(def-parse-error parse-invalid-bi-function (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is not a valid built_in_function."
			   definition token)))))

(def-parse-error parse-invalid-bi-procedure (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is not a valid built_in_procedure."
			  definition token)))))

(def-parse-error parse-invalid-decl (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is not a valid declaration."
			   definition token)))))

(def-parse-error parse-bad-call (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, the token '~A' is neither an entity nor a function."
			  definition token)))))

(def-parse-error parse-redefine-enumeration-id (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing ~A, there was an attempt to redeclare the enumeration_id '~A'"
			  definition token)))))

(def-parse-error parse-cmd-bad-call (parse-error-with-token)
  ()
  (:report (lambda (err stream)
	     (with-slots (definition token) err
	       (format stream "While parsing your input: ~A~%, the token '~A' is neither an entity nor a function."
			   definition token)))))


;;;--- not really parsing errors, but associated with a line
(def-parse-error pprocess-error ()
  ())
