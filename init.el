;;; init.el --- Emacs configuration  -*- lexical-binding: t -*-

(let ((elc (concat user-init-file "c")))
  (when (and (file-exists-p elc) (file-newer-than-file-p user-init-file elc))
    (delete-file elc)))

;;----------------------------------------------------------------------------
;; PACKAGE BOOTSTRAP
;;----------------------------------------------------------------------------
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)

(when (null package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;;----------------------------------------------------------------------------
;; CORE SETTINGS
;;----------------------------------------------------------------------------
(setq-default
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 auto-save-default nil
 indent-tabs-mode nil
 show-trailing-whitespace t
 blink-cursor-delay 0
 blink-cursor-interval 0.4
 line-spacing 0.2
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t
 mouse-yank-at-point t
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain)

(setq use-short-answers t
      default-directory "~/")

(let ((backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/")))
  (make-directory backup-dir t)
  (setq backup-directory-alist `(("." . ,backup-dir))))

(save-place-mode 1)
(recentf-mode 1)
(electric-pair-mode 1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)
(show-paren-mode 1)
(setq show-paren-delay 0.0)
(column-number-mode 1)
(display-time-mode 1)
(transient-mark-mode 1)
(cua-selection-mode 1)
(winner-mode 1)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(dolist (hook '(term-mode-hook comint-mode-hook compilation-mode-hook vterm-mode-hook))
  (add-hook hook (lambda () (setq show-trailing-whitespace nil))))

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq tramp-default-method "ssh"
      tramp-chunksize 500)

;; plugins/ directory (mark-lines, etc.)
(add-to-list 'load-path (expand-file-name "plugins" user-emacs-directory))

;;----------------------------------------------------------------------------
;; macOS
;;----------------------------------------------------------------------------
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta
        mac-option-modifier 'hyper
        ns-use-native-fullscreen nil)
  (use-package exec-path-from-shell
    :config (exec-path-from-shell-initialize)))

;;----------------------------------------------------------------------------
;; UI / THEME
;;----------------------------------------------------------------------------
(scroll-bar-mode -1)
(tool-bar-mode -1)

(when (and (eq system-type 'darwin) (display-graphic-p))
  (set-frame-font "Monaspace Neon-12" nil t))

(use-package doom-themes
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package nyan-mode
  :config (nyan-mode 1))

(custom-set-faces
 '(mode-line          ((t (:background "#FFD700" :foreground "black"
                           :box (:line-width 1 :style released-button)))))
 '(mode-line-inactive ((t (:background "#7a6500" :foreground "#ffd080"
                           :box (:line-width 1 :color "#7a6500")))))
 '(mode-line-buffer-id ((t (:foreground "black" :weight bold)))))

;;----------------------------------------------------------------------------
;; COMPLETION — VERTICO + CORFU
;;----------------------------------------------------------------------------
(use-package vertico
  :init (vertico-mode 1)
  :bind (:map vertico-map
         ("M-k" . vertico-next)
         ("M-i" . vertico-previous)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :init (marginalia-mode 1))

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-quit-no-match 'separator)
  :init (global-corfu-mode 1))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;;----------------------------------------------------------------------------
;; SEARCH / NAVIGATION — CONSULT + AVY
;;----------------------------------------------------------------------------
(use-package consult)

(use-package avy)

(use-package page-break-lines
  :config (global-page-break-lines-mode 1))

;;----------------------------------------------------------------------------
;; GIT — MAGIT
;;----------------------------------------------------------------------------
(use-package magit)

;;----------------------------------------------------------------------------
;; TREE-SITTER + LANGUAGES
;;----------------------------------------------------------------------------
(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :custom (markdown-command "multimarkdown"))

;;----------------------------------------------------------------------------
;; LSP — EGLOT (built-in, Emacs 29+)
;;----------------------------------------------------------------------------
(use-package eglot
  :ensure nil
  :hook
  ((python-ts-mode    . eglot-ensure)
   (js-ts-mode        . eglot-ensure)
   (tsx-ts-mode       . eglot-ensure)
   (typescript-ts-mode . eglot-ensure))
  :config
  (add-to-list 'eglot-server-programs
               '((js-ts-mode tsx-ts-mode typescript-ts-mode)
                 . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(python-ts-mode . ("pyright-langserver" "--stdio"))))

;;----------------------------------------------------------------------------
;; TERMINAL — VTERM
;;----------------------------------------------------------------------------
(use-package vterm
  :custom
  (vterm-keymap-exceptions
   '("M-a" "M-s" "M-S" "M-0" "M-1" "M-2" "M-3" "M-b" "M-t"
     "M-j" "M-l" "M-i" "M-k" "M-u" "M-o" "M-U" "M-O"
     "M-I" "M-K" "M-J" "M-L" "M-h" "M-H" "M-p"
     "M-d" "M-f" "M-e" "M-r" "M-g" "M-G" "M-z"
     "M-y" "C-c" "C-x" "C-u" "C-g" "C-l" "M-x" "<f2>")))


(defun visit-vterm ()
  "Switch to existing vterm buffer, rename if already in vterm, or create new."
  (interactive)
  (if (equal "*vterm*" (buffer-name))
      (call-interactively #'rename-buffer)
    (if (get-buffer "*vterm*")
        (switch-to-buffer "*vterm*")
      (vterm))))

;;----------------------------------------------------------------------------
;; EDITING UTILITIES
;;----------------------------------------------------------------------------
(use-package multiple-cursors)

(use-package expand-region)

(use-package move-text
  :config (move-text-default-bindings))

(use-package whole-line-or-region
  :config (whole-line-or-region-global-mode 1))

(autoload 'zap-up-to-char "misc" "Kill up to, but not including ARGth occurrence of CHAR.")

(defun duplicate-line ()
  "Duplicate the current line below."
  (interactive)
  (save-excursion
    (let ((line-text (buffer-substring-no-properties
                      (line-beginning-position)
                      (line-end-position))))
      (move-end-of-line 1)
      (newline)
      (insert line-text))))

(defun kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))

(defun isearch-exit-other-end ()
  "Exit isearch at the opposite end of the match."
  (interactive)
  (isearch-exit)
  (goto-char isearch-other-end))

(defun backward-up-sexp (arg)
  "Jump up to the start of the ARG'th enclosing sexp, handling strings."
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (backward-up-sexp (1- arg)))
          ((backward-up-list arg)))))

(defun sort-lines-random (beg end)
  "Sort lines in region randomly."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ((inhibit-field-text-motion t))
        (sort-subr nil 'forward-line 'end-of-line nil nil
                   (lambda (_s1 _s2) (eq (random 2) 0)))))))

(global-set-key [remap backward-up-list] #'backward-up-sexp)

;;----------------------------------------------------------------------------
;; CUSTOM FUNCTIONS
;;----------------------------------------------------------------------------
(defun load-init ()
  "Reload ~/.emacs.d/init.el."
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

(defun nimms-copy-line (arg)
  "Copy lines (as many as prefix argument) to the kill ring."
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(defun copy-all ()
  "Copy entire buffer contents to the kill ring."
  (interactive)
  (kill-ring-save (point-min) (point-max))
  (message "Buffer copied"))

(defun three-quarters-window ()
  "Resize current window to 75% of frame height."
  (interactive)
  (let ((size (- (truncate (* .75 (frame-height))) (window-height))))
    (when (> size 0) (enlarge-window size))))

(defun half-window ()
  "Resize current window to 50% of frame height."
  (interactive)
  (let ((size (- (truncate (* .5 (frame-height))) (window-height))))
    (when (> size 0) (enlarge-window size))))

(defun dos2unix ()
  "Convert buffer from DOS (CRLF) to Unix (LF) line endings."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (search-forward "\r" nil t)
      (replace-match ""))
    (goto-char (1- (point-max)))
    (when (looking-at "\C-z") (delete-char 1))))

(defun toggle-fullscreen ()
  "Toggle frame fullscreen."
  (interactive)
  (set-frame-parameter nil 'fullscreen
                        (unless (frame-parameter nil 'fullscreen) 'fullboth)))

(defun word-count ()
  "Count words in buffer."
  (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

(defun remote-term (new-buffer-name cmd &rest switches)
  "Open a terminal running CMD with SWITCHES in a buffer named NEW-BUFFER-NAME."
  (require 'term)
  (let ((buf-name (generate-new-buffer-name (concat "*" new-buffer-name "*"))))
    (setq buf-name (apply #'make-term buf-name cmd nil switches))
    (set-buffer buf-name)
    (term-mode)
    (term-char-mode)
    (term-set-escape-char ?\C-x)
    (switch-to-buffer buf-name)))

(defun web01 () (interactive) (remote-term "web01" "ssh" "web01"))
(defun web03 () (interactive) (remote-term "web03" "ssh" "web03"))
(defun deploy () (interactive) (remote-term "deploy" "ssh" "deploy"))

;;----------------------------------------------------------------------------
;; ERGOEMACS
;;----------------------------------------------------------------------------
(use-package ergoemacs-mode
  :init
  (setq ergoemacs-theme nil
        ergoemacs-keyboard-layout "us")
  :config
  (ergoemacs-mode 1)
  (when (eq system-type 'darwin)
    (setq mac-command-modifier 'meta
          mac-option-modifier 'hyper))
  ;; Clear ergoemacs key translations we override ourselves
  (define-key key-translation-map (kbd "M-u") nil)
  (define-key key-translation-map (kbd "M-o") nil))

;;----------------------------------------------------------------------------
;; KEYBINDINGS
;;----------------------------------------------------------------------------
;; nimms-keys-mode: override minor mode placed in emulation-mode-map-alists
;; so it beats ergoemacs (which also uses emulation-mode-map-alists but gets
;; added later — first entry wins).
(defvar nimms-keys-mode-map (make-sparse-keymap))
(define-minor-mode nimms-keys-mode "Custom key overrides."
  :global t :keymap nimms-keys-mode-map)
(nimms-keys-mode 1)

(add-to-list 'emulation-mode-map-alists
             `((nimms-keys-mode . ,nimms-keys-mode-map)))

;; Re-push to front after ergoemacs activates so we stay ahead of it.
(add-hook 'ergoemacs-mode-on-hook
          (lambda ()
            (setq emulation-mode-map-alists
                  (cons `((nimms-keys-mode . ,nimms-keys-mode-map))
                        (cl-remove-if (lambda (e)
                                        (and (listp e) (assq 'nimms-keys-mode e)))
                                      emulation-mode-map-alists)))))

(let ((m nimms-keys-mode-map))
  ;; M-x
  (define-key m (kbd "M-a") #'execute-extended-command)
  (define-key m (kbd "C-x C-m") #'execute-extended-command)

  ;; Buffer/file navigation
  (define-key m (kbd "M-b") #'consult-buffer)
  (define-key m (kbd "M-[") #'consult-find)
  (define-key m (kbd "M-{") #'consult-recent-file)
  (define-key m (kbd "M-t") #'project-find-file)

  ;; Window management
  (define-key m (kbd "M-s") #'other-window)
  (define-key m (kbd "M-S") (lambda () (interactive) (other-window -1)))
  (define-key m (kbd "M-0") #'delete-window)
  (define-key m (kbd "M-1") #'delete-other-windows)
  (define-key m (kbd "M-,") #'winner-undo)
  (define-key m (kbd "M-.") #'winner-redo)
  (define-key m (kbd "M-2") (lambda () (interactive)
                               (split-window-vertically) (other-window 1)))
  (define-key m (kbd "M-3") (lambda () (interactive)
                               (split-window-horizontally) (other-window 1)))

  ;; Search
  (define-key m (kbd "M-y") #'isearch-forward)
  (define-key m (kbd "M-;") #'isearch-forward)
  (define-key m (kbd "M-:") #'isearch-backward)

  ;; Word movement (ergoemacs layout)
  (define-key m (kbd "M-u") #'backward-word)
  (define-key m (kbd "M-o") #'forward-word)

  ;; Editing
  (define-key m (kbd "M-m") #'back-to-indentation)
  (define-key m (kbd "M-w") #'kill-ring-save)
  (define-key m (kbd "M-C") #'nimms-copy-line)
  (define-key m (kbd "M-Z") #'zap-up-to-char)
  (define-key m (kbd "M-T") #'transpose-lines)
  (define-key m (kbd "C-o") #'open-line)
  (define-key m (kbd "H-i") #'open-line)
  (define-key m (kbd "C-M-g") #'goto-line)
  (define-key m (kbd "C-k") #'kill-current-buffer)
  (define-key m (kbd "C-c C-r") #'revert-buffer)
  (define-key m (kbd "C-r") (lambda () (interactive)
                               (if (derived-mode-p 'vterm-mode)
                                   (vterm-send-C-r)
                                 (isearch-backward))))
  (define-key m (kbd "C-a") (lambda () (interactive)
                               (if (derived-mode-p 'vterm-mode)
                                   (vterm-send-C-a)
                                 (beginning-of-line))))
  (define-key m (kbd "C-e") (lambda () (interactive)
                               (if (derived-mode-p 'vterm-mode)
                                   (vterm-send-C-e)
                                 (end-of-line))))
  (define-key m (kbd "C-k") (lambda () (interactive)
                               (if (derived-mode-p 'vterm-mode)
                                   (vterm-send-C-k)
                                 (kill-current-buffer))))
  (define-key m (kbd "C-c j") #'join-line)
  (define-key m (kbd "C-c J") (lambda () (interactive) (join-line 1)))
  (define-key m (kbd "C-.") #'set-mark-command)
  (define-key m (kbd "C-x C-.") #'pop-global-mark)
  (define-key m (kbd "C-c p") #'duplicate-line)
  (define-key m (kbd "C-M-<backspace>") #'kill-back-to-indentation)

  ;; Completion / expand
  (define-key m (kbd "C-=") #'er/expand-region)

  ;; Multiple cursors
  (define-key m (kbd "C-<") #'mc/mark-previous-like-this)
  (define-key m (kbd "C->") #'mc/mark-next-like-this)
  (define-key m (kbd "C-+") #'mc/mark-next-like-this)
  (define-key m (kbd "C-c C-<") #'mc/mark-all-like-this)
  (define-key m (kbd "C-c c r") #'set-rectangular-region-anchor)
  (define-key m (kbd "C-c c c") #'mc/edit-lines)
  (define-key m (kbd "C-c c e") #'mc/edit-ends-of-lines)
  (define-key m (kbd "C-c c a") #'mc/edit-beginnings-of-lines)

  ;; Avy
  (define-key m (kbd "C-;") #'avy-goto-char)
  (define-key m (kbd "C-:") #'avy-goto-word-1)

  ;; Hyper keys (Option on macOS)
  (define-key m (kbd "H-c") #'copy-all)
  (define-key m (kbd "H-p") #'mark-lines-previous-line)
  (define-key m (kbd "H-n") #'mark-lines-next-line)

  ;; Function keys
  (define-key m (kbd "<f2>") #'visit-vterm)
  (define-key m (kbd "<f5>") #'consult-ripgrep)
  (define-key m (kbd "<f7>") #'rename-buffer)
  (define-key m (kbd "<f8>") #'magit-status)
  (define-key m (kbd "<f9>") #'rgrep)
  (define-key m (kbd "C-<return>") #'toggle-fullscreen))

(add-hook 'prog-mode-hook (lambda () (local-set-key (kbd "RET") #'newline-and-indent)))

;; isearch mode bindings (mode-local, unaffected by ergoemacs)
(define-key isearch-mode-map (kbd "M-;") #'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "M-:") #'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "C-o") #'isearch-occur)
(define-key isearch-mode-map [(meta z)] #'zap-to-isearch)
(define-key isearch-mode-map [(control return)] #'isearch-exit-other-end)
(define-key isearch-mode-map "\C-\M-w" #'isearch-yank-symbol)

;; mark-lines plugin (provides mark-lines-previous-line, mark-lines-next-line)
(load "mark-lines" 'noerror)

;;; init.el ends here
