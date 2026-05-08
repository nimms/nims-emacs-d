# Emacs Config Rewrite — Design Spec

**Date:** 2026-05-08  
**Scope:** Full rewrite of `~/.emacs.d` for Emacs 30.2  
**Primary use cases:** Python, JavaScript, SSH/TRAMP, vterm, custom keybindings

---

## Problem

The existing config dates from ~2014 (Emacs 24-era). It fails to load on Emacs 30.2 with two fatal errors:

1. `ergoemacs-mode` (2014 ELPA version) fails to activate via `package-initialize` — startup crashes at `nimms.el:27`
2. `package-desc-vers` (renamed to `package-desc-version` in modern Emacs) is called in `init-elpa.el:33` — would crash if package refresh is triggered

Additional non-fatal issues: deprecated `cl`, `defadvice`, `point-at-bol`, dead HTTP archive URLs, ~14 fragmented init files.

---

## Approach

Single `init.el` using `use-package` (built into Emacs 29+). Each feature is a self-contained block with its config, hooks, and keybindings co-located. No ergoemacs-mode — custom keybindings extracted from `nimai-keycommands.el` instead.

---

## File Plan

### New files
- `init.el` — single config replacing all init-*.el and nimms.el
- `custom.el` — kept as-is (Customize writes here)
- `themes/nimms-color.el` — moved here from root (loadable manually via `M-x nimms-color-theme`; requires `color-theme` package which uses the old 2008 API — may need the legacy `color-theme` ELPA package to work)
- `themes/nims-theme-theme.el` — moved here from root (loadable via `M-x load-theme RET nims-theme`; proper `deftheme` format, should work in Emacs 30)

### Move to `archived/`
All of the following are absorbed into `init.el` or dropped entirely:

**Old init files (14):** `init-autocomplete.el`, `init-css.el`, `init-editing-utils.el`, `init-elpa.el`, `init-exec-path.el`, `init-flymake.el`, `init-frame-hooks.el`, `init-haml.el`, `init-helm.el`, `init-ido.el`, `init-isearch.el`, `init-javascript.el`, `init-php.el`, `init-python.el`, `init-rails.el`, `init-recentf.el`, `init-ruby.el`, `init-ruby-bak.el`, `init-sh.el`, `init-utils.el`, `init-webmode.el`, `init-xterm.el`

**User config files:** `nimms.el`, `nimai-keycommands.el`, `nimms-functions.el`, `hooks.el`

**Color themes (replaced by sanityinc-tomorrow):** `color-theme-active.el`, `color-theme-less.el`, `color-theme-obsolescence.el`, `color-theme-subdued.el`, `color-theme-tango.el`, `color-theme-tangotango.el`, `color-theme-tomorrow.el`, `color-theme-wombat.el`, `color-theme-nimms-new.el`, `nimms-color.el` (copy to themes/ first)

**Old plugins/packages:** `auto-complete.el`, `auto-complete-config.el`, `auto-complete-etags.el`, `ac-yasnippet.el`, `fuzzy.el`, `popup.el`, `parenface.el`, `loaddefs.el`, `nimai-clisp.el`

**Directories:** `egg/`, `nyan/`, `ac-dict/`

### Leave alone
`elpa/`, `plugins/`, `custom.el`, `abbrev_defs`, `places`, `recentf`, `snippets/`, `auto-save-list/`, `backups/`, `eshell/`, `semanticdb/`

---

## New `init.el` Structure

### 1. Package bootstrap
- MELPA + GNU ELPA via HTTPS
- `use-package` with `:ensure t` as default (auto-installs missing packages)
- Pin `custom-file` to `custom.el`

### 2. Core settings
Absorbed from `init-editing-utils.el` and `nimms.el`:
- `use-short-answers t` (replaces `fset yes-or-no-p`)
- No lockfiles, no startup screen
- Backup files in `/tmp/emacs_backups/`
- `save-place-mode`, `recentf-mode`, `uniquify`
- `electric-pair-mode`, `global-auto-revert-mode`
- `show-paren-mode`, `column-number-mode`
- `indent-tabs-mode nil`, `show-trailing-whitespace t`
- `cua-selection-mode t` (rectangle selections)
- Narrowing/case-change commands enabled

