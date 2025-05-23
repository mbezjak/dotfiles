;;; git-link-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from git-link.el

(autoload 'git-link "git-link" "\
Create a URL representing the current buffer's location in its
GitHub/Bitbucket/GitLab/... repository at the current line number
or active region. The URL will be added to the kill ring.  If
`git-link-open-in-browser' is non-nil also call `browse-url'.

With a prefix argument of - generate a link without line number(s).
Also see `git-link-use-single-line-number'.

With a single prefix argument prompt for the remote's name.
Defaults to \"origin\".

With a double prefix argument invert the value of
`git-link-use-commit'.

(fn REMOTE START END)" t)
(autoload 'git-link-commit "git-link" "\
Create a URL representing the commit for the hash under point
in the current buffer's GitHub/Bitbucket/GitLab/...
repository. The URL will be added to the kill ring.

With a prefix argument prompt for the remote's name.
Defaults to \"origin\".

(fn REMOTE)" t)
(autoload 'git-link-homepage "git-link" "\
Create a URL representing the homepage of the current
buffer's GitHub/Bitbucket/GitLab/... repository.  The URL will be
added to the kill ring.  If `git-link-open-in-browser' is non-nil
or if you pass the double prefix (Ctrl-u Ctrl-u), then also call
`browse-url'.

With a prefix argument prompt for the remote's name.
Defaults to \"origin\".

(fn REMOTE)" t)
(register-definition-prefixes "git-link" '("git-link-"))


;;; Generated autoloads from git-link-transient.el

 (autoload 'git-link-dispatch "git-link-transient" nil t)
(register-definition-prefixes "git-link-transient" '("git-link-"))

;;; End of scraped data

(provide 'git-link-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; git-link-autoloads.el ends here
