(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'hyper)

;(global-set-key (kbd "M-z") 'repeat)
(setq local-function-key-map (delq '(kp-tab . [9]) local-function-key-map))

(global-set-key (kbd "<f5>") 'ag-project-at-point)
(global-set-key (kbd "<f6>") 'ag-regexp-project-at-point)

(global-set-key (kbd "<f7>") 'rename-buffer)
(global-set-key (kbd "<f8>")
                (lambda ()
                  (interactive)
                  (egg-status)
                  (other-window 1)))
(global-set-key (kbd "<f9>") 'rgrep)
(global-set-key [(control return)] 'ns-toggle-fullscreen)
(global-set-key [(meta return)] 'auto-complete)

(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-set-key (kbd "<f2>") 'shell)
;;reload the current page in firefox
(global-set-key (kbd "C-x p")
                (lambda ()
                  (interactive)
                  (comint-send-string (inferior-moz-process)
                                      "BrowserReload();")))
(global-set-key (kbd "M-a") 'helm-M-x)
(global-set-key (kbd "M-A") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-a") 'execute-extended-command) ;;old m-x
(global-set-key (kbd "C-c M-A") 'shell-command)
(global-set-key (kbd "H-i") 'open-line)                                        ;(global-set-key (kbd "M-z") 'repeat)
(global-set-key (kbd "M-b") 'helm-mini)
(global-set-key (kbd "M-[") 'helm-for-files)
(global-set-key (kbd "M-t") 'helm-projectile)
(global-set-key (kbd "H-o") 'projectile-find-file)
(global-set-key (kbd "M-{") 'recentf-ido-find-file)
(global-set-key (kbd "C-o") 'open-line)
(global-set-key (kbd "C-M-g") 'goto-line)
(global-set-key (kbd "M-m") 'back-to-indentation)
(global-set-key (kbd "C-h C-m") 'describe-mode)

;;(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)
;; marking commands
(define-key cua--cua-keys-keymap (kbd "M-v") 'cua-paste)
(global-set-key (kbd "M-C") 'nimms-copy-line)
(global-set-key (kbd "H-c") 'copy-all)
(global-set-key (kbd "H-p") 'mark-lines-previous-line)
(global-set-key (kbd "H-n") 'mark-lines-next-line)
(global-set-key (kbd "M-w") 'kill-ring-save)
(global-set-key (kbd "M-;") 'isearch-forward)
(global-set-key (kbd "M-:") 'isearch-backward)
(define-key isearch-mode-map (kbd "M-;") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "M-:") 'isearch-repeat-backward)
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

;; ruby stuff
(global-set-key (kbd "C-x C-d") 'ido-dired)
(global-unset-key (kbd "M-R"))
(eval-after-load 'ruby-mode
  '(progn
     (require 'rinari)
     (global-set-key (kbd "C-M-c") 'rinari-find-controller)
     (global-set-key (kbd "C-M-v") 'rinari-find-view)
     (global-set-key (kbd "C-M-m") 'rinari-find-model)
     (global-set-key (kbd "C-r") 'ruby-send-block)
     (global-set-key (kbd "C-R") 'ruby-send-region)
     (global-set-key (kbd "C-h r") 'ri)
     (setq ruby-use-encoding-map nil)
     (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)))

;;isearch keys
(define-key isearch-mode-map [(meta z)] 'zap-to-isearch)
(define-key isearch-mode-map [(control return)] 'isearch-exit-other-end)
(define-key isearch-mode-map "\C-\M-w" 'isearch-yank-symbol)
(define-key isearch-mode-map (kbd "C-o") 'isearch-occur);; Activate occur easily inside isearch


(global-unset-key (kbd "C-p"))
(global-unset-key (kbd "C-n"))
(global-set-key (kbd "C-p") 'comint-previous-input)
(global-set-key (kbd "C-n") 'comint-next-input)

(global-set-key (kbd "C-d") 'dash-at-point)

(provide 'nimai-keycommands)
