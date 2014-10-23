;;;###autoload
(define-derived-mode gradle-mode groovy-mode
  "Gradle"
  "Major mode for editing build.gradle.")

;;;###autoload
(add-to-list 'auto-mode-alist '("build\\.gradle\\'" . gradle-mode))


(provide 'gradle-mode)
