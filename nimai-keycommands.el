(global-set-key (kbd "<f5>") 'nimms-toggle-selective-display)
(global-set-key (kbd "<f7>") 'rename-buffer)
(global-set-key (kbd "<f8>") 'egg-status)
(global-set-key (kbd "<f9>") 'rgrep)
(global-set-key [(meta return)] 'toggle-fullscreen)


(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-x C-t") 'eterminal/run-terminal)
;;reload the current page in firefox
(global-set-key (kbd "C-x p")
                (lambda ()
                  (interactive)
                  (comint-send-string (inferior-moz-process)
                                      "BrowserReload();")))

(global-set-key (kbd "C-z") 'repeat)
;;org mode
;;(global-set-key (kbd "C-c r") 'remember)
;(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

(global-set-key (kbd "<f2>") 'visit-ansi-term)
;; ruby stuff

(global-set-key (kbd "C-x C-d") 'ido-dired)

(eval-after-load 'ruby-mode
  '(progn
     (require 'rinari)
     (define-key rinari-minor-mode-map (kbd "C-M-c") 'rinari-find-controller)
     (define-key rinari-minor-mode-map (kbd "C-M-m") 'rinari-find-model)
     (define-key rinari-minor-mode-map (kbd "C-M-v") 'rinari-find-view)))



(provide 'nimai-keycommands)