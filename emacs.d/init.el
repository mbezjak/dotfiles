;; disable early in initialization to avoid flicker
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(make-directory "~/.emacs.d/managed" 'parents)
(defun my-managed-file (name)
  "Create a file path where managed files are put."
  (concat user-emacs-directory "managed/" name))

(setq custom-file (my-managed-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(column-number-mode t)
(setq-default tab-width      4
              c-basic-offset 4
              fill-column    80)

(setq ido-save-directory-list-file (my-managed-file "ido.last")
      recentf-save-file (my-managed-file "recentf")
      recentf-max-saved-items 50
      bookmark-default-file (my-managed-file "bookmarks")
      bookmark-save-flag 1
      url-configuration-directory (my-managed-file "url/"))


;; To use:
;; cd ~/lib
;; git clone git://orgmode.org/org-mode.git
;; cd org-mode
;; git checkout release_8.0.2 -b 8.0.2
;; make autoloads
(when (file-directory-p "~/lib/org-mode/lisp")
  (add-to-list 'load-path "~/lib/org-mode/lisp"))


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
(setq bmkp-bmenu-state-file (my-managed-file "bmkp-bmenu-state-file.el")
      bmkp-last-as-first-bookmark-file nil)


(require 'monky)
(set-face-foreground 'monky-diff-add "green4")
(set-face-foreground 'monky-diff-del "red3")
(setq monky-process-type 'cmdserver)
(global-set-key (kbd "C-c h") 'monky-status)


(projectile-global-mode)
(setq projectile-enable-caching t
      projectile-cache-file (my-managed-file "projectile.cache")
      projectile-known-projects-file (my-managed-file "projectile-bookmarks.eld"))
(add-to-list 'projectile-globally-ignored-directories "target")
(add-to-list 'projectile-globally-ignored-directories "build")


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


(defun my-groovy-not-electric ()
  (setq c-electric-flag nil)) ; annoying, especially for colon!

(eval-after-load "groovy-mode"
  '(progn
     (add-hook 'groovy-mode-hook 'my-groovy-not-electric)))


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

;; To use:
;; $ cd ~/lib
;; $ hub clone aemoncannon/ensime
;; $ cd ensime
;; $ git checkout v2.10.0-0.9.8.8 -b 0.9.8.8
;; $ sbt update stage
(when (file-directory-p "~/lib/ensime/dist")
  (add-to-list 'load-path "~/lib/ensime/dist/elisp")
  (require 'ensime)
  (eval-after-load "scala-mode"
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))


(eval-after-load "haskell-mode"
  '(progn
     (add-hook 'haskell-mode-hook 'esk-prog-mode-hook)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

     ;; To use:
     ;; $ cabal install ghc-mod
     (when (file-executable-p "~/.cabal/bin/ghc-mod")
       (add-hook 'haskell-mode-hook (lambda () (ghc-init))))))
