(defun nimms-indent-xml-region (begin end)
  "Pretty format XML markup in region. You need to have nxml-mode http://www.emacswiki.org/cgi-bin/wiki/NxmlMode installed to do this. The function inserts linebreaks to separate tags that have nothing but whitespace between them. It then indents the markup by using nxml’s indentation rules."
  (interactive "r")
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    (while (search-forward-regexp "\>[ \\t]*\<" nil t)
      (backward-char) (insert "\n")
      )
    (mark-whole-buffer)
    (indent-region begin end)
                                        ;(indent-region point-min point-max)
    )
  (message "Ah, much better!"))

(defun nimms-wrap-markup (tag)
  "Wrap region with html tag"
  (interactive "sWrap with: ")
  (goto-char (region-end))
  (insert (concat "</" tag ">"))
  (goto-char (region-beginning))
  (insert (concat "<" tag ">\n" )))

(defun word-count nil "Count words in buffer" (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

(defun three-quarters-window ()
  "Resizes current window big"
  (interactive)
  (let
      ((size (- (truncate (* .75 (frame-height))) (window-height))))
    (if (> size 0)
        (enlarge-window size))))

(defun half-window ()
  "Resizes current window big"
  (interactive)
  (let
      ((size (- (truncate (* .5 (frame-height))) (window-height))))
    (if (> size 0)
        (enlarge-window size))))

(defun dos2unix ()
  "Convert this entire buffer from MS-DOS text file format to UNIX."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-regexp "\r$" "" nil)
    (goto-char (1- (point-max)))
    (if (looking-at "\C-z")
        (delete-char 1)))) 

(defun toggle-fullscreen () 
  (interactive) 
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 
                                                            'fullscreen) 
                                           nil 
                                         'fullboth))) 


(defun auto-reload-firefox-on-after-save-hook ()         
  (add-hook 'after-save-hook
            '(lambda ()
               (interactive)
               (comint-send-string (inferior-moz-process)
                                   "BrowserReload();"))
            'append 'local)) ; buffer-local



(setq sql-connection-alist
      '((px-local
         (sql-product 'postgres)
         (sql-server "localhost")
         (sql-user "postgres")
         (sql-database "planxchange_development")
         (sql-password "")
         (sql-port 5432))        
        (px-prod
         (sql-product 'postgres)
         (sql-server "pxprod")
         (sql-user "nimai")
         (sql-database "planxchange_development")
         (sql-port 5432))
        (sharemap-local2
         (sql-product 'postgres)
         (sql-server "localhost")
         (sql-user "postgres")
         (sql-database "sharemap_dev2")
         (sql-port 5432))
        (sharemap-local
         (sql-product 'postgres)
         (sql-server "localhost")
         (sql-user "postgres")
         (sql-database "sharemap_development")
         (sql-password "")
         (sql-port 5432))))

(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let, (cdr (assoc name sql-connection-alist))
               (flet ((sql-get-login (&rest what)))
                 (sql-product-interactive sql-product)))))

(defun px-dev ()
  (interactive)
  (sql-connect-preset 'px-local)
  (rename-buffer "*px-development*"))

(defun px-prod ()
  (interactive)
  (sql-connect-preset 'px-prod)
  (rename-buffer "*px-production*"))

(defun sm-dev ()
  (interactive)
  (sql-connect-preset 'sharemap-local)
  (rename-buffer "*sm-development*"))

(defun sm-dev2 ()
  (interactive)
  (sql-connect-preset 'sharemap-local2)
  (rename-buffer "*sm-development2*"))

(defun visit-ansi-term ()
  "If we are in an *ansi-term*, rename it.
If there is no *ansi-term*, run it.
If there is one running, switch to that buffer."
  (interactive)
  (if (equal "*ansi-term*" (buffer-name))
      (call-interactively 'rename-buffer)
    (if (get-buffer "*ansi-term*")
        (switch-to-buffer "*ansi-term*")
      (ansi-term "/bin/bash"))))


(defun remote-term (new-buffer-name cmd &rest switches)
  "Use this for remote so I can specify command line arguments"
  (setq term-ansi-buffer-name (concat "*" new-buffer-name "*"))
  (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))
  (setq term-ansi-buffer-name (apply 'make-term term-ansi-buffer-name cmd nil switches))
  (set-buffer term-ansi-buffer-name)
  (term-mode)
  (term-char-mode)
  (term-set-escape-char ?\C-x)
  (switch-to-buffer term-ansi-buffer-name))

(defun web01 ()
  (interactive) 
  (remote-term "web01" "ssh" "web01"))

(defun web03 ()
  (interactive) 
  (remote-term "web03" "ssh" "web03")) 


(defun nimms-toggle-selective-display (column)
  "toggles code folding.  defaults to 3 which will show ruby methods in a file"
  (interactive "P")
  (set-selective-display
   (if selective-display nil (or column 3))))

(defun nimms-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))



(setq path-to-ctags "/opt/local/bin/ctags") ;; <- your ctags path here
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "Directory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
  )
(provide 'nimms-functions)
