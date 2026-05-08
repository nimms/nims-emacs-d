;; Specify modes for Lisp file extensions
(setq auto-mode-alist
      (append '(("\.lisp$" . lisp-mode)
		("\.lsp$" . lisp-mode)
		("\.cl$" . lisp-mode)
		("\.asd$" . lisp-mode)
		("\.system$" . lisp-mode)) auto-mode-alist))



;; Hooks into lisp mode
(add-hook 'lisp-mode-hook
	  (lambda ()
	    (slime-mode t)
	    (define-key lisp-mode-map [(control j)] 'newline)
	    (define-key lisp-mode-map [(control m)] 'newline-and-indent)
	    (set (make-local-variable lisp-indent-function)
		 'common-lisp-indent-function)))

(add-hook 'inferior-lisp-mode-hook
	  (lambda ()
	    (inferior-slime-mode t)))
;(slime-autodoc-mode)

;; GNU CLISP
(defun clisp ()
  (interactive)
  (setq inferior-lisp-program "/opt/local/bin/clisp"
;; 				      " -B " bin-dir "clisp-2.33/full/"
;; 				      " -M " bin-dir "clisp-2.33/full/lispinit.mem"
;; 				      " -ansi -q"
                                      )
  (load "slime"))
(clisp)

(provide 'nimai-clisp)
  