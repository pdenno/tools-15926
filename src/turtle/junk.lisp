#| Not used
(defun ensure-uri-ref-node (uri)
  "Return an exsiting or new URIReference node. URI is a URIReference."
  (unless (typep uri 'rdfb:|URIReference|) (error "ensure-uri-ref-node: argument type"))
  (or
   (gethash uri *nodes*)
   (make-instance 'rdfb:|URIReferenceNode| :uri-ref  uri)))
|#
      


      ;; The integer part (if any) 
      (unless (eql #\. (peek-char nil in nil nil))
	(setf int (read-from-string
		   (with-output-to-string (i)
		     (loop for p = (peek-char nil in nil nil)
			while (and (characterp p)
				   (digit-char-p p))
			do (write-char (read-char in nil nil) i))))))
