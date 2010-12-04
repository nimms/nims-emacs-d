(defadvice viper-maybe-checkout (around viper-git-checkin-fix activate)
  "Advise viper-maybe-checkout to ignore git files."
  (let ((file (expand-file-name (buffer-file-name buf))))
    (when (and (featurep 'vc-hooks)
               (not (memq (vc-backend file) '(nil Git))))
      ad-do-it)))

(defadvice yank (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode scheme-mode lisp-mode
                                           c-mode c++-mode objc-mode
                                           LaTeX-mode TeX-mode ruby-mode java-mode))
      (indent-region (region-beginning) (region-end) nil)))

(defadvice viper-maybe-checkout (around viper-git-checkin-fix activate)
  "Advise viper-maybe-checkout to ignore svn files."
  (let ((file (expand-file-name (buffer-file-name buf))))
    (when (and (featurep 'vc-hooks)
               (not (memq (vc-backend file) '(nil Git))))
      ad-do-it)))
