(define-package "clj-refactor" "3.2.2" "A collection of commands for refactoring Clojure code"
  '((emacs "26.1")
    (seq "2.19")
    (yasnippet "0.6.1")
    (paredit "24")
    (multiple-cursors "1.2.2")
    (clojure-mode "5.9")
    (cider "1.0")
    (parseedn "1.0.6")
    (inflections "2.3")
    (hydra "0.13.2"))
  :commit "e0d83c845014a24c2604a08f9c9931c63ea809c4" :authors
  '(("Magnar Sveen" . "magnars@gmail.com")
    ("Lars Andersen" . "expez@expez.com")
    ("Benedek Fazekas" . "benedek.fazekas@gmail.com")
    ("Bozhidar Batsov" . "bozhidar@batsov.dev"))
  :maintainer
  '("Magnar Sveen" . "magnars@gmail.com")
  :keywords
  '("convenience" "clojure" "cider"))
;; Local Variables:
;; no-byte-compile: t
;; End:
