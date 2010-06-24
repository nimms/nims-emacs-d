
;; window size commands
(global-set-key (kbd "C-x 7") 'three-quarters-window)
(global-set-key (kbd "C-x 8") 'half-window)
(global-set-key (kbd "<f7>") 'rename-buffer)
(global-set-key [(meta return)] 'toggle-fullscreen)


;;reload the current page in firefox
(global-set-key (kbd "C-x p")
                (lambda ()
                  (interactive)
                  (comint-send-string (inferior-moz-process)
                                      "BrowserReload();")))


;;org mode
(global-set-key (kbd "C-c r") 'remember)
;(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)

;;wind move
(global-set-key (kbd "C-c h") 'windmove-left)
(global-set-key (kbd "C-c l") 'windmove-right)
(global-set-key (kbd "C-c j") 'windmove-down)
(global-set-key (kbd "C-c k") 'windmove-up)

;; egg
(global-set-key (kbd "<f8>") 'egg-status)

;; ruby stuff

(eval-after-load 'ruby-mode
  '(progn
     (require 'rinari)
     (define-key rinari-minor-mode-map (kbd "C-M-c") 'rinari-find-controller)
     (define-key rinari-minor-mode-map (kbd "C-M-m") 'rinari-find-model)
     (define-key rinari-minor-mode-map (kbd "C-M-v") 'rinari-find-view)))



(provide 'nimai-keycommands)