(require 'helm)
(require 'helm-ls-git)
(helm-mode 1)
(define-key global-map (kbd "C-x C-o") 'helm-mini)

;; TABで補完
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; For helm-find-files etc.
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
