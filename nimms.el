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
                              (concat use-home ".emacs.d/plugins/cucumber-mode")
                              (concat use-home ".emacs.d/plugins/slime")
                              (concat use-home ".emacs.d/egg")
                              (concat use-home ".emacs.d/emacs-rails")
                              (concat use-home ".emacs.d/includes")
                              (concat use-home ".emacs.d/rhtml-mode")
                              (concat use-plugins "jd-el")
                              (concat use-plugins "yasnippet")
                              (concat use-plugins "remember")
                              (concat use-plugins "ecb-snap")
                              (concat use-plugins ""))
                        load-path))


(load "moz-auto-update.el")



                                        ;(load "color-theme-ld-dark")
                                        ;(color-theme-ld-dark)

                                        ;(require 'nimms-color)
                                        ;(load "color-theme-obsolescence.el")

(load-file "~/.emacs.d/cedet-1.0pre7/common/cedet.el")

                                        ;(load "color-theme-subdued.el")
;;(color-theme-subdued)
                                        ;(nimms-color-theme)

;;(load "anything.el")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(require 'parenface)
;;(require 'nimai-clisp)
(require 'nimai-keycommands)
(require 'nimms-functions)
(require 'tramp)
(require 'cc-mode)
(require 'etags)
(require 'egg)
(require 'snippet)
(require 'rainbow-mode)
;;(require 'multi-term)
(require 'google-maps)

(require 'cedet)
(require 'ecb-autoloads)
(require 'window-numbering)

(scroll-bar-mode -1)
(column-number-mode t)
(display-time)
(tool-bar-mode -1)
(rainbow-mode t)

(global-auto-revert-mode t)
(winner-mode 1)
(window-numbering-mode)
(cua-mode t)
(desktop-save-mode t)
;;cucumber mode
(load "feature-mode")


(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)

(setq multi-term-program "/bin/bash")   ;; use bash
;; (setq multi-term-program "/bin/zsh") ;; or use zsh...

;; Enabling various SEMANTIC minor modes.  See semantic/INSTALL for more ideas.
;; Select one of the following
(semantic-load-enable-code-helpers)
;; (semantic-load-enable-guady-code-helpers)
;; (semantic-load-enable-excessive-code-helpers)

;; Enable this if you develop in semantic, or develop grammars
;; (semantic-load-enable-semantic-debugging-helpers)

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

;;;;#### moz repl stuff
(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'javascript-mode-hook 'javascript-custom-setup)
(defun javascript-custom-setup ()
  (moz-minor-mode 1))



(defvar php-file-patterns '("\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'") 
  "List of file patterns for which to automatically invoke `php-mode'.")

(custom-autoload 'php-file-patterns "../related/php-mode-2008-10-23" nil)

(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)


(require 'remember)
(setq org-remember-templates
      '(("Tasks" ?t "* TODO %?\n  %i\n  %a" "~/org/todo.org")
        ("Appointments" ?a "* Appointment: %?\n%^T\n%i\n  %a" "~/org/todo.org")))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(eval-after-load 'remember
  '(add-hook 'remember-mode-hook 'org-remember-apply-template))

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;;(setq org-todo-keywords '("TODO" "STARTED" "WAITING" "DONE"))
(setq org-agenda-include-diary t)                                               
(setq org-agenda-include-all-todo t)    
(setq org-log-done t)


(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


(setq hippie-expand-try-functions-list '(try-expand-dabbrev try-expand-dabbrev-all-buffers try-complete-file-name))

;; hippie-expand-try-functions-list ))

;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . nxhtml-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . nxhtml-mode))
;; (add-to-list 'auto-mode-alist '("\\.rhtml\\'" . nxhtml-mode))

(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t
      color-theme-is-cumulative t
      color-theme-load-all-themes nil)
(load "color-theme-tangotango")
(color-theme-tangotango)

;; (load "color-theme-nimms-new")
;; (color-theme-nimms-new)

(add-hook 'message-mode-hook 'color-theme-tangotango)
(add-hook 'gnus-article-mode-hook 'color-theme-tangotango)

(add-hook 'after-make-frame-functions
	  (lambda (frame)
	    (set-variable 'color-theme-is-global nil)
	    (select-frame frame)
	    (if window-system
		(color-theme-tangotango)
	      (color-theme-ld-dark))))

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

(defmacro de-erc-connect (command server port nick)
  "Create interactive command `command', for connecting to an IRC server. The
      command uses interactive mode if passed an argument."
  (fset command
        `(lambda (arg)
           (interactive "p")
           (if (not (= 1 arg))
               (call-interactively 'erc)
             (erc :server ,server :port ,port :nick ,nick)))))

(autoload 'erc "erc" "" t)
(de-erc-connect erc-opn "localhost" 6667 "nimai")
(call-interactively 'erc-opn)

;; fires up a new frame and opens your servers in there. You will need
;; to modify it to suit your needs.
;; (defun my-irc ()
;;   "Start to waste time on IRC with ERC."
;;   (interactive)
;;   (select-frame (make-frame '((name . "Emacs IRC")
;; 			      (minibuffer . t))))
;;   (call-interactively 'erc-opn))

;; (setq erc-autojoin-channels-alist
;;       '(("freenode.net" "#emacs" "#kde" "#ruby" "ubuntu" "kubuntu")))


     ;;; rhtml-mode

;; (load  "/home/nimai/.emacs.d/plugins/nxhtml/autostart") --->

;; (setq --->
;;  nxhtml-global-minor-mode t --->
;;  mumamo-chunk-coloring 'submode-colored --->
;;  nxhtml-skip-welcome t --->
;;  indent-region-mode t --->
;;  rng-nxml-auto-validate-flag nil --->
;;  nxml-degraded t) --->
;; (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo-mode)) --->

(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
     	  (lambda () (rinari-launch)))

;;eshell
;; Change the default eshell prompt
(setq eshell-prompt-function
      (lambda ()
        (concat "[" (getenv "USER") "@" (system-name) "] "
                (eshell/pwd) (if (= (user-uid) 0) " # " " $ "))))

;;ansi-term
;; enable cua and transient mark modes in term-line-mode
(defadvice term-line-mode (after term-line-mode-fixes ())
  (set (make-local-variable 'cua-mode) t)
  (set (make-local-variable 'transient-mark-mode) t))
(ad-activate 'term-line-mode)

;; disable cua and transient mark modes in term-char-mode
(defadvice term-char-mode (after term-char-mode-fixes ())
  (set (make-local-variable 'cua-mode) nil)
  (set (make-local-variable 'transient-mark-mode) nil))
(ad-activate 'term-char-mode)
