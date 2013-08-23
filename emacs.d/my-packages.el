(setq my-packages
      '(paredit
        idle-highlight-mode
        find-file-in-project
        smex
        ido-ubiquitous
        magit
        monky
        starter-kit
        starter-kit-bindings
        starter-kit-eshell
        starter-kit-lisp
        haskell-mode
        ghc
        coffee-mode
        groovy-mode
        scala-mode
        js2-mode
        markdown-mode
        yasnippet
        projectile
        switch-window
        bookmark+
        move-text
        htmlize))

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))


;; not always
;; (require 'package)
;; (unless package-archive-contents
;;   (package-refresh-contents))


(setq package-load-list '(all))
(package-initialize)

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))


(provide 'my-packages)
