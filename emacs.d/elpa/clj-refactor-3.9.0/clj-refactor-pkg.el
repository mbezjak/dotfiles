(define-package "clj-refactor" "3.9.0" "A collection of commands for refactoring Clojure code"
  '((emacs "26.1")
    (seq "2.19")
    (yasnippet "0.6.1")
    (paredit "24")
    (multiple-cursors "1.2.2")
    (clojure-mode "5.14")
    (cider "1.4.1")
    (parseedn "1.1.0")
    (inflections "2.6")
    (hydra "0.13.2"))
  :commit "0a2719be5f0af0d478b37007f3a716bccd708450" :authors
  '(("Magnar Sveen" . "magnars@gmail.com")
    ("Lars Andersen" . "expez@expez.com")
    ("Benedek Fazekas" . "benedek.fazekas@gmail.com")
    ("Bozhidar Batsov" . "bozhidar@batsov.dev"))
  :maintainers
  '(("Magnar Sveen" . "magnars@gmail.com"))
  :maintainer
  '("Magnar Sveen" . "magnars@gmail.com")
  :keywords
  '("convenience" "clojure" "cider"))
;; Local Variables:
;; no-byte-compile: t
;; End:
