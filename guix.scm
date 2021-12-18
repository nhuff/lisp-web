(use-modules (guix build-system asdf)
             (gnu packages)
             (gnu packages lisp-xyz)
             (gnu packages lisp)
             (guix packages)
             (guix licenses)
             (ice-9 rdelim)
             (ice-9 popen)
             (guix gexp))


(define-public lisp-web
  (package
   (name "lisp-web")
   (version (string-take (read-string (open-pipe "git show HEAD | head -1 | cut -d ' ' -f 2" OPEN_READ)) 7))
   (source (local-file (dirname (current-filename)) #:recursive? #t))
   (license bsd-2)
   (home-page "https://www.example.com")
   (synopsis "web demo")
   (description "common lisp web demo")
   (inputs `(("sbcl" ,sbcl)
             ("bordeaux-threads" ,sbcl-bordeaux-threads)
             ("hunchentoot" ,sbcl-hunchentoot)))
   (build-system asdf-build-system/sbcl)
   (arguments '(#:asd-systems '("webdemo")
                #:phases
                (modify-phases %standard-phases
                               (add-after 'create-asdf-configuration 'build-program
                                          (lambda* (#:key outputs #:allow-other-keys)
                                            (build-program
                                             (string-append (assoc-ref outputs "out") "/bin/webdemo")
                                             outputs
                                             #:entry-program '((app:main))))))))))
                                                   
                

lisp-web


             
