;;;###autoload
(define-derived-mode sbt-mode scala-mode
  "SBT"
  "Major mode for editing build.sbt.")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.sbt\\'" . sbt-mode))


(provide 'sbt-mode)
