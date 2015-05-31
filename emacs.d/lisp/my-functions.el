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



;; ported from starter-kit
(defun my-untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun my-indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun my-cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (my-indent-buffer)
  (my-untabify-buffer)
  (delete-trailing-whitespace))

(defun my-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun my-lorem ()
  "Insert a lorem ipsum."
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
          "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
          "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
          "aliquip ex ea commodo consequat. Duis aute irure dolor in "
          "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
          "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
          "culpa qui officia deserunt mollit anim id est laborum."))

(defun my-generate-autoloads-in-emacs.d ()
  "Regenerate emacs.d/lisp/loaddefs.el"
  (let* ((dir (f-expand "~/.emacs.d/lisp"))
         (generated-autoload-file (f-join dir "loaddefs.el")))
    (when (f-exists? generated-autoload-file)
      (f-delete generated-autoload-file))
    (update-directory-autoloads dir)))

(provide 'my-functions)
