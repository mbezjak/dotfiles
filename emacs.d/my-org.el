(setq org-replace-disputed-keys t
      calendar-week-start-day 1 ; monday
      org-startup-indented t
      org-hide-leading-stars t
      org-log-done 'time
      org-directory "~/Dropbox/notes"
      org-default-notes-file (concat org-directory "/pool.org")
      org-agenda-files (list org-directory)
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-extend-today-until 5
      org-refile-targets '((nil :maxlevel . 3)
                           (org-agenda-files :maxlevel . 2)))

(eval-after-load "org"
  '(progn
     (add-to-list 'org-modules 'org-habit t)
     (plist-put org-format-latex-options :scale 1.5))) ; bigger latex fragment

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
