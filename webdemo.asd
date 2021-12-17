(asdf:defsystem "webdemo"
  :depends-on ("hunchentoot" "bordeaux-threads")
  :serial t
  :components ((:file "packages")
               (:file "app"))
  :build-operation "asdf:program-op"
  :build-pathname "webdemo"
  :entry-point "app:main")
