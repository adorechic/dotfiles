(require 'helm)
(require 'helm-ls-git)
(require 'helm-ag)
(helm-mode 1)
(custom-set-variables
   '(helm-truncate-lines t) ; Truncate too long line
   '(helm-delete-minibuffer-contents-from-point t) ; Do not clear by Ctrl-k
   '(helm-mini-default-sources '(helm-source-buffers-list
                                 helm-source-files-in-current-dir
                                 helm-source-ls-git
                                 helm-source-recentf
                                 )))
(define-key global-map (kbd "C-x C-o") 'helm-mini)
(global-set-key (kbd "M-g .") 'helm-ag)
;; TABで補完
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; For helm-find-files etc.
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
