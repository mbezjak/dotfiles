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

(defun my-repo-status ()
  "Open git or hg status buffer."
  (interactive)
  (if (magit-inside-worktree-p)
      (magit-status (magit-toplevel "."))
    (monky-status)))

(defun my-xml-pretty-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (region-beginning) (region-end) "xmllint --format -" (buffer-name) t)))

;; ported from starter-kit
(defun my-untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

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

(defun my-delete-region-or-line ()
  "Delete region if active or current line."
  (interactive)
  (if (use-region-p)
      (call-interactively 'kill-region)
    (call-interactively 'my-delete-line-keep-column-position)))

(defun my-complete ()
  "Complete using company-mode or if not available then hippie-expand"
  (interactive)
  (if company-mode
      (company-complete)
    (hippie-expand nil)))

;; http://stackoverflow.com/questions/17829619/rename-current-buffer-and-related-file-in-emacs
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun my-rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew file name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun my-groovy-change-class-name-to (new-name)
  (save-excursion
    (goto-char 1)
    (when (re-search-forward "^class [^ ]+ ")
      (replace-match (concat "class " new-name " ")))))

(defun my-groovy-rename-class (new-name)
  (interactive "sNew class name: ")
  (my-rename-file-and-buffer (concat new-name "." (f-ext (buffer-file-name))))
  (my-groovy-change-class-name-to new-name))

(defun my-coffee-change-fn-name-to (new-name)
  (save-excursion
    (goto-char 1)
    (when (re-search-forward "\.[a-zA-Z0-9_]+ =")
      (replace-match (concat "." new-name " =")))))

(defun my-coffee-rename-fn (new-name)
  (interactive "sNew fn name: ")
  (my-rename-file-and-buffer (concat new-name "." (f-ext (buffer-file-name))))
  (my-coffee-change-fn-name-to new-name))

(provide 'my-functions)
