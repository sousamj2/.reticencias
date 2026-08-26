
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons-dired auto-package-update beacon command-log-mode
			 company-prescient consult-projectile dap-mode
			 dashboard dired-hide-dotfiles dired-open
			 doom-modeline doom-themes embark
			 embark-consult general helpful hungry-delete
			 lsp-ui magit marginalia orderless org-bullets
			 org-tempo python-mode rainbow-delimiters
			 vertico-prescient visual-fill-column winum
			 yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
