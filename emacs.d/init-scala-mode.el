(require 'scala-mode-auto)

(eval-after-load "scala-mode"
  '(progn
     (define-key scala-mode-map (kbd "C-c l")   'my-scala-load-file)
     (define-key scala-mode-map (kbd "C-c C-l") 'my-scala-load-file)))

(defun my-scala-load-file ()
  (interactive)
  (if (scala-interpreter-running-p-1)
      (scala-load-file (buffer-file-name))
    (scala-run-scala "scala")))
