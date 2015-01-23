(require 'helm)
(require 'helm-config)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z") 'helm-select-action) ; list potential actions

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-]") 'helm-find-files)
(global-set-key (kbd "M-<f8>") 'helm-for-files)

(setq history-length 100 ; determines file-name-history; see helm-ff-file-name-history-use-recentf
      helm-for-files-preferred-list '(helm-source-buffers-list
                                      helm-source-recentf
                                      helm-source-bookmarks
                                      helm-source-file-cache
                                      helm-source-files-in-current-dir))

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))


(helm-mode 1)

(provide 'my-helm)
