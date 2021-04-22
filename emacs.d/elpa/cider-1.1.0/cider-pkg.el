(define-package "cider" "1.1.0" "Clojure Interactive Development Environment that Rocks"
  '((emacs "25")
    (clojure-mode "5.12")
    (parseedn "0.2")
    (pkg-info "0.4")
    (queue "0.2")
    (spinner "1.7")
    (seq "2.22")
    (sesman "0.3.2"))
  :commit "b27daf2a7b801ac2b1467a6797a19ea78e10adbc" :authors
  '(("Tim King" . "kingtim@gmail.com")
    ("Phil Hagelberg" . "technomancy@gmail.com")
    ("Bozhidar Batsov" . "bozhidar@batsov.com")
    ("Artur Malabarba" . "bruce.connor.am@gmail.com")
    ("Hugo Duncan" . "hugo@hugoduncan.org")
    ("Steve Purcell" . "steve@sanityinc.com"))
  :maintainer
  '("Bozhidar Batsov" . "bozhidar@batsov.com")
  :keywords
  '("languages" "clojure" "cider")
  :url "http://www.github.com/clojure-emacs/cider")
;; Local Variables:
;; no-byte-compile: t
;; End:
