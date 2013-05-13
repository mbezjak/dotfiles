;; disable early in initialization to avoid flicker
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(column-number-mode t)
(setq-default tab-width      4
              c-basic-offset 4
              fill-column    80)

(setq ido-save-directory-list-file (concat user-emacs-directory ".ido.last")
      recentf-save-file (concat user-emacs-directory ".recentf")
      recentf-max-saved-items 50
      bookmark-save-flag 1)

;; my-stuff
(add-to-list 'load-path user-emacs-directory)
(require 'my-functions)
(require 'my-org)
(require 'my-dev)
(require 'my-keys)
(load-file (concat user-emacs-directory "loaddefs.el"))

;; el-get and melpa package initialization
(require 'my-packages)



;;; INITS

(eval-after-load "starter-kit-defuns"
  '(progn
     (remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)))


(require 'switch-window)


(require 'my-yasnippet)


(require 'bookmark+)
(setq bmkp-bmenu-state-file "~/.emacs.d/bmk-bmenu-state.el")


(require 'monky)
(set-face-foreground 'monky-diff-add "green4")
(set-face-foreground 'monky-diff-del "red3")
(setq monky-process-type 'cmdserver)
(global-set-key (kbd "C-c h") 'monky-status)


(projectile-global-mode)
(setq projectile-enable-caching t)
(add-to-list 'projectile-globally-ignored-directories "target")


;; To use:
;; $ pacman --sync perl-text-markdown
(eval-after-load "markdown-mode"
  '(progn
     (let ((cmd "/usr/bin/vendor_perl/Markdown.pl"))
       (when (file-exists-p cmd)
         (setq markdown-command cmd)))))


(eval-after-load "coffee-mode"
  '(progn
     (add-hook 'coffee-mode-hook 'esk-prog-mode-hook)
     (define-key coffee-mode-map (kbd "M-r") 'coffee-compile-buffer)))


(eval-after-load "groovy-mode"
  '(progn
     (setq c-electric-flag nil))) ; annoying, especially for colon!


(require 'scala-mode-auto)
(eval-after-load "scala-mode"
  '(progn
     (define-key scala-mode-map (kbd "C-c l")   'my-scala-load-file)
     (define-key scala-mode-map (kbd "C-c C-l") 'my-scala-load-file)))

(defun my-scala-load-file ()
  (interactive)
  (if (scala-interpreter-running-p-1)
      (scala-load-file (buffer-file-name))
    (scala-run-scala "scala")))


(eval-after-load "haskell-mode"
  '(progn
     (add-hook 'haskell-mode-hook 'esk-prog-mode-hook)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

     ;; To use:
     ;; $ cabal install ghc-mod
     (when (file-executable-p "~/.cabal/bin/ghc-mod")
       (add-hook 'haskell-mode-hook (lambda () (ghc-init))))))
