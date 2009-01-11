(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))

(defvar use-home)
(setq use-home (concat (expand-file-name "~") "/"))
(defvar use-bin
  (if mswindows-p
      "c:/bin/"
    (concat (expand-file-name "~") "/bin/")))

;; Set up load path
 (setq load-path (append (list (concat use-home "")
                               (concat use-home ".emacs.d/plugins")
                               (concat use-home ".emacs.d/plugins/color-theme")
                               (concat use-home ".emacs.d/plugins/clojure-mode")
                               (concat use-home ".emacs.d/plugins/slime"))
                         load-path))

(require 'color-theme)
(require 'parenface)
(require 'slime)
(require 'nimai-clisp)


(setq max-lisp-eval-depth 2048)         ; trying to fix max list eval
                            ; depth errors

(color-theme-initialize)                ; color theme loving
(color-theme-deep-blue)


;;(load "~/.emacs.d/plugins/nxhtml/autostart.el")