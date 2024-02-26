;; start garbage collection every x MB to improve performance
(setq gc-cons-threshold (* 100 1024 1024))
(setq gc-cons-percentage 0.6)

(setq package-user-dir (locate-user-emacs-file "elpa"))
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(setq package-archive-priorities
      '(("melpa" . 10)
        ("gnu" . 0)))
(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(blink-cursor-mode -1)

(mouse-wheel-mode)
(column-number-mode)
(size-indication-mode)
(show-paren-mode)
(delete-selection-mode)
(global-auto-revert-mode)

(setq-default tab-width      4
              c-basic-offset 4
              sgml-basic-offset 4
              fill-column    100
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
      dired-listing-switches "-lha --group-directories-first"
      ;; node / create-react-app dislikes lock files
      create-lockfiles nil)

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
(eval-when-compile
  (require 'use-package))


(use-package no-littering
  :ensure t
  :config
  (no-littering-theme-backups))

(setq custom-file (no-littering-expand-var-file-name "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package dash :ensure t)
(use-package s    :ensure t)
(use-package f    :ensure t)

(use-package my-functions
  :ensure nil
  :hook ((prog-mode . my-pretty-lambdas)
         (prog-mode . my-add-watchwords)))

(use-package my-org
  :ensure nil)

(use-package my-keys
  :ensure nil)

(use-package telephone-line
  :ensure t
  :hook ((after-init . telephone-line-mode))
  :config
  (setq telephone-line-lhs '((evil   . (telephone-line-airline-position-segment))
                             (accent . (telephone-line-vc-segment
                                        telephone-line-erc-modified-channels-segment
                                        telephone-line-process-segment))
                             (nil    . (telephone-line-projectile-segment
                                        telephone-line-buffer-segment)))
        telephone-line-rhs '((nil    . (telephone-line-flycheck-segment
                                        telephone-line-misc-info-segment))
                             (accent . (telephone-line-major-mode-segment
                                        telephone-line-minor-mode-segment))
                             (evil   . (telephone-line-evil-tag-segment)))))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one 'no-confirm)
  (doom-themes-visual-bell-config))

(use-package diminish
  :ensure t
  :defer t)

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  :config
  (yas-global-mode)
  (define-key yas-minor-mode-map (kbd "<tab>") yas-maybe-expand))

(use-package recentf
  :ensure nil
  :defer t
  :init
  (setq recentf-max-saved-items 200))

(use-package sh-script
  :ensure nil
  :init
  (defun sh-mode-setup+ ()
    (add-hook 'after-save-hook #'executable-make-buffer-file-executable-if-script-p))
  (add-hook 'sh-mode-hook #'sh-mode-setup+))

