;; avoiding mistakes
(global-unset-key (kbd "C-x C-c"))    ; save-buffers-kill-terminal; shutdown with alt + F4
(global-unset-key (kbd "C-z"))        ; suspend-frame
(global-unset-key (kbd "C-x C-z"))    ; suspend-frame
(global-unset-key (kbd "C-t"))        ; transpose-chars
(global-unset-key (kbd "C-/"))        ; undo; use C-_

;; replaced by move-text
(global-unset-key (kbd "C-M-<up>"))   ; backward-up-list
(global-unset-key (kbd "C-M-<down>")) ; down-list

;; replaced by helm-occur
(global-unset-key (kbd "M-o"))

;; replaced by helm-swoop
(global-unset-key (kbd "M-i"))

;; jump to directory
(defmacro my-jump-macro (fnname dir)
  `(defun ,fnname () (interactive) (my-find-file-in-dir ,dir)))
(my-jump-macro my-jump-to-org-notes org-directory)
(my-jump-macro my-jump-to-workspace "~/workspace")
(my-jump-macro my-jump-to-dotfiles  "~/workspace/dotfiles")
(my-jump-macro my-jump-to-emacsd    "~/workspace/dotfiles/emacs.d")
(my-jump-macro my-jump-to-snippets  "~/workspace/dotfiles/emacs.d/snippets")


;; org-mode keys
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "<f9>")  'org-agenda)
(global-set-key (kbd "<f4>")  'org-capture)

;; rest
(global-set-key (kbd "M-<f1>")     'kmacro-start-macro-or-insert-counter)
(global-set-key (kbd "<f1>")       'kmacro-end-or-call-macro)
(global-set-key (kbd "M-<f6>")     'point-to-register)
(global-set-key (kbd "<f6>")       'jump-to-register)
(global-set-key (kbd "<f8>")       'my-repo-status)
(global-set-key (kbd "M-<f9>")     'previous-buffer)
(global-set-key (kbd "M-<f10>")    'next-buffer)
(global-set-key (kbd "<f12> s")    'my-org-agenda-sort)
(global-set-key (kbd "<f12> d")    'org-decrypt-entry)
(global-set-key (kbd "<f12> p")    'my-project-version-at-point)
(global-set-key (kbd "<f12> l")    'my-org-agenda-remove-later)
(global-set-key (kbd "C-x \\")     'align-regexp)
(global-set-key (kbd "C-]")        'my-jump-to-workspace)
(global-set-key (kbd "M-K")        'my-kill-current-buffer)
(global-set-key (kbd "M-I")        'my-org-insert-link)
(global-set-key (kbd "M-L")        'browse-url)
(global-set-key (kbd "M-P")        'browse-url-at-point)
(global-set-key (kbd "C-M-<down>") 'my-duplicate-line)
(global-set-key (kbd "C-c SPC")    'ace-jump-mode)
(global-set-key (kbd "C-.")        'ace-window)
(global-set-key (kbd "M-/") '(lambda ()
                               (interactive)
                               (if company-mode
                                   (company-complete)
                                 (hippie-expand nil))))

;; explore new modes
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; use regex search by default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-M-%") 'query-replace)

;; shift + arrow keys
(windmove-default-keybindings)

;; must be set before projectile is loaded
(setq projectile-keymap-prefix (kbd "M-F"))


(provide 'my-keys)
