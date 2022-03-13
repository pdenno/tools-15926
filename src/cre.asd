;;; -*- Mode: Lisp; -*-

(in-package :user-system)

(defsystem :cre
    :serial t
    :depends-on (:qvt :readers :cre-http #+injector :injector :vamp :turtle)
    :components ())














