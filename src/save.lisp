;;; Run this from the command line, not in slime.

(defun qqq () (sb-ext:quit))
(load "load")
(pushnew :cre-ready *features*)
(sb-ext:save-lisp-and-die "./cre-image.sbcl")
