(defconst gommons-dir (concat (getenv "HOME") "/workspace/gommons")
  "Directory where gommons project exists")

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

;; consider using `replace-regexp-in-string'
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

(defun gommons-run-js-tests ()
  "Run coffee and javascript tests"
  (interactive)
  (let* ((cdir (format "%s/client-app" gommons-dir)))
    (shell-command-to-string
     (format "cd %s && make test" cdir))
    (browse-url (format "file://%s/jasmine.html" cdir))
    (browse-url (format "%s/jspec.html" cdir))))

(defun gommons-run-unit-tests ()
  "Run grails unittests"
  (interactive)
  (shell-command
   (format "cd %s && grails test-app unit:" gommons-dir)))

(defun gommons-make-js-docs ()
  "Create javascript documentation"
  (interactive)
  (let* ((cdir (format "%s/client-app" gommons-dir)))
    (shell-command-to-string
     (format "cd %s && make doc" cdir))
    (browse-url (format "%s/target/jsdoc/index.html" cdir))))

(defun gommons-make-manual ()
  "Create Gommons manual"
  (interactive)
  (shell-command-to-string
   (format "cd %s/src/docs && make html" gommons-dir))
  (let* ((file (replace-regexp-in-string "\.rst" ".html" (buffer-name))))
    (browse-url
     (format "file://%s/target/manual/html/%s" gommons-dir file))))

(defun gommons-commit ()
  "Open mercurial commit dialog"
  (interactive)
  (shell-command-to-string
   (format "cd %s && thg commit" gommons-dir)))

(defvar gommons-mode-map (make-keymap)
  "Keymap for Gommons minor mode.")

(define-key gommons-mode-map (kbd "<f5>")  'gommons-toggle-current)
(define-key gommons-mode-map (kbd "M-G t") 'gommons-run-js-tests)
(define-key gommons-mode-map (kbd "M-G u") 'gommons-run-unit-tests)
(define-key gommons-mode-map (kbd "M-G d") 'gommons-make-js-docs)
(define-key gommons-mode-map (kbd "M-G m") 'gommons-make-manual)
(define-key gommons-mode-map (kbd "M-G c") 'gommons-commit)

;;;###autoload
(define-minor-mode gommons-mode
  "Toggle gommons mode

The following commands are available:
\\{gommons-mode-map}"
  :init-value nil
  :lighter " Gommons"
  :keymap gommons-mode-map

  (add-to-list 'projectile-ignored-directories "client-app/target")
  (add-to-list 'projectile-ignored-directories "web-app"))

(provide 'gommons-mode)
