(define-package "magit" "20240908.1411" "A Git porcelain inside Emacs"
  '((emacs "26.1")
    (compat "30.0.0.0")
    (dash "2.19.1")
    (magit-section "4.1.0")
    (seq "2.24")
    (transient "0.7.5")
    (with-editor "3.4.2"))
  :commit "05d7565f15beb57d1f92298d0dad55eda1e527b5" :authors
  '(("Marius Vollmer" . "marius.vollmer@gmail.com")
    ("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev"))
  :maintainers
  '(("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev")
    ("Kyle Meyer" . "kyle@kyleam.com"))
  :maintainer
  '("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev")
  :keywords
  '("git" "tools" "vc")
  :url "https://github.com/magit/magit")
;; Local Variables:
;; no-byte-compile: t
;; End:
