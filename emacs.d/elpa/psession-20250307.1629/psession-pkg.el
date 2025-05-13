;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "psession" "20250307.1629"
  "Persistent save of elisp objects."
  '((emacs  "24")
    (cl-lib "0.5")
    (async  "1.9.3"))
  :url "https://github.com/thierryvolpiatto/psession"
  :commit "371e23c9cc1ad5d8ccb149ccdaf6500935f27da1"
  :revdesc "371e23c9cc1a"
  :keywords '("psession" "persistent" "save" "session")
  :authors '(("Thierry Volpiatto" . "thievol@posteo.net"))
  :maintainers '(("Thierry Volpiatto" . "thievol@posteo.net")))
