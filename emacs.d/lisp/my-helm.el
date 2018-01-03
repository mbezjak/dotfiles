(use-package helm :ensure t)
(use-package helm-descbinds :ensure t)

(require 'helm-files)
(require 'helm-config)

(setq history-length 100 ; determines file-name-history; see helm-ff-file-name-history-use-recentf
      helm-always-two-windows t
      helm-split-window-default-side 'right)

(when (executable-find "curl")
  (setq helm-net-prefer-curl t))

(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

(helm-mode 1)
(helm-descbinds-mode)
(diminish 'helm-mode)

(provide 'my-helm)
