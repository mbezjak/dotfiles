;;; helm-rg-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "helm-rg" "helm-rg.el" (0 0 0 0))
;;; Generated autoloads from helm-rg.el

(autoload 'helm-rg "helm-rg" "\
Search for the perl regexp RG-PATTERN extremely quickly with ripgrep.

\\{helm-rg-map}

\(fn RG-PATTERN &optional PFX)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "helm-rg" '("helm-rg-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; helm-rg-autoloads.el ends here
