;;; lispy-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads "actual autoloads are elsewhere" "le-clojure" "../../../../../.emacs.d/elpa/lispy-0.27.0/le-clojure.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/le-clojure.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "le-clojure" '("lispy-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "le-hy" "../../../../../.emacs.d/elpa/lispy-0.27.0/le-hy.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/le-hy.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "le-hy" '("lispy--")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "le-julia" "../../../../../.emacs.d/elpa/lispy-0.27.0/le-julia.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/le-julia.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "le-julia" '("lispy-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "le-lisp" "../../../../../.emacs.d/elpa/lispy-0.27.0/le-lisp.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/le-lisp.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "le-lisp" '("lispy-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "le-python" "../../../../../.emacs.d/elpa/lispy-0.27.0/le-python.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/le-python.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "le-python" '("lispy-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "le-scheme" "../../../../../.emacs.d/elpa/lispy-0.27.0/le-scheme.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/le-scheme.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "le-scheme" '("lispy-")))

;;;***

;;;### (autoloads nil "lispy" "../../../../../.emacs.d/elpa/lispy-0.27.0/lispy.el"
;;;;;;  "eca8525ddcc5d021cb4826713d03dfc7")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/lispy.el

(autoload 'lispy-mode "lispy" "\
Minor mode for navigating and editing LISP dialects.

If called interactively, enable Lispy mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

When `lispy-mode' is on, most unprefixed keys,
i.e. [a-zA-Z+-./<>], conditionally call commands instead of
self-inserting. The condition (called special further on) is one
of:

- the point is before \"(\"
- the point is after \")\"
- the region is active

For instance, when special, \"j\" moves down one sexp, otherwise
it inserts itself.

When special, [0-9] call `digit-argument'.

When `lispy-mode' is on, \"[\" and \"]\" move forward and
backward through lists, which is useful to move into special.

\\{lispy-mode-map}

\(fn &optional ARG)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "lispy" "../../../../../.emacs.d/elpa/lispy-0.27.0/lispy.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/lispy.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lispy" '("ac-trigger-commands" "hydra-lispy-x" "lh-knight" "lispy-" "mc/cmds-to-run-" "unsupported-mode-error")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "lispy-inline"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/lispy-inline.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/lispy-inline.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lispy-inline" '("lispy-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "lispy-tags" "../../../../../.emacs.d/elpa/lispy-0.27.0/lispy-tags.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/lispy-0.27.0/lispy-tags.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "lispy-tags" '("lispy-")))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/lispy-0.27.0/elpa.el"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/le-clojure.el"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/le-hy.el" "../../../../../.emacs.d/elpa/lispy-0.27.0/le-julia.el"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/le-lisp.el" "../../../../../.emacs.d/elpa/lispy-0.27.0/le-python.el"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/le-scheme.el"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/lispy-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/lispy-inline.el"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/lispy-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/lispy-tags.el"
;;;;;;  "../../../../../.emacs.d/elpa/lispy-0.27.0/lispy.el") (0
;;;;;;  0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; lispy-autoloads.el ends here
