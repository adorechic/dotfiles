;; ruby-mode
(setq ruby-deep-indent-paren-style nil)

(require 'ruby-electric)

(require 'ruby-block)
(require 'haml-mode)
(require 'rinari)

(defun ruby-mode-hooks ()
  (ruby-electric-mode t)
  (ruby-block-mode t)
  (rinari-minor-mode t))

(add-hook 'ruby-mode-hook 'ruby-mode-hooks)
(add-hook 'haml-mode-hook 'rinari-minor-mode)
