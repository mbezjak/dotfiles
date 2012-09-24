(require 'monky)

(set-face-foreground 'monky-diff-add "green4")
(set-face-foreground 'monky-diff-del "red3")

(setq monky-process-type 'cmdserver)
(global-set-key (kbd "C-c h") 'monky-status)
