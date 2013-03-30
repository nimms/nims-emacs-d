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
                              (concat use-plugins "ergoemacs")
                              (concat use-plugins ""))
                        load-path))

(require 'helm-config)

(load "hooks.el")


;; set default font depending on what machine I'm on
(if macosx-p 
    (set-frame-font "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1"))

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

(setq tab-always-indent 'complete)
(setq smex-history-length 50)
(load "mark-lines")
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US layout



(load "ergoemacs-mode")

;;(load (concat use-home ".emacs.d/nxhtml/autostart.el"))
;; turn on minor mode ergoemacs-mode

(semantic-mode 1)

(scroll-bar-mode -1)
(column-number-mode t)
(display-time)
(tool-bar-mode -1)
(rainbow-mode 1)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'sass-mode-hook 'rainbow-mode)
(add-hook 'rhtml-mode-hook 'rainbow-mode)

(global-auto-revert-mode)
(winner-mode 1)
(cua-mode t)
(ergoemacs-mode 1)
(iswitchb-mode 1)
(icomplete-mode 1)

(setq show-paren-delay 0.0)
(auto-fill-mode 0)

(setq multi-term-program "/bin/zsh") ;; or use zsh...

;;auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(setq ac-auto-start 2)


(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings))


(setq x-select-enable-clipboard t)
(setq rinari-tags-file-name "TAGS")
(setq line-number-mode 1)
(setq default-directory "~/")
(setq tramp-default-method "ssh")
(setq tramp-chunksize 500)
(set-default 'truncate-lines t)




;;(setq org-todo-keywords '("TODO" "STARTED" "WAITING" "DONE"))
(setq org-agenda-include-diary t)                                               
(setq org-agenda-include-all-todo t)    
(setq org-log-done t)


(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name))



;; hippie-expand-try-functions-list ))

(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t
      color-theme-is-cumulative t
      color-theme-load-all-themes nil)
(load "color-theme-tangotango")
(color-theme-tangotango)


(autoload 'erc "erc" "" t)
(ignore-errors
  (progn

    (defmacro de-erc-connect (command server port nick)
      "Create interactive command `command', for connecting to an IRC server. The
      command uses interactive mode if passed an argument."
      (fset command
            `(lambda (arg)
               (interactive "p")
               (if (not (= 1 arg))
                   (call-interactively 'erc)
                 (erc :server ,server :port ,port :nick ,nick)))))
    (unless (or macosx-p mswindows-p)
      ((de-erc-connect erc-opn "localhost" 6667 "nimai")
       (call-interactively 'erc-opn)))))

;; fires up a new frame and opens your servers in there. You will need
;; to modify it to suit your needs.
;; (defun my-irc ()
;;   "Start to waste time on IRC with ERC."
;;   (interactive)
;;   (select-frame (make-frame '((name . "Emacs IRC")
;; 			      (minibuffer . t))))
;;   (call-interactively 'erc-opn))

(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#ruby")))

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


;; auto complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
(setq ac-auto-start 2)


;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))
(setq backup-directory-alist (list (cons "." backup-dir)))
(setq make-backup-files nil)
(setq auto-save-default nil)

(setq debug-on-error nil)

;;; Code:
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)



(load "nimai-keycommands")
(require 'nimms-functions)


