(in-package :app)

(defvar *acceptor* (make-instance 'hunchentoot:easy-acceptor :port 4242))
(defun hostname ()
  (machine-instance))

(defun start ()
  (push
   (hunchentoot:create-prefix-dispatcher "/hostname" #'hostname)
   hunchentoot:*dispatch-table*)
  (hunchentoot:start *acceptor*))

(defun main ()
  (start)
  ;; Hunchentoot runs as a background thread so pause the main
  ;; thread until the background threads exit
  (let ((thread-list (remove-if
                      #'(lambda (x) (eq (bt:current-thread) x))
                      (bt:all-threads))))
    (handler-case (loop for thread in thread-list
                     do (bt:join-thread thread))
      (sb-sys:interactive-interrupt ()
        (progn
          (format *error-output* "Aborting.~&")
          (hunchentoot:stop *acceptor*)
          (uiop:quit))))))
