(require 'coffee-mode)
(add-hook 'coffee-mode-hook 'esk-prog-mode-hook)
(define-key coffee-mode-map (kbd "M-r") 'coffee-compile-buffer)
