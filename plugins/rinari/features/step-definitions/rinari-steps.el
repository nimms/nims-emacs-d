(Given "^Rails application \"\\(.+\\)\"$"
       (lambda (name)
         (generate-app name)))

(Given "^Rinari is \\(active\\|inactive\\)$"
       (lambda (status)
         (rinari-minor-mode (if (string= status "active") 1 -1))))

(When "^I visit \"\\(.+\\)\"$"
      (lambda (file)
        (let* ((app-file (expand-file-name file current-rails-application))
               (v (vconcat [?\C-x ?\C-f] (string-to-vector app-file))))
          (should (file-exists-p app-file))
          (execute-kbd-macro v))))

(When "^I visit migration \"\\(.+\\)\"$"
      (lambda (file)
        (let* ((app-file (car
                          (file-expand-wildcards
                           (concat (file-name-as-directory current-rails-application) file))))
               (v (vconcat [?\C-x ?\C-f] (string-to-vector app-file))))
          (should (file-exists-p app-file))
          (execute-kbd-macro v))))

(Then "^Rinari should be active$"
      (lambda ()
        (should rinari-minor-mode)))

(Given "^I generate scaffold for \"\\(.+\\)\"$"
       (lambda (name)
         (generate-scaffold name)))
