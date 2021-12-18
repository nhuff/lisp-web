(require 'asdf)
(load "webdemo.asd")
(asdf:load-system "webdemo")

(in-package :app)

(main)
