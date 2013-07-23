;; ruby-mode
(setq ruby-deep-indent-paren-style nil)

(require 'ruby-electric)

(require 'ruby-block)

(defun ruby-mode-hooks ()
  (ruby-electric-mode t)
  (ruby-block-mode t))

(add-hook 'ruby-mode-hook 'ruby-mode-hooks)
