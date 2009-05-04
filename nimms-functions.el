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

(provide 'nimms-functions)