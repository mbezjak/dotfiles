(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode -1)

(mouse-wheel-mode)
(column-number-mode)
(global-subword-mode)
(show-paren-mode)

(setq-default tab-width      4
              c-basic-offset 4
              fill-column    80
              indent-tabs-mode      nil
              indicate-empty-lines  t
              require-final-newline t
              sentence-end-double-space nil)

(setq frame-title-format '(buffer-file-name "%f" ("%b"))
      inhibit-startup-screen t
      visible-bell t
      shift-select-mode nil
      mouse-yank-at-point t
      whitespace-style '(face trailing tabs)
      whitespace-line-column 80
      uniquify-buffer-name-style 'forward
      recentf-max-saved-items 50
      bookmark-save-flag 1
      imenu-auto-rescan t
      ediff-window-setup-function 'ediff-setup-windows-plain
      diff-switches "-u"

      magit-last-seen-setup-instructions "1.4.0"

      ;; use keys that all in the same row
      aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)

      ;; respect case when inserting into buffer, ignore when searching for candidates
      company-dabbrev-downcase nil
      company-dabbrev-ignore-case 'yes

      ;; start garbage collection every 100MB to improve performance
      gc-cons-threshold 100000000)

(set-face-background 'mode-line "SkyBlue")

(random t) ;; seed the random number generator


(make-directory "~/.emacs.d/managed" 'parents)
(defun my-managed-file (name)
  "Create a file path where managed files are put."
  (concat user-emacs-directory "managed/" name))

(setq custom-file (my-managed-file "custom.el")
      recentf-save-file (my-managed-file "recentf")
      auto-save-list-file-prefix (my-managed-file "auto-save-list/saves-")
      bookmark-default-file (my-managed-file "bookmarks")
      url-configuration-directory (my-managed-file "url/")
      eshell-directory-name (my-managed-file "eshell/")
      save-place-file (my-managed-file "places")
      backup-directory-alist `(("." . ,(my-managed-file "backups"))))

(when (file-exists-p custom-file)
  (load custom-file))


(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'dash)
(require 's)
(require 'f)

;; my-stuff
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'my-functions)
(require 'my-org)
(require 'my-dev)
(require 'my-keys)
(load-file (concat user-emacs-directory "lisp/loaddefs.el"))

(my-register-buffer-save-on-focus-out)


;;; INITS

(move-text-default-bindings)
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
