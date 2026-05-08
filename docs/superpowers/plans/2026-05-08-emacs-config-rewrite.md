# Emacs Config Rewrite Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace a broken 2014-era multi-file Emacs config with a single `init.el` using `use-package`, targeting Emacs 30.2 for Python, JavaScript, SSH, vterm, and custom keybindings.

**Architecture:** Single `init.el` built up section by section; each `use-package` block owns its config, hooks, and keybindings. Old files moved to `archived/`. Custom themes preserved in `themes/`.

**Tech Stack:** Emacs 30.2, use-package (built-in), MELPA/GNU ELPA (HTTPS), eglot (built-in), treesit-auto, vertico, orderless, marginalia, corfu, cape, consult, avy, magit, vterm, multiple-cursors, expand-region, move-text, whole-line-or-region, nyan-mode, color-theme-sanityinc-tomorrow

---

## Verification commands (used throughout)

**Syntax check** (no packages needed, fast):
```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: warnings about undefined variables are OK; no `Error:` lines.

**Full load test** (run after all packages installed):
```bash
emacs --batch --load ~/.emacs.d/init.el 2>&1 | grep -iE "^.*[Ee]rror|Cannot open|void-function|void-variable"
```
Expected: no output.

---

## Task 1: File cleanup

**Files:**
- Create: `~/.emacs.d/themes/`
- Create: `~/.emacs.d/archived/` (may already exist)
- Move: all listed files into `archived/`
- Copy: `nimms-color.el` and `nims-theme-theme.el` into `themes/`

- [ ] **Step 1: Create themes directory**

```bash
mkdir -p ~/.emacs.d/themes
```

- [ ] **Step 2: Copy custom themes to themes/**

```bash
cp ~/.emacs.d/nimms-color.el ~/.emacs.d/themes/
cp ~/.emacs.d/nims-theme-theme.el ~/.emacs.d/themes/
```

- [ ] **Step 3: Move old init files to archived/**

```bash
cd ~/.emacs.d
mkdir -p archived
mv init-autocomplete.el init-css.el init-editing-utils.el init-elpa.el \
   init-exec-path.el init-flymake.el init-frame-hooks.el init-haml.el \
   init-helm.el init-ido.el init-isearch.el init-javascript.el init-php.el \
   init-python.el init-rails.el init-recentf.el init-ruby.el init-ruby-bak.el \
   init-sh.el init-utils.el init-webmode.el init-xterm.el archived/ 2>/dev/null; true
```

- [ ] **Step 4: Move old user config files to archived/**

```bash
cd ~/.emacs.d
mv nimms.el nimai-keycommands.el nimms-functions.el hooks.el archived/ 2>/dev/null; true
```

- [ ] **Step 5: Move old color theme files to archived/**

```bash
cd ~/.emacs.d
mv color-theme-active.el color-theme-less.el color-theme-obsolescence.el \
   color-theme-subdued.el color-theme-tango.el color-theme-tangotango.el \
   color-theme-tomorrow.el color-theme-wombat.el color-theme-nimms-new.el \
   nimms-color.el nims-theme-theme.el archived/ 2>/dev/null; true
```

- [ ] **Step 6: Move old loose plugin/package files to archived/**

```bash
cd ~/.emacs.d
mv auto-complete.el auto-complete-config.el auto-complete-etags.el \
   ac-yasnippet.el fuzzy.el popup.el parenface.el loaddefs.el \
   nimai-clisp.el archived/ 2>/dev/null; true
