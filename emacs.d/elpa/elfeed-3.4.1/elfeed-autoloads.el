;;; elfeed-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "elfeed" "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed.el"
;;;;;;  "37093bbce45c114ac14c23de08226fbc")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed.el

(autoload 'elfeed-update "elfeed" "\
Update all the feeds in `elfeed-feeds'." t nil)

(autoload 'elfeed "elfeed" "\
Enter elfeed." t nil)

(autoload 'elfeed-load-opml "elfeed" "\
Load feeds from an OPML file into `elfeed-feeds'.
When called interactively, the changes to `elfeed-feeds' are
saved to your customization file.

\(fn FILE)" t nil)

(autoload 'elfeed-export-opml "elfeed" "\
Export the current feed listing to OPML-formatted FILE.

\(fn FILE)" t nil)

;;;### (autoloads "actual autoloads are elsewhere" "elfeed" "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elfeed" '("elfeed-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "elfeed-csv" "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-csv.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-csv.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elfeed-csv" '("elfeed-csv-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "elfeed-curl"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-curl.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-curl.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elfeed-curl" '("elfeed-curl-")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "elfeed-db" "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-db.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-db.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elfeed-db" '("elfeed-" "with-elfeed-db-visit")))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "elfeed-lib" "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-lib.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-lib.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elfeed-lib" '("elfeed-")))

;;;***

;;;### (autoloads nil "elfeed-link" "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-link.el"
;;;;;;  "edede7313d9cd9fa45f9675cb87290d5")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-link.el

(autoload 'elfeed-link-store-link "elfeed-link" "\
Store a link to an elfeed search or entry buffer.

When storing a link to an entry, automatically extract all the
entry metadata.  These can be used in the capture templates as
%:elfeed-entry-<prop>.  See `elfeed-entry--create' for the list
of available props." nil nil)

(autoload 'elfeed-link-open "elfeed-link" "\
Jump to an elfeed entry or search.

Depending on what FILTER-OR-ID looks like, we jump to either
search buffer or show a concrete entry.

\(fn FILTER-OR-ID)" nil nil)

(eval-after-load 'org `(funcall ',(lambda nil (if (version< (org-version) "9.0") (with-no-warnings (org-add-link-type "elfeed" #'elfeed-link-open) (add-hook 'org-store-link-functions #'elfeed-link-store-link)) (with-no-warnings (org-link-set-parameters "elfeed" :follow #'elfeed-link-open :store #'elfeed-link-store-link))))))

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "elfeed-log" "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-log.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-log.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elfeed-log" '("elfeed-log")))

;;;***

;;;### (autoloads nil "elfeed-search" "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-search.el"
;;;;;;  "6a7d1c21b6f7dbe98c1f771ba79e5722")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-search.el

(autoload 'elfeed-search-bookmark-handler "elfeed-search" "\
Jump to an elfeed-search bookmarked location.

\(fn RECORD)" nil nil)

(autoload 'elfeed-search-desktop-restore "elfeed-search" "\
Restore the state of an elfeed-search buffer on desktop restore.

\(fn FILE-NAME BUFFER-NAME SEARCH-FILTER)" nil nil)

(add-to-list 'desktop-buffer-mode-handlers '(elfeed-search-mode . elfeed-search-desktop-restore))

;;;### (autoloads "actual autoloads are elsewhere" "elfeed-search"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-search.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-search.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elfeed-search" '("elfeed-s")))

;;;***

;;;***

;;;### (autoloads nil "elfeed-show" "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-show.el"
;;;;;;  "a6070a38b199d69bc7ee0567d14aefec")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-show.el

(autoload 'elfeed-show-bookmark-handler "elfeed-show" "\
Show the bookmarked entry saved in the `RECORD'.

\(fn RECORD)" nil nil)

;;;### (autoloads "actual autoloads are elsewhere" "elfeed-show"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-show.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-show.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "elfeed-show" '("elfeed-")))

;;;***

;;;***

;;;### (autoloads "actual autoloads are elsewhere" "xml-query" "../../../../../.emacs.d/elpa/elfeed-3.4.1/xml-query.el"
;;;;;;  (0 0 0 0))
;;; Generated autoloads from ../../../../../.emacs.d/elpa/elfeed-3.4.1/xml-query.el

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "xml-query" '("xml-query")))

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-csv.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-curl.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-db.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-lib.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-link.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-log.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-pkg.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-search.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed-show.el"
;;;;;;  "../../../../../.emacs.d/elpa/elfeed-3.4.1/elfeed.el" "../../../../../.emacs.d/elpa/elfeed-3.4.1/xml-query.el")
;;;;;;  (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; elfeed-autoloads.el ends here
