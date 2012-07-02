(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;; disable mouse interface
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (blink-cursor-mode -1))

(setq visible-bell t
      inhibit-startup-message t)

(windmove-default-keybindings)
(ffap-bindings)
(show-paren-mode 1)
(ido-mode t)

(global-set-key (kbd "C-c f") 'find-file-in-project)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-<f10>") 'menu-bar-mode)
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
      (let (el-get-master-branch)
        (goto-char (point-max))
        (eval-print-last-sexp))))

(setq my-packages '(ghc-mod haskell-mode coffee-mode paredit
                    highlight-symbol find-file-in-project smex
                    magit markdown-mode htmlize))

(setq el-get-user-package-directory
      (concat user-emacs-directory "el-get-init"))

(el-get 'sync my-packages)
