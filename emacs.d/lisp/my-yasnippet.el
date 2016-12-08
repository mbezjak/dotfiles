(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(setq yas-new-snippet-default "\
# -*- mode: snippet -*-
# key: $1
# name: $1
# --
$0")
(yas-global-mode)

(defun my-yas-buffer-class-name ()
  (let ((file (or (buffer-file-name) "Foo")))
    (f-base file)))

(defun my-yas-buffer-package-name ()
  (let* ((default-pkg "foo")
         (fullpath (or (buffer-file-name) default-pkg))
         (dirs (or (file-name-directory fullpath) default-pkg))
         (replacements '(".*/src/\\(main\\|test\\)/\\(java\\|groovy\\|scala\\)/"
                         ".*/src/groovy/"
                         ".*/test/\\(unit\\|integration\\)/"
                         ".*/grails-app/\\(controllers\\|services\\|domain\\)/"
                         ".*/app/"
                         ".*/test/"
                         "^/"
                         "/$"))
         (reduction (lambda (path regex) (replace-regexp-in-string regex "" path t)))
         (pkg (-reduce-from reduction dirs replacements)))
    (replace-regexp-in-string "/" "." pkg)))


(provide 'my-yasnippet)