```

- [ ] **Step 7: Move old directories to archived/**

```bash
cd ~/.emacs.d
mv egg archived/ 2>/dev/null; true
mv nyan archived/ 2>/dev/null; true
mv ac-dict archived/ 2>/dev/null; true
```

- [ ] **Step 8: Verify themes/ has both files**

```bash
ls ~/.emacs.d/themes/
```
Expected: `nimms-color.el  nims-theme-theme.el`

- [ ] **Step 9: Commit**

```bash
cd ~/.emacs.d
git add -A
git commit -m "chore: archive old config files, create themes/ directory"
```

---

## Task 2: Create init.el — Package Bootstrap

**Files:**
- Create: `~/.emacs.d/init.el` (replaces existing)

- [ ] **Step 1: Write the new init.el with package bootstrap only**

Replace the entire contents of `~/.emacs.d/init.el` with:

```elisp
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

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: init.el skeleton with package bootstrap"
```

---

## Task 3: Core Settings + macOS

**Files:**
- Modify: `~/.emacs.d/init.el` — add core settings and macOS sections before the final comment

- [ ] **Step 1: Add core settings and macOS blocks**

In `init.el`, replace `;;; init.el ends here` with:

```elisp
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

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: add core settings and macOS config"
```

---

## Task 4: UI / Theme

**Files:**
- Modify: `~/.emacs.d/init.el`

- [ ] **Step 1: Add UI and theme block**

In `init.el`, replace `;;; init.el ends here` with:

```elisp
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

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: add UI and theme config"
```

---

## Task 5: Completion — Vertico + Corfu

**Files:**
- Modify: `~/.emacs.d/init.el`

- [ ] **Step 1: Add completion block**

In `init.el`, replace `;;; init.el ends here` with:

```elisp
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

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: add vertico/corfu completion stack"
```

---

## Task 6: Search / Navigation — Consult + Avy

**Files:**
- Modify: `~/.emacs.d/init.el`

- [ ] **Step 1: Add search and navigation block**

In `init.el`, replace `;;; init.el ends here` with:

```elisp
;;----------------------------------------------------------------------------
;; SEARCH / NAVIGATION — CONSULT + AVY
;;----------------------------------------------------------------------------
(use-package consult)

(use-package avy)

