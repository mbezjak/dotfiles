(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'my-remove-elc-on-save)
(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)

(defun my-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

(bind-keys :map emacs-lisp-mode-map
           ("C-c v" . eval-buffer))

;;; Enhance Lisp Modes

(bind-keys :map read-expression-map
           ("TAB" . completion-at-point))

(bind-keys :map lisp-mode-shared-map
           ("RET" . reindent-then-newline-and-indent))

(provide 'my-lisp)
