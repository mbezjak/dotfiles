;;; package-utils-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:

(add-to-list 'load-path (or (and load-file-name (directory-file-name (file-name-directory load-file-name))) (car load-path)))



;;; Generated autoloads from package-utils.el

(autoload 'package-utils-list-upgrades "package-utils" "\
List all packages that can be upgraded.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

Return true if there were packages to install, nil otherwise.

(fn &optional NO-FETCH)" t)
(autoload 'package-utils-upgrade-all "package-utils" "\
Upgrade all packages that can be upgraded.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

Return true if there were packages to install, nil otherwise.

(fn &optional NO-FETCH)" t)
(autoload 'package-utils-upgrade-all-no-fetch "package-utils" "\
Upgrade all packages that can be upgraded without refreshing first.

This skips calling `package-refresh-contents'." t)
(autoload 'package-utils-upgrade-all-and-recompile "package-utils" "\
Upgrade all packages that can be upgraded, and recompile all byte-code.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

(fn &optional NO-FETCH)" t)
(autoload 'package-utils-upgrade-all-and-quit "package-utils" "\
Upgrade all packages that can be upgraded, then quit emacs.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

(fn &optional NO-FETCH)" t)
(autoload 'package-utils-upgrade-all-and-restart "package-utils" "\
Upgrade all packages that can be upgraded, then restart emacs.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

(fn &optional NO-FETCH)" t)
(autoload 'package-utils-upgrade-by-name "package-utils" "\
Upgrade the package NAME.

With prefix argument NO-FETCH, do not call `package-refresh-contents'.

(fn NAME &optional NO-FETCH)" t)
(autoload 'package-utils-upgrade-by-name-no-fetch "package-utils" "\
Upgrade the package NAME, without calling `package-refresh-contents' first.

(fn NAME)" t)
(autoload 'package-utils-remove-by-name "package-utils" "\
Uninstall the package NAME.

(fn NAME)" t)
(register-definition-prefixes "package-utils" '("package-utils-"))

;;; End of scraped data

(provide 'package-utils-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; package-utils-autoloads.el ends here
