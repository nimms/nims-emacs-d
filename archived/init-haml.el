(require-package 'haml-mode)

(add-hook 'haml-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq dash-at-point-docset "rails")
            (define-key haml-mode-map "\C-m" 'newline-and-indent)))

(provide 'init-haml)
