;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "magit" "20250428.1656"
  "A Git porcelain inside Emacs."
  '((emacs         "27.1")
    (compat        "30.0.2.0")
    (llama         "0.6.2")
    (magit-section "4.3.2")
    (seq           "2.24")
    (transient     "0.8.7")
    (with-editor   "3.4.3"))
  :url "https://github.com/magit/magit"
  :commit "dd14711edf616382d0fd103b09ce590304b0ebd5"
  :revdesc "dd14711edf61"
  :keywords '("git" "tools" "vc")
  :authors '(("Marius Vollmer" . "marius.vollmer@gmail.com")
             ("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev"))
  :maintainers '(("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev")
                 ("Kyle Meyer" . "kyle@kyleam.com")))
