;;; sesman-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "sesman" "../../../../../.emacs.d/elpa/sesman-0.3.4/sesman.el"
;;;;;;  "f1bb690500ca502dea4362088f1ccb46")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/sesman-0.3.4/sesman.el

(autoload 'sesman-start "sesman" "\
Start a Sesman session.

\(fn)" t nil)

(autoload 'sesman-restart "sesman" "\
Restart sesman session.
When WHICH is nil, restart the current session; when a single universal
argument or 'linked, restart all linked sessions; when a double universal
argument, t or 'all, restart all sessions. For programmatic use, WHICH can also
be a session or a name of the session, in which case that session is restarted.

\(fn &optional WHICH)" t nil)

(autoload 'sesman-quit "sesman" "\
Terminate a Sesman session.
When WHICH is nil, kill only the current session; when a single universal
argument or 'linked, kill all linked sessions; when a double universal argument,
t or 'all, kill all sessions. For programmatic use, WHICH can also be a session
or a name of the session, in which case that session is killed.

\(fn &optional WHICH)" t nil)

(autoload 'sesman-info "sesman" "\
Display info for all current sessions (`sesman-current-sessions').
In the resulting minibuffer display linked sessions are numbered and the
other (friendly) sessions are not. When ALL is non-nil, show info for all
sessions.

\(fn &optional ALL)" t nil)

(autoload 'sesman-link-with-buffer "sesman" "\
Ask for SESSION and link with BUFFER.
BUFFER defaults to current buffer. On universal argument, or if BUFFER is 'ask,
ask for buffer.

\(fn &optional BUFFER SESSION)" t nil)

(autoload 'sesman-link-with-directory "sesman" "\
Ask for SESSION and link with DIR.
DIR defaults to `default-directory'. On universal argument, or if DIR is 'ask,
ask for directory.

\(fn &optional DIR SESSION)" t nil)

(autoload 'sesman-link-with-project "sesman" "\
Ask for SESSION and link with PROJECT.
PROJECT defaults to current project. On universal argument, or if PROJECT is
'ask, ask for the project. SESSION defaults to the current session.

\(fn &optional PROJECT SESSION)" t nil)

(autoload 'sesman-link-with-least-specific "sesman" "\
Ask for SESSION and link with the least specific context available.
Normally the least specific context is the project. If not in a project, link
with the `default-directory'. If `default-directory' is nil, link with current
buffer.

\(fn &optional SESSION)" t nil)

(autoload 'sesman-unlink "sesman" "\
Break any of the previously created links.

\(fn)" t nil)
 (autoload 'sesman-map "sesman" "Session management prefix keymap." t 'keymap)

;;;### (autoloads "actual autoloads are elsewhere" "sesman" "../../../../../.emacs.d/elpa/sesman-0.3.4/sesman.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/sesman-0.3.4/sesman.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sesman" '("sesman-")))

;;;***

;;;***

;;;### (autoloads nil "sesman-browser" "../../../../../.emacs.d/elpa/sesman-0.3.4/sesman-browser.el"
;;;;;;  "8a326eebce1a4015760a03cacebd5fa3")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/sesman-0.3.4/sesman-browser.el

(autoload 'sesman-browser "sesman-browser" "\
Display an interactive session browser.
See `sesman-browser-mode' for more details.

\(fn)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "sesman-browser"
;;;;;;  "../../../../../.emacs.d/elpa/sesman-0.3.4/sesman-browser.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/sesman-0.3.4/sesman-browser.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "sesman-browser" '("sesman-")))

;;;***

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/sesman-0.3.4/sesman-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/sesman-0.3.4/sesman-browser.el"
;;;;;;  "../../../../../.emacs.d/elpa/sesman-0.3.4/sesman-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/sesman-0.3.4/sesman.el") (0
;;;;;;  0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; sesman-autoloads.el ends here
