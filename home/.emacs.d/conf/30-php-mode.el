;; php-mode(
(require 'php-mode)
(add-to-list 'auto-mode-alist '(".inc$" . php-mode))
(add-hook 'php-mode-hook
  '(lambda()
     (setq tab-width 4)
     (setq indent-tabs-mode t)
     (setq c-basic-offset 4)
   ))
