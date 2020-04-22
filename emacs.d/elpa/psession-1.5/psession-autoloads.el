;;; psession-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "psession" "psession.el" (0 0 0 0))
;;; Generated autoloads from psession.el

(autoload 'psession-save-winconf "psession" "\
Save persistently current window config to PLACE.
Arg PLACE is the key of an entry in `psession--winconf-alist'.

\(fn PLACE)" t nil)

(autoload 'psession-restore-winconf "psession" "\
Restore window config CONF.
Arg CONF is an entry in `psession--winconf-alist'.

\(fn CONF)" t nil)

(autoload 'psession-delete-winconf "psession" "\
Delete window config CONF from `psession--winconf-alist'.

\(fn CONF)" t nil)

(defvar psession-savehist-mode nil "\
Non-nil if Psession-Savehist mode is enabled.
See the `psession-savehist-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `psession-savehist-mode'.")

(custom-autoload 'psession-savehist-mode "psession" nil)

(autoload 'psession-savehist-mode "psession" "\
Save minibuffer-history variables persistently.

\(fn &optional ARG)" t nil)

(defvar psession-autosave-mode nil "\
Non-nil if Psession-Autosave mode is enabled.
See the `psession-autosave-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `psession-autosave-mode'.")

(custom-autoload 'psession-autosave-mode "psession" nil)

(autoload 'psession-autosave-mode "psession" "\
Auto save emacs session when enabled.

\(fn &optional ARG)" t nil)

(defvar psession-mode nil "\
Non-nil if Psession mode is enabled.
See the `psession-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `psession-mode'.")

(custom-autoload 'psession-mode "psession" nil)

(autoload 'psession-mode "psession" "\
Persistent emacs sessions.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "psession" '("psession-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; psession-autoloads.el ends here