(use-package page-break-lines
  :config (global-page-break-lines-mode 1))

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: add consult/avy search and navigation"
```

---

## Task 7: Git — Magit

**Files:**
- Modify: `~/.emacs.d/init.el`

- [ ] **Step 1: Add magit block**

In `init.el`, replace `;;; init.el ends here` with:

```elisp
;;----------------------------------------------------------------------------
;; GIT — MAGIT
;;----------------------------------------------------------------------------
(use-package magit)

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: add magit"
```

---

## Task 8: LSP — Eglot + Tree-sitter + Languages

**Files:**
- Modify: `~/.emacs.d/init.el`

**Prerequisites:** Before this task loads correctly, install LSP servers:
```bash
npm install -g pyright typescript typescript-language-server
```

- [ ] **Step 1: Add eglot, tree-sitter, and language blocks**

In `init.el`, replace `;;; init.el ends here` with:

```elisp
;;----------------------------------------------------------------------------
;; TREE-SITTER + LANGUAGES
;;----------------------------------------------------------------------------
(use-package treesit-auto
  :custom (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

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

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: add eglot LSP with Python and JS/TS support"
```

---

## Task 9: Terminal — vterm

**Files:**
- Modify: `~/.emacs.d/init.el`

**Note:** vterm requires `cmake` and `libvterm`. On macOS: `brew install cmake libvterm`.

- [ ] **Step 1: Add vterm block**

In `init.el`, replace `;;; init.el ends here` with:

```elisp
;;----------------------------------------------------------------------------
;; TERMINAL — VTERM
;;----------------------------------------------------------------------------
(use-package vterm)

(defun visit-vterm ()
  "Switch to existing vterm buffer, rename if already in vterm, or create new."
  (interactive)
  (if (equal "*vterm*" (buffer-name))
      (call-interactively #'rename-buffer)
    (if (get-buffer "*vterm*")
        (switch-to-buffer "*vterm*")
      (vterm))))

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: add vterm terminal"
```

---

## Task 10: Editing Utilities

**Files:**
- Modify: `~/.emacs.d/init.el`

- [ ] **Step 1: Add editing utilities block**

In `init.el`, replace `;;; init.el ends here` with:

```elisp
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

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: no errors.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: add editing utilities"
```

---

## Task 11: Custom Functions + Keybindings

**Files:**
- Modify: `~/.emacs.d/init.el`

- [ ] **Step 1: Add custom functions and keybindings**

In `init.el`, replace `;;; init.el ends here` with:

```elisp
;;----------------------------------------------------------------------------
;; CUSTOM FUNCTIONS
;;----------------------------------------------------------------------------
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
;; KEYBINDINGS
;;----------------------------------------------------------------------------

;; M-x
(global-set-key (kbd "M-a") #'execute-extended-command)
(global-set-key (kbd "C-x C-m") #'execute-extended-command)

;; Buffer/file navigation (Consult replaces Helm)
(global-set-key (kbd "M-b") #'consult-buffer)
(global-set-key (kbd "M-[") #'consult-find)
(global-set-key (kbd "M-{") #'consult-recent-file)
(global-set-key (kbd "M-t") #'project-find-file)

;; Window management (ergoemacs-style)
(global-set-key (kbd "M-0") #'delete-window)
(global-set-key (kbd "M-1") #'delete-other-windows)
(global-set-key (kbd "M-2")
                (lambda () (interactive)
                  (split-window-vertically) (other-window 1)))
(global-set-key (kbd "M-3")
                (lambda () (interactive)
                  (split-window-horizontally) (other-window 1)))

;; Search
(global-set-key (kbd "M-;") #'isearch-forward)
(global-set-key (kbd "M-:") #'isearch-backward)
(define-key isearch-mode-map (kbd "M-;") #'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "M-:") #'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "C-o") #'isearch-occur)
(define-key isearch-mode-map [(meta z)] #'zap-to-isearch)
(define-key isearch-mode-map [(control return)] #'isearch-exit-other-end)
(define-key isearch-mode-map "\C-\M-w" #'isearch-yank-symbol)

;; Editing
(global-set-key (kbd "RET") #'newline-and-indent)
(global-set-key (kbd "M-m") #'back-to-indentation)
(global-set-key (kbd "M-w") #'kill-ring-save)
(global-set-key (kbd "M-C") #'nimms-copy-line)
(global-set-key (kbd "M-Z") #'zap-up-to-char)
(global-set-key (kbd "M-T") #'transpose-lines)
(global-set-key (kbd "C-o") #'open-line)
(global-set-key (kbd "H-i") #'open-line)
(global-set-key (kbd "C-M-g") #'goto-line)
(global-set-key (kbd "C-k") #'kill-current-buffer)
(global-set-key (kbd "C-c C-r") #'revert-buffer)
(global-set-key (kbd "C-c j") #'join-line)
(global-set-key (kbd "C-c J") (lambda () (interactive) (join-line 1)))
(global-set-key (kbd "C-.") #'set-mark-command)
(global-set-key (kbd "C-x C-.") #'pop-global-mark)
(global-set-key (kbd "C-c p") #'duplicate-line)
(global-set-key (kbd "C-M-<backspace>") #'kill-back-to-indentation)
(global-unset-key [M-left])
(global-unset-key [M-right])

;; Completion / expand
(global-set-key (kbd "C-=") #'er/expand-region)

;; Multiple cursors
(global-set-key (kbd "C-<") #'mc/mark-previous-like-this)
(global-set-key (kbd "C->") #'mc/mark-next-like-this)
(global-set-key (kbd "C-+") #'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") #'mc/mark-all-like-this)
(global-set-key (kbd "C-c c r") #'set-rectangular-region-anchor)
(global-set-key (kbd "C-c c c") #'mc/edit-lines)
(global-set-key (kbd "C-c c e") #'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c c a") #'mc/edit-beginnings-of-lines)

;; Avy (replaces ace-jump)
(global-set-key (kbd "C-;") #'avy-goto-char)
(global-set-key (kbd "C-:") #'avy-goto-word-1)

;; Hyper keys (Option key on macOS)
(global-set-key (kbd "H-c") #'copy-all)
(global-set-key (kbd "H-p") #'mark-lines-previous-line)
(global-set-key (kbd "H-n") #'mark-lines-next-line)

;; Function keys
(global-set-key (kbd "<f2>") #'visit-vterm)
(global-set-key (kbd "<f5>") #'consult-ripgrep)
(global-set-key (kbd "<f7>") #'rename-buffer)
(global-set-key (kbd "<f8>") #'magit-status)
(global-set-key (kbd "<f9>") #'rgrep)
(global-set-key (kbd "C-<return>") #'toggle-fullscreen)

;; mark-lines plugin (provides mark-lines-previous-line, mark-lines-next-line)
(load "mark-lines" 'noerror)

;;; init.el ends here
```

- [ ] **Step 2: Syntax check**

```bash
emacs -Q --batch --eval '(byte-compile-file (expand-file-name "~/.emacs.d/init.el"))' 2>&1 | grep -v "^Wrote\|^$\|^In toplevel"
```
Expected: warnings about undefined `mc/`, `er/`, `avy-`, `consult-`, `cape-` symbols are OK (packages not loaded in batch); no `Error:` lines.

- [ ] **Step 3: Commit**

```bash
cd ~/.emacs.d
git add init.el
git commit -m "feat: add custom functions and keybindings"
```

---

## Task 12: First Launch and Package Installation

**Files:** none — this task installs packages and verifies startup

- [ ] **Step 1: Install vterm system dependencies (macOS)**

```bash
brew install cmake libvterm
```
Expected: cmake and libvterm installed.

- [ ] **Step 2: Install LSP servers**

```bash
npm install -g pyright typescript typescript-language-server
```
Expected: all three packages installed globally.

- [ ] **Step 3: Launch Emacs for first time**

Run `emacs` in your terminal. On first launch, Emacs will:
1. Download and install all `use-package` dependencies from MELPA (~16 packages)
2. Compile vterm's native module (takes ~30 seconds)
3. Prompt to install tree-sitter grammars (answer `y`)

This may take 1-3 minutes.

- [ ] **Step 4: Check *Messages* buffer for errors**

In Emacs: `C-h e` (opens `*Messages*`)

Search for errors:
```
M-; error
```
Expected: no lines containing "Error", "void-function", "Cannot open load file".

- [ ] **Step 5: Verify key packages loaded**

In Emacs, run each of these and confirm they work:
- `M-a` → opens command completion (vertico minibuffer)
- `M-b` → opens buffer list (consult-buffer)
- `F8` → opens magit status
- `F2` → opens vterm terminal
- `C-;` → prompts for avy jump char

- [ ] **Step 6: Test Python LSP**

Open a `.py` file. Within a few seconds, you should see eglot start in the mode line (`[pyright]`). Type a function name and confirm completions appear via corfu popup.

- [ ] **Step 7: Install tree-sitter grammars if not prompted automatically**

If opening a `.py` or `.js` file doesn't use tree-sitter mode, run:
```
M-x treesit-install-language-grammar RET python RET
M-x treesit-install-language-grammar RET javascript RET
M-x treesit-install-language-grammar RET typescript RET
M-x treesit-install-language-grammar RET tsx RET
```

- [ ] **Step 8: Full batch load test**

```bash
emacs --batch --load ~/.emacs.d/init.el 2>&1 | grep -iE "^.*[Ee]rror|Cannot open|void-function|void-variable"
```
Expected: no output (clean load).

- [ ] **Step 9: Final commit**

```bash
cd ~/.emacs.d
git add -A
git commit -m "feat: complete Emacs config rewrite for Emacs 30.2"
```

---

## Quick reference: complete init.el section order

For reference, the final `init.el` sections in order:

1. Package bootstrap (`require 'package`, `use-package`)
2. Core settings (`setq-default`, modes, uniquify, tramp, load-path)
3. macOS (`mac-command-modifier`, `exec-path-from-shell`)
4. UI/Theme (chrome, font, `color-theme-sanityinc-tomorrow`, `nyan-mode`)
5. Completion (`vertico`, `orderless`, `marginalia`, `corfu`, `cape`)
6. Search/Navigation (`consult`, `avy`, `page-break-lines`)
7. Git (`magit`)
8. LSP (`treesit-auto`, `eglot`)
9. Terminal (`vterm`, `visit-vterm`)
10. Editing utilities (`multiple-cursors`, `expand-region`, `move-text`, `whole-line-or-region`, inline functions)
11. Custom functions (`nimms-copy-line`, `copy-all`, SSH helpers, etc.)
12. Keybindings (all `global-set-key` calls, `mark-lines` load)
