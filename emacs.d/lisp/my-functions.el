(require 'mm-url) ; to include mm-url-decode-entities-string


(defun my-get-html-title-from-url (url)
  "Return content in <title> tag."
  (let (x1 x2 (download-buffer (url-retrieve-synchronously url)))
    (with-current-buffer download-buffer
      (goto-char (point-min))
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
  (if (magit-inside-worktree-p)
      (magit-status (magit-toplevel "."))
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

(defun my-xml-pretty-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (region-beginning) (region-end) "xmllint --format -" (buffer-name) t)))


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

(defun my-align-multi (start end regexp)
  "Align selection by repeating REGEXP."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end
                (concat "\\(\\s-*\\)" regexp "\\(\\s-*\\)")
                1 1 t))

(defun my-align-spock-table (start end)
  "Align spockframework data table."
  (interactive "r")
  (my-align-multi start end "|"))

(defun my-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first. If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defun my-delete-line-keep-column-position ()
  "Delete current line and keep point at current column."
  (interactive)
  (let ((column-index (current-column)))
    (kill-whole-line)
    (move-to-column column-index)))

(defun my-complete ()
  "Complete using company-mode or if not available then hippie-expand"
  (interactive)
  (if company-mode
      (company-complete)
    (hippie-expand nil)))

(provide 'my-functions)
