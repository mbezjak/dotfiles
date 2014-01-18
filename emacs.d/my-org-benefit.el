(setq my-org-benefit-prop-name "BENEFIT")

(defun my-org-benefit-heading-text ()
  (nth 4 (org-heading-components)))

(defun my-org-benefit-val-to-str (val)
  (if (numberp val)
      (number-to-string val)
    val))

(defun my-org-benefit-set (val)
  (save-excursion
    (org-back-to-heading)
    (org-entry-put nil my-org-benefit-prop-name val)))

(defun my-org-benefit-get ()
  (save-excursion
    (org-back-to-heading)
    (or (org-entry-get nil my-org-benefit-prop-name) "0")))

(defun my-org-benefit-set-num (val)
  (my-org-benefit-set (number-to-string val)))

(defun my-org-benefit-get-num ()
  (string-to-number (my-org-benefit-get)))

(defun my-org-benefit-read-set (val)
  (interactive "nBenefit: ")
  (my-org-benefit-set (my-org-benefit-val-to-str val)))

(defun my-org-benefit-calc ()
  (save-excursion
    (org-back-to-heading)
    (let ((sum 0)
          (add-current-benefit '(lambda () (setq sum (+ sum (my-org-benefit-get-num))))))

      (when (org-goto-first-child)
        (funcall add-current-benefit)
        (while (org-goto-sibling)
          (funcall add-current-benefit)))

      sum)))

(defun my-org-benefit-calc-set ()
  (save-excursion
    (org-back-to-heading)
    (my-org-benefit-set-num (my-org-benefit-calc))))

(defun my-org-benefit-table ()
  (save-excursion
    (org-back-to-heading)
    (let ((tbl '())
          (add
           '(lambda ()
              (add-to-list 'tbl (list (my-org-benefit-heading-text) (my-org-benefit-get-num)) t))))

      (when (org-goto-first-child)
        (funcall add)
        (while (org-goto-sibling)
          (funcall add)))

      tbl)))

(defun my-org-benefit-summary ()
  (interactive)
  (let ((tbl (my-org-benefit-table)))

    (switch-to-buffer-other-window (get-buffer-create "*Benefit*"))
    (org-mode)
    (flyspell-mode -1)
    (erase-buffer)

    (insert "| Name | Benefit |\n")
    (insert "|--\n")

    (dolist (row tbl)
      (let ((text (car row))
            (benefit (nth 1 row)))
        (insert (concat "|" text "|" (number-to-string benefit) "|\n"))))

    (end-of-buffer)
    (insert "|--\n")
    (insert "| Sum | |\n")
    (insert "#+TBLFM: @>$2..@>$2=vsum(@I..II);%.0f")

    (goto-char 2)
    (org-table-align)
    (org-table-goto-line 2)
    (org-table-goto-column 2)
    (org-table-sort-lines nil ?n)

    (end-of-buffer)
    (org-table-calc-current-TBLFM)

    (local-set-key (kbd "q")
                   '(lambda () (interactive)
                      (progn
                        (kill-buffer)
                        (select-window (previous-window)))))

    (read-only-mode)))


;; integrate with org-mode

(setq org-speed-commands-user
      '(("V" . my-org-benefit-read-set)
        ("S" . my-org-benefit-summary)))
