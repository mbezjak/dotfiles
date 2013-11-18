(defconst gommons-root-dir (concat (getenv "HOME") "/workspace/gommons"))
(defconst gommons-js-dir (concat gommons-root-dir "/client-app"))
(defconst gommons-refman-dir (concat gommons-root-dir "/src/docs"))

(defconst gommons-jsdoc-file (concat gommons-js-dir "/target/jsdoc/index.html"))
(defconst gommons-refman-file (concat gommons-root-dir "/target/manual/html/%s.html"))

(defconst gommons-rel-coffee-src  "client-app/src/main/coffeescript")
(defconst gommons-rel-coffee-test "client-app/src/test/coffeescript")
(defconst gommons-rel-js-src      "client-app/src/main/javascript")
(defconst gommons-rel-js-test     "client-app/src/test/javascript")

(defconst gommons-test-js-cmd     "make test")
(defconst gommons-test-unit-cmd   "grails test-app unit:")
(defconst gommons-docs-js-cmd     "make doc")
(defconst gommons-docs-refman-cmd "make html")

(defvar-local gommons-referring-buffer nil
  "Name of buffer that issued `gommons-exec'. Only used in some circumstances.")

(put 'gommons-referring-buffer 'permanent-local 't)

(defvar gommons-key-map (make-keymap)
  "Keymap for Gommons minor mode.")


;; PREDICATES
(defun gommons-coffee-src-p (name)
  "Test if NAME is a coffeescript source file."
  (string-match-p gommons-rel-coffee-src name))

(defun gommons-coffee-test-p (name)
  "Test if NAME is a coffeescript test file."
  (string-match-p gommons-rel-coffee-test name))

(defun gommons-js-src-p (name)
  "Test if NAME is a javascript source file."
  (string-match-p gommons-rel-js-src name))

(defun gommons-js-test-p (name)
  "Test if NAME is a javascript test file."
  (string-match-p gommons-rel-js-test name))


;; COMBINED PREDICATES
(defun gommons-src-p (name)
  "Test if NAME is a source file."
  (or (gommons-coffee-src-p name)
      (gommons-js-src-p     name)))

(defun gommons-test-p (name)
  "Test if NAME is a test file."
  (or (gommons-coffee-test-p name)
      (gommons-js-test-p     name)))


;; FUNCTIONS
(defun gommons-rel-file (name)
  "Relative file to `gommons-root-dir'."
  (file-relative-name name gommons-root-dir))

(defun gommons-new-ext (ext name)
  "Return filename with given file extension."
  (concat (file-name-sans-extension name) "." ext))

(defun gommons-msg-with-name (tpl name)
  "Send TPL message and replace '%s' with NAME."
  (let ((rel (gommons-rel-file name)))
    (message (format tpl rel))))

(defun gommons-open-file (name)
  "Open NAME in new buffer."
  (if (file-exists-p name)
      (find-file name)
    (gommons-msg-with-name "File '%s' does not exist!" name)))

(defun gommons-browse-jsdoc ()
  "Browse javascript documentation."
  (browse-url gommons-jsdoc-file))

(defun gommons-browse-manual (name)
  "Browse reference manual."
  (let ((file (format gommons-refman-file name)))
    (when (file-exists-p file) (browse-url file))))

(defun gommons-exec (basedir cmd &optional onfinish)
  "Execute shell CMD in BASEDIR as working directory."
  (let* ((current-buffer (buffer-name))
         (buffer-name "*gommons*")
         (buffer-name-fn (lambda (mode) buffer-name))
         (compilation-scroll-output t))
    (pop-to-buffer buffer-name)

    (setq gommons-referring-buffer current-buffer)

    (setq compilation-finish-functions nil)
    (when onfinish (add-hook 'compilation-finish-functions onfinish))

    (cd basedir)
    (compilation-start cmd nil buffer-name-fn)))


;; FROM-TO FUNCTIONS
(defun gommons-name-replace (from to name)
  "Replace FROM to TO in a name."
  (replace-regexp-in-string from to name t t))

(defun gommons-coffee-from-src-to-test (name)
  "Return coffeescript test file for given src file."
  (gommons-name-replace gommons-rel-coffee-src gommons-rel-coffee-test name))

(defun gommons-coffee-from-test-to-src (name)
  "Return coffeescript src file for given test file."
  (gommons-name-replace gommons-rel-coffee-test gommons-rel-coffee-src name))

(defun gommons-js-from-src-to-test (name)
  "Return javascript test file for given src file."
  (gommons-new-ext "jspec"
   (gommons-name-replace gommons-rel-js-src gommons-rel-js-test name)))

(defun gommons-js-from-test-to-src (name)
  "Return javascript src file for given test file."
  (gommons-new-ext "js"
   (gommons-name-replace gommons-rel-js-test gommons-rel-js-src name)))

(defun gommons-from-src-to-test (name)
  "Return test file for given src file."
  (cond ((gommons-coffee-src-p name) (gommons-coffee-from-src-to-test name))
        ((gommons-js-src-p name)     (gommons-js-from-src-to-test name))))

(defun gommons-from-test-to-src (name)
  "Return src file for given test file."
  (cond ((gommons-coffee-test-p name) (gommons-coffee-from-test-to-src name))
        ((gommons-js-test-p name)     (gommons-js-from-test-to-src name))))

(defun gommons-toggle-open-src-test (name)
  "Jump between src and test file."
  (cond
   ((gommons-src-p name) (gommons-open-file (gommons-from-src-to-test name)))
   ((gommons-test-p name) (gommons-open-file (gommons-from-test-to-src name)))
   (t (gommons-msg-with-name "No test for '%s'!" name))))


;; COMMANDS
(defun gommons-toggle-open-current ()
  "Interactive `gommons-toggle-open-src-test' for current buffer name."
  (interactive)
  (gommons-toggle-open-src-test (buffer-file-name)))

(defun gommons-test-js ()
  "Run coffeescript and javascript tests."
  (interactive)
  (gommons-exec gommons-js-dir gommons-test-js-cmd))

(defun gommons-test-unit ()
  "Run grails unit tests."
  (interactive)
  (gommons-exec gommons-root-dir gommons-test-unit-cmd))

(defun gommons-docs-js ()
  "Create javascript documentation."
  (interactive)
  (gommons-exec gommons-js-dir gommons-docs-js-cmd
                (lambda (buffer status) (gommons-browse-jsdoc))))

(defun gommons-docs-manual ()
  "Create reference manual."
  (interactive)
  (gommons-exec gommons-refman-dir gommons-docs-refman-cmd
   (lambda (buffer status)
     (let ((ref (buffer-local-value 'gommons-referring-buffer buffer)))
       (when ref (gommons-browse-manual (file-name-sans-extension ref)))))))


;; KEYS
(define-key gommons-key-map (kbd "M-G o") 'gommons-toggle-open-current)
(define-key gommons-key-map (kbd "M-G j") 'gommons-test-js)
(define-key gommons-key-map (kbd "M-G u") 'gommons-test-unit)
(define-key gommons-key-map (kbd "M-G d") 'gommons-docs-js)
(define-key gommons-key-map (kbd "M-G m") 'gommons-docs-manual)


;; MINOR MODE
;;;###autoload
(define-minor-mode gommons-mode
  "Toggle gommons mode.

The following commands are available:
\\{gommons-key-map}"
  :init-value nil
  :lighter " Gommons"
  :keymap gommons-key-map)


(provide 'gommons-mode)
