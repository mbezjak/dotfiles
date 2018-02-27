;; start garbage collection every x MB to improve performance
(setq gc-cons-threshold (* 100 1024 1024))

(setq package-user-dir (locate-user-emacs-file (concat "elpa-" emacs-version)))
(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
        ("melpa"        . "https://melpa.org/packages/")
        ("gnu"          . "https://elpa.gnu.org/packages/")))
(setq package-archive-priorities
      '(("melpa-stable" . 10)
        ("melpa" . 5)
        ("gnu" . 0)))
(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode -1)

(mouse-wheel-mode)
(column-number-mode)
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
      imenu-auto-rescan t
      ediff-window-setup-function 'ediff-setup-windows-plain
      diff-switches "-u"
      dired-recursive-copies 'always
      dired-recursive-deletes 'top
      dired-listing-switches "-lha")

;; trying out scroll setup from frontmacs
(setq scroll-preserve-screen-position 1)

(set-locale-environment "en_US.UTF-8")
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'safe-local-variable-values '(lexical-binding . t))
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(defalias 'yes-or-no-p 'y-or-n-p)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-verbose t)
(require 'use-package)


(use-package no-littering
  :ensure t
  :config
  (setq auto-save-file-name-transforms
        `((".*" ,(no-littering-expand-var-file-name "auto-save/") t))))

(use-package recentf
  :init
  (setq recentf-max-saved-items 200)
  :config
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory))

(setq custom-file (no-littering-expand-var-file-name "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package dash :ensure t)
(use-package s :ensure t)
(use-package f :ensure t)
(use-package my-functions)
(use-package my-org)
(use-package my-dev)
(use-package my-yasnippet)
(use-package my-keys)

(use-package uniquify
  :init
  (setq uniquify-buffer-name-style 'forward))

(use-package move-text
  :ensure t
  :disabled t
  :init
  (move-text-default-bindings))

(use-package drag-stuff
  :ensure t
  :init
  (drag-stuff-global-mode)
  (drag-stuff-define-keys))

(use-package subword
  :diminish subword-mode
  :config
  (global-subword-mode))

(use-package whitespace
  :defer t
  :diminish whitespace-mode
  :init
  (setq whitespace-style '(face trailing tabs empty)
        whitespace-line-column 80)
  (defun my-delete-trailing-whitespace-before-save ()
    "Ensure trailing whitespaces are deleted."
    (add-hook 'before-save-hook 'delete-trailing-whitespace))
  (add-to-list 'safe-local-variable-values '(whitespace-line-column . 80))
  (add-hook 'prog-mode-hook 'whitespace-mode)
  (add-hook 'prog-mode-hook 'my-delete-trailing-whitespace-before-save))

(use-package flycheck
  :ensure t
  :defer t
  :init (global-flycheck-mode))

(use-package company
  :ensure t
  :defer t
  :diminish company-mode
  :bind (:map company-active-map
              ("<escape>" . company-abort))
  :init (global-company-mode)
  :config
  ;; respect case when inserting into buffer, ignore when searching for candidates
  (setq company-dabbrev-downcase nil
        company-dabbrev-ignore-case 'yes
        company-show-numbers t))

(use-package psession
  :ensure t
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
  :ensure t
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
  :ensure t
  :defer t
  :init
  (setq monky-process-type 'cmdserver)
  :config
  (set-face-foreground 'monky-diff-add  "green4")
  (set-face-foreground 'monky-diff-del  "red3"))

(use-package magit
  :ensure t
  :defer t
  :commands magit-inside-worktree-p
  :init
  (setq magit-last-seen-setup-instructions "1.4.0"))

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode)
  (add-hook 'dired-mode-hook 'diff-hl-dired-mode))

(use-package anzu
  :ensure t
  :diminish anzu-mode
  :config
  (global-anzu-mode))

(use-package duplicate-thing
  :ensure t
  :bind ("C-M-<down>" . duplicate-thing))

(use-package volatile-highlights
  :ensure t
  :diminish volatile-highlights-mode
  :config
  (volatile-highlights-mode t))

(use-package expand-region
  :ensure t
  :bind ("C-:" . er/expand-region))

(use-package indent-guide
  :ensure t
  :diminish indent-guide-mode
  :config
  (indent-guide-global-mode))

(use-package helm
  :ensure t
  :diminish helm-mode
  :bind (("M-x" . helm-M-x)
         ("M-[" . helm-projectile-find-file)
         ("C-M-]" . helm-find-files)
         ("M-<f8>" . helm-for-files)
         ("C-x C-i" . helm-semantic-or-imenu)
         ("M-f" . helm-swoop)
         ("C-x C-f" . helm-find-files)
         ("M-S" . helm-projectile-grep)
         ("C-o" . helm-find-files)
         ("C-v" . helm-show-kill-ring)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action)
         ("C-i" . helm-execute-persistent-action) ; make TAB work in terminal
         ("C-z" . helm-select-action)
         ("M-k" . helm-next-line)
         ("M-o" . helm-previous-line)
         ("<escape>" . helm-keyboard-quit)
         :map helm-find-files-map
         ("M-l" . helm-find-files-up-one-level)
         :map isearch-mode-map
         ("M-o" . helm-occur-from-isearch)
         ("M-i" . helm-swoop-from-isearch))
  :init
  (setq history-length 100 ; determines file-name-history; see helm-ff-file-name-history-use-recentf
        helm-split-window-default-side 'right)
  (when (executable-find "curl")
    (setq helm-net-prefer-curl t))
  (when (executable-find "ack-grep")
    (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
          helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))
  :config
  (use-package helm-config)
  (helm-mode)
  (use-package helm-descbinds
    :ensure t
    :config (helm-descbinds-mode)))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :init
  (setq projectile-keymap-prefix (kbd "M-F")
        projectile-enable-caching t)
  :config
  (projectile-global-mode)
  (add-to-list 'projectile-globally-ignored-directories "target")
  (add-to-list 'projectile-globally-ignored-directories "build")
  (add-to-list 'projectile-globally-ignored-files "*-all.js")
  (--each '(".log" ".png" ".gif" ".jar")
    (add-to-list 'projectile-globally-ignored-file-suffixes it))
  (--each '("*.png" "*.gif" "*.jar" "*.log")
    (add-to-list 'grep-find-ignored-files it)))

(use-package helm-projectile
  :ensure t
  :init
  (setq projectile-completion-system 'helm)
  :config
  (helm-projectile-on))

(use-package hippie-exp
  :no-require t
  :config
  (dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially))
    (delete f hippie-expand-try-functions-list))

  ;; Add this back in at the end of the list.
  (add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t))

(use-package markdown-mode
  :ensure t
  :defer t
  :config
  ;; To use:
  ;; $ pacman --sync perl-text-markdown
  (let ((cmd "/usr/bin/vendor_perl/Markdown.pl"))
    (when (file-exists-p cmd)
      (setq markdown-command cmd))))

(use-package coffee-mode
  :ensure t
  :defer t
  :config
  (bind-keys :map coffee-mode-map
             ("M-C" . coffee-compile-buffer)
             ("S-C-r" . my-coffee-rename-fn)))


(use-package groovy-mode
  :ensure t
  :defer t
  :mode ("build\\.kin\\'" "build\\.gradle\\'" "\\.drw\\'")
  :config
  (bind-keys :map groovy-mode-map
             ("C-d" . my-delete-line-keep-column-position)
             ("M-e" . backward-kill-word)
             ("S-C-r" . my-groovy-rename-class))

  (use-package groovy-imports
    :ensure t
    :config
    (add-hook 'groovy-mode-hook 'groovy-imports-scan-file)
    (bind-keys :map groovy-mode-map
               ("C-M-i" . groovy-imports-add-import-dwim))))

(use-package gommons-mode
  :defer t
  :commands gommons-mode
  :diminish gommons-mode)

(use-package ensime
  :ensure t
  :defer t)

(use-package scala-mode
  :ensure t
  :defer t)

(use-package haskell-mode
  :ensure t
  :defer t
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

  ;; To use:
  ;; $ cabal install ghc-mod
  (when (file-executable-p "~/.cabal/bin/ghc-mod")
    (add-hook 'haskell-mode-hook (lambda () (ghc-init)))))

(use-package web-mode
  :ensure t
  :mode ("\\.[gj]sp\\'" "\\.html?\\'"))

(use-package super-save
  :ensure t
  :diminish super-save-mode
  :config
  (super-save-mode))

(use-package pomidor
  :ensure t
  :commands pomidor
  :init
  (setq pomidor-sound-tick nil
        pomidor-sound-tack nil))

(use-package alert
  :no-require t
  :init
  (setq alert-default-style 'libnotify))

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package dumb-jump
  :ensure t
  :config
  (dumb-jump-mode)
  (setq dumb-jump-selector 'helm))

(use-package helpful
  :ensure t
  :bind (("C-h f" . helpful-function)))

(use-package parinfer
  :ensure t
  :bind (("C-," . parinfer-toggle-mode))
  :init
  (add-hook 'clojure-mode-hook 'parinfer-mode)
  (add-hook 'emacs-lisp-mode-hook 'parinfer-mode)
  (add-hook 'common-lisp-mode-hook 'parinfer-mode)
  (add-hook 'scheme-mode-hook 'parinfer-mode)
  (add-hook 'lisp-mode-hook 'parinfer-mode))

(use-package clojure-mode
  :ensure t
  :defer t
  :config
  (use-package clj-refactor
    :ensure t
    :diminish clj-refactor-mode
    :init
    (setq cljr-warn-on-eval nil)
    :config
    (defun my-clj-refactor-set-keybinding-hook ()
      (cljr-add-keybindings-with-prefix "C-c C-m"))
    (add-hook 'clojure-mode-hook 'clj-refactor-mode)
    (add-hook 'clojure-mode-hook 'my-clj-refactor-set-keybinding-hook)))

(use-package smart-mode-line
  :ensure t
  :config
  (sml/setup))

(use-package idle-highlight-mode
  :ensure t
  :defer t
  :init
  (add-hook 'prog-mode-hook 'idle-highlight-mode))

(use-package goto-addr
  :defer t
  :init
  (add-hook 'text-mode-hook 'goto-address-mode)
  (add-hook 'prog-mode-hook 'goto-address-mode))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'")

(use-package rjsx-mode
  :ensure t
  :mode "components\\/.*\\.js\\'"
  :bind (:map rjsx-mode-map
         ("C-d" . my-delete-line-keep-column-position)))

(use-package octave
  :mode ("\\.m\\'" . octave-mode))

(use-package simple
  :diminish auto-fill-function
  :init
  (defun my-local-comment-auto-fill ()
    (set (make-local-variable 'comment-auto-fill-only-comments) t)
    (auto-fill-mode t))
  :config
  (add-hook 'text-mode-hook 'turn-on-auto-fill)
  (add-hook 'prog-mode-hook 'my-local-comment-auto-fill))

(use-package ispell
  :defer t
  :config
  (use-package flyspell
    :if (executable-find ispell-program-name)
    :diminish flyspell-mode
    :defer t
    :init
    (add-hook 'text-mode-hook 'turn-on-flyspell)))

(use-package elisp-mode
  :bind (:map emacs-lisp-mode-map
              ("C-c v" . eval-buffer)
         :map lisp-mode-shared-map
              ("RET" . reindent-then-newline-and-indent)
         :map read-expression-map
              ("TAB" . completion-at-point))
  :init
  (defun my-remove-elc-on-save ()
    "If you're saving an elisp file, likely the .elc is no longer valid."
    (make-local-variable 'after-save-hook)
    (add-hook 'after-save-hook
              (lambda ()
                (if (file-exists-p (concat buffer-file-name "c"))
                    (delete-file (concat buffer-file-name "c"))))))
  (add-hook 'emacs-lisp-mode-hook 'my-remove-elc-on-save)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode))

(use-package java-mode
  :bind (:map java-mode-map
              ("C-d" . my-delete-line-keep-column-position)))

(use-package cider
  :ensure t
  :defer t
  :init
  (setq cider-default-repl-command "lein"))

(use-package elisp-slime-nav   :ensure t :defer t)
(use-package helm-swoop        :ensure t :defer t)
(use-package helm-ag           :ensure t :defer t)
(use-package htmlize           :ensure t :defer t)
(use-package free-keys         :ensure t :defer t)
(use-package discover-my-major :ensure t :defer t)
(use-package ghc               :ensure t :defer t)
(use-package sbt-mode          :ensure t :defer t)
(use-package ensime            :ensure t :defer t)
(use-package json-mode         :ensure t :defer t)
(use-package paradox           :ensure t :defer t)
