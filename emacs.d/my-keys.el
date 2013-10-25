(global-unset-key (kbd "C-x C-c"))    ; save-buffers-kill-terminal; shutdown with alt + F4
(global-unset-key (kbd "C-z"))        ; suspend-frame
(global-unset-key (kbd "C-x C-z"))    ; suspend-frame
(global-unset-key (kbd "C-t"))        ; transpose-chars
(global-unset-key (kbd "C-/"))        ; undo; use C-_
(global-unset-key (kbd "C-M-<up>"))   ; backward-up-list
(global-unset-key (kbd "C-M-<down>")) ; down-list

;; jump to directory
(defmacro my-jump-macro (fnname dir)
  `(defun ,fnname () (interactive) (my-find-file-in-dir ,dir)))
(my-jump-macro my-jump-to-org-notes org-directory)
(my-jump-macro my-jump-to-workspace "~/workspace")
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
(global-set-key (kbd "<f9>")  'org-agenda)
(global-set-key (kbd "<f4>")  'org-capture)

;; rest
(global-set-key (kbd "M-<f1>")     'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "<f1>")       'kmacro-end-or-call-macro)
(global-set-key (kbd "M-<f6>")     'point-to-register)
(global-set-key (kbd "<f6>")       'jump-to-register)
(global-set-key (kbd "M-<f7>")     'bmkp-autofile-set)
(global-set-key (kbd "<f7>")       'bmkp-autofile-jump)
(global-set-key (kbd "<f8>")       'my-repo-status)
(global-set-key (kbd "M-<f8>")     'ido-switch-buffer)
(global-set-key (kbd "M-<f9>")     'previous-buffer)
(global-set-key (kbd "M-<f10>")    'next-buffer)
(global-set-key (kbd "<f12> d")    'org-decrypt-entry)
(global-set-key (kbd "<f12> h")    'my-org-hotd-to-journal)
(global-set-key (kbd "<f12> p")    'my-org-perception-to-journal)
(global-set-key (kbd "C-x \\")     'align-regexp)
(global-set-key (kbd "C-x C-d")    'ido-dired)
(global-set-key (kbd "M-[")        '(lambda () (interactive) (dired ".")))
(global-set-key (kbd "M-]")        'ido-find-file)
(global-set-key (kbd "C-]")        'my-jump-to-workspace)
(global-set-key (kbd "M-K")        'my-kill-current-buffer)
(global-set-key (kbd "M-I")        'my-org-insert-link)
(global-set-key (kbd "M-L")        'browse-url)
(global-set-key (kbd "M-P")        'browse-url-at-point)
(global-set-key (kbd "C-M-<down>") 'my-duplicate-line)

;; must be set before projectile is loaded
(setq projectile-keymap-prefix (kbd "M-F"))


(provide 'my-keys)
