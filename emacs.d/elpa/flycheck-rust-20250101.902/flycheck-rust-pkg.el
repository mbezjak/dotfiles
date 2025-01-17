;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "flycheck-rust" "20250101.902"
  "Flycheck: Rust additions and Cargo support."
  '((emacs     "24.1")
    (flycheck  "28")
    (dash      "2.13.0")
    (seq       "2.3")
    (let-alist "1.0.4"))
  :url "https://github.com/flycheck/flycheck-rust"
  :commit "d499471ec433a62898a95ce76561964e3d015ce5"
  :revdesc "d499471ec433"
  :keywords '("tools" "convenience")
  :authors '(("Sebastian Wiesner" . "swiesner@lunaryorn.com"))
  :maintainers '(("Sebastian Wiesner" . "swiesner@lunaryorn.com")))
