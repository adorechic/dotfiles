
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

; カーソル位置をハイライト表示
(setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)
