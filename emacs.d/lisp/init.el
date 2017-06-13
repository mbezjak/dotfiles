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


(make-directory "~/.emacs.d/var" 'parents)
(defun my-var-file (name)
  "Create a file path where var files are put."
  (concat user-emacs-directory "var/" name))

(setq custom-file (my-var-file "custom.el")
      recentf-save-file (my-var-file "recentf")
      auto-save-list-file-prefix (my-var-file "auto-save-list/saves-")
      bookmark-default-file (my-var-file "bookmarks")
      url-configuration-directory (my-var-file "url/")
      eshell-directory-name (my-var-file "eshell/")
      save-place-file (my-var-file "places")
      backup-directory-alist `(("." . ,(my-var-file "backups")))
      ensime-startup-dirname (my-var-file "ensime"))

(when (file-exists-p custom-file)
  (load custom-file))


(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'dash)
(require 's)
(require 'f)
(require 'use-package)

;; my-stuff
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(require 'my-functions)
(require 'my-org)
(require 'my-dev)
(move-text-default-bindings)
(require 'uniquify)
(require 'my-helm)
(require 'my-yasnippet)
(require 'my-lisp)

(require 'my-keys)

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
  (setq psession-elisp-objects-default-directory (my-var-file "elisp-objects")
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
  (setq keyfreq-file (my-var-file "keyfreq")
        keyfreq-file-lock (my-var-file "keyfreq.lock"))
  :config
  (keyfreq-mode)
  (keyfreq-autosave-mode))

(use-package diff-mode
  :no-require t
  :config
  (set-face-foreground 'diff-added "green4")
  (set-face-foreground 'diff-removed "red3"))

(use-package monky
  :init
  (setq monky-process-type 'cmdserver)
  :config
  (set-face-foreground 'monky-diff-add  "green4")
  (set-face-foreground 'monky-diff-del  "red3"))

(use-package magit
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
        projectile-enable-caching t
        projectile-cache-file (my-var-file "projectile.cache")
        projectile-known-projects-file (my-var-file "projectile-bookmarks.eld"))
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
  :no-require t
  :config
  ;; To use:
  ;; $ pacman --sync perl-text-markdown
  (let ((cmd "/usr/bin/vendor_perl/Markdown.pl"))
    (when (file-exists-p cmd)
      (setq markdown-command cmd))))

(use-package coffee-mode
  :no-require t
  :config
  (bind-keys :map coffee-mode-map
             ("M-C" . coffee-compile-buffer)
             ("S-C-r" . my-coffee-rename-fn)))


(defun my-groovy-offset-fixes ()
  "Fixes quirks with indentation. This is still not 100% ok, but it works more
times than not.

NOTE: in order to see syntactic information:
1. move point to an interesting location
2. M-x c-show-syntactic-information RET

The rest can be loaded into groovy-mode buffer and tested by indenting the
whole buffer:
--------------------------------------------------------------------------------

// the following code should be properly indented
def map = [
    a:1,
    b:2
]

fn(
    a:1,
    b:2
)

fn [
    a:1,
    b:2
]

fn([
    a:1,
    b:2
])

fn 'a', 'b', [
    a:1,
    b:2
]

def fn = {
    [
        a:1,
        b:2
    ]
}

def \"spock spec\"() {
    setup:
    def map = [
        a:1,
        b:2
    ]

    expect:
    map.a == 1
    map.b == 2
}

dsl {
    a = 1
    b = 2
    map = [
        a:1,
        b:2
    ]
}

// this following code currently doesn't work, but such code is used less often
fn(a:1,
b:2)

fn 'a',
'b'

fn 'a', 'b',
a:1,
b:2
"
  (setq c-recognize-colon-labels nil)
  (c-set-offset 'arglist-cont-nonempty 0))

(use-package groovy-mode
  :no-require t
  :mode "build\\.kin\\'"
  :config
  (add-hook 'groovy-mode-hook 'my-groovy-offset-fixes)
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
  :no-require t
  :diminish gommons-mode)

(use-package scala-mode
  :no-require t
  :config
  (require 'ensime)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

(use-package haskell-mode
  :no-require t
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
  :config
  (which-key-mode))

(use-package dumb-jump
  :config
  (dumb-jump-mode)
  (setq dumb-jump-selector 'helm))

(use-package helpful
  :bind (("C-h F" . helpful-function)))
