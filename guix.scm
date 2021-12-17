(use-modules (guix build-system asdf)
             (gnu packages)
             (gnu packages lisp-xyz)
             (guix packages)
             (guix licenses)
             (ice-9 rdelim)
             (ice-9 popen))

(define-public lisp-web
  (package
   (name "lisp-web")
   (version (string-take (read-string (open-pipe "git show HEAD | head -1 | cut -d ' ' -f 2" OPEN_READ)) 7))
   (source (local-file (dirname (current-filename)) #:recursive? #t))
   (license bsd)
   (home-page "https://www.example.com")
   (synopsis "web demo")
   (description "common lisp web demo")
   (build-system asdf-build-system)
   (inputs `(("sbcl" ,sbcl)
             ("bordeaux-threads" ,sbcl-bourdeax-threads)
             ("hunchentoot" ,sbcl-hunchentoot)))))

lisp-web


             
