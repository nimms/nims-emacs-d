;;cucumhber mode
(autoload 'feature-mode "feature-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.feature\\'" . feature-mode))

;;java mode
(autoload 'malabar-mode "malabar-mode" "Java shiz n shiz" t)
(setq malabar-groovy-lib-dir "/home/nimai/.emacs.d/malabar-1.4-SNAPSHOT/lib")
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

(add-hook 'malabar-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'malabar-compile-file-silently nil t)
            (add-to-list 'compilation-error-regexp-alist (list "\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*" 1 2 3))))


;;moz mode
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

;;js mode
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))

(defvar php-file-patterns '("\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'") 
  "List of file patterns for which to automatically invoke `php-mode'.")

(custom-autoload 'php-file-patterns "../related/php-mode-2008-10-23" nil)

(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)


;;org mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))



(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . eruby-nxhtml-mumamo-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml\\'" . eruby-nxhtml-mumamo-mode))

(add-to-list 'auto-mode-alist '("\\.html\\.haml\\'" . haml-mode))
