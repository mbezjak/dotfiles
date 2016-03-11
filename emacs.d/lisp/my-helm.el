(require 'helm)
(require 'helm-files)
(require 'helm-config)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ; list potential actions
(define-key helm-map (kbd "<escape>") 'helm-keyboard-quit)

(bind-key "M-x" 'helm-M-x)
(bind-key "M-y" 'helm-show-kill-ring)
(bind-key "M-[" 'helm-projectile-find-file)
(bind-key "M-]" 'projectile-switch-project)
(bind-key "C-M-]" 'helm-find-files)
(bind-key "M-<f8>" 'helm-for-files)
(bind-key "C-x C-i" 'helm-semantic-or-imenu)
(bind-key "M-o" 'helm-swoop)
(bind-key "C-x C-f" 'helm-find-files)

(define-key isearch-mode-map (kbd "M-o") 'helm-occur-from-isearch)
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

(define-key helm-find-files-map (kbd "M-l") 'helm-find-files-up-one-level)

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
