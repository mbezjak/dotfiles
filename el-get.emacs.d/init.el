(ffap-bindings)

(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
      (let (el-get-master-branch)
        (goto-char (point-max))
        (eval-print-last-sexp))))

(setq el-get-user-package-directory
      (concat user-emacs-directory "el-get-init"))

(setq el-get-sources
      '((:name starter-kit          :type elpa)
        (:name starter-kit-bindings :type elpa)
        (:name htmlize              :type elpa)))

(setq my-el-get-elpa-packages
      (mapcar 'el-get-source-name el-get-sources))

(setq my-el-get-packages '(ghc-mod haskell-mode coffee-mode
      markdown-mode))

(setq my-packages
      (append my-el-get-elpa-packages my-el-get-packages))

(el-get 'sync my-packages)
