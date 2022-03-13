
;;; Run this from the command line, not in slime.
(load "load")
(push :cre-essential-models *features*)
(sb-ext:save-lisp-and-die "./cre-models.sbcl-core")
