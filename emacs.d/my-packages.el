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
        htmlize))

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

;; (unless package-archive-contents
;;   (package-refresh-contents))

(setq package-load-list '(all))
(package-initialize)

(mapc (lambda (package)
        (unless (package-installed-p package)
          (package-install package)))
 my-packages)


(mapc (lambda (package)
        (let ((file (concat "~/.emacs.d/init-" (symbol-name package) ".el")))
          (when (file-exists-p file)
            (load file))))
 my-packages)

(provide 'my-packages)
