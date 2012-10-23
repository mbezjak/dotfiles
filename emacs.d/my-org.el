(setq calendar-week-start-day 1 ; monday
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


;; org-capture-templates
(setq my-org-capture-template-todo
      '("t" "Todo" entry (file+headline "pool.org" "SHORT")
        "* %?"))

(setq my-org-capture-template-work-todo
      '("w" "Work Todo" entry (file+headline "work.org" "GENERAL")
        "* %?"))

(setq my-org-capture-template-to-read
      '("r" "To Read" entry (file+headline "pool.org" "TO READ")
        "* %?"))

(setq my-org-capture-template-next-week
      '("N" "Next Week Tasks" entry (file+headline "agenda.org" "WEEKLY PLEDGE")
        "* TODO Fallacy x1
* TODO KhanAcademy video x1
* TODO KhanAcademy video x2
* TODO KhanAcademy practice x1
* TODO KhanAcademy practice x2"))

(setq my-org-capture-template-pressure
      '("p" "Pressure" table-line (file+headline "everything.org" "PRESSURE")
        "| %U | %? |   |   |"
        :table-line-pos "II-1"))

(setq org-capture-templates
      (list my-org-capture-template-todo
            my-org-capture-template-work-todo
            my-org-capture-template-to-read
            my-org-capture-template-next-week
            my-org-capture-template-pressure))


;; functions
(defun my-org-unbind-keys ()
  "Unset keys that are not useful in org-mode."
  (local-unset-key (kbd "C-c ["))
  (local-unset-key (kbd "C-c ]")))

(defun my-org-find-files ()
  "Find org files."
  (interactive)
  (ido-find-file-in-dir org-directory))

(defun my-org-insert-link ()
  "Insert org link where default description is set to html title."
  (interactive)
  (let* ((url (read-string "URL: "))
         (title (my-get-html-title-from-url url)))
    (org-insert-link nil url title)))


(add-hook 'org-mode-hook 'my-org-unbind-keys)


(provide 'my-org)
