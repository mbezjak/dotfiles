(add-hook 'haskell-mode-hook 'esk-prog-mode-hook)
(add-hook 'haskell-mode-hook
	  (lambda ()
	    (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
