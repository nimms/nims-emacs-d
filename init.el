;;; init.el --- Emacs configuration  -*- lexical-binding: t -*-

;;----------------------------------------------------------------------------
;; PACKAGE BOOTSTRAP
;;----------------------------------------------------------------------------
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
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
      default-directory "~/"
      backup-directory-alist
      `(("." . ,(expand-file-name (concat "~/.emacs_backups/" (user-login-name) "/")))))

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

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(dolist (hook '(term-mode-hook comint-mode-hook compilation-mode-hook))
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
  (set-frame-font "Monaco-12" nil t))

(add-to-list 'load-path (expand-file-name "themes" user-emacs-directory))
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

(use-package color-theme-sanityinc-tomorrow
  :config (load-theme 'sanityinc-tomorrow-night t))

(use-package nyan-mode
  :config (nyan-mode 1))

;;----------------------------------------------------------------------------
;; COMPLETION — VERTICO + CORFU
;;----------------------------------------------------------------------------
(use-package vertico
  :init (vertico-mode 1))

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

;;; init.el ends here
