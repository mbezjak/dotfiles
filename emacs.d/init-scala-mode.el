(require 'scala-mode-auto)

(eval-after-load "scala-mode"
  '(progn
     (define-key scala-mode-map (kbd "C-c l") 'scala-load-file)))
