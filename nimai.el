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
                              (concat use-home ".emacs.d/plugins/color-theme")
                              (concat use-home ".emacs.d/plugins/clojure-mode")
                              (concat use-home ".emacs.d/plugins/cucumber-mode")
                              (concat use-home ".emacs.d/plugins/slime")
                              (concat use-home ".emacs.d/egg")
                              (concat use-home ".emacs.d/emacs-rails")
                              (concat use-home ".emacs.d/includes")
                              (concat use-home ".emacs.d/rhtml-mode")
                              (concat use-home ".emacs.d/malabar-1.4-SNAPSHOT/lisp")
                              (concat use-plugins "ergoemacs")
                              (concat use-plugins "rinari")
                              (concat use-plugins "jd-el")
                              (concat use-plugins "yasnippet")
                              (concat use-plugins "remember")
                              (concat use-plugins "ergoemacs")
                              (concat use-plugins ""))
                        load-path))


(load "mode-list.el")
(load "hooks.el")
(load "vi-misc.el")
(load "moz-auto-update.el")

                                        ;(load "color-theme-ld-dark")
                                        ;(color-theme-ld-dark)

                                        ;(require 'nimms-color)
                                        ;(load "color-theme-obsolescence.el")

                                        ;(load "color-theme-subdued.el")
;;(color-theme-subdued)
                                        ;(nimms-color-theme)

;; set default font depending on what machine I'm on
(if macosx-p 
    (set-frame-font "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1"))

;(if gnu-linux-p
;    (set-frame-font "-unknown-Droid Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1"))

;;(load "anything.el")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(require 'parenface)
;;(require 'nimai-clisp)
(require 'tramp)
(require 'cc-mode)
(require 'etags)
(require 'egg)
(require 'snippet)
(require 'rainbow-mode)
;;(require 'multi-term)
(require 'google-maps)
(require 'window-numbering)
;;(require 'vimpulse)
(require 'remember)
(require 'rinari)
(require 'pabbrev)
(require 'enclose)
(require 'ruby-end)
(setq pabbrev-idle-timer-verbose nil)
;; (if macosx-p 
;;     (require 'rvm)
;;     (rvm-use-default))

(setq smex-history-length 50)
(require 'smex)

(smex-initialize)

(load "mark-lines")
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US layout
;(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "colemak") ; Colemak layout

;; load ErgoEmacs keybinding
(load "ergoemacs-mode")

(load (concat use-home ".emacs.d/nxhtml/autostart.el"))
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
;;(desktop-save-mode t)
(partial-completion-mode t)
(iswitchb-mode 1)
(icomplete-mode 1)

(setq show-paren-delay 0.0)
(auto-fill-mode 0)


(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)
(setq multi-term-program "/bin/zsh") ;; or use zsh...



;;smex
(require 'smex)
(smex-initialize)

(when (require 'browse-kill-ring nil 'noerror)
  (browse-kill-ring-default-keybindings))
;; Enabling various SEMANTIC minor modes.  See semantic/INSTALL for more ideas.
;; Select one of the following


(setq x-select-enable-clipboard t
      interprogram-paste-function 'x-cut-buffer-or-selection-value      
      tramp-default-method "ssh"
      default-directory "~/"
      line-number-mode 1
      rinari-tags-file-name "TAGS")

(set-default 'truncate-lines t)
(setq-default ispell-program-name "aspell")
(setq max-lisp-eval-depth 2048)         ; trying to fix max list eval
                                        ; depth errors


(setq org-remember-templates
      '(("Todo" ?t "* TODO %^{Brief Description} %^g\n%?\nAdded: %U" "~/org/gtd.org" "Tasks")
        ("Appointments" ?a "* Appointment: %?\n%^T\n%i\n  %a" "~/org/appoinments.org")))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(eval-after-load 'remember
  '(add-hook 'remember-mode-hook 'org-remember-apply-template))



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


;; bitlbee
  
(defvar bitlbee-password "Trinkets")

(add-hook 'erc-join-hook 'bitlbee-identify)

(defun bitlbee-identify ()
  "If we're on the bitlbee server, send the identify command to the 
 &bitlbee channel."
  (when (and (string= "localhost" erc-session-server)
             (string= "&bitlbee" (buffer-name)))
    (erc-message "PRIVMSG" (format "%s identify %s" 
                                   (erc-default-target) 
                                   bitlbee-password))))

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
;; I use version control, don't annoy me with backup files everywhere
(setq make-backup-files nil)
(setq auto-save-default nil)

(setq debug-on-error nil)

(require 'nimai-keycommands)
(require 'nimms-functions)