### 3. macOS
- `mac-command-modifier 'meta`
- `mac-option-modifier 'hyper`
- `exec-path-from-shell` (ensures shell PATH is inherited)

### 4. UI / Theme
- `color-theme-sanityinc-tomorrow` — night variant, loaded at startup
- `themes/` added to `load-path` (custom themes loadable but not auto-loaded)
- No toolbar, no scrollbar
- Monaco 12pt font on macOS
- `display-time-mode`, `column-number-mode`

### 5. Completion — Vertico + Corfu
- **Vertico** — vertical minibuffer completion (M-x, find-file, buffers)
- **Orderless** — fuzzy/space-separated matching style
- **Marginalia** — annotations in completion (file sizes, docstrings)
- **Corfu** — in-buffer popup completion (LSP symbols, dabbrev)
- `Cape` — completion-at-point extensions (file, dabbrev, etc.)

### 6. Search / Navigation — Consult
Replaces Helm bindings:
- `consult-buffer` → `M-b` (was `helm-mini`)
- `consult-recent-file` → `M-{` (was `recentf-ido-find-file`)
- `project-find-file` → `M-t` (was `helm-projectile`)
- `consult-find` → `M-[` (was `helm-for-files`)
- `consult-ripgrep` / `project-find-regexp` for project search
- `avy` for jump-to-char (replaces `ace-jump-mode`)

### 7. Git — Magit
- Replaces `egg` (abandoned ~2015)
- `F8` → `magit-status` (was `egg-status`)

### 8. LSP — Eglot
Built into Emacs 29+. Hooks for:
- `python-ts-mode` → `eglot-ensure` → pyright
- `js-ts-mode` / `tsx-ts-mode` → `eglot-ensure` → typescript-language-server

**Required installs (user must run once):**
```
npm install -g pyright typescript typescript-language-server
```

### 9. Python
- `python-ts-mode` (tree-sitter, built-in Emacs 29+)
- `eglot` for completions/navigation/errors
- `exec-path-from-shell` ensures correct virtualenv python is found

### 10. JavaScript / TypeScript
- `js-ts-mode` / `tsx-ts-mode` (tree-sitter)
- `eglot` for completions/navigation/errors

### 11. vterm
- Full terminal emulator — handles Claude Code and interactive TUI programs
- `F2` → `vterm` (replaces old `shell` binding)
- `visit-vterm` function: if already in a vterm, rename it; if one exists, switch to it; else open new

### 12. TRAMP / SSH
- `tramp-default-method "ssh"`
- `tramp-chunksize 500`

### 13. Editing utilities
Absorbed from `init-editing-utils.el`:
- `multiple-cursors` — `C-<` / `C->` / `C-c c*` bindings kept
- `expand-region` — `C-=` binding kept
- `move-text` — shift lines up/down
- `whole-line-or-region-mode` — cut/copy line when no region
- `duplicate-line` function — `C-c p`
- `kill-back-to-indentation` — `C-M-<backspace>`
- `backward-up-sexp` — remaps `backward-up-list`
- `sort-lines-random`
- `page-break-lines-mode`

### 14. Custom functions (kept from `nimms-functions.el`)
- `nimms-copy-line` — copy N lines to kill ring
- `three-quarters-window` / `half-window` — resize current window
- `dos2unix` — strip CRLF
- `toggle-fullscreen` — frame fullscreen toggle
- `word-count` — word count via wc
- `remote-term` — open SSH terminal with custom buffer name
- `web01`, `web03`, `deploy` — quick SSH shortcuts
- `copy-all` — copy entire buffer contents to kill ring (used by `H-c`)

