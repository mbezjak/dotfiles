;; M-x describe-personal-keybindings RET

(unbind-key "M-1")
(unbind-key "M-2")
(unbind-key "M-3")
(unbind-key "M-4")
(unbind-key "M-5")
(unbind-key "M-6")
(unbind-key "M-7")
(unbind-key "M-8")
(unbind-key "M-9")
(unbind-key "M-0")
(unbind-key "M--")
(unbind-key "M-'")
(unbind-key "M-.")
(unbind-key "M-,")
(unbind-key "M-i")
(unbind-key "M-r")
(unbind-key "M-s")
(unbind-key "M-j")
(when window-system (unbind-key "C-x C-c"))
(unbind-key "C-x C-z")
(unbind-key "C-x C-f")
(unbind-key "C-t")
(unbind-key "C-g")
(unbind-key "C-M-<up>")
(unbind-key "C-M-<down>")


;; ergoemacs like
(bind-keys
 ("M-o" . previous-line)
 ("M-k" . next-line)

 ("C-d" . my-delete-line) ; delete line and keep column position

 ("<escape>" . keyboard-quit)
 ("C-z" . undo)
 ("C-n" . make-frame-command)
 ("C--" . text-scale-decrease)
 ("C-+" . text-scale-increase)
 ("C-=" . text-scale-increase))


;; jump to directory
(defmacro my-jump-macro (fnname dir)
  `(defun ,fnname () (interactive) (my-find-file-in-dir ,dir)))
(my-jump-macro my-jump-to-workspace "~/workspace")


;; org-mode keys
(bind-key "C-c a" 'org-agenda)
(bind-key "<f9>"  'org-agenda)
(bind-key "<f4>"  'org-capture)

;; rest
(bind-key "M-<f1>"     'kmacro-start-macro-or-insert-counter)
(bind-key "<f1>"       'kmacro-end-or-call-macro)
(bind-key "M-<f6>"     'point-to-register)
(bind-key "<f6>"       'jump-to-register)
(bind-key "<f8>"       'my-repo-status)
(bind-key "M-<f9>"     'previous-buffer)
(bind-key "M-<f10>"    'next-buffer)
(bind-key "<f12> s"    'my-org-agenda-sort)
(bind-key "<f12> d"    'org-decrypt-entry)
(bind-key "<f12> p"    'my-project-version-at-point)
(bind-key "<f12> l"    'my-org-agenda-remove-later)
(bind-key "C-x \\"     'align-regexp)
(bind-key "C-`"        'align-regexp)
(bind-key "C-~"        'my-align-multi)
(bind-key "C-!"        'my-align-spock-table)
(bind-key "C-x C-m"    'shell)
(bind-key "C-]"        'my-jump-to-workspace)
(bind-key "M-K"        'my-kill-current-buffer)
(bind-key "M-I"        'my-org-insert-link)
(bind-key "M-L"        'browse-url)
(bind-key "M-P"        'browse-url-at-point)
(bind-key "C-c SPC"    'avy-goto-word-1)
(bind-key "C-."        'ace-window)
(bind-key "M-/"        'my-complete)

;; toggle between back-to-indentation and move-beginning-of-line
(bind-key "C-a" 'my-move-beginning-of-line)

;; explore new modes
(bind-key "C-<f10>" 'menu-bar-mode)

(bind-key "C-c y" 'bury-buffer)
(bind-key "C-c r" 'revert-buffer)

;; better than M-S-6
(bind-key "C-c q" 'join-line)

;; general cleanup
(bind-key "C-c n" 'my-cleanup-buffer)

;; eval and replace anywhere
(bind-key "C-c e" 'my-eval-and-replace)

;; use regex search by default
(bind-key "C-s" 'isearch-forward-regexp)
(bind-key "C-r" 'isearch-backward-regexp)
(bind-key "M-%" 'query-replace-regexp)
(bind-key "C-/" 'query-replace-regexp)
(bind-key "C-M-s" 'isearch-forward)
(bind-key "C-M-r" 'isearch-backward)
(bind-key "C-M-%" 'query-replace)

;; unrestricted help search
(define-key 'help-command "a" 'apropos)

;; shift + arrow keys
(windmove-default-keybindings)


(provide 'my-keys)
