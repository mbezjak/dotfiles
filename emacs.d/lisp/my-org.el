;; update with: $ ~/bin/update-orgmode.sh
(when (file-directory-p "~/lib/org-mode/lisp")
  (add-to-list 'load-path "~/lib/org-mode/lisp"))

(defun my-org-note (name)
  "File name from org note NAME."
  (concat org-directory "/" name ".org"))

(setq org-replace-disputed-keys t
      calendar-week-start-day   1 ; monday
      org-startup-indented      t
      org-hide-leading-stars    t
      org-use-speed-commands    t
      org-log-done       'time
      org-directory      "~/Dropbox/notes"
      my-org-note-agenda  (my-org-note "agenda")
      my-org-note-habit   (my-org-note "habit")
      my-org-note-pool    (my-org-note "pool")
      my-org-note-meta    (my-org-note "meta")
      my-org-note-archive (my-org-note "archive")
      org-default-notes-file my-org-note-pool
      org-agenda-files       (list my-org-note-agenda my-org-note-habit my-org-note-pool)
      org-archive-location   (concat my-org-note-archive "::")
      org-global-properties '(("BENEFIT_ALL" . "1 2 3 4 5 6 7 8 0.5 0"))
      org-habit-show-habits-only-for-today nil
      org-habit-graph-column 70
      org-habit-show-done-always-green t
      org-tags-exclude-from-inheritance '("crypt")
      org-crypt-key nil
      org-mobile-directory "~/Dropbox/MobileOrg"
      org-mobile-inbox-for-pull (my-org-note "refile")
      org-mobile-agendas '("m")
      org-latex-preview-ltxpng-directory (my-managed-file "ltxpng/")
      org-id-locations-file (my-managed-file "org-id-locations")
      org-extend-today-until 5
      org-refile-targets '((nil :maxlevel . 1)
                           (my-org-note-meta    :maxlevel . 1)
                           (my-org-note-agenda  :maxlevel . 1)
                           (my-org-note-pool    :maxlevel . 1))
      org-agenda-prefix-format '((agenda . " %i %-10:c%?-12t% s %-8e")
                                 (timeline . "  % s")
                                 (todo . " %i %-12:c")
                                 (tags . " %i %-12:c")
                                 (search . " %i %-12:c")))

;; https://aur.archlinux.org/packages/plantuml/
(setq org-plantuml-jar-path "/opt/plantuml/plantuml.jar")

(eval-after-load "org"
  '(progn
     (add-to-list 'org-modules 'org-habit t)
     (plist-put org-format-latex-options :scale 1.5) ; bigger latex fragment

     (org-babel-do-load-languages 'org-babel-load-languages
                                  '((gnuplot . t)
                                    (plantuml . t)
                                    (dot . t)
                                    (sh . t)
                                    (emacs-lisp . t)))

     (add-hook 'org-mode-hook #'(lambda () (flycheck-mode -1)))

     ;; http://orgmode.org/worg/org-tutorials/encrypting-files.html
     (require 'org-crypt)
     (org-crypt-use-before-save-magic)))

;; org-agenda-custom-commands and org-capture-templates
(load (concat org-directory "/org-custom"))


;; kbd-macros
(fset 'my-actually-i-did-it-yesterday
   [?\C-s ?< ?2 ?0 ?\C-m ?\C-c ?. ?\C-m ?\C-s ?\\ ?\[ ?2 ?0 ?\C-m ?\C-c ?! ?\C-? ?\C-? ?\C-? ?\C-? ?\C-? ?2 ?3 ?: ?0 ?0 home ?- ?1 ?  ?\C-m ?\C-r ?\\ ?\[ ?\C-m ?\C-k ?\C-y ?\C-s ?L ?A ?S ?T ?\C-m ?\C-c ?\C-r ?\C-a tab ?\C-s ?\\ ?\[ ?2 ?0 ?\C-m ?\C-b ?\C-b ?\C-b S-insert ?\C-k])

(fset 'my-correct-for-after-midnight
   [?\C-s ?< ?2 ?0 ?\C-m ?\C-s ?\\ ?\[ ?2 ?0 ?\C-m ?\C-c ?! ?\C-? ?\C-? ?\C-? ?\C-? ?\C-? ?2 ?3 ?: ?0 ?0 home ?- ?1 ?  ?\C-m ?\C-r ?\\ ?\[ ?\C-m ?\C-k ?\C-y ?\C-s ?L ?A ?S ?T ?\C-m ?\C-c ?\C-r ?\C-a tab ?\C-s ?\\ ?\[ ?2 ?0 ?\C-m ?\C-b ?\C-b ?\C-b S-insert ?\C-k])

(put 'my-actually-i-did-it-yesterday 'kmacro t)


;; functions
(defun my-org-agenda-sort ()
  (interactive)
  (goto-char (point-min))

  (search-forward-regexp "^\* EXPIRES")
  (beginning-of-line)
  (org-sort-entries nil ?t)
  (org-cycle)

  (search-forward-regexp "^\* DEADLINED")
  (beginning-of-line)
  (org-sort-entries nil ?t)
  (org-cycle)

  (search-forward-regexp "^\* SCHEDULED")
  (beginning-of-line)
  (org-sort-entries nil ?t)
  (org-cycle)
  (org-cycle))

(defun my-org-agenda-remove-later ()
  "Remove agenda items with `later` tag."
  (interactive)
  (let ((tags '("-later")))
    (setq org-agenda-tag-filter tags)
    (org-agenda-filter-apply tags 'tag)))

(defun my-org-unbind-keys ()
  "Unset keys that are not useful in org-mode."
  (unbind-key "C-c [")
  (unbind-key "C-c ]"))

(defun my-org-rebind-keys ()
  "Rebind keys that are useful in org-mode."
  (bind-keys :map org-agenda-keymap
             ("C-s" . org-save-all-org-buffers)))

(defun my-org-insert-link ()
  "Insert org link where default description is set to html title."
  (interactive)
  (let* ((url (read-string "URL: "))
         (title (my-get-html-title-from-url url)))
    (org-insert-link nil url title)))

(defun my-org-push-on-emacs-exit ()
  (when (functionp 'org-mobile-push) (org-mobile-push)))

; http://lists.gnu.org/archive/html/emacs-orgmode/2014-02/msg00088.html
(defun my-org-ask-clock-out ()
  "Ask the user before clocking out.
   This is a useful function for adding to `kill-emacs-query-functions'."
  (if (and (featurep 'org-clock)
           (funcall 'org-clocking-p)
           (y-or-n-p "You are currently clocking time, clock out? "))
      (org-clock-out)
    t)) ; only fails on keyboard quit or error


(add-hook 'org-mode-hook 'my-org-unbind-keys)
(add-hook 'org-mode-hook 'my-org-rebind-keys)
(add-hook 'kill-emacs-query-functions 'my-org-ask-clock-out)
(when window-system
  (add-hook 'kill-emacs-hook 'my-org-push-on-emacs-exit t))

(provide 'my-org)