**Dropped from `nimms-functions.el`:** Firefox reload functions, SQL presets (old projects), Ruby/rake functions, `recentf-ido-find-file` (replaced by consult), XML indent, HTML wrap markup.

### 15. Keybindings
Migrated from `nimai-keycommands.el` with Helm references updated:

| Key | Command | Notes |
|-----|---------|-------|
| `mac-command-modifier` | `'meta` | macOS |
| `mac-option-modifier` | `'hyper` | macOS |
| `M-a` | `execute-extended-command` | was helm-M-x |
| `M-b` | `consult-buffer` | was helm-mini |
| `M-[` | `consult-find` | was helm-for-files |
| `M-t` | `project-find-file` | was helm-projectile |
| `M-{` | `consult-recent-file` | was recentf-ido-find-file |
| `M-0` | `delete-window` | ergoemacs window |
| `M-1` | `delete-other-windows` | ergoemacs window |
| `M-2` | split vertical + other-window | ergoemacs window |
| `M-3` | split horizontal + other-window | ergoemacs window |
| `M-;` / `M-:` | isearch forward/backward | kept |
| `M-m` | `back-to-indentation` | kept |
| `M-w` | `kill-ring-save` | kept |
| `M-C` | `nimms-copy-line` | kept |
| `M-Z` | `zap-up-to-char` | kept |
| `C-o` | `open-line` | kept |
| `C-M-g` | `goto-line` | kept |
| `C-k` | `kill-current-buffer` | was ido-kill-buffer |
| `C-c C-r` | `revert-buffer` | kept |
| `C-c j` / `C-c J` | `join-line` | kept |
| `C-;` / `C-:` | `avy-goto-char` / word | replaces ace-jump |
| `C-=` | `er/expand-region` | kept |
| `C-<` / `C->` | multiple-cursors prev/next | kept |
| `C-c p` | `duplicate-line` | kept |
| `C-<return>` | `toggle-fullscreen` | kept |
| `F2` | `vterm` | was shell |
| `F5` | `consult-ripgrep` | was ag-project-at-point |
| `F7` | `rename-buffer` | kept |
| `F8` | `magit-status` | was egg-status |
| `F9` | `rgrep` | kept |
| `H-i` | `open-line` | kept |
| `H-p` / `H-n` | `mark-lines-previous/next-line` | kept (plugins/mark-lines.el) |
| `H-c` | `copy-all` | kept |

**Dropped keybindings:** Ruby/rinari bindings, Firefox reload, smex, `C-p/C-n → comint` (too disruptive globally), dash-at-point (can re-add if needed), MozRepl.

---

## What's NOT in the new config

- ergoemacs-mode (replaced by explicit bindings above)
- Ruby, Rails, PHP, Haml, SASS modes
- Helm, IDO (replaced by Vertico + Consult)
- auto-complete (replaced by Corfu)
- flymake with separate linters (replaced by eglot)
- egg (replaced by magit)
- nyan-mode, window-numbering, pabbrev, enclose, rainbow-mode
- Any 2014-era ELPA package not listed above

---

## Packages to Install

| Package | Purpose |
|---------|---------|
| `color-theme-sanityinc-tomorrow` | Theme |
| `exec-path-from-shell` | PATH inheritance on macOS |
| `vertico` | Minibuffer completion UI |
| `orderless` | Fuzzy completion style |
| `marginalia` | Completion annotations |
| `corfu` | In-buffer completion popup |
| `cape` | Completion-at-point extensions |
| `consult` | Enhanced search/navigation commands |
| `avy` | Jump-to-char navigation |
| `magit` | Git client |
| `vterm` | Terminal emulator |
| `multiple-cursors` | Multi-cursor editing |
| `expand-region` | Semantic region expansion |
| `move-text` | Shift lines up/down |
| `whole-line-or-region` | Cut/copy full line without selection |
| `page-break-lines` | Render ^L as horizontal rules |

All installed automatically via `use-package :ensure t`.
