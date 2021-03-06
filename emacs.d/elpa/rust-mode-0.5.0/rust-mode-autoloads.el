;;; rust-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "rust-mode" "../../../../../.emacs.d/elpa/rust-mode-0.5.0/rust-mode.el"
;;;;;;  "2b48d68ce4f2c2c22d4cf41a86f00750")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rust-mode-0.5.0/rust-mode.el

(autoload 'rust-mode "rust-mode" "\
Major mode for Rust code.

\\{rust-mode-map}

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

(autoload 'rust-dbg-wrap-or-unwrap "rust-mode" "\
Either remove or add the dbg! macro." t nil)

;;;### (autoloads "actual autoloads are elsewhere" "rust-mode" "../../../../../.emacs.d/elpa/rust-mode-0.5.0/rust-mode.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/rust-mode-0.5.0/rust-mode.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "rust-mode" '("cargo-compilation-regexps" "rust")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/rust-mode-0.5.0/rust-mode-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/rust-mode-0.5.0/rust-mode.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; rust-mode-autoloads.el ends here
