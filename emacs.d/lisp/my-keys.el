;; avoiding mistakes
(when window-system
  (global-unset-key (kbd "C-x C-c"))) ; save-buffers-kill-terminal; shutdown with alt + F4
(global-unset-key (kbd "C-z"))        ; suspend-frame
(global-unset-key (kbd "C-x C-z"))    ; suspend-frame
(global-unset-key (kbd "C-t"))        ; transpose-chars
(global-unset-key (kbd "C-/"))        ; undo; use C-_
(global-unset-key (kbd "C-x C-f"))    ; replaced by helm-find-files
(global-unset-key (kbd "C-a"))        ; replaced by my-move-beginning-of-line

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
(my-jump-macro my-jump-to-workspace "~/workspace")


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
(global-set-key (kbd "C-`")        'align-regexp)
(global-set-key (kbd "C-~")        'my-align-multi)
(global-set-key (kbd "C-!")        'my-align-spock-table)
(global-set-key (kbd "C-x C-m")    'shell)
(global-set-key (kbd "C-]")        'my-jump-to-workspace)
(global-set-key (kbd "M-K")        'my-kill-current-buffer)
(global-set-key (kbd "M-I")        'my-org-insert-link)
(global-set-key (kbd "M-L")        'browse-url)
(global-set-key (kbd "M-P")        'browse-url-at-point)
(global-set-key (kbd "C-c SPC")    'avy-goto-word-1)
(global-set-key (kbd "C-.")        'ace-window)
(global-set-key (kbd "M-/") '(lambda ()
                               (interactive)
                               (if company-mode
                                   (company-complete)
                                 (hippie-expand nil))))

;; toggle between back-to-indentation and move-beginning-of-line
(global-set-key (kbd "C-a") 'my-move-beginning-of-line)

;; explore new modes
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)

;; better than M-S-6
(global-set-key (kbd "C-c q") 'join-line)

;; general cleanup
(global-set-key (kbd "C-c n") 'my-cleanup-buffer)

;; eval and replace anywhere
(global-set-key (kbd "C-c e") 'my-eval-and-replace)

;; use regex search by default
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "C-/") 'query-replace-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-M-%") 'query-replace)

;; unrestricted help search
(define-key 'help-command "a" 'apropos)

;; shift + arrow keys
(windmove-default-keybindings)


(provide 'my-keys)
