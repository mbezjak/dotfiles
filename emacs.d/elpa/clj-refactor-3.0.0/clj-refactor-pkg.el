(define-package "clj-refactor" "3.0.0" "A collection of commands for refactoring Clojure code"
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
  :commit "b1503962c90f1c88a4f32b8d32cf87c48437c158" :authors
  '(("Magnar Sveen" . "magnars@gmail.com")
    ("Lars Andersen" . "expez@expez.com")
    ("Benedek Fazekas" . "benedek.fazekas@gmail.com")
    ("Bozhidar Batsov" . "bozhidar@batsov.com"))
  :maintainer
  '("Magnar Sveen" . "magnars@gmail.com")
  :keywords
  '("convenience" "clojure" "cider"))
;; Local Variables:
;; no-byte-compile: t
;; End:
