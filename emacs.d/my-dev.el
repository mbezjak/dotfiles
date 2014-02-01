(add-to-list 'auto-mode-alist '("\\.m\\'"    . octave-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'"   . js2-mode))
(add-to-list 'auto-mode-alist '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))


(defun my-delete-trailing-whitespace-before-save ()
  "Ensure trailing whitespaces are deleted."
  (add-hook 'before-save-hook 'delete-trailing-whitespace))


(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'my-delete-trailing-whitespace-before-save)


(provide 'my-dev)
