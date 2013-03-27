(defun my-org-note (name)
  "File name from org note NAME."
  (concat org-directory "/" name ".org"))

(setq org-replace-disputed-keys t
      calendar-week-start-day   1 ; monday
      org-startup-indented      t
      org-hide-leading-stars    t
      org-log-done       'time
      org-directory      "~/Dropbox/notes"
      my-org-note-agenda  (my-org-note "agenda")
      my-org-note-pool    (my-org-note "pool")
      my-org-note-archive (my-org-note "archive")
      org-default-notes-file my-org-note-pool
      org-agenda-files       (list my-org-note-agenda)
      org-archive-location   (concat my-org-note-archive "::")
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done  t
      org-habit-show-habits-only-for-today nil
      org-habit-graph-column 70
      org-tags-exclude-from-inheritance '("crypt")
      org-crypt-key nil
      org-mobile-directory "~/Dropbox/MobileOrg"
      org-mobile-inbox-for-pull (my-org-note "mobile")
      org-mobile-force-id-on-agenda-items nil
      org-mobile-agendas '("a")
      org-latex-preview-ltxpng-directory "~/.emacs.d/ltxpng/"
      org-extend-today-until 5
      org-refile-targets '((nil :maxlevel . 1)
                           (my-org-note-agenda :maxlevel . 2)
                           (my-org-note-pool   :maxlevel . 1)))

(add-to-list 'kill-emacs-hook 'org-mobile-push t)

(eval-after-load "org"
  '(progn
     (add-to-list 'org-modules 'org-habit t)
     (plist-put org-format-latex-options :scale 1.5) ; bigger latex fragment

     ;; http://orgmode.org/worg/org-tutorials/encrypting-files.html
     (require 'org-crypt)
     (org-crypt-use-before-save-magic)))

;; org-agenda-custom-commands and org-capture-templates
(load (concat org-directory "/org-custom"))


;; functions
(defun my-org-unbind-keys ()
  "Unset keys that are not useful in org-mode."
  (local-unset-key (kbd "C-c ["))
  (local-unset-key (kbd "C-c ]")))

(defun my-org-insert-link ()
  "Insert org link where default description is set to html title."
  (interactive)
  (let* ((url (read-string "URL: "))
         (title (my-get-html-title-from-url url)))
    (org-insert-link nil url title)))


;; advice
(defadvice org-read-date (around my-no-disputed-keys activate)
  "Ignore org-replace-disputed-keys when calendar is active."
  (let ((org-replace-disputed-keys nil))
    ad-do-it))


(add-hook 'org-mode-hook 'my-org-unbind-keys)


(provide 'my-org)
