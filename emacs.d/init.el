;; disable early in initialization to avoid flicker
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(column-number-mode t)
(setq-default tab-width 4
              c-basic-offset 4
              fill-column 80)

(global-set-key (kbd "C-x \\") 'align-regexp)
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

(defun delete-trailing-whitespace-before-save ()
  (add-hook 'before-save-hook 'delete-trailing-whitespace))
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'prog-mode-hook 'delete-trailing-whitespace-before-save)

(add-to-list 'load-path "~/.emacs.d/")
(require 'gommons-mode)


;; el-get.el dependent code
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
      (let (el-get-master-branch)
        (goto-char (point-max))
        (eval-print-last-sexp))))

(setq el-get-user-package-directory user-emacs-directory)

;; Everything above `starter-kit' are its dependencies.
;; It seems they are needed for proper load order.
(setq el-get-sources
      '((:name paredit              :type elpa)
        (:name idle-highlight-mode  :type elpa)
        (:name find-file-in-project :type elpa)
        (:name smex                 :type elpa)
        (:name ido-ubiquitous       :type elpa)
        (:name magit                :type elpa)
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
        (:name projectile           :type elpa)
        (:name htmlize              :type elpa)))

(setq my-el-get-elpa-packages
      (mapcar 'el-get-source-name el-get-sources))

(setq my-el-get-packages
      '(ghc-mod))

(setq my-packages
      (append my-el-get-elpa-packages my-el-get-packages))

(el-get 'sync my-packages)