(when (file-executable-p "~/.cabal/bin/ghc-mod")
  (add-hook 'haskell-mode-hook (lambda () (ghc-init))))
