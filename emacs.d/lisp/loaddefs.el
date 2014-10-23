;;; loaddefs.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (gommons-mode) "gommons-mode" "gommons-mode.el"
;;;;;;  (20862 11732 760713 328000))
;;; Generated autoloads from gommons-mode.el

(autoload 'gommons-mode "gommons-mode" "\
Toggle gommons mode.

The following commands are available:
\\{gommons-key-map}

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads (gradle-mode) "gradle-mode" "gradle-mode.el" (20780
;;;;;;  35089 375866 475000))
;;; Generated autoloads from gradle-mode.el

(autoload 'gradle-mode "gradle-mode" "\
Major mode for editing build.gradle.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("build\\.gradle\\'" . gradle-mode))

;;;***

;;;### (autoloads (kin-mode) "kin-mode" "kin-mode.el" (20874 6552
;;;;;;  751551 873000))
;;; Generated autoloads from kin-mode.el

(autoload 'kin-mode "kin-mode" "\
Major mode for editing build.kin.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("build\\.kin\\'" . kin-mode))

;;;***

;;;### (autoloads (sbt-mode) "sbt-mode" "sbt-mode.el" (20880 55872
;;;;;;  41340 985000))
;;; Generated autoloads from sbt-mode.el

(autoload 'sbt-mode "sbt-mode" "\
Major mode for editing build.sbt.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.sbt\\'" . sbt-mode))

;;;***

;;;### (autoloads nil nil ("bmk-bmenu-state.el" "custom.el" "init.el"
;;;;;;  "my-dev.el" "my-functions.el" "my-keys.el" "my-org.el" "my-packages.el"
;;;;;;  "my-yasnippet.el") (20880 55888 484019 579000))

;;;***

(provide 'loaddefs)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; loaddefs.el ends here
