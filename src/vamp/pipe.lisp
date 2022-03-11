
(in-package :pod-utils)

;;; Copyright (c) Peter Denno, 2006

;;; The principal difference between this and a two-way-stream built on
;;; character vectors is the behavior at end of string: This one blocks.
;;; One based on string-input/output-streams necessarily does EOF behavior.

(export '(pipe clean-pipe))

(defclass pipe (stream:fundamental-character-input-stream
		stream:fundamental-character-output-stream)
  ((cbuf :reader cbuf :initform (make-array 1024 :element-type 'character))
   (read-ptr :accessor read-ptr :initform 0)   ;; first unread char (if not = write-ptr).
   (write-ptr :accessor write-ptr :initform 0) ;; next empty spot
   (writing-p :accessor writing-p :initform nil)))

(defmethod stream:stream-listen ((s pipe))
  "Returns T when there is something to read."
  (with-slots (writing-p read-ptr write-ptr) s
     (mp:with-interrupts-blocked
      (and (not writing-p)
           (not (= read-ptr write-ptr))))))

(defmethod stream:stream-read-char ((s pipe))
  (mp:process-wait "Waiting for input." #'stream:stream-listen s)
  (mp:with-interrupts-blocked
   (with-slots (cbuf read-ptr) s
     (let ((c (char cbuf read-ptr)))
       (if (= read-ptr 1023) (setf read-ptr 0) (incf read-ptr))
       c))))

(defmethod stream:stream-write-char ((s pipe) (c character))
  (when (char= c #\Null) (break "In write-char: writing a null."))
  (with-slots (writing-p read-ptr write-ptr cbuf) s
    (when (or (= (1+ write-ptr) read-ptr)
	      (and (= write-ptr 1023) (zerop read-ptr)))
      (mp:process-wait "Waiting on pipe space" 
		       #'(lambda () (and (not (= (1+ write-ptr) read-ptr))
					 (not (and (= write-ptr 1023) (zerop read-ptr)))))))
    (setf writing-p t)
    (mp:with-interrupts-blocked
     (setf (char cbuf write-ptr) c)
     (if (= write-ptr 1023) (setf write-ptr 0) (incf write-ptr))
     (setf writing-p nil))))

(defmethod stream:stream-write-string ((s pipe) string &optional start end)
  "Write the string. But first make sure there is enough room, and that it will be visible."
  (loop for c across string do (stream:stream-write-char s c)))

(defmethod stream:stream-terpri ((s pipe))
  (stream:stream-write-char s #\Newline))

(defmethod stream:stream-line-column ((s pipe))
  nil)

(defmethod clean-pipe ((s pipe))
  (with-slots (read-ptr write-ptr writing-p) s
    (setf read-ptr 0)
    (setf write-ptr 0)
    (setf writing-p nil)))

;;; TRYME -- so is this supposed to block? Yes. 
;;; Run it and then do (read-char *zippy* nil nil) a few times.
#+nil(defvar *zippy* nil)
#+nil
(defun tryme ()
  (let ((p (setf *zippy* (make-instance 'pipe))))
    (loop for c across "1234" do (write-char c p))))
#+nil
(defun tryme1 ()
  (let ((p (setf *zippy* (make-instance 'pipe))))
    (format p  "output this")
    (loop for c = (read-char-no-hang p nil nil)
	  do (write-char c *standard-output*)
	  (force-output *standard-output*))))


(export '(pipe))








