(defvar mswindows-p (string-match "windows" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))
(defvar gnu-linux-p  (string-match "gnu/linux" (symbol-name system-type)))

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
                              (concat use-home ".emacs.d/egg")
                              (concat use-home ".emacs.d/includes")
;                              (concat use-plugins "ergoemacs")
                              (concat use-plugins ""))
                        load-path))
(load "mark-lines")

(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US layout
(load "ergoemacs-mode")
(ergoemacs-mode 1)

;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
;(require 'init-compat)
(require 'init-utils)
;(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
(require 'init-elpa) ;; Machinery for installing required packages
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'wgrep)
(require-package 'project-local-variables)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'mwe-log-commands)

(require 'init-frame-hooks)
(require 'init-editing-utils)
(require 'init-autocomplete)
(require 'init-flymake)
(require 'init-exec-path)
(require 'init-webmode)
(require 'init-css)
(require 'init-ruby)
(require 'init-rails)
(require 'init-haml)
(require 'init-isearch)
(require 'init-javascript)
(require 'init-php)
(require 'init-sh)
(require 'init-recentf)
(require 'init-python)
(require 'init-helm)
(require 'init-ido) ;; put this here so my key commands don't overwrite it

;(require 'init-xterm)

(load "hooks.el")


;; set default font depending on what machine I'm on
(if macosx-p
    (progn
      (set-frame-font "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
      (exec-path-from-shell-initialize)))

;(if gnu-linux-p
;    (set-frame-font "-unknown-Droid Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1"))

;;(load "anything.el")
(require 'parenface)
;;(require 'nimai-clisp)
(require 'tramp)
(require 'cc-mode)
(require 'etags)
(require 'egg)
(require 'rainbow-mode)
(require 'window-numbering)

(require 'pabbrev)
(require 'enclose)
(setq pabbrev-idle-timer-verbose nil)
; (if macosx-p 
;     (require 'rvm)
;     (rvm-use-default))

(require 'nyan-mode)
(nyan-mode 1)
(nyan-start-animation)


;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))

(setq ns-use-native-fullscreen nil)
(scroll-bar-mode -1)
(column-number-mode t)
(display-time)
(tool-bar-mode -1)
(rainbow-mode 1)
(projectile-global-mode 1)


(setq show-paren-delay 0.0)
(auto-fill-mode 0)


(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings))


(setq x-select-enable-clipboard t)
(setq rinari-tags-file-name "TAGS")
(setq line-number-mode 1)
(setq default-directory "~/")
(setq tramp-default-method "ssh")
(setq tramp-chunksize 500)
(set-default 'truncate-lines t)


(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name))


;;eshell
;; Change the default eshell prompt
(setq eshell-prompt-function
      (lambda ()
        (concat "[" (getenv "USER") "@" (system-name) "] "
                (eshell/pwd) (if (= (user-uid) 0) " # " " $ "))))


;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
  (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
          (if buffer-file-name
              (concat "#" (file-name-nondirectory buffer-file-name) "#")
            (expand-file-name
             (concat "#%" (buffer-name) "#")))))



;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))
(setq make-backup-files nil)
(setq auto-save-default nil)

(setq debug-on-error nil)


(load "nimai-keycommands")
(require 'nimms-functions)


