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

(define-key emacs-lisp-mode-map (kbd "C-c v") 'eval-buffer)

;;; Enhance Lisp Modes

(define-key read-expression-map (kbd "TAB") 'completion-at-point)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)

;; TODO: look into parenface package
(defface my-paren-face
  '((((class color) (background dark))
     (:foreground "grey50"))
    (((class color) (background light))
     (:foreground "grey55")))
  "Face used to dim parentheses."
  :group 'starter-kit-faces)

(eval-after-load 'paredit
  ;; need a binding that works in the terminal
  '(progn
     (define-key paredit-mode-map (kbd "M-)") 'paredit-forward-slurp-sexp)
     (define-key paredit-mode-map (kbd "M-(") 'paredit-backward-slurp-sexp)))

(dolist (mode '(scheme emacs-lisp lisp clojure clojurescript))
  (when (> (display-color-cells) 8)
    (font-lock-add-keywords (intern (concat (symbol-name mode) "-mode"))
                            '(("(\\|)" . 'my-paren-face))))
  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
            'paredit-mode))

(defun my-pretty-fn ()
  (font-lock-add-keywords nil `(("(\\(\\<fn\\>\\)"
                                 (0 (progn (compose-region (match-beginning 1)
                                                           (match-end 1)
                                                           "\u0192"
                                                           'decompose-region)))))))
(add-hook 'clojure-mode-hook 'my-pretty-fn)
(add-hook 'clojurescript-mode-hook 'my-pretty-fn)

(provide 'my-lisp)