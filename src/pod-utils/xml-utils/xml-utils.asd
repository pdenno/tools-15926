
(asdf:defsystem :xml-utils
  :name "xml-utils"
  :depends-on ("pod-utils" #+closure-xml :cxml #+sbcl :inferior-shell)
  :components
  ((:file "xml-utils")))
