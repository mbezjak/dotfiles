(define-package "clj-refactor" "2.5.1" "A collection of commands for refactoring Clojure code"
  '((emacs "25.1")
    (seq "2.19")
    (yasnippet "0.6.1")
    (paredit "24")
    (multiple-cursors "1.2.2")
    (clojure-mode "5.9")
    (cider "0.24.0")
    (parseedn "0.1")
    (inflections "2.3")
    (hydra "0.13.2"))
  :commit "b24ce76acefe792975f00147c94b4dd784e65b80" :authors
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
