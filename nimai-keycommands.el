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
(global-set-key [(meta return)] 'hippie-expand)

(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-set-key (kbd "C-x C-t") 'eterminal/run-terminal)
;;reload the current page in firefox
(global-set-key (kbd "C-x p")
                (lambda ()
                  (interactive)
                  (comint-send-string (inferior-moz-process)
                                      "BrowserReload();")))

(global-set-key (kbd "M-z") 'repeat)
(global-set-key (kbd "M-b") 'ido-switch-buffer)
(global-set-key (kbd "M-o") 'ido-find-file)
(global-set-key (kbd "M-O") 'ido-find-file-other-window)
(global-set-key (kbd "H-o") 'find-file-in-project)
(global-set-key (kbd "M-q") 'save-buffers-kill-terminal)
(global-set-key (kbd "C-M-o") 'recentf-ido-find-file)

(global-set-key (kbd "M-k") 'ido-kill-buffer)
(global-set-key (kbd "C-s") 'save-buffer)
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
(global-set-key (kbd "M-z") 'other-window)
;;org mode-compile-after-compile-hook
(global-set-key (kbd "C-c r") 'remember)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "<f2>") 'eshell)
;; ruby stuff

(global-set-key (kbd "C-x C-d") 'ido-dired)

(global-set-key (kbd "M-/") 'cua-set-rectangle-mark)

(eval-after-load 'ruby-mode
  '(progn
     (require 'rinari)
     (define-key rinari-minor-mode-map (kbd "H-c") 'rinari-find-controller)
     (define-key rinari-minor-mode-map (kbd "H-m") 'rinari-find-model)
     (define-key rinari-minor-mode-map (kbd "H-v") 'rinari-find-view)))


(eval-after-load 'malabar-mode
  '(progn
     (define-key malabar-mode-map (kbd "RET") 'newline-and-indent)
     (define-key malabar-mode-map (kbd "M-t") 'semantic-ia-complete-symbol-menu)
     (define-key malabar-mode-map (kbd "<tab>") 'yas/expand)
     (setq yas/fallback-behaviour 'indent-for-tab-command)))

(provide 'nimai-keycommands)
