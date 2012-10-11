;; disable early in initialization to avoid flicker
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(column-number-mode t)
(setq-default tab-width 4
              c-basic-offset 4
              fill-column 80)

(setq ido-save-directory-list-file (concat user-emacs-directory ".ido.last")
      recentf-save-file (concat user-emacs-directory ".recentf")
      recentf-max-saved-items 50
      calendar-week-start-day 1 ; monday
      org-startup-indented t
      org-hide-leading-stars t
      org-log-done 'time
      org-directory "~/Dropbox/notes"
      org-agenda-files (list org-directory)
      org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-extend-today-until 5
      org-refile-targets '((nil :maxlevel . 3)
                           (org-agenda-files :maxlevel . 2)))

(add-to-list 'load-path "~/.emacs.d/")
(require 'my-functions)

(defun my-org-insert-link ()
  "Insert org link where default description is set to html title."
  (interactive)
  (let* ((url (read-string "URL: "))
         (title (my-get-html-title-from-url url)))
    (org-insert-link nil url title)))

(defun find-org-files ()
  (interactive)
  (ido-find-file-in-dir org-directory))

(defun unbind-org-keys ()
  (local-unset-key (kbd "C-c ["))
  (local-unset-key (kbd "C-c ]")))

(add-hook 'org-mode-hook 'unbind-org-keys)

(global-unset-key (kbd "C-x C-c")) ; shutdown with alt + F4
(global-unset-key (kbd "C-z"))

(global-set-key (kbd "C-x c") 'find-org-files)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-x \\") 'align-regexp)
(global-set-key (kbd "M-B") 'browse-url)
(global-set-key (kbd "M-P") 'browse-url-at-point)
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

(defun delete-trailing-whitespace-before-save ()
  (add-hook 'before-save-hook 'delete-trailing-whitespace))
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'delete-trailing-whitespace-before-save)

(require 'gommons-mode)

;; el-get and melpa package initialization
(require 'my-packages)
