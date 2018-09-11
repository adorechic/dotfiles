
;; package.el setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; install package.el
(require 'cl)
(defvar installing-package-list
  '(
    init-loader
    helm
    helm-ls-git
    helm-ag
    auto-complete
    yaml-mode
    ruby-electric
    ruby-block
    haml-mode
    ruby-compilation
    rinari
    egg
    yasnippet
    less-css-mode
    scss-mode
    coffee-mode
    go-mode
    puppet-mode
    magit
    ace-jump-mode
    ace-isearch
    open-junk-file
    markdown-mode
    swift-mode
    rust-mode
    php-mode
    rjsx-mode
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg)))
)
;; load config by init-loader
(require 'init-loader)
(init-loader-load "~/.emacs.d/conf")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-delete-minibuffer-contents-from-point t)
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-files-in-current-dir helm-source-ls-git helm-source-recentf)))
 '(helm-truncate-lines t t)
 '(open-junk-file-directory "~/.emacs.d/junk/%Y/%m/%d-%H%M%S." t)
 '(package-selected-packages
   (quote
    (rust-mode yasnippet yaml-mode swift-mode scss-mode ruby-electric ruby-block rinari puppet-mode open-junk-file markdown-mode magit less-css-mode init-loader helm-ls-git helm-descbinds helm-ag haml-mode go-mode flycheck-pos-tip egg descbinds-anything ddskk coffee-mode auto-complete ace-isearch))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
