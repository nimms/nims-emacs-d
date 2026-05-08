
;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;
;; "Emacs outshines all other editing software in approximately the
;; same way that the noonday sun does the stars. It is not just bigger
;; and brighter; it simply makes everything else vanish."
;; -Neal Stephenson, "In the Beginning was the Command Line"

;; Load path etc.

;; check to see which platform we are running on
(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar linux-p (string-match "gnu/linux" (symbol-name system-type)))

(defvar use-home)
(setq use-home (concat (expand-file-name "~") "/"))
(defvar use-bin
  (if mswindows-p
      "c:/bin/"
    (concat (expand-file-name "~") "/bin/")))

(setq default-directory "~/")

;; Set up load path
(setq load-path (append (list (concat use-home "")
                              (concat use-home ".emacs.d/plugins"))
	load-path))

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))
;; These should be loaded on startup rather than autoloaded on demand
;; since they are likely to be used in every session

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

(fset 'yes-or-no-p 'y-or-n-p)



;; this must be loaded before ELPA since it bundles its own
;; out-of-date js stuff. TODO: fix it to use ELPA dependencies
;;(load "nxhtml/autostart")

;; Load up ELPA, the package manager

(require 'package)
(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)


;(require 'smartparens-config)
;(require 'smartparens-ruby)
;(smartparens-global-mode)
;(show-smartparens-global-mode t)
;(sp-with-modes '(rhtml-mode)
;  (sp-local-pair "<" ">")
;  (sp-local-pair "<%" "%>"))




;(regen-autoloads)
(load custom-file 'noerror)


;; Work around a bug on OS X where system-name is FQDN
(if (eq system-type 'darwin)
    (setq system-name (car (split-string system-name "\\."))))




;; You can keep system- or user-specific customizations here

(setq system-specific-config (concat dotfiles-dir system-name ".el")
      ;user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-config (concat dotfiles-dir "nimms.el")
user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
    (mapc #'load (directory-files user-specific-dir nil ".*el$")))

(put 'narrow-to-region 'disabled nil)

(put 'narrow-to-page 'disabled nil)

(put 'upcase-region 'disabled nil)

(require 'highlight-indentation)
(add-hook 'enh-ruby-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

(add-hook 'coffee-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

(add-hook 'haml-mode-hook
          (lambda () (highlight-indentation-current-column-mode)))

;; init.el ends here
