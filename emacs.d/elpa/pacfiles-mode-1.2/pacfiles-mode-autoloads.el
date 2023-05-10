;;; pacfiles-mode-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "pacfiles-automerge" "pacfiles-automerge.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from pacfiles-automerge.el

(autoload 'pacfiles--automerge-available "pacfiles-automerge" "\
Return the function that knows how to merge UPDATE-FILE if it exists.

UPDATE-FILE searches for matches in `pacfiles--automerge-alist'. If a match is
found, return a function, otherwise return nil.

\(fn UPDATE-FILE)" nil nil)

(autoload 'pacfiles--automerge-mirrorlist "pacfiles-automerge" "\
Automatically merge the mirrorlist in BASE-FILE into UPDATE-FILE.

\(fn BASE-FILE UPDATE-FILE)" nil nil)

(autoload 'pacfiles--find-mirrorlist-servers "pacfiles-automerge" "\
Find the activated servers (i.e., those uncommented) in BASE-BUFFER.

\(fn BASE-BUFFER)" nil nil)

(autoload 'pacfiles--create-mirrorlist-merge-buffer "pacfiles-automerge" "\
Ready up the merge buffer for the mirrorlist.

The MIRRORLIST-UPDATE-FILE is the path of the original mirrorlist. UPDATE-BUFFER
is the buffer with the updated mirrorlist. Return the buffer of the merged file.

\(fn MIRRORLIST-UPDATE-FILE UPDATE-BUFFER)" nil nil)

(autoload 'pacfiles--merge-mirrorlist-servers "pacfiles-automerge" "\
Automatically merge the mirrorlist update in MIRRORLIST-UPDATE-FILE.

Merge the uncommented lines in SERVERS that exist in UPDATE-BUFFER.

\(fn SERVERS MIRRORLIST-UPDATE-FILE UPDATE-BUFFER)" nil nil)

(register-definition-prefixes "pacfiles-automerge" '("pacfiles--automerge-alist"))

;;;***

;;;### (autoloads nil "pacfiles-buttons" "pacfiles-buttons.el" (0
;;;;;;  0 0 0))
;;; Generated autoloads from pacfiles-buttons.el

(register-definition-prefixes "pacfiles-buttons" '("pacfiles-"))

;;;***

;;;### (autoloads nil "pacfiles-mode" "pacfiles-mode.el" (0 0 0 0))
;;; Generated autoloads from pacfiles-mode.el

(defalias 'pacfiles 'pacfiles-start)

(autoload 'pacfiles-start "pacfiles-mode" "\
Find and manage pacman backup files in an Arch-based GNU/Linux system." t nil)

(autoload 'pacfiles-quit "pacfiles-mode" "\
Quit ‘pacfiles-mode’ and restore the previous window and ediff configuration." t nil)

(autoload 'pacfiles-revert-buffer "pacfiles-mode" "\
Populate the ‘pacfiles-mode’ buffer with .pacnew and .pacsave files.

Ignore IGNORE-AUTO but take into account NOCONFIRM.

\(fn &optional IGNORE-AUTO NOCONFIRM)" t nil)

(autoload 'pacfiles-revert-buffer-no-confirm "pacfiles-mode" "\
Revert the pacfiles list buffer without asking for confirmation." t nil)

(autoload 'pacfiles-mode "pacfiles-mode" "\


\(fn)" t nil)

(register-definition-prefixes "pacfiles-mode" '("pacfiles-"))

;;;***

;;;### (autoloads nil "pacfiles-utils" "pacfiles-utils.el" (0 0 0
;;;;;;  0))
;;; Generated autoloads from pacfiles-utils.el

(register-definition-prefixes "pacfiles-utils" '("pacfiles--"))

;;;***

;;;### (autoloads nil "pacfiles-win" "pacfiles-win.el" (0 0 0 0))
;;; Generated autoloads from pacfiles-win.el

(register-definition-prefixes "pacfiles-win" '("pacfiles-"))

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
