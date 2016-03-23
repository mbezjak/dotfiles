(require 'helm)
(require 'helm-files)
(require 'helm-config)

(bind-keys ("M-x" . helm-M-x)
           ("M-y" . helm-show-kill-ring)
           ("M-[" . helm-projectile-find-file)
           ("M-]" . projectile-switch-project)
           ("C-M-]" . helm-find-files)
           ("M-<f8>" . helm-for-files)
           ("C-x C-i" . helm-semantic-or-imenu)
           ("M-i" . helm-swoop)
           ("C-x C-f" . helm-find-files))

(bind-keys :map helm-map
           ("<tab>" . helm-execute-persistent-action)
           ("C-i" . helm-execute-persistent-action) ; make TAB work in terminal
           ("C-z" . helm-select-action)
           ("<escape>" . helm-keyboard-quit))

(bind-keys :map helm-find-files-map
           ("M-l" . helm-find-files-up-one-level))

(bind-keys :map isearch-mode-map
           ("M-o" . helm-occur-from-isearch)
           ("M-i" . helm-swoop-from-isearch))

(eval-after-load 'helm-swoop
  '(bind-keys :map helm-swoop-map
              ("M-k" . helm-next-line)
              ("M-o" . helm-previous-line)))

(setq history-length 100 ; determines file-name-history; see helm-ff-file-name-history-use-recentf
      helm-always-two-windows t
      helm-split-window-default-side 'right
      helm-for-files-preferred-list '(helm-source-buffers-list
                                      helm-source-recentf
                                      helm-source-bookmarks
                                      helm-source-file-cache
                                      helm-source-files-in-current-dir))

(when (executable-find "curl")
  (setq helm-net-prefer-curl t))

(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

(helm-mode 1)
(helm-descbinds-mode)

(provide 'my-helm)
