(if macosx-p
    (setq mac-command-modifier 'hyper))

;(global-set-key (kbd "M-z") 'repeat)
(setq local-function-key-map (delq '(kp-tab . [9]) local-function-key-map))

(global-set-key (kbd "<f5>") 'nimms-toggle-selective-display)
(global-set-key (kbd "<f7>") 'rename-buffer)
(global-set-key (kbd "<f8>")
                (lambda ()
                  (interactive)
                  (egg-status)
                  (other-window 1)))
(global-set-key (kbd "<f9>") 'rgrep)
(global-set-key [(control return)] 'toggle-fullscreen)
(global-set-key [(meta return)] 'auto-complete)

(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-set-key (kbd "<f2>") 'shell)
;;reload the current page in firefox
(global-set-key (kbd "C-x p")
                (lambda ()
                  (interactive)
                  (comint-send-string (inferior-moz-process)
                                      "BrowserReload();")))
(global-set-key (kbd "M-a") 'smex)
(global-set-key (kbd "M-A") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-a") 'execute-extended-command) ;;old m-x
(global-set-key (kbd "C-c M-A") 'shell-command)
(global-set-key (kbd "H-i") 'open-line)                                        ;(global-set-key (kbd "M-z") 'repeat)
(global-set-key (kbd "M-b") 'ido-switch-buffer)
(global-set-key (kbd "M-[") 'ido-find-file)
(global-set-key (kbd "M-]") 'ido-find-file)
(global-set-key (kbd "H-o") 'find-file-in-project)
(global-set-key (kbd "C-M-o") 'recentf-ido-find-file)
(global-set-key (kbd "C-o") 'open-line)
(global-set-key (kbd "H-g") 'goto-line)
(global-set-key (kbd "M-m") 'back-to-indentation)                
;; marking commands
(define-key cua--cua-keys-keymap (kbd "M-v") 'cua-paste)
(global-set-key (kbd "M-C") 'nimms-copy-line)
(global-set-key (kbd "H-c") 'copy-all)
(global-set-key (kbd "H-p") 'mark-lines-previous-line)
(global-set-key (kbd "H-n") 'mark-lines-next-line)
(global-set-key (kbd "M-w") 'kill-ring-save)
;; open keyboard shortcut image with F8 key
(global-set-key (kbd "M-<f12>")
                (lambda ()
                  (interactive)
                  (find-file "~/.emacs.d/ergo_emacs_qwerty.png")))

(global-set-key (kbd "C-k") 'ido-kill-buffer)
                                        ;(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2")
                (lambda ()
                  (interactive)
                  (split-window-vertically)
                  (other-window 1)))

(global-set-key (kbd "M-3")
                (lambda ()
                  (interactive)
                  (split-window-horizontally)
                  (other-window 1)))
(global-set-key (kbd "M-0") 'delete-window)
                                        ;(global-set-key (kbd "M-z") 'other-window)
;;org mode-compile-after-compile-hook
(global-set-key (kbd "C-c r") 'remember)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

;; ruby stuff
(global-set-key (kbd "C-x C-d") 'ido-dired)
(global-unset-key (kbd "M-R"))
(eval-after-load 'ruby-mode
  '(progn
     (require 'rinari)
     (global-set-key (kbd "M-c") 'rinari-find-controller)
     (global-set-key (kbd "C-M-v") 'rinari-find-view)
     (global-set-key (kbd "M-m") 'rinari-find-model)
     (global-set-key (kbd "M-t") 'rinari-find-rspec)
     (global-set-key (kbd "C-r") 'ruby-send-block)
     (global-set-key (kbd "C-R") 'ruby-send-region)
     (global-set-key (kbd "H-o") 'find-file-in-project)))

(global-unset-key (kbd "C-p"))
(global-unset-key (kbd "C-n"))
(global-set-key (kbd "C-p") 'comint-previous-input)
(global-set-key (kbd "C-n") 'comint-next-input)

(eval-after-load 'malabar-mode
  '(progn
     (define-key malabar-mode-map (kbd "RET") 'newline-and-indent)
     (define-key malabar-mode-map (kbd "M-t") 'semantic-ia-complete-symbol-menu)
     (define-key malabar-mode-map (kbd "<tab>") 'yas/expand)
     (setq yas/fallback-behaviour 'indent-for-tab-command)))

(provide 'nimai-keycommands)
