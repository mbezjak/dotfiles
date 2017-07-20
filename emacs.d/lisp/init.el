(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode -1)

(mouse-wheel-mode)
(column-number-mode)
(global-subword-mode)
(show-paren-mode)
(delete-selection-mode)
(global-auto-revert-mode)

(setq-default tab-width      4
              c-basic-offset 4
              fill-column    80
              indent-tabs-mode      nil
              indicate-empty-lines  t
              require-final-newline t
              sentence-end-double-space nil
              save-place nil)

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
      dired-recursive-copies 'always
      dired-recursive-deletes 'top
      dired-listing-switches "-lha"

      ;; use keys that all in the same row
      aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)

      ;; start garbage collection every 100MB to improve performance
      gc-cons-threshold 100000000)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(set-locale-environment "en_US.UTF-8")

(set-face-background 'mode-line "SkyBlue")

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'goto-address-mode)

(add-to-list 'safe-local-variable-values '(lexical-binding . t))
(add-to-list 'safe-local-variable-values '(whitespace-line-column . 80))

(eval-after-load "ispell"
  '(when (executable-find ispell-program-name)
     (add-hook 'text-mode-hook 'turn-on-flyspell)))

; shorter way to answer yes/no questions
(defalias 'yes-or-no-p 'y-or-n-p)

