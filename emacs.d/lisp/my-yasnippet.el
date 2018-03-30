(use-package yasnippet :ensure t)

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(setq yas-new-snippet-default "\
# -*- mode: snippet -*-
# key: $1
# name: $1
# --
$0")
(yas-global-mode)
(diminish 'yas-minor-mode)

(defun my-yas-buffer-class-name ()
  (let ((file (or (buffer-file-name) "Foo")))
    (f-base file)))

(defun my-yas-buffer-package-name ()
  (let* ((default-pkg "foo")
         (fullpath (or (buffer-file-name) default-pkg))
         (dirs (or (file-name-directory fullpath) default-pkg))
         (replacements '(".*/src/\\(main\\|test\\)/\\(java\\|groovy\\|scala\\|coffeescript\\)/"
                         ".*/src/groovy/"
                         ".*/src/coffee/"
                         ".*/src/"
                         ".*/test/\\(unit\\|integration\\)/"
                         ".*/grails-app/\\(controllers\\|services\\|domain\\|commands\\|taglib\\)/"
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
  (let ((package (my-yas-buffer-package-name))
        (base-name (f-base (buffer-file-name))))
    (s-concat package "." base-name)))


(provide 'my-yasnippet)
