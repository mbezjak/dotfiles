;;; pacfiles-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "pacfiles-buttons" "pacfiles-buttons.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from pacfiles-buttons.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pacfiles-buttons" '("pacfiles-")))

;;;***

;;;### (autoloads nil "pacfiles-mode" "pacfiles-mode.el" (0 0 0 0))
;;; Generated autoloads from pacfiles-mode.el

(defalias 'pacfiles 'pacfiles-start)

(autoload 'pacfiles-start "pacfiles-mode" "\
Find and manage pacman backup files in an Arch-based GNU/Linux system.

\(fn)" t nil)

(autoload 'pacfiles-revert-buffer-no-confirm "pacfiles-mode" "\
Revert the pacfiles list buffer without asking for confirmation.

\(fn)" t nil)

(autoload 'pacfiles-mode "pacfiles-mode" "\


\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pacfiles-mode" '("pacfiles-")))

;;;***

;;;### (autoloads nil "pacfiles-utils" "pacfiles-utils.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from pacfiles-utils.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pacfiles-utils" '("pacfiles--")))

;;;***

;;;### (autoloads nil "pacfiles-win" "pacfiles-win.el" (0 0 0 0))
;;; Generated autoloads from pacfiles-win.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "pacfiles-win" '("pacfiles-")))

;;;***

;;;### (autoloads nil nil ("pacfiles-mode-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pacfiles-mode-autoloads.el ends here
