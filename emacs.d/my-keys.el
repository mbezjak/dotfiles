(global-unset-key (kbd "C-x C-c")) ; shutdown with alt + F4
(global-unset-key (kbd "C-z"))

;; jump to directory
(defmacro my-jump-macro (fnname dir)
  `(defun ,fnname () (interactive) (my-find-file-in-dir ,dir)))
(my-jump-macro my-jump-to-org-notes org-directory)
(my-jump-macro my-jump-to-dotfiles  "~/workspace/dotfiles")
(my-jump-macro my-jump-to-emacsd    "~/workspace/dotfiles/emacs.d")
(my-jump-macro my-jump-to-snippets  "~/workspace/dotfiles/emacs.d/snippets")

(define-prefix-command 'my-jump-map)
(global-set-key (kbd "C-x c") 'my-jump-map)
(define-key 'my-jump-map (kbd "c") 'my-jump-to-org-notes)
(define-key 'my-jump-map (kbd "d") 'my-jump-to-dotfiles)
(define-key 'my-jump-map (kbd "e") 'my-jump-to-emacsd)
(define-key 'my-jump-map (kbd "s") 'my-jump-to-snippets)


;; org-mode keys
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; rest
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "M-B") 'browse-url)
(global-set-key (kbd "M-P") 'browse-url-at-point)

;; must be set before projectile is loaded
(setq projectile-keymap-prefix (kbd "M-F"))


(provide 'my-keys)
