;; disable early in initialization to avoid flicker
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(column-number-mode t)
(setq-default tab-width 4
              c-basic-offset 4
              fill-column 80)

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
