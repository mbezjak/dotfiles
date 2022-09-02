(define-package "cider" "1.5.0" "Clojure Interactive Development Environment that Rocks"
  '((emacs "26")
    (clojure-mode "5.15.1")
    (parseedn "1.0.6")
    (queue "0.2")
    (spinner "1.7")
    (seq "2.22")
    (sesman "0.3.2"))
  :commit "700ded1d6c245e01fca7f364db1561ad1e1bb595" :authors
  '(("Tim King" . "kingtim@gmail.com")
    ("Phil Hagelberg" . "technomancy@gmail.com")
    ("Bozhidar Batsov" . "bozhidar@batsov.dev")
    ("Artur Malabarba" . "bruce.connor.am@gmail.com")
    ("Hugo Duncan" . "hugo@hugoduncan.org")
    ("Steve Purcell" . "steve@sanityinc.com"))
  :maintainer
  '("Bozhidar Batsov" . "bozhidar@batsov.dev")
  :keywords
  '("languages" "clojure" "cider")
  :url "http://www.github.com/clojure-emacs/cider")
;; Local Variables:
;; no-byte-compile: t
;; End:
