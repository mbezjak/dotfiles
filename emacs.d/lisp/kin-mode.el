;;;###autoload
(define-derived-mode kin-mode groovy-mode
  "kin"
  "Major mode for editing build.kin.")

;;;###autoload
(add-to-list 'auto-mode-alist '("build\\.kin\\'" . kin-mode))


(provide 'kin-mode)
