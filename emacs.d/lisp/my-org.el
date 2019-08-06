;; must be manually installed
;; https://github.com/jwiegley/use-package/issues/319
(use-package org
  :defer t)

(defun my-org-note (name)
  "File name from org note NAME."
  (concat org-directory "/" name ".org"))

(setq org-replace-disputed-keys t
      calendar-week-start-day   1       ; monday
      org-startup-indented      t
      org-hide-leading-stars    t
      org-use-speed-commands    t
      org-cycle-separator-lines 0
      org-catch-invisible-edits 'show-and-error
      org-log-done       'time
      org-directory      "~/Dropbox/notes"
      my-org-note-agenda  (my-org-note "agenda")
      my-org-note-archive (my-org-note "archive/archive")
      org-default-notes-file my-org-note-agenda
      org-agenda-files       (list my-org-note-agenda)
      org-archive-location   (concat my-org-note-archive "::")
      org-global-properties '(("BENEFIT_ALL" . "1 2 3 4 5 6 7 8 0.5 0"))
      org-tags-exclude-from-inheritance '("crypt")
      org-crypt-key nil
      org-latex-preview-ltxpng-directory (no-littering-expand-var-file-name "org/ltxpng/")
      org-extend-today-until 5
      org-refile-targets '((nil :maxlevel . 1)))

(with-eval-after-load 'org
  (plist-put org-format-latex-options :scale 1.5) ; bigger latex fragment

  (add-hook 'org-mode-hook #'(lambda () (flycheck-mode -1)))

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

(setq org-capture-templates
      '(("w" "work" entry (file+headline "work.org" "WEEK")
         "* %?")
        ("W" "next week" entry (file+headline "work.org" "WEEK")
         (file "capture/next-week.org")
         :prepend t
         :immediate-finish t)
        ("d" "deliberate practice" entry (file+headline "work.org" "DELIBERATE PRACTICE")
         "* try %?
%x"
         :prepend t)))

;; functions
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
