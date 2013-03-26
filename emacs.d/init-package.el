;; el-get's package.rcp adds `ELPA', `marmalade' and `SC' repositories that I
;; don't want because of potential version conflicts with `melpa'.
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)
