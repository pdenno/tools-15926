;;; -*- Mode: Lisp; Syntax: ANSI-Common-Lisp; Package: CL-USER; Base: 10 -*-

;;; Copyright (c) 2002 Logicon, Inc.
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without restriction,
;;; including without limitation the rights to use, copy, modify,
;;; merge, publish, distribute, sublicense, and/or sell copies of the
;;; Software, and to permit persons to whom the Software is furnished
;;; to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
;;; ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
;;; CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
;;;-----------------------------------------------------------------------

;;; Author: Craig Lanning
;;; Date: 05-Aug-2002
;;;
;;; Purpose: Makes Express-X Package etc.

(in-package :CL-USER)


(defpackage p21u
  (:nicknames p21-user)
  (:use )
  (:export
   ))

(defpackage p21p
  (:nicknames p21-parser)
  (:use p11-parser pod-utils cl)
  (:shadowing-import-from :p11-parser
    declaration function type otherwise)
  (:shadowing-import-from :expo *dataset*)
  #+(or Allegro LispWorks)
  (:shadowing-import-from :clos
    slot-definition-name slot-definition-initargs)
  #+CMU
  (:shadowing-import-from :pcl
    slot-definition-name slot-definition-initargs)
  #+SBCL
  (:shadowing-import-from :sb-pcl
    slot-definition-name slot-definition-initargs)
  (:export
    p21-stream
    p21-read p21-read-from-string
    parse-entity-from-string
    p21-entity-ref))


