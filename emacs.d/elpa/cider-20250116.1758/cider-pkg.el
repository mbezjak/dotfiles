;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "cider" "20250116.1758"
  "Clojure Interactive Development Environment that Rocks."
  '((emacs        "26")
    (clojure-mode "5.19")
    (parseedn     "1.2.1")
    (queue        "0.2")
    (spinner      "1.7")
    (seq          "2.22")
    (sesman       "0.3.2")
    (transient    "0.4.1"))
  :url "https://www.github.com/clojure-emacs/cider"
  :commit "c0e7f2526d7b5ed67c723c4fbf3ce5391f4f5123"
  :revdesc "c0e7f2526d7b"
  :keywords '("languages" "clojure" "cider")
  :authors '(("Tim King" . "kingtim@gmail.com")
             ("Phil Hagelberg" . "technomancy@gmail.com")
             ("Bozhidar Batsov" . "bozhidar@batsov.dev")
             ("Artur Malabarba" . "bruce.connor.am@gmail.com")
             ("Hugo Duncan" . "hugo@hugoduncan.org")
             ("Steve Purcell" . "steve@sanityinc.com"))
  :maintainers '(("Bozhidar Batsov" . "bozhidar@batsov.dev")))
