(defconst gommons-src "client-app/src/main"
  "Partial directory structure that contains source files")

(defconst gommons-test "client-app/src/test"
  "Partial directory structure that contains test files")

(defun gommons-src-file-p (name)
  "Test if NAME is a gommons source file"
  (string-match gommons-src name))

(defun gommons-test-file-p (name)
  "Test if NAME is a gommons test file"
  (string-match gommons-test name))

(defun gommons-src-to-test (name)
  "Make test location from source"
  (when (gommons-src-file-p name)
    (replace-match gommons-test t t name)))

(defun gommons-test-to-src (name)
  "Make src location from test"
  (when (gommons-test-file-p name)
    (replace-match gommons-src t t name)))

(defun gommons-open-file (name)
  "Open NAME for editing"
  (if (file-exists-p name)
      (find-file name)
    (message (format "No file '%s' exists" name))))

(defun gommons-toggle-open (name)
  "Toggle between src and test file"
  (if (gommons-src-file-p name)
      (gommons-open-file (gommons-src-to-test name))
    (gommons-open-file (gommons-test-to-src name))))

(defun gommons-toggle-current ()
  "Interactive gommons-toggle-open for current buffer name"
  (interactive)
  (gommons-toggle-open (buffer-file-name)))

(defvar gommons-mode-map (make-keymap)
  "Keymap for Gommons minor mode.")

(define-key gommons-mode-map
  (kbd "<f5>") 'gommons-toggle-current)

;;;###autoload
(define-minor-mode gommons-mode
  "Toggle gommons mode"
  :init-value nil
  :lighter " Gommons"
  :keymap gommons-mode-map)

(provide 'gommons-mode)
