(require 'helm)
(require 'helm-files)
(require 'helm-config)

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
