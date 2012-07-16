(add-hook 'coffee-mode-hook 'esk-prog-mode-hook)
(define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
