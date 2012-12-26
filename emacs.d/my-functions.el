(require 'mm-url) ; to include mm-url-decode-entities-string

;; from http://www.emacswiki.org/emacs/KeyboardMacros
;; and  http://stackoverflow.com/questions/6003666/one-key-macros-in-emacs
(defun toggle-kbd-macro-recording-on ()
  "One-key keyboard macros: turn recording on."
  (interactive)
  (define-key global-map (this-command-keys) 'toggle-kbd-macro-recording-off)
  (start-kbd-macro nil))

(defun toggle-kbd-macro-recording-off ()
  "One-key keyboard macros: turn recording off."
  (interactive)
  (define-key global-map (this-command-keys) 'toggle-kbd-macro-recording-on)
  (end-kbd-macro))


(defun my-get-html-title-from-url (url)
  "Return content in <title> tag."
  (let (x1 x2 (download-buffer (url-retrieve-synchronously url)))
    (save-excursion
      (set-buffer download-buffer)
      (beginning-of-buffer)
      (setq x1 (search-forward "<title>"))
      (search-forward "</title>")
      (setq x2 (search-backward "<"))
      (mm-url-decode-entities-string (buffer-substring-no-properties x1 x2)))))

(defun my-find-file-in-dir (dir)
  "Find file in DIR. Don't use filename or url at point."
  (let ((ido-use-filename-at-point nil)
        (ido-use-url-at-point nil))
    (ido-find-file-in-dir dir)))


(provide 'my-functions)
