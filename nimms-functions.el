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
         (sql-sever "pxprod")
         (sql-user "nimai")
         (sql-database "planxchange_development")
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

(defun eterminal/get-matching-buffer-names (name-to-match)
  (let ((buffers (buffer-list))
        (matching-buffers))
    (dolist (buf buffers matching-buffers)
      (if (eq 0 (string-match name-to-match (buffer-name buf)))
          (setq matching-buffers (cons (buffer-name buf) matching-buffers))))
    matching-buffers))

(defun eterminal/get-next-buffer (buffer-name-list)
  (let ((name (buffer-name (current-buffer))))
    (setq frst (car buffer-name-list))
    (setq next nil)
    (while buffer-name-list
      (setq n (pop buffer-name-list))
      (if (string= n name)
          (if buffer-name-list
              (setq next (car buffer-name-list))
            (setq next frst))))
    next))

(defun eterminal/switch-to-next-term-buffer ()
  (interactive)
  (let ((buf-list (eterminal/get-matching-buffer-names "*Terminal*")))
    (setq buf-list (sort buf-list 'string<))
    (setq next (eterminal/get-next-buffer buf-list))
    (if next
        (switch-to-buffer next))))

(defun eterminal/switch-to-prev-term-buffer ()
  (interactive)
  (let ((buf-list (eterminal/get-matching-buffer-names "*Terminal*")))
    (setq buf-list (sort buf-list 'string<))
    (setq buf-list (nreverse buf-list))
    (setq next (eterminal/get-next-buffer buf-list))
    (if next
        (switch-to-buffer next))))

(add-hook 'term-mode-hook
          (lambda ()
            (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
            (setq term-term-name "ansi")
            (setq term-input-chunk-size 1024)
                                        ; term-raw-map on char-moodia varten.
            (define-key term-raw-map [C-tab] 'eterminal/switch-to-next-term-buffer)
            (define-key term-raw-map [C-iso-lefttab] 'eterminal/switch-to-prev-term-buffer)
                                        ; term-mode-map on line-moodia varten.
            (define-key term-mode-map [C-tab] 'eterminal/switch-to-next-term-buffer)
            (define-key term-mode-map [C-iso-lefttab] 'eterminal/switch-to-prev-term-buffer)))

(defun eterminal/run-terminal ()
  (interactive)
  (ansi-term "/bin/bash" "Terminal"))

(define-key ctl-x-map' "t" 'eterminal/run-terminal)


(setq my-key-pairs
      '((?! ?1) (?@ ?2) (?# ?3) (?$ ?4) (?% ?5)
        (?^ ?6) (?& ?7) (?* ?8) (?( ?9) (?) ?0)
        (?- ?_) (?\" ?') (?{ ?[) (?} ?])         ; (?| ?\\)
        ))
        
(defun my-key-swap (key-pairs)
  (if (eq key-pairs nil)
      (message "Keyboard zapped!! Shift-F10 to restore!")
      (progn
        (keyboard-translate (caar key-pairs)  (cadar key-pairs)) 
        (keyboard-translate (cadar key-pairs) (caar key-pairs))
        (my-key-swap (cdr key-pairs))
        )
    ))

(defun my-key-restore (key-pairs)
  (if (eq key-pairs nil)
      (message "Keyboard restored!! F10 to Zap!")
    (progn
      
      (keyboard-translate (caar key-pairs)  (caar key-pairs))
      (keyboard-translate (cadar key-pairs) (cadar key-pairs))
      (my-key-restore (cdr key-pairs))
      )
    ))






(provide 'nimms-functions)