(random t) ;; seed the random number generator

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(setq use-package-verbose t)
(require 'use-package)

(use-package no-littering
  :config
  (use-package recentf)
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory)
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(setq custom-file (no-littering-expand-var-file-name "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package dash)
(use-package s)
(use-package f)

;; my-stuff
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(use-package my-functions)
(use-package my-org)
(use-package my-dev)
(move-text-default-bindings)
(use-package uniquify)
(use-package my-helm)
(use-package my-yasnippet)
(use-package my-lisp)

(use-package my-keys)

(use-package flycheck
  :defer t
  :init (global-flycheck-mode))

(use-package company
  :defer t
  :diminish company-mode
  :bind (:map company-active-map
              ("<escape>" . company-abort))
  :init (global-company-mode)
  :config
  ;; respect case when inserting into buffer, ignore when searching for candidates
  (setq company-dabbrev-downcase nil
        company-dabbrev-ignore-case 'yes))

(use-package psession
  :init
  (setq psession-elisp-objects-default-directory (no-littering-expand-var-file-name "elisp-objects")
        psession-object-to-save-alist
        '((ioccur-history . "ioccur-history.el")
          (extended-command-history . "extended-command-history.el")
          (helm-external-command-history . "helm-external-command-history.el")
          (helm-surfraw-engines-history . "helm-surfraw-engines-history.el")
          (helm-ff-history . "helm-ff-history.el")
          (helm-grep-history . "helm-grep-history.el")))
  :config
  (psession-mode)
  (dolist (fn '(psession--dump-some-buffers-to-list
                psession--restore-some-buffers
                psession-save-last-winconf
                psession-restore-last-winconf))
    (remove-hook 'kill-emacs-hook fn)
    (remove-hook 'emacs-startup-hook fn)))

(use-package keyfreq
  :init
  (setq keyfreq-file (no-littering-expand-var-file-name "keyfreq")
        keyfreq-file-lock (no-littering-expand-var-file-name "keyfreq.lock"))
  :config
  (keyfreq-mode)
  (keyfreq-autosave-mode))

(use-package diff-mode
  :defer t
  :config
  (set-face-foreground 'diff-added "green4")
  (set-face-foreground 'diff-removed "red3"))

(use-package monky
  :defer t
  :init
  (setq monky-process-type 'cmdserver)
  :config
  (set-face-foreground 'monky-diff-add  "green4")
  (set-face-foreground 'monky-diff-del  "red3"))

(use-package magit
  :defer t
  :commands magit-inside-worktree-p
  :init
  (setq magit-last-seen-setup-instructions "1.4.0"))

(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(use-package anzu
  :diminish anzu-mode
  :config
  (global-anzu-mode +1))

(use-package duplicate-thing
  :bind ("C-M-<down>" . duplicate-thing))

(use-package volatile-highlights
  :diminish volatile-highlights-mode
  :config
  (volatile-highlights-mode t))

(use-package expand-region
  :bind ("C-:" . er/expand-region))

(use-package indent-guide
  :diminish indent-guide-mode
  :config
  (indent-guide-global-mode))

(use-package projectile
  :diminish projectile-mode
  :init
  (setq projectile-keymap-prefix (kbd "M-F")
        projectile-completion-system 'helm
        projectile-enable-caching t)
  :config
  (projectile-global-mode)
  (helm-projectile-on)
  (add-to-list 'projectile-globally-ignored-directories "target")
  (add-to-list 'projectile-globally-ignored-directories "build")
  (add-to-list 'projectile-globally-ignored-files "*-all.js")
  (--each '(".log" ".png" ".gif" ".jar")
    (add-to-list 'projectile-globally-ignored-file-suffixes it))
  (--each '("*.png" "*.gif" "*.jar" "*.log")
    (add-to-list 'grep-find-ignored-files it)))

(use-package hippie-exp
  :no-require t
  :config
  (dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially))
    (delete f hippie-expand-try-functions-list))

  ;; Add this back in at the end of the list.
  (add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t))

(use-package markdown-mode
  :defer t
  :config
  ;; To use:
  ;; $ pacman --sync perl-text-markdown
  (let ((cmd "/usr/bin/vendor_perl/Markdown.pl"))
    (when (file-exists-p cmd)
      (setq markdown-command cmd))))

(use-package coffee-mode
  :defer t
  :config
  (bind-keys :map coffee-mode-map
             ("M-C" . coffee-compile-buffer)
             ("S-C-r" . my-coffee-rename-fn)))


(use-package groovy-mode
  :defer t
  :mode "build\\.kin\\'"
  :config
  (bind-keys :map groovy-mode-map
             ("C-d" . my-delete-line-keep-column-position)
             ("M-e" . backward-kill-word)
             ("S-C-r" . my-groovy-rename-class))

  (use-package groovy-imports
    :config
    (add-hook 'groovy-mode-hook 'groovy-imports-scan-file)
    (bind-keys :map groovy-mode-map
               ("C-M-i" . groovy-imports-add-import-dwim))))

(use-package gradle-mode
  :mode "build\\.gradle\\'")

(use-package gommons-mode
  :defer t
  :commands gommons-mode
  :diminish gommons-mode)

(use-package scala-mode
  :defer t
  :config
  (use-package ensime)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

(use-package haskell-mode
  :defer t
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

  ;; To use:
  ;; $ cabal install ghc-mod
  (when (file-executable-p "~/.cabal/bin/ghc-mod")
    (add-hook 'haskell-mode-hook (lambda () (ghc-init)))))

(use-package web-mode
  :mode ("\\.[gj]sp\\'" "\\.html?\\'"))

(use-package super-save
  :diminish super-save-mode
  :config
  (super-save-mode))

(use-package pomidor
  :commands pomidor
  :init
  (setq pomidor-sound-tick nil
        pomidor-sound-tack nil))

(use-package alert
  :no-require t
  :init
  (setq alert-default-style 'libnotify))

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package dumb-jump
  :config
  (dumb-jump-mode)
  (setq dumb-jump-selector 'helm))

(use-package helpful
  :bind (("C-h f" . helpful-function)))

(use-package parinfer
  :bind (("C-," . parinfer-toggle-mode))
  :init
  (add-hook 'clojure-mode-hook 'parinfer-mode)
  (add-hook 'emacs-lisp-mode-hook 'parinfer-mode)
  (add-hook 'common-lisp-mode-hook 'parinfer-mode)
  (add-hook 'scheme-mode-hook 'parinfer-mode)
  (add-hook 'lisp-mode-hook 'parinfer-mode))

(use-package clojure-mode
  :defer t
  :config
  (use-package clj-refactor
    :config
    (defun my-clj-refactor-set-keybinding-hook ()
      (cljr-add-keybindings-with-prefix "C-c C-m"))
    (add-hook 'clojure-mode-hook 'clj-refactor-mode)
    (add-hook 'clojure-mode-hook 'my-clj-refactor-set-keybinding-hook)))
