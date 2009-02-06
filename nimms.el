(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))

(defvar use-home)
(setq use-home (concat (expand-file-name "~") "/"))
(setq use-plugins (concat (expand-file-name "~") "/.emacs.d/plugins/"))
(defvar use-bin
  (if mswindows-p
      "c:/bin/"
    (concat (expand-file-name "~") "/bin/")))

;; Set up load path
 (setq load-path (append (list (concat use-home "")
                               (concat use-home ".emacs.d/plugins")
                               (concat use-home ".emacs.d/")
                               (concat use-home ".emacs.d/plugins/color-theme")
                               (concat use-home ".emacs.d/plugins/clojure-mode")
                               (concat use-home ".emacs.d/plugins/slime")
                               (concat use-plugins "yasnippet"))
                         load-path))


(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(require 'color-theme)
(require 'parenface)
(require 'slime)
(require 'nimai-clisp)
(require 'tramp)
(setq tramp-default-method "ftp")


(setq max-lisp-eval-depth 2048)         ; trying to fix max list eval
                            ; depth errors

;; (color-theme-initialize)                ; color theme loving
;; (color-theme-deep-blue)

(my-color-theme)

(defun toggle-fullscreen () 
  (interactive) 
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 
                                                            'fullscreen) 
                                           nil 
                                         'fullboth))) 


(global-set-key [(meta return)] 'toggle-fullscreen)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;(load "~/.emacs.d/plugins/nxhtml/autostart.el")
(load "nimms-color.el")