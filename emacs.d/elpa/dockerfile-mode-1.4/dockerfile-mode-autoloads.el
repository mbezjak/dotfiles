;;; dockerfile-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "dockerfile-mode" "../../../../../.emacs.d/elpa/dockerfile-mode-1.4/dockerfile-mode.el"
;;;;;;  "4338b670c712304da6586c1c83d46fa3")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/dockerfile-mode-1.4/dockerfile-mode.el

(autoload 'dockerfile-build-buffer "dockerfile-mode" "\
Build an image called IMAGE-NAME based upon the buffer.

If prefix arg NO-CACHE is set, don't cache the image.
The build string will be of the format:
`sudo docker build --no-cache --tag IMAGE-NAME --build-args arg1.. -f filename directory`

\(fn IMAGE-NAME &optional NO-CACHE)" t nil)

(autoload 'dockerfile-build-no-cache-buffer "dockerfile-mode" "\
Build an image called IMAGE-NAME based upon the buffer without cache.

\(fn IMAGE-NAME)" t nil)

(autoload 'dockerfile-mode "dockerfile-mode" "\
A major mode to edit Dockerfiles.
\\{dockerfile-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("/Dockerfile\\(?:\\..*\\)?\\'" . dockerfile-mode))

(add-to-list 'auto-mode-alist '("\\.dockerfile\\'" . dockerfile-mode))

;;;### (autoloads "actual autoloads are elsewhere" "dockerfile-mode"
;;;;;;  "../../../../../.emacs.d/elpa/dockerfile-mode-1.4/dockerfile-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/dockerfile-mode-1.4/dockerfile-mode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "dockerfile-mode" '("dockerfile-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/dockerfile-mode-1.4/dockerfile-mode-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/dockerfile-mode-1.4/dockerfile-mode.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; dockerfile-mode-autoloads.el ends here