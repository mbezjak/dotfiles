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

      ;; use keys that all in the same row
      aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)

      ;; respect case when inserting into buffer, ignore when searching for candidates
      company-dabbrev-downcase nil
      company-dabbrev-ignore-case 'yes

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
      backup-directory-alist `(("." . ,(my-managed-file "backups")))
      psession-elisp-objects-default-directory (my-managed-file "elisp-objects"))

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
(require 'my-keys)
(load-file (concat user-emacs-directory "lisp/loaddefs.el"))

(my-register-buffer-save-on-focus-out)

(move-text-default-bindings)
(require 'uniquify)
(require 'my-helm)
(require 'my-yasnippet)
(require 'my-lisp)

(add-hook 'after-init-hook #'global-company-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

(use-package
  psession
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

(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

(use-package
  monky
  :init
  (setq monky-process-type 'cmdserver)
  :config
  (set-face-foreground 'monky-diff-add  "green4")
  (set-face-foreground 'monky-diff-del  "red3"))

(use-package
  magit
  :init
  (setq magit-last-seen-setup-instructions "1.4.0"))

(global-diff-hl-mode)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)

(use-package
  anzu
  :diminish anzu-mode
  :config
  (global-anzu-mode +1))

(use-package
  projectile
  :diminish projectile-mode
  :init
  (setq projectile-keymap-prefix (kbd "M-F")
        projectile-completion-system 'helm
        projectile-enable-caching t
        projectile-cache-file (my-managed-file "projectile.cache")
        projectile-known-projects-file (my-managed-file "projectile-bookmarks.eld"))
  :config
  (projectile-global-mode)
  (helm-projectile-on)
  (add-to-list 'projectile-globally-ignored-directories "target")
  (add-to-list 'projectile-globally-ignored-directories "build")
  (add-to-list 'projectile-globally-ignored-files "*.log"))

(use-package
  hippie-exp
  :no-require t
  :config
  (dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially))
    (delete f hippie-expand-try-functions-list))

  ;; Add this back in at the end of the list.
  (add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t))

(use-package
  markdown-mode
  :no-require t
  :config
  ;; To use:
  ;; $ pacman --sync perl-text-markdown
  (let ((cmd "/usr/bin/vendor_perl/Markdown.pl"))
    (when (file-exists-p cmd)
      (setq markdown-command cmd))))

(use-package
  coffee-mode
  :no-require t
  :config
  (bind-key "M-r" 'coffee-compile-buffer coffee-mode-map))


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

(use-package
  groovy-mode
  :no-require t
  :mode "build\\.kin\\'"
  :config
  (add-hook 'groovy-mode-hook 'my-groovy-offset-fixes))

(use-package
  scala-mode2
  :no-require t
  :config
  (require 'ensime)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

(use-package
  haskell-mode
  :no-require t
  :config
  (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

  ;; To use:
  ;; $ cabal install ghc-mod
  (when (file-executable-p "~/.cabal/bin/ghc-mod")
    (add-hook 'haskell-mode-hook (lambda () (ghc-init)))))
