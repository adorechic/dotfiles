
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq require-final-newline t)          ; ファイル末の改行がなければ追加
; カーソル位置をハイライト表示
(setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)

;; 末尾空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)
