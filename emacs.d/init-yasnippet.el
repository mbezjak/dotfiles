(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas/global-mode 1)

(defun my-yas-buffer-class-name ()
  (let ((file (or (buffer-file-name) "Foo")))
    (file-name-nondirectory (file-name-sans-extension file))))
