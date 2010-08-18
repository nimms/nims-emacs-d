(setq local-function-key-map (delq '(kp-tab . [9]) local-function-key-map))

(global-set-key (kbd "<f5>") 'nimms-toggle-selective-display)
(global-set-key (kbd "<f7>") 'rename-buffer)
(global-set-key (kbd "<f8>") 'egg-status)
(global-set-key (kbd "<f9>") 'rgrep)
(global-set-key [(meta return)] 'toggle-fullscreen)


(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-set-key (kbd "C-x C-t") 'eterminal/run-terminal)
;;reload the current page in firefox
(global-set-key (kbd "C-x p")
                (lambda ()
                  (interactive)
                  (comint-send-string (inferior-moz-process)
                                      "BrowserReload();")))

(global-set-key (kbd "C-z") 'repeat)
;;org mode
(global-set-key (kbd "C-c r") 'remember)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "<f2>") 'visit-ansi-term)
;; ruby stuff

(global-set-key (kbd "C-x C-d") 'ido-dired)

(global-set-key (kbd "<f10>") 'my-key-swap)
(global-set-key (kbd "S-<f10>") 'my-key-restore)
(global-set-key [(control return)] 'hippie-expand)
(global-set-key (kbd "M-/") 'cua-set-rectangle-mark)

(global-set-key [f10]         '(lambda () (interactive) (my-key-swap    my-key-pairs)))
(global-set-key [S-f10]       '(lambda () (interactive) (my-key-restore my-key-pairs)))


(eval-after-load 'ruby-mode
  '(progn
     (require 'rinari)
     (define-key rinari-minor-mode-map (kbd "C-M-c") 'rinari-find-controller)
     (define-key rinari-minor-mode-map (kbd "C-M-m") 'rinari-find-model)
     (define-key rinari-minor-mode-map (kbd "C-M-v") 'rinari-find-view)))


(eval-after-load 'malabar-mode
  '(progn
     (define-key malabar-mode-map (kbd "RET") 'newline-and-indent)
     (define-key malabar-mode-map (kbd "C-t") 'semantic-ia-complete-symbol-menu)
     (define-key malabar-mode-map (kbd "<tab>") 'yas/expand)
     (setq yas/fallback-behaviour 'indent-for-tab-command)))

(provide 'nimai-keycommands)