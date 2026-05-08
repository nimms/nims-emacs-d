;;; helm-rubygems-org-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (helm-rubygems-org) "helm-rubygems-org" "helm-rubygems-org.el"
;;;;;;  (21530 39984 0 0))
;;; Generated autoloads from helm-rubygems-org.el

(defvar helm-rubygems-org-search-source '((name . "Rubygems.org") (candidates . helm-rubygems-org-search) (volatile) (delayed) (requires-pattern . 2) (action ("Copy Gemfile require" . helm-rubygems-org-candidate-to-kill-ring) ("View Description" . helm-rubygems-org-candidate-view) ("Browse source code project" . helm-rubygems-org-candidate-browse-to-source) ("Browse on rubygems.org" . helm-rubygems-org-candidate-browse-to-project))))

(autoload 'helm-rubygems-org "helm-rubygems-org" "\
List Rubygems.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("helm-rubygems-org-pkg.el") (21530 39984
;;;;;;  155077 0))

;;;***

(provide 'helm-rubygems-org-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; helm-rubygems-org-autoloads.el ends here
