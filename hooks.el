

(add-hook 'nxhtml-mode-hook 'nxhtml-custom-setup)
(add-hook 'haml-mode-hook 'auto-reload-firefox-on-after-save-hook)
(add-hook 'css-mode-hook 'auto-reload-firefox-on-after-save-hook)
(add-hook 'js-mode-hook 'auto-reload-firefox-on-after-save-hook)


(add-hook 'ruby-mode-hook 'ruby-custom-setup)
(defun ruby-custom-setup ()
  ;;(pabbrev-mode 1)
  (enclose-mode t))


(add-hook 'js-mode-hook 'js-custom-setup)
(defun js-custom-setup ()
  (moz-minor-mode 1)
  (enclose-mode t))
  ;;(pabbrev-mode 1))

(defun nxhtml-custom-setup ()
  (auto-reload-firefox-on-after-save-hook)
  (enclose-mode))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'message-mode-hook 'color-theme-tangotango)
(add-hook 'gnus-article-mode-hook 'color-theme-tangotango)

(add-hook 'after-make-frame-functions
	  (lambda (frame)
	    (set-variable 'color-theme-is-global nil)
	    (select-frame frame)
	    (if window-system
		(color-theme-tangotango)
	      (color-theme-ld-dark))))

