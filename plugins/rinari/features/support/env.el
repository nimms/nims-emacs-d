(defvar current-rails-application nil
  "Path to current active Rails application.")

(let* ((features-directory
        (file-name-directory
         (directory-file-name (file-name-directory load-file-name))))
       (project-directory
        (file-name-directory
         (directory-file-name features-directory))))
  (setq rinari-root-path project-directory)
  (setq rinari-util-path (expand-file-name "util" rinari-root-path))
  (setq rinari-features-path (expand-file-name "features" rinari-root-path)))

(add-to-list 'load-path rinari-root-path)
(add-to-list 'load-path rinari-features-path)
(add-to-list 'load-path (expand-file-name "support" rinari-features-path))
(add-to-list 'load-path (expand-file-name "espuds" (expand-file-name "test" rinari-util-path)))
(add-to-list 'load-path (expand-file-name "ert" (expand-file-name "test" rinari-util-path)))

(require 'rinari)
(require 'espuds)
(require 'ert)
(require 'rails-helpers)
(require 'cl)

(defun remove-tmp ()
  "Removes tmp folder."
  (shell-command (concat "rm -Rf " (expand-file-name "tmp" rinari-root-path))))

(Setup
 (remove-tmp)
 (make-directory (expand-file-name "tmp" rinari-root-path)))

(Teardown
 (remove-tmp))

(After
 (setq rinari-minor-mode-hook '()))
