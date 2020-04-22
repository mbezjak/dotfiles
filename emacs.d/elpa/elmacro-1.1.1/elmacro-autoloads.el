;;; elmacro-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "elmacro" "../../../../../.emacs.d/elpa/elmacro-1.1.1/elmacro.el"
;;;;;;  "d29a51e47b3eb418da654d790c707f08")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elmacro-1.1.1/elmacro.el

(autoload 'elmacro-show-last-macro "elmacro" "\
Show the last macro as emacs lisp with NAME.

\(fn NAME)" t nil)

(autoload 'elmacro-show-last-commands "elmacro" "\
Take the latest COUNT commands and show them as emacs lisp.

This is basically a better version of `kmacro-edit-lossage'.

The default number of commands shown is modifiable in variable
`elmacro-show-last-commands-default'.

You can also modify this number by using a numeric prefix argument or
by using the universal argument, in which case it'll ask for how many
in the minibuffer.

\(fn &optional COUNT)" t nil)

(autoload 'elmacro-clear-command-history "elmacro" "\
Clear the list of recorded commands.

\(fn)" t nil)

(defvar elmacro-mode nil "\
Non-nil if elmacro mode is enabled.
See the `elmacro-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `elmacro-mode'.")

(custom-autoload 'elmacro-mode "elmacro" nil)

(autoload 'elmacro-mode "elmacro" "\
Toggle emacs activity recording (elmacro mode).
With a prefix argument ARG, enable elmacro mode if ARG is
positive, and disable it otherwise. If called from Lisp, enable
the mode if ARG is omitted or nil.

\(fn &optional ARG)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "elmacro" "../../../../../.emacs.d/elpa/elmacro-1.1.1/elmacro.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elmacro-1.1.1/elmacro.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elmacro" '("elmacro-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/elmacro-1.1.1/elmacro-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/elmacro-1.1.1/elmacro.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; elmacro-autoloads.el ends here
