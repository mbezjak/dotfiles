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
              fill-column    80
              indent-tabs-mode     nil
              indicate-empty-lines t
              imenu-auto-rescan    t)

(setq recentf-save-file (my-managed-file "recentf")
      recentf-max-saved-items 50
      auto-save-list-file-prefix (my-managed-file "auto-save-list/saves-")
      bookmark-default-file (my-managed-file "bookmarks")
      bookmark-save-flag 1
      url-configuration-directory (my-managed-file "url/")
      require-final-newline t)

(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))

;; respect case when inserting into buffer, ignore case when searching for candidates
(setq company-dabbrev-downcase nil
      company-dabbrev-ignore-case 'yes)

;; Start garbage collection every 100MB to improve Emacs performance
(setq gc-cons-threshold 100000000)

(set-face-background 'mode-line "SkyBlue")

(global-subword-mode)
(show-paren-mode)


;; Update with: $ ~/bin/update-orgmode.sh
(when (file-directory-p "~/lib/org-mode/lisp")
  (add-to-list 'load-path "~/lib/org-mode/lisp"))


;; my-stuff
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'my-functions)
(require 'my-org)
(require 'my-dev)
(require 'my-keys)
(load-file (concat user-emacs-directory "lisp/loaddefs.el"))

(my-register-buffer-save-on-focus-out)


(require 'cask "~/.cask/cask.el")
(cask-initialize)


;;; INITS

(move-text-default-bindings)
(require 'dash)
(require 's)
(require 'f)
(require 'my-helm)
(require 'my-yasnippet)


(require 'uniquify)
(require 'starter-kit-defuns)
(require 'starter-kit-misc)
(require 'starter-kit-bindings)
(require 'starter-kit-eshell)
(require 'starter-kit-lisp)

(add-hook 'after-init-hook 'global-company-mode)


(require 'monky)
(set-face-foreground 'monky-diff-add  "green4")
(set-face-foreground 'monky-diff-del  "red3")
(setq monky-process-type 'cmdserver)

(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

(eval-after-load "magit"
  '(progn
     (set-face-background 'magit-item-highlight "PaleGoldenrod")
     (set-face-foreground 'magit-diff-add "green4")
     (set-face-foreground 'magit-diff-del "red3")))

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-enable-caching t
      projectile-cache-file (my-managed-file "projectile.cache")
      projectile-known-projects-file (my-managed-file "projectile-bookmarks.eld"))
(add-to-list 'projectile-globally-ignored-directories "target")
(add-to-list 'projectile-globally-ignored-directories "build")
(add-to-list 'projectile-globally-ignored-files "*.log")


;; To use:
;; $ pacman --sync perl-text-markdown
(eval-after-load "markdown-mode"
  '(progn
     (let ((cmd "/usr/bin/vendor_perl/Markdown.pl"))
       (when (file-exists-p cmd)
         (setq markdown-command cmd)))))


(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map (kbd "M-r") 'coffee-compile-buffer)))


(defun my-groovy-not-electric ()
  (setq c-electric-flag nil)) ; annoying, especially for colon!

(eval-after-load "groovy-mode"
  '(progn
     (add-hook 'groovy-mode-hook 'my-groovy-not-electric)))


(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


(eval-after-load "haskell-mode"
  '(progn
     (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
     (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

     ;; To use:
     ;; $ cabal install ghc-mod
     (when (file-executable-p "~/.cabal/bin/ghc-mod")
       (add-hook 'haskell-mode-hook (lambda () (ghc-init))))))
