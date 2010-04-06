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
                               (concat use-plugins "yasnippet")
                               (concat use-plugins "remember")
                               (concat use-plugins ""))
                         load-path))


(load "moz-auto-update.el")

(require 'nimms-color)
;;(load "color-theme-subdued.el")
;;(color-theme-subdued)
(nimms-color-theme)

;;(load "anything.el")
(require 'nimms-functions)
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(require 'parenface)
(require 'slime)
(require 'nimai-clisp)
(require 'tramp)
(setq tramp-default-method "ssh")
(setq default-directory "~/")
(setq rinari-tags-file-name "TAGS")


(set-default 'truncate-lines t)
(setq-default ispell-program-name "aspell")
(setq max-lisp-eval-depth 2048)         ; trying to fix max list eval
                            ; depth errors

;; (color-theme-initialize)                ; color theme loving
;; (color-theme-deep-blue)


(global-set-key (kbd "C-x 7") 'three-quarters-window)
(global-set-key (kbd "C-x 8") 'half-window)
(global-set-key [(meta return)] 'toggle-fullscreen)
;;;;#### moz repl stuff
    (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

    (add-hook 'javascript-mode-hook 'java-custom-setup)
    (defun javascript-custom-setup ()
      (moz-minor-mode 1))

(global-set-key (kbd "C-x p")
                (lambda ()
                  (interactive)
                  (comint-send-string (inferior-moz-process)
                                      "BrowserReload();")))


;;;### (autoloads (php-mode php-file-patterns) "../related/php-mode-2008-10-23"
;;;;;;  "related/php-mode-2008-10-23.el" (18688 64648))
;;; Generated autoloads from related/php-mode-2008-10-23.el

(defvar php-file-patterns '("\\.php[s34]?\\'" "\\.phtml\\'" "\\.inc\\'") 
"List of file patterns for which to automatically invoke `php-mode'.")

(custom-autoload 'php-file-patterns "../related/php-mode-2008-10-23" nil)

(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)


;;vb mode

(autoload 'vbnet-mode "vbdotnet" "Visual Basic mode." t)
  (setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|cls\\)$" .
                                  vbnet-mode)) auto-mode-alist))


;; (autoload 'php-mode "../related/php-mode-2008-10-23" "Major mode for editing PHP code.
;; \\{php-mode-map}

;; \(fn)" t nil)

(require 'remember)
(setq org-remember-templates
      '(("Tasks" ?t "* TODO %?\n  %i\n  %a" "~/Dropbox/org/organiser.org")
        ("Appointments" ?a "* Appointment: %?\n%^T\n%i\n  %a" "~/Dropbox/org/organiser.org")))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(eval-after-load 'remember
  '(add-hook 'remember-mode-hook 'org-remember-apply-template))
(global-set-key (kbd "C-c r") 'remember)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

;;(setq org-todo-keywords '("TODO" "STARTED" "WAITING" "DONE"))
(setq org-agenda-include-diary t)                                               
(setq org-agenda-include-all-todo t)    
(setq org-log-done t)


;; (global-set-key [(meta return)] 'toggle-fullscreen)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;;erc
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emacs" "#kde" "#ruby" "ubuntu" "kubuntu")))

