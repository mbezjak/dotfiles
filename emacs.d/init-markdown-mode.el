;; To use:
;; $ pacman --sync perl-text-markdown
(let*  ((cmd "/usr/bin/vendor_perl/Markdown.pl"))
  (when (file-exists-p cmd)
    (setq markdown-command cmd)))

(add-to-list 'auto-mode-alist
             '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode))
