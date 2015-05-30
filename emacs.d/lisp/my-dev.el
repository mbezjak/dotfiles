(add-to-list 'auto-mode-alist '("\\.m\\'"    . octave-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'"   . js2-mode))


(defun my-delete-trailing-whitespace-before-save ()
  "Ensure trailing whitespaces are deleted."
  (add-hook 'before-save-hook 'delete-trailing-whitespace))

(defun my-local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t)
  (auto-fill-mode t))

(defun my-pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(?\\(lambda\\>\\)"
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))

(defun my-add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
          1 font-lock-warning-face t))))

(defun my-turn-on-save-place-mode ()
  (require 'saveplace)
  (setq save-place t))


(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'my-delete-trailing-whitespace-before-save)
(add-hook 'prog-mode-hook 'my-local-comment-auto-fill)
(add-hook 'prog-mode-hook 'my-pretty-lambdas)
(add-hook 'prog-mode-hook 'my-add-watchwords)
(add-hook 'prog-mode-hook 'my-turn-on-save-place-mode)
(add-hook 'prog-mode-hook 'idle-highlight-mode)

(provide 'my-dev)
