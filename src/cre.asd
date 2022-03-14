;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :cre
    :serial t
    :depends-on (:cre-essential-models :qvt :readers :cre-http #+injector :injector :vamp :turtle)
    :components ())














