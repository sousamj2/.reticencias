
;; ;; Load the generated configuration if it exists.
;; ;; On a fresh installation, generate config.el from config.org first.
;; (let ((config-el
;;        (expand-file-name "config-el/init.el"
;;                          user-emacs-directory))
;;       (config-org
;;        (expand-file-name "config-org/init.org"
;;                          user-emacs-directory)))
;;   (if (file-exists-p config-el)
;;       (load-file config-el)
;;     (with-current-buffer (find-file-noselect config-org)
;;       (org-babel-tangle nil config-el "emacs-lisp"))
;;     (load-file config-el)))

(mj/load-config 'init)
