(defun mj/load-config (name)
  "Load configuration NAME, tangling its Org source if necessary."
  (let ((config-el
         (expand-file-name
          (concat "config-el/" (symbol-name name) ".el")
          user-emacs-directory))
        (config-org
         (expand-file-name
          (concat "config-org/" (symbol-name name) ".org")
          user-emacs-directory)))
    (if (file-exists-p config-el)
	(load-file config-el)
      (let ((buffer (find-file-noselect config-org)))
	(unwind-protect
            (with-current-buffer buffer
              (org-babel-tangle nil config-el "emacs-lisp"))
	  (when (buffer-live-p buffer)
            (kill-buffer buffer))))
      (load-file config-el))))

(mj/load-config 'early-init)
