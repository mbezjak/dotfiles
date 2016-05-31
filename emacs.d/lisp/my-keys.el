;; M-x describe-personal-keybindings RET


;; ergoemacs like
(bind-keys
 ("M-o" . previous-line)
 ("M-k" . next-line)
 ("M-j" . backward-char)
 ("M-l" . forward-char)
 ("M-i" . backward-word)
 ("M-p" . forward-word)

 ("C-f" . isearch-forward-regexp)
 ("C-S-f" . isearch-backward-regexp)

 ("C-d" . my-delete-line-keep-column-position)
 ("M-e" . backward-kill-word)
 ("M-r" . kill-word)
 ("M-d" . zap-to-char)

 ("M-2" . delete-window)
 ("C-M-2" . delete-other-windows)
 ("M-3" . split-window-below)
 ("M-4" . split-window-right)

 ("<escape>" . keyboard-quit)
 ("C-s" . save-buffer)
 ("C-z" . undo)
 ("C-n" . make-frame-command)
 ("C--" . text-scale-decrease)
 ("C-+" . text-scale-increase)
 ("C-=" . text-scale-increase))

(bind-keys :map minibuffer-local-map
           ("<escape>" . minibuffer-keyboard-quit)
           :map isearch-mode-map
           ("C-f" . isearch-repeat-forward)
           ("C-S-f" . isearch-repeat-backward))


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
(bind-key "M-%" 'query-replace-regexp)
(bind-key "C-/" 'query-replace-regexp)
(bind-key "C-M-%" 'query-replace)

;; unrestricted help search
(define-key 'help-command "a" 'apropos)

;; shift + arrow keys
(windmove-default-keybindings)


(unbind-key "M-1")
(unbind-key "M-5")
(unbind-key "M-6")
(unbind-key "M-7")
(unbind-key "M-8")
(unbind-key "M-9")
(unbind-key "M-0")
(unbind-key "C-1")
(unbind-key "C-2")
(unbind-key "C-3")
(unbind-key "C-4")
(unbind-key "C-5")
(unbind-key "C-6")
(unbind-key "C-7")
(unbind-key "C-8")
(unbind-key "C-9")
(unbind-key "C-0")
(unbind-key "C-M-1")
(unbind-key "C-M-3")
(unbind-key "C-M-4")
(unbind-key "C-M-5")
(unbind-key "C-M-6")
(unbind-key "C-M-7")
(unbind-key "C-M-8")
(unbind-key "C-M-9")
(unbind-key "C-M-0")
(unbind-key "M--")
(unbind-key "M-'")
(unbind-key "M-.")
(unbind-key "M-,")
(unbind-key "M-s")
(unbind-key "M-z")
(when window-system (unbind-key "C-x C-c"))
(unbind-key "C-x C-z")
(unbind-key "C-x C-s")
(unbind-key "C-x 0")
(unbind-key "C-t")
(unbind-key "C-g")
(unbind-key "C-p")
(unbind-key "C-<backspace>")
(unbind-key "C-<delete>")
(unbind-key "M-<backspace>")
(unbind-key "M-<delete>")
(unbind-key "M-DEL")

;; used by duplicate-thing.el
(unbind-key "C-M-<up>")
(unbind-key "C-M-<down>")


(provide 'my-keys)