(use-package uniquify
  :ensure nil
  :init
  (setq uniquify-buffer-name-style 'forward))

(use-package rect
  :ensure nil
  :bind (("<C-return>" . rectangle-mark-mode)))

(use-package move-text
  :ensure t
  :init
  (move-text-default-bindings))

(use-package subword
  :ensure nil
  :diminish subword-mode
  :config
  (global-subword-mode))

(use-package whitespace
  :ensure nil
  :diminish whitespace-mode
  :hook (prog-mode . whitespace-mode)
  :init
  (setq whitespace-action '(auto-cleanup)
        whitespace-style '(face trailing empty indentation space-after-tab space-before-tab)))

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :hook ((after-init . global-flycheck-mode)))

;; config in notes.el
(use-package hydra
  :ensure t
  :bind ("<f12> f" . my-hydra-fns/body)
  :config
  (defhydra my-hydra-fns (:color amaranth)
    "Functions"
    ("x" (my-xml-pretty-format) "Format XML")
    ("u" (my-dos2unix) "DOS->Unix")
    ("d" (my-unix2dos) "Unix->DOS")
    ("c" (my-delete-carrage-returns) "Delete `^M'")
    ("t" (my-untabify-buffer) "Untabify")
    ("l" (my-lorem) "Insert lorem")
    ("F" flyspell-mode "Flyspell" :toggle t)
    ("L" auto-fill-mode "Auto fill" :toggle t)
    ("q" nil "quit")))

(use-package company
  :ensure t
  :diminish company-mode
  :bind (:map company-active-map
              ("<escape>" . company-abort))
  :hook ((after-init . global-company-mode))
  :config
  (setq company-tooltip-offset-display 'lines
        company-show-numbers t
        ;; respect case when inserting into buffer, ignore when searching for candidates
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case 'yes))

(use-package psession
  :ensure t
  :init
  (setq psession-object-to-save-alist
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
  :config
  (keyfreq-mode)
  (keyfreq-autosave-mode))

(use-package diff-mode
  :ensure nil
  :defer t
  :config
  (set-face-foreground 'diff-added "green4")
  (set-face-foreground 'diff-removed "red3"))

(use-package magit
  :ensure t
  :bind (("<f8>" . magit-status)))

(use-package git-timemachine
  :ensure t
  :defer t)

(use-package git-messenger
  :ensure t
  :defer t
  :init
  (setq git-messenger:show-detail t
        git-messenger:use-magit-popup t))

(use-package git-link
  :ensure t
  :defer t
  :init
  (setq git-link-use-commit t
        git-link-open-in-browser t))

(use-package anzu
  :ensure t
  :diminish anzu-mode
  :config
  (global-anzu-mode))

(use-package volatile-highlights
  :ensure t
  :diminish volatile-highlights-mode
  :config
  (volatile-highlights-mode t))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))

(use-package helm
  :ensure t
  :diminish helm-mode
  :bind (("M-x" . helm-M-x)
         ("M-[" . helm-projectile-find-file)
         ("M-]" . projectile-switch-project)
         ("C-]" . my-jump-to-workspace)
         ("C-M-]" . helm-find-files)
         ("M-<f8>" . helm-for-files)
         ("C-x C-i" . helm-semantic-or-imenu)
         ("M-b" . helm-semantic-or-imenu)
         ("M-f" . helm-swoop)
         ("C-x C-f" . helm-find-files)
         ("M-S" . helm-projectile-rg)
         ("C-o" . helm-find-files)
         ("C-v" . helm-show-kill-ring)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action)
         ("C-i" . helm-execute-persistent-action) ; make TAB work in terminal
         ("<right>" . helm-execute-persistent-action)
         ("C-z" . helm-select-action)
         ("M-k" . helm-next-line)
         ("M-o" . helm-previous-line)
         ("<escape>" . helm-keyboard-quit)
         :map helm-find-files-map
         ("M-l" . helm-find-files-up-one-level)
         :map isearch-mode-map
         ("M-o" . helm-occur-from-isearch)
         ("M-i" . helm-swoop-from-isearch)
         ("C-/" . isearch-query-replace))
  :init
  (setq history-length 100 ; determines file-name-history; see helm-ff-file-name-history-use-recentf
        helm-split-window-default-side 'right
        helm-find-files-ignore-thing-at-point t
        helm-move-to-line-cycle-in-source nil)
  (when (executable-find "curl")
    (setq helm-net-prefer-curl t))
  (when (executable-find "ack")
    (setq helm-grep-default-command "ack -Hn --color --smart-case --no-group %e %p %f"
          helm-grep-default-recurse-command "ack -H --color --smart-case --no-group %e %p %f"))
  :config
  (require 'tramp) ; otherwise void variable tramp-methods on projectile switch project
  (helm-mode)
  (use-package helm-descbinds
    :ensure t
    :config (helm-descbinds-mode))
  (use-package helm-rg
    :ensure t
    :bind (:map helm-rg-map
           ("<right>" . helm-execute-persistent-action)
           ("C-<right>" . helm-rg--file-forward)
           ("C-<left>" . helm-rg--file-backward))
    :config
    (setenv "RIPGREP_CONFIG_PATH" (f-full "~/.ripgreprc"))))

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind-keymap (("M-F" . projectile-command-map))
  :init
  (setq projectile-enable-caching t
        projectile-indexing-method 'native
        projectile-hg-command "hg files -0 -I ."
        projectile-create-missing-test-files t)
  :config
  (projectile-mode)
  (--each '("target" "node_modules" ".gradle" ".clj-kondo" ".nx-cache" ".nx")
    (add-to-list 'projectile-globally-ignored-directories it))
  (--each '("*-all.js")
    (add-to-list 'projectile-globally-ignored-files it))
  (--each '(".log" ".png" ".gif" ".jar")
    (add-to-list 'projectile-globally-ignored-file-suffixes it))
  (--each '("*.png" "*.jpg" "*.gif" "*.jar" "*.log" "*.pdf" "*.jasper")
    (add-to-list 'grep-find-ignored-files it)))

(use-package helm-projectile
  :ensure t
  :init
  (setq projectile-completion-system 'helm
        helm-source-projectile-files-and-dired-list '(helm-source-projectile-files-list))
  :config
  (helm-projectile-on))

(use-package hippie-exp
  :ensure nil
  :no-require t
  :config
  (dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially))
    (delete f hippie-expand-try-functions-list))

  ;; Add this back in at the end of the list.
  (add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t))

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
        pomidor-sound-tack nil
        pomidor-sound-overwork nil
        pomidor-sound-break-over nil))

(use-package alert
  :ensure t
  :no-require t
  :init
  (setq alert-default-style 'libnotify))

(use-package dumb-jump
  :ensure t
  :config
  (dumb-jump-mode)
  (setq dumb-jump-selector 'helm))

(use-package helpful
  :ensure t
  :bind (("<f1>" . helpful-at-point)
         ("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)))

(use-package idle-highlight-mode
  :ensure t
  :hook (prog-mode . idle-highlight-mode))

(use-package goto-addr
  :ensure nil
  :hook ((text-mode . goto-address-mode)
         (prog-mode . goto-address-mode)))

(use-package simple
  :ensure nil
  :diminish auto-fill-function
  :init
  (defun my-local-comment-auto-fill ()
    (set (make-local-variable 'comment-auto-fill-only-comments) t)
    (auto-fill-mode t))
  :hook ((text-mode . turn-on-auto-fill)
         (prog-mode . my-local-comment-auto-fill)))

(use-package flyspell
  :ensure nil
  :diminish flyspell-mode
  :if (executable-find "aspell")
  :hook ((text-mode . turn-on-flyspell)))

(use-package crux
  :ensure t
  :bind (("C-c o" . crux-open-with)
         ("C-S-<return>" . crux-smart-open-line-above)
         ("S-<return>" . crux-smart-open-line)
         ;; ("C-c n" . crux-cleanup-buffer-or-region)
         ("C-c u" . crux-view-url)
         ("C-c e" . crux-eval-and-replace)
         ("C-c D" . crux-delete-file-and-buffer)
         ("C-M-<down>" . crux-duplicate-current-line-or-region)
         ("C-S-M-<down>" . crux-duplicate-and-comment-current-line-or-region)
         ("C-S-r" . crux-rename-file-and-buffer)
         ("C-c t" . crux-visit-term-buffer)
         ("C-c j" . crux-top-join-line)
         ("M-E" . crux-kill-line-backwards)
         ("C-c i" . crux-ispell-word-then-abbrev)))

(use-package try
  :ensure t
  :defer t)

(use-package elmacro
  :ensure t
  :defer t)

(use-package elisp-slime-nav
  :ensure t
  :hook (emacs-lisp-mode-hook . elisp-slime-nav-mode))

(use-package helm-swoop
  :ensure t
  :defer t)

(use-package helm-ag
  :ensure t
  :defer t)

(use-package htmlize
  :ensure t
  :defer t)

(use-package discover-my-major
  :ensure t
  :defer t)

(use-package package-utils
  :ensure t
  :defer t)

(use-package pacfiles-mode
  :ensure t
  :defer t)

(use-package unfill
  :ensure t
  :defer t
  :bind (("M-Q" . unfill-paragraph)))

(use-package free-keys
  :ensure t
  :defer t
  :init
  (setq free-keys-modifiers '("" "C" "M" "C-M" "C-S")))

(use-package yaml-mode
  :ensure t
  :defer t
  :init
  (setq yaml-indent-offset 2))

(use-package toggle-quotes
  :ensure t
  :bind (("C-'" . toggle-quotes)))

(use-package avy
  :ensure t
  :bind (("C-:" . avy-goto-word-1)))

(use-package mwim
  :ensure t
  :bind (([remap move-beginning-of-line] . mwim-beginning-of-code-or-line)
         ([remap move-end-of-line] . mwim-end-of-code-or-line)))

(use-package goto-chg
  :ensure t
  :bind(("C-," . goto-last-change)))

(use-package multiple-cursors
  :ensure t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("M-C->" . mc/mark-all-like-this)))

(use-package elfeed
  :ensure t
  :bind (("<f12> e" . elfeed)))

(use-package auto-dim-other-buffers
  :ensure t
  :hook ((after-init . auto-dim-other-buffers-mode)))

(use-package go-mode         :ensure t :defer t)
(use-package dockerfile-mode :ensure t :defer t)
(use-package scala-mode      :ensure t :defer t)
(use-package sbt-mode        :ensure t :defer t)
(use-package terraform-mode  :ensure t :defer t)
(use-package json-mode       :ensure t :defer t)

(use-package typescript-mode
  :ensure t
  :defer t
  :config
  (setq typescript-indent-level 2))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :interpreter "node")

(use-package xref-js2
  :ensure t
  :after js2-mode
  :config
  (define-key js2-mode-map (kbd "M-.") nil)
  (add-hook 'js2-mode-hook
            (lambda () (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))
  (setq xref-js2-search-program 'rg)
  (define-key js2-mode-map (kbd "M-.") 'xref-find-definitions)
  (define-key js2-mode-map (kbd "M-,") 'xref-pop-marker-stack))

(use-package rjsx-mode
  :ensure t
  :mode "components\\/.*\\.js\\'"
  :bind (:map rjsx-mode-map
              ("C-d" . my-delete-region-or-line)))

(use-package prettier-js
  :ensure t
  :hook ((typescript-mode . prettier-js-mode)
         (rjsx-mode . prettier-js-mode)
         (js2-mode . prettier-js-mode)
         (json-mode . prettier-js-mode)))

;; needs: aura -A js-beautify
(use-package web-beautify
  :ensure t
  :defer t)

(use-package markdown-mode
  :ensure t
  :defer t
  :config
  ;; $ pacman --sync perl-text-markdown
  (let ((cmd "/usr/bin/vendor_perl/Markdown.pl"))
    (when (file-exists-p cmd)
      (setq markdown-command cmd))))

(use-package java-mode
  :ensure nil
  :bind (:map java-mode-map
              ("C-d" . my-delete-region-or-line)))

(use-package groovy-mode
  :ensure t
  :defer t
  :mode ("build\\.kin\\'" "build\\.gradle\\'" "\\.drw\\'")
  :config
  (bind-keys :map groovy-mode-map
             ("C-d" . my-delete-region-or-line)
             ("M-e" . backward-kill-word)
             ("S-C-r" . my-groovy-rename-class))

  (use-package groovy-imports
    :ensure t
    :config
    (setq groovy-imports-find-block-function 'groovy-imports-find-place-sorted-block)
    (add-hook 'groovy-mode-hook 'groovy-imports-scan-file)
    (bind-keys :map groovy-mode-map
               ("C-M-i" . groovy-imports-add-import-dwim))))

(use-package haskell-mode
  :ensure t
  :defer t
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

  ;; $ cabal install ghc-mod
  (when (file-executable-p "~/.cabal/bin/ghc-mod")
    (add-hook 'haskell-mode-hook (lambda () (ghc-init)))))

(use-package web-mode
  :ensure t
  :mode ("\\.[gj]sp\\'" "\\.html?\\'"))

(use-package cargo
  :ensure t
  :defer t)

(use-package flycheck-rust
  :ensure t
  :defer t)

(use-package racer
  :ensure t
  :defer t
  :init
  (setq racer-rust-src-path "/usr/src/rust/src"))

(use-package rust-mode
  :ensure t
  :hook ((rust-mode . cargo-minor-mode)
         (rust-mode . racer-mode)
         (rust-mode . eldoc-mode))
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package elisp-mode
  :ensure nil
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
  (add-hook 'emacs-lisp-mode-hook 'my-remove-elc-on-save))

(use-package lispy
  :ensure t
  :diminish lispy-mode
  :defer t
  :bind (([remap lispy-move-beginning-of-line] . mwim-beginning-of-code-or-line)
         :map lispy-mode-map
         (("C-d" . my-delete-region-or-line)
          ("M-d" . lispy-delete)
          ("M-e" . lispy-backward-kill-word)
          ("M-r" . lispy-kill-word)))
  :hook ((clojure-mode . lispy-mode)
         (emacs-lisp-mode . lispy-mode)
         (common-lisp-mode . lispy-mode)
         (scheme-mode . lispy-mode)
         (lisp-mode . lispy-mode))
  :init
  (setq lispy-compat '(cider)
        lispy-key-theme '(special parinfer c-digits))
  ;; https://github.com/abo-abo/lispy/pull/403
  ;; temporary to get accustom to lispy
  (advice-add 'delete-selection-pre-hook :around 'lispy--delsel-advice))

(use-package clojure-mode
  :ensure t
  :defer t
  :bind (:map clojure-mode-map
              (("M-c" . my-clojure-copy-qualified-fn)
               ("M-v" . my-clojure-copy-ns)
               ("M-m" . my-hydra-bloom-backend/body)))
  :config
  (defhydra my-hydra-bloom-backend (:color amaranth)
    "Functions"
    ("s" (my-ardoq-backend-start) "Start backend" :exit t)
    ("t" (my-ardoq-backend-stop) "Stop backend" :exit t)
    ("r" (my-ardoq-backend-restart) "Restart backend" :exit t)
    ("p" (my-ardoq-backend-fix-protocols) "Fix protocols" :exit t)
    ("l" (my-ardoq-backend-load-lib) "Load lib.clj" :exit t)
    ("c" (my-clojure-sort-ns) "Sort and clean ns" :exit t)
    ("n" (my-clojure-remove-ns) "Remove ns" :exit t)
    ("q" nil "Quit"))
  (use-package clj-refactor
    :ensure t
    :diminish clj-refactor-mode
    :init
    (setq cljr-warn-on-eval nil
          cljr-eagerly-build-asts-on-startup nil)
    :config
    (cljr-toggle-debug-mode)
    (defun my-clj-refactor-set-keybinding-hook ()
      (cljr-add-keybindings-with-prefix "C-c C-m"))
    (add-hook 'clojure-mode-hook 'clj-refactor-mode)
    (add-hook 'clojure-mode-hook 'my-clj-refactor-set-keybinding-hook))
  (use-package flycheck-clj-kondo
    :ensure t))

(use-package cider
  :ensure t
  :defer t
  :init
  (setq cider-repl-pop-to-buffer-on-connect nil
        cider-repl-use-pretty-printing t
        cider-enrich-classpath t
        ;; M-. should still be cider-find-var
        ;; xref is ok, but with lispy M-. becomes lispy-goto-symbol which doesn't work
        cider-use-xref nil)
  :config
  (add-hook 'cider-mode-hook #'eldoc-mode)
  (add-hook 'cider-mode-hook #'cider-auto-test-mode)
  (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)
  (use-package cider-eval-sexp-fu
    :ensure t)
  (use-package helm-cider
    :ensure t
    :config (helm-cider-mode)))

;;(use-package lsp-mode
;;  :ensure t
;;  :hook (groovy-mode . lsp)
;;  :commands lsp)
;;
;;(use-package lsp-ui
;;  :ensure t
;;  :commands lsp-ui-mode)
;;(use-package company-lsp
;;  :ensure t
;;  :commands company-lsp)
;;(use-package helm-lsp
;;  :ensure t
;;  :commands helm-lsp-workspace-symbol)
