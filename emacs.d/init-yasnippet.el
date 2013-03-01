(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas/global-mode 1)

(defun my-yas-buffer-class-name ()
  (let ((file (or (buffer-file-name) "Foo")))
    (file-name-nondirectory (file-name-sans-extension file))))

(defun my-yas-buffer-package-name ()
  (let* ((default-pkg "foo")
         (fullpath (or (buffer-file-name) default-pkg))
         (dirs (or (file-name-directory fullpath) default-pkg))
         (replacements '(".*/src/\\(main\\|test\\)/\\(java\\|groovy\\)/"
                         ".*/src/groovy/"
                         ".*/test/unit/"
                         ".*/grails-app/services/"
                         ".*/app/"
                         "^/"
                         "/$"))
         (reduction (lambda (path regex) (replace-regexp-in-string regex "" path t)))
         (pkg (-reduce-from reduction dirs replacements)))
    (replace-regexp-in-string "/" "." pkg)))
