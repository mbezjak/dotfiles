(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
      (let (el-get-master-branch
            el-get-install-skip-emacswiki-recipes)
        (goto-char (point-max))
        (eval-print-last-sexp))))

(setq el-get-user-package-directory user-emacs-directory)

;; Above `starter-kit' are mostly its dependencies.
;; It seems they are needed for proper load order.
(setq el-get-sources
      '((:name paredit              :type elpa)
        (:name idle-highlight-mode  :type elpa)
        (:name find-file-in-project :type elpa)
        (:name smex                 :type elpa)
        (:name ido-ubiquitous       :type elpa)
        (:name magit                :type elpa)
        (:name monky                :type elpa)
        (:name starter-kit          :type elpa)
        (:name starter-kit-bindings :type elpa)
        (:name starter-kit-eshell   :type elpa)
        (:name starter-kit-lisp     :type elpa)
        (:name haskell-mode         :type elpa)
        (:name coffee-mode          :type elpa)
        (:name groovy-mode          :type elpa)
        (:name scala-mode           :type elpa)
        (:name markdown-mode        :type elpa)
        (:name yasnippet            :type elpa)
        (:name switch-window        :type elpa)
        (:name htmlize              :type elpa)
;        (:name ensime :load-path ("./dist_2.9.2/elisp"))
        ))

;; see also init-package.el
(setq my-elpa-packages (mapcar 'el-get-source-name el-get-sources))

(setq my-el-get-packages
      '(ghc-mod
        projectile ; installing though el-get because it doesn't work with elpa
        ))

(setq my-packages (append my-elpa-packages my-el-get-packages))

(el-get 'sync my-packages)


(provide 'my-packages)
