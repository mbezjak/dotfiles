(defun my-find-file-in-dir (dir)
  "Find file in DIR. Don't use filename or url at point."
  (let ((pattern (f-full dir)))
    (helm-find-files-1 pattern)))

(defun my-jump-to-workspace ()
  (interactive)
  (my-find-file-in-dir "~/workspace"))

(defun my-open-dired-here ()
  (interactive)
  (if-let ((filename (buffer-file-name))
           (dir (f-dirname filename)))
      (dired dir)
    (message "WARNING: Current buffer is not attached to a file!")))

(defun my-xml-pretty-format ()
  (interactive)
  (save-excursion
    (shell-command-on-region (region-beginning) (region-end) "xmllint --format -" (buffer-name) t)))

;; https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-funcs.el#L37
(defun my-dos2unix ()
  "Convert the current buffer to UNIX file format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix nil))

;; https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-funcs.el#L43
(defun my-unix2dos ()
  "Convert the current buffer to DOS file format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-dos nil))

;; https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-funcs.el#L48
(defun my-delete-carrage-returns ()
  "Delete `^M' characters in the buffer.
Same as `replace-string C-q C-m RET RET'."
  (interactive)
  (save-excursion
    (goto-char 0)
    (while (search-forward "\r" nil :noerror)
      (replace-match ""))))

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

(defun my-split-window-below ()
  "Split window below and focus it."
  (interactive)
  (split-window-below)
  (other-window 1))

(defun my-split-window-right ()
  "Split window right and focus it."
  (interactive)
  (split-window-right)
  (other-window 1))

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

;; https://www.reddit.com/r/emacs/comments/idz35e/emacs_27_can_take_svg_screenshots_of_itself/
(defun screenshot-svg ()
  "Save a screenshot of the current frame as an SVG image.
Saves to a temp file and puts the filename in the kill ring."
  (interactive)
  (let* ((filename (make-temp-file "Emacs" nil ".svg"))
         (data (x-export-frames nil 'svg)))
    (with-temp-file filename
      (insert data))
    (kill-new filename)
    (message filename)))

(defun my-pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(?\\(lambda\\>\\)"
          (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                    ,(make-char 'greek-iso8859-7 107))
                    nil))))))

(defun my-add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
          1 font-lock-warning-face t))))

(defun my-open-thg-commit ()
  (interactive)
  (let ((repo (f-dirname (buffer-file-name))))
    (call-process "thg" nil 0 nil "-R" repo "commit")))

(defun my-open-thg ()
  (interactive)
  (let ((repo (f-dirname (buffer-file-name))))
    (call-process "thg" nil 0 nil "-R" repo)))

(defun my-git-mergetool ()
  (interactive)
  (let ((dir (projectile-project-root)))
    (call-process "git" nil 0 nil "mergetool")))

(defun my-no-properties (p)
  (set-text-properties 0 (length p) nil p)
  p)

(defun my-clojure-copy-qualified-fn ()
  (interactive)
  (save-excursion
    (end-of-defun)
    (clojure-backward-logical-sexp 1)
    (lispy-flow 1)
    (let* ((ns (my-no-properties (cider-current-ns)))
           (fn (cider-second-sexp-in-list))
           (qfn (format "%s/%s" ns fn)))
      (kill-new qfn)
      (message "Copied to clipboard: %s" qfn))))

(defun my-clojure-copy-ns ()
  (interactive)
  (let ((ns (my-no-properties (cider-current-ns))))
    (kill-new ns)
    (message "Copied to clipboard: %s" ns)))

(defun my-clojure-remove-ns ()
  (interactive)
  (let ((ns (my-no-properties (cider-current-ns))))
    (cider-interactive-eval (format "(remove-ns '%s)" ns))
    (message "Removed ns: %s" ns)))

(defun my-yas-buffer-class-name ()
  (let ((file (or (buffer-file-name) "Foo")))
    (f-base file)))

(defun my-yas-buffer-package-name ()
  (let* ((default-pkg "foo")
         (fullpath (or (buffer-file-name) default-pkg))
         (dirs (or (file-name-directory fullpath) default-pkg))
         (replacements '(".*/src/\\(main\\|test\\)/\\(java\\|groovy\\|scala\\|coffeescript\\)/"
                         ".*/src/groovy/"
                         ".*/src/main/groovy/"
                         ".*/src/integration-test/groovy/"
                         ".*/src/test/groovy/"
                         ".*/src/coffee/"
                         ".*/src/main/coffee/"
                         ".*/src/"
                         ".*/test/"
                         ".*/grails-app/\\(controllers\\|services\\|domain\\|commands\\|hxcommands\\|taglib\\)/"
                         ".*/app/"
                         ".*/test/"
                         "^/"
                         "/$"))
         (reduction (lambda (path regex) (replace-regexp-in-string regex "" path t)))
         (pkg (-reduce-from reduction dirs replacements)))
    (replace-regexp-in-string "/" "." pkg)))

(defun my-yas-buffer-namespace-name ()
  (let ((package-name (my-yas-buffer-package-name)))
    (if (or (s-starts-with? "hx" package-name)
            (s-starts-with? "hr" package-name))
        package-name
      (s-concat "Hx." package-name))))

(defun my-yas-buffer-clojure-namespace ()
  (let ((package (replace-regexp-in-string "_" "-" (my-yas-buffer-package-name)))
        (base-name (replace-regexp-in-string "_" "-" (f-base (buffer-file-name)))))
    (s-concat package "." base-name)))

(defun my-yas-buffer-clojure-non-test-namespace ()
  (->> (my-yas-buffer-clojure-namespace)
       (replace-regexp-in-string "\-test$" "")
       (replace-regexp-in-string "^unit\." "bloom.")))

(defun my-bloom-backend-start ()
  (interactive)
  (cider-interactive-eval "(debug/start)"))

(defun my-bloom-backend-stop ()
  (interactive)
  (cider-interactive-eval "(dev/stop)"))

(defun my-bloom-backend-eval-debug-fns ()
  (interactive)
  (with-current-buffer (find-file-noselect (f-join (projectile-project-root) "miro/debug.clj"))
    (goto-char (point-min))
    (search-forward-regexp ";; fn defs above")
    (let ((text (buffer-substring-no-properties (point-min) (point))))
      (cider-interactive-eval text))))

(defun my-bloom-backend-set-replace-responses ()
  (interactive)
  (with-current-buffer (find-file-noselect (f-join (projectile-project-root) "test/it/support/rest_utils.clj"))
    (goto-char (point-min))
    (search-forward-regexp "^(def replace-responses ")
    (lispy-kill-word 1)
    (insert " true")
    (save-buffer)
    (cider-eval-defun-at-point)
    (run-with-idle-timer 0.3 nil (lambda () (message "replace responses true")))))

(defun my-bloom-backend-set-write-json-tree ()
  (interactive)
  (with-current-buffer (find-file-noselect (f-join (projectile-project-root) "test/it/support/fs_storage_utils.clj"))
    (goto-char (point-min))
    (search-forward-regexp "^(def write-json-tree ")
    (lispy-kill-word 1)
    (insert " true")
    (save-buffer)
    (cider-eval-defun-at-point)
    (run-with-idle-timer 0.3 nil (lambda () (message "write json-tree true")))))

(defun my-bloom-dired-data ()
  (interactive)
  (let ((dir (f-join (projectile-project-root) "data")))
    (dired dir)))

(defun my-bloom-dired-open-resources ()
  (interactive)
  (let ((dir (replace-regexp-in-string "/test/it/" "/test-resources/it/" dired-directory)))
    (dired dir)))

(provide 'my-functions)
