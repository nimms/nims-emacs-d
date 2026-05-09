;;; nimms-color-theme.el --- Dark theme by Nimai Etheridge -*- lexical-binding: t -*-
;; Original: color-theme-install format, 2009-02-02
;; Converted to deftheme 2026

(deftheme nimms-color
  "Dark theme by Nimai Etheridge (2009), converted to deftheme.")

(custom-theme-set-faces
 'nimms-color

 ;; Core
 '(default ((t (:background "black" :foreground "White"))))
 '(cursor ((t (:background "yellow"))))
 '(fringe ((t (:background "DarkSlateBlue"))))
 '(border ((t (:background "black"))))
 '(vertical-border ((t nil)))
 '(mouse ((t (:background "black"))))

 ;; Highlighting / selection
 '(highlight ((t (:background "darkolivegreen"))))
 '(hl-line ((t (:background "darkolivegreen"))))
 '(region ((t (:background "LavenderBlush4"))))
 '(secondary-selection ((t (:background "darkslateblue"))))
 '(match ((t (:background "RoyalBlue3"))))
 '(next-error ((t (:background "blue"))))

 ;; Search
 '(isearch ((t (:background "blue"))))
 '(isearch-fail ((t (:background "red4"))))
 '(lazy-highlight ((t (:background "paleturquoise4"))))

 ;; Mode line
 '(mode-line ((t (:background "RoyalBlue3" :foreground "white"
                  :box (:line-width 1 :style released-button)))))
 '(mode-line-buffer-id ((t (:background "RoyalBlue4" :foreground "white"))))
 '(mode-line-highlight ((t (:box (:line-width 2 :color "grey40"
                                  :style released-button)))))
 '(mode-line-inactive ((t (:background "grey30" :foreground "grey80"
                            :box (:line-width -1 :color "grey40") :weight light))))
 '(header-line ((t (:background "grey90" :foreground "grey20" :box nil))))

 ;; Minibuffer / prompts
 '(minibuffer-prompt ((t (:foreground "cyan"))))
 '(shadow ((t (:foreground "grey70"))))
 '(file-name-shadow ((t (:foreground "grey70"))))
 '(escape-glyph ((t (:foreground "cyan"))))
 '(nobreak-space ((t (:foreground "cyan" :underline t))))

 ;; Font lock
 '(font-lock-builtin-face ((t (:foreground "LightSteelBlue"))))
 '(font-lock-comment-face ((t (:foreground "orchid"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "orchid"))))
 '(font-lock-constant-face ((t (:foreground "Aquamarine"))))
 '(font-lock-doc-face ((t (:foreground "Orange"))))
 '(font-lock-function-name-face ((t (:foreground "YellowGreen"))))
 '(font-lock-keyword-face ((t (:foreground "PaleYellow"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:foreground "Aquamarine"))))
 '(font-lock-string-face ((t (:foreground "DarkOliveGreen1"))))
 '(font-lock-type-face ((t (:foreground "Green"))))
 '(font-lock-variable-name-face ((t (:foreground "darkseagreen"))))
 '(font-lock-warning-face ((t (:bold t :foreground "Pink" :weight bold))))
 '(font-lock-regexp-grouping-backslash ((t (:bold t :weight bold))))
 '(font-lock-regexp-grouping-construct ((t (:bold t :weight bold))))

 ;; Parens
 '(show-paren-match ((t (:background "Aquamarine" :foreground "SlateBlue"))))
 '(show-paren-mismatch ((t (:background "Red" :foreground "White"))))

 ;; Links / buttons
 '(button ((t (:underline t))))
 '(link ((t (:foreground "cyan1" :underline t))))
 '(link-visited ((t (:foreground "violet" :underline t))))

 ;; Trailing whitespace
 '(trailing-whitespace ((t (:background "red"))))

 ;; Compilation
 '(compilation-column-number ((t (:foreground "Green"))))
 '(compilation-error ((t (:bold t :foreground "Pink" :weight bold))))
 '(compilation-info ((t (:bold t :foreground "Green1" :weight bold))))
 '(compilation-line-number ((t (:foreground "darkseagreen"))))
 '(compilation-warning ((t (:bold t :foreground "Orange" :weight bold))))

 ;; Comint
 '(comint-highlight-input ((t (:bold t :weight bold))))
 '(comint-highlight-prompt ((t (:foreground "DeepSkyBlue3"))))

 ;; Dired
 '(dired-directory ((t (:foreground "YellowGreen"))))
 '(dired-flagged ((t (:bold t :foreground "Pink" :weight bold))))
 '(dired-header ((t (:foreground "Green"))))
 '(dired-ignored ((t (:foreground "grey70"))))
 '(dired-mark ((t (:foreground "Aquamarine"))))
 '(dired-marked ((t (:bold t :foreground "Pink" :weight bold))))
 '(dired-symlink ((t (:foreground "PaleYellow"))))
 '(dired-warning ((t (:bold t :foreground "Pink" :weight bold))))

 ;; Eshell
 '(eshell-ls-archive ((t (:bold t :foreground "IndianRed" :weight bold))))
 '(eshell-ls-backup ((t (:foreground "Grey"))))
 '(eshell-ls-clutter ((t (:foreground "DimGray"))))
 '(eshell-ls-directory ((t (:bold t :foreground "MediumSlateBlue" :weight bold))))
 '(eshell-ls-executable ((t (:foreground "Coral"))))
 '(eshell-ls-missing ((t (:foreground "black"))))
 '(eshell-ls-product ((t (:foreground "sandybrown"))))
 '(eshell-ls-readonly ((t (:foreground "Aquamarine"))))
 '(eshell-ls-special ((t (:foreground "Gold"))))
 '(eshell-ls-symlink ((t (:foreground "White"))))
 '(eshell-ls-unreadable ((t (:foreground "DimGray"))))
 '(eshell-prompt ((t (:foreground "MediumAquamarine"))))

 ;; Info
 '(info-node ((t (:bold t :foreground "DodgerBlue1" :underline t :weight bold))))
 '(info-xref ((t (:foreground "DodgerBlue1" :underline t))))
 '(info-xref-visited ((t (:foreground "violet" :underline t))))

 ;; Widget / custom
 '(widget-button ((t (:bold t :weight bold))))
 '(widget-button-pressed ((t (:foreground "red"))))
 '(widget-documentation ((t (:foreground "lime green"))))
 '(widget-field ((t (:background "dim gray"))))
 '(widget-inactive ((t (:foreground "light gray"))))
 '(custom-state ((t (:foreground "lime green"))))
 '(custom-variable-tag ((t (:foreground "light blue" :underline t))))
 '(custom-group-tag ((t (:foreground "light blue" :underline t))))
 '(custom-face-tag ((t (:underline t))))

 ;; Message / mail
 '(message-cited-text ((t (:bold t :foreground "green" :weight bold))))
 '(message-header-name ((t (:bold t :foreground "orange" :weight bold))))
 '(message-header-subject ((t (:bold t :foreground "yellow" :weight bold))))
 '(message-header-to ((t (:bold t :foreground "cadetblue" :weight bold))))
 '(message-mml ((t (:bold t :foreground "Green3" :weight bold)))))

(custom-theme-set-variables
 'nimms-color
 '(frame-background-mode 'dark))

(provide-theme 'nimms-color)

;;; nimms-color-theme.el ends here
