;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode) ;; text-modeでも自動的に有効にする

(add-to-list 'ac-user-dictionary-files '"~/.emacs.d/ac-dict/dict")
