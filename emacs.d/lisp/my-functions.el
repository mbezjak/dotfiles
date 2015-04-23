(require 'mm-url) ; to include mm-url-decode-entities-string


(defun my-get-html-title-from-url (url)
  "Return content in <title> tag."
  (let (x1 x2 (download-buffer (url-retrieve-synchronously url)))
    (save-excursion
      (set-buffer download-buffer)
      (beginning-of-buffer)
      (setq x1 (search-forward "<title>"))
      (search-forward "</title>")
      (setq x2 (search-backward "<"))
      (mm-url-decode-entities-string (buffer-substring-no-properties x1 x2)))))

(defun my-find-file-in-dir (dir)
  "Find file in DIR. Don't use filename or url at point."
  (let ((pattern (f-full dir)))
    (helm-find-files-1 pattern)))

(defun my-kill-current-buffer ()
  "Kill current buffer."
  (interactive)
  (kill-buffer))

(defun my-duplicate-line ()
  "Duplicate current line."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(defun my-project-version-at-point ()
  "Get the version for the project at point"
  (interactive)
  (let* ((project (thing-at-point 'symbol))
         (cmd (format "cd ~/workspace/%s; version" project))
         (version (shell-command-to-string cmd)))
    (message "%s %s" project version)))

(autoload 'magit-get-top-dir "magit")
(defun my-repo-status ()
  "Open git or hg status buffer."
  (interactive)
  (if (magit-get-top-dir ".")
      (magit-status ".")
    (monky-status)))

(defun my-save-buffer-on-focus-out ()
  "Save buffer when emacs loses focus"
  (interactive)
  (unless (or buffer-read-only
              (minibufferp)
              (s-starts-with? "*" (buffer-name)))
    (save-buffer)))

(defun my-register-buffer-save-on-focus-out ()
  (my-unregister-buffer-save-on-focus-out)
  (add-hook 'focus-out-hook 'my-save-buffer-on-focus-out))

(defun my-unregister-buffer-save-on-focus-out ()
  (remove-hook 'focus-out-hook 'my-save-buffer-on-focus-out))

(provide 'my-functions)
