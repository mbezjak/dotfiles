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
 ("M-L" . browse-url)
 ("M-P" . browse-url-at-point)

 ("C-`" . align-regexp)
 ("C-~" . my-align-multi)
 ("C-!" . my-align-spock-table)
 ("M-/" . my-complete)
 ("C-/" . query-replace-regexp)

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
 ("C-q" . kill-current-buffer)
 ("S-C-q" . quoted-insert)
 ("C-z" . undo)
 ("C-n" . make-frame-command)

 ("<f2>" . my-open-dired-here)
 ("<f5>" . revert-buffer)
 ("<f7>" . my-open-thg-commit)
 ("S-<f7>" . my-open-thg)
 ("M-<f9>" . previous-buffer)
 ("M-<f10>" . next-buffer)
 ("<f9>" . org-agenda)
 ("<f10>" . org-capture)
 ("<f12> p" . pomidor)
 ("<f12> d" . org-decrypt-entry)
 ("C-+" . text-scale-increase)
 ("C-_" . text-scale-decrease)

 ("C-c a" . org-agenda)
 ("C-c r" . revert-buffer)
 ("C-x C-m" . ansi-term))

(bind-keys :map minibuffer-local-map
           ("<escape>" . minibuffer-keyboard-quit)
           :map isearch-mode-map
           ("C-f" . isearch-repeat-forward)
           ("C-S-f" . isearch-repeat-backward))

;; unrestricted help search
(define-key 'help-command "a" 'apropos)

;; shift + arrow keys
;; Not using `(windmove-default-keybindings)` because minor modes override local
;; map that org mode setups up in `org-read-date-minibuffer-local-map`.
;; I want to use shift+arrows in minibuffer to select a date, but everywhere
;; else it should be windmove commands. Below is defining those keys via global
;; map which has lowest precedence.
;; https://www.masteringemacs.org/article/mastering-key-bindings-emacs#keymap-lookup-order
(bind-keys
 ("S-<left>" . windmove-left)
 ("S-<right>" . windmove-right)
 ("S-<up>" . windmove-up)
 ("S-<down>" . windmove-down))
(windmove-swap-states-default-keybindings '(shift meta))


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
(unbind-key "C-<backspace>")
(unbind-key "C-<delete>")
(unbind-key "M-<backspace>")
(unbind-key "M-<delete>")
(unbind-key "M-DEL")


(provide 'my-keys)
