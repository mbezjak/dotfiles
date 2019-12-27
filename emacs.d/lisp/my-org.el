;; must be manually installed
;; https://github.com/jwiegley/use-package/issues/319
(use-package org
  :defer t)

(load-file "~/Sync/notes/config/notes.el")

(use-package org-randomnote
  :ensure t
  :bind ("<f12> r" . my-org-randomnote))

(use-package org-cliplink
  :ensure t
  :defer t)

(require 'org-attach)

(setq org-replace-disputed-keys t
      calendar-week-start-day   1       ; monday
      org-startup-indented      t
      org-hide-leading-stars    t
      org-use-speed-commands    t
      org-cycle-separator-lines 0
      org-catch-invisible-edits 'show-and-error
      org-log-done       'time
      org-tags-exclude-from-inheritance '("crypt")
      org-crypt-key nil
      org-latex-preview-ltxpng-directory (no-littering-expand-var-file-name "org/ltxpng/")
      org-extend-today-until 5)

(with-eval-after-load 'org
  (plist-put org-format-latex-options :scale 1.5) ; bigger latex fragment

  (add-hook 'org-mode-hook #'(lambda () (flycheck-mode -1)))
  (add-hook 'org-mode-hook #'(lambda () (diff-hl-mode -1)))

  ;; when in calendar mode, shift+keys do not switch windows
  (let ((map org-read-date-minibuffer-local-map))
    (define-key map [(shift up)]
      (lambda () (interactive)
        (org-eval-in-calendar '(calendar-backward-week 1))))
    (define-key map [(shift down)]
                (lambda () (interactive)
                  (org-eval-in-calendar '(calendar-forward-week 1))))
    (define-key map [(shift left)]
                (lambda () (interactive)
                  (org-eval-in-calendar '(calendar-backward-day 1))))
    (define-key map [(shift right)]
                (lambda () (interactive)
                  (org-eval-in-calendar '(calendar-forward-day 1)))))

  ;; http://orgmode.org/worg/org-tutorials/encrypting-files.html
  (require 'org-crypt)
  (org-crypt-use-before-save-magic))

(with-eval-after-load 'org-indent
  (diminish 'org-indent-mode))

(defun my-org-unbind-keys ()
  "Unset keys that are not useful in `org-mode`."
  (unbind-key "C-c [")
  (unbind-key "C-c ]"))

(defun my-org-rebind-keys ()
  "Rebind keys that are useful in `org-mode`."
  (require 'org-agenda)
  (bind-keys :map org-mode-map
             ("M-e" . backward-kill-word)
             ("M-p" . forward-word)
             ;; reserved for windmove
             ("S-<right>" . nil)
             ("S-<left>" . nil)
             ("S-<up>" . nil)
             ("S-<down>" . nil)
             :map org-agenda-keymap
             ("C-s" . org-save-all-org-buffers)))

; http://lists.gnu.org/archive/html/emacs-orgmode/2014-02/msg00088.html
(defun my-org-ask-clock-out ()
  "Ask the user before clocking out. This is a useful function for adding to `kill-emacs-query-functions'."
  (if (and (featurep 'org-clock)
           (funcall 'org-clocking-p)
           (y-or-n-p "You are currently clocking time, clock out? "))
      (org-clock-out)
    t)) ; only fails on keyboard quit or error


(add-hook 'org-mode-hook 'my-org-unbind-keys)
(add-hook 'org-mode-hook 'my-org-rebind-keys)
(add-hook 'kill-emacs-query-functions 'my-org-ask-clock-out)

(provide 'my-org)
