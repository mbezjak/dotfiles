(global-unset-key (kbd "C-x C-c")) ; shutdown with alt + F4
(global-unset-key (kbd "C-z"))

;; org-mode keys
(global-set-key (kbd "C-x c") 'my-org-find-files)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; rest
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "M-B") 'browse-url)
(global-set-key (kbd "M-P") 'browse-url-at-point)

;; must be set before projectile is loaded
(setq projectile-keymap-prefix (kbd "M-F"))


(provide 'my-keys)
