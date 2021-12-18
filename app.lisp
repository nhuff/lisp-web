(in-package :app)

(defun listen-port ()
  (let ((port (uiop:getenvp "WEBAPP_PORT")))
    (if port
        port 
        4242)))

(defun listen-address ()
  (let ((address (uiop:getenvp "WEBAPP_ADDRESS")))
    (if address
        address
        nil)))

(defvar *acceptor* (make-instance 'hunchentoot:easy-acceptor
                                  :port (listen-port)
                                  :address (listen-address)))

(defun hostname ()
  (machine-instance))

(defun start ()
  (push
   (hunchentoot:create-prefix-dispatcher "/hostname" #'hostname)
   hunchentoot:*dispatch-table*)
  (hunchentoot:start *acceptor*))

(defun main ()
  ;; Have sigterm do the same thing as sigint which is to signal
  ;; sb-sys:interactive-interrupt and allow us to cleanup nicely.
  (sb-unix::%install-handler sb-unix::sigterm #'sb-unix::sigint-handler)
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
