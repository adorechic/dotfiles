;; ruby-mode
(setq ruby-deep-indent-paren-style nil)

;; 対応するendや括弧をハイライト
(require 'ruby-block)
(require 'haml-mode)
(require 'rinari)

;; 自動でendなどを補完
(require 'ruby-electric)
(defun ruby-insert-end ()
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))

;; マジコメしない
(setq ruby-insert-encoding-magic-comment nil)

(defun ruby-mode-hooks ()
  (ruby-electric-mode t)
  (ruby-block-mode t)
  (rinari-minor-mode t))

(add-hook 'ruby-mode-hook 'ruby-mode-hooks)
(add-hook 'haml-mode-hook 'rinari-minor-mode)

;; 閉じ括弧などのインデントを良い感じにする
(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
