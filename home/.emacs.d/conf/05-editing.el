;; Lang and Encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; ファイル末の改行がなければ追加
(setq require-final-newline t)

;; 末尾空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)
