;; M-x describe-personal-keybindings RET


;; ergoemacs like
(when window-system
  (bind-keys
   ("M-o" . previous-line)
   ("M-k" . next-line)
   ("M-O" . scroll-down-command)
   ("M-K" . scroll-up-command)
   ("M-j" . backward-char)
   ("M-l" . forward-char)
   ("M-i" . backward-word)
   ("M-p" . forward-word)))

(bind-keys
 ("C-f" . isearch-forward-regexp)
 ("C-r" . isearch-backward-regexp)
 ("S-C-f" . isearch-backward-regexp)
 ("C-l" . goto-line)

 ("C-d" . my-delete-region-or-line)
 ("M-e" . backward-kill-word)
 ("M-r" . kill-word)
 ("M-d" . zap-to-char)
 ("M-s" . just-one-space)
 ("C-M-s" . delete-horizontal-space)
 ("M-D" . delete-rectangle)
 ("M-R" . string-rectangle)
 ("M-Y" . capitalize-word)
 ("M-U" . upcase-word)
 ("M-J" . downcase-word)

 ("M-]" . projectile-switch-project)

 ("M-2" . delete-window)
 ("C-M-2" . delete-other-windows)
 ("M-3" . my-split-window-below)
 ("M-4" . my-split-window-right)

 ("<escape>" . keyboard-quit)
 ("M-SPC" . set-mark-command)
 ("C-s" . save-buffer)
 ("S-C-s" . write-file)
 ("S-C-M-s" . sort-lines)
 ("C-p" . recenter-top-bottom)
 ("C-q" . my-kill-current-buffer)
 ("S-C-q" . quoted-insert)
 ("C-z" . undo)
 ("C-n" . make-frame-command)

 ("<f5>" . revert-buffer)
 ("<f12> p" . pomidor))

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
(bind-key "M-<f9>"     'previous-buffer)
(bind-key "M-<f10>"    'next-buffer)
(bind-key "<f12> d"    'org-decrypt-entry)
(bind-key "C-`"        'align-regexp)
(bind-key "C-~"        'my-align-multi)
(bind-key "C-!"        'my-align-spock-table)
(bind-key "C-x C-m"    'shell)
(bind-key "C-]"        'my-jump-to-workspace)
(bind-key "M-L"        'browse-url)
(bind-key "M-P"        'browse-url-at-point)
(bind-key "M-/"        'my-complete)

;; toggle between back-to-indentation and move-beginning-of-line
(bind-key "C-a" 'my-move-beginning-of-line)

(bind-key "C-c r" 'revert-buffer)

;; use regex search by default
(bind-key "C-/" 'query-replace-regexp)

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
(unbind-key "M-\\")
(unbind-key "M-.")
(unbind-key "M-,")
(unbind-key "M-y")
(unbind-key "M-z")
(unbind-key "M-b")
(unbind-key "M-v")
(unbind-key "M-m")
(unbind-key "M-c")
(unbind-key "M-u")
(unbind-key "M-g g")
(unbind-key "M-g M-g")
(when window-system (unbind-key "C-x C-c"))
(unbind-key "C-x C-z")
(unbind-key "C-x C-s")
(unbind-key "C-x 0")
(unbind-key "C-y")
(unbind-key "C-t")
(unbind-key "C-g")
(unbind-key "C-b")
(unbind-key "S-C-v")
(unbind-key "C-@")
(unbind-key "C-_")
(unbind-key "C-\\")
(unbind-key "C-<backspace>")
(unbind-key "C-<delete>")
(unbind-key "M-<backspace>")
(unbind-key "M-<delete>")
(unbind-key "M-DEL")
(unbind-key "<f2>")
(unbind-key "<f3>")
(unbind-key "<f10>")

;; used by duplicate-thing.el
(unbind-key "C-M-<up>")
(unbind-key "C-M-<down>")


(provide 'my-keys)
