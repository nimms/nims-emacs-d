(defun rails-version()
  "Determine rails version"
  (save-excursion
    (let ((buffer "*rails-version*"))
      (flet ((kill-buffer-and-return-version (buffer version)
                                             (progn
                                               (kill-buffer buffer)
                                               version)))
        (progn
          (shell-command "rails -v" buffer)
          (switch-to-buffer buffer)
          (goto-char (point-min))
          (if (search-forward "Rails 2" (point-max) t)
              (kill-buffer-and-return-version buffer 2)
            (progn
              (goto-char (point-min))
              (if (search-forward "Rails 3" (point-max) t)
                  (kill-buffer-and-return-version buffer 3)))))))))

(defun generate-app (name)
  "Generates a Rails application with NAME if it does not exist."
  (let* ((tmp-dir (expand-file-name "tmp" rinari-root-path))
         (app (expand-file-name name tmp-dir)))
    (unless (file-exists-p app)
      (setq current-rails-application app)
      (shell-command
       (if (= (rails-version) 2)
           (concat "rails " app " -q")
         (concat "rails new " app " -q"))))))

(defun generate-scaffold (name)
  "Generates a scaffold with name."
  (unless (scaffold-exists-p name)
    (let ((script-dir (expand-file-name "script" current-rails-application)))
      (cond ((= (rails-version) 2)
             (shell-command
              (concat (expand-file-name "generate" script-dir) " scaffold " name)))
            (t
             (shell-command
              (concat (expand-file-name "rails" script-dir) " generate scaffold " name " -q")))))))

(defun scaffold-exists-p (name)
  "Checks if scaffold with NAME exists."
  (file-exists-p
   (expand-file-name
    (concat (downcase name) ".rb")
    (expand-file-name
     "models"
     (expand-file-name
      "app"
      current-rails-application)))))


(provide 'rails-helpers)
