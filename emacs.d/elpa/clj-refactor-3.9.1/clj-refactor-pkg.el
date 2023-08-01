(define-package "clj-refactor" "3.9.1" "A collection of commands for refactoring Clojure code"
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
  :commit "1fdc95a479406a83865d06f43122354c0dd2b93f" :authors
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
