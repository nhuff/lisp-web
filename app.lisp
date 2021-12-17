(in-package :app)

(defvar *acceptor* (make-instance 'hunchentoot:easy-acceptor :port 4242))
(defun hostname ()
  (machine-instance))

(defun start ()
  (push
   (hunchentoot:create-prefix-dispatcher "/hostname" #'hostname)
   hunchentoot:*dispatch-table*)
  (hunchentoot:start *acceptor*))
