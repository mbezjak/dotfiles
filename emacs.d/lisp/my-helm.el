(require 'helm)
(require 'helm-files)
(require 'helm-config)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ; list potential actions

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-[") 'helm-projectile-find-file)
(global-set-key (kbd "M-]") 'projectile-switch-project)
(global-set-key (kbd "C-M-]") 'helm-find-files)
(global-set-key (kbd "M-<f8>") 'helm-for-files)
(global-set-key (kbd "C-x C-i") 'helm-semantic-or-imenu)
(global-set-key (kbd "M-o") 'helm-occur)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

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
  (setq helm-google-suggest-use-curl-p t))

(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

(helm-mode 1)
(helm-descbinds-mode)

(provide 'my-helm)
