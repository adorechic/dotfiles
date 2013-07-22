;; Lang and Encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; ファイル末の改行がなければ追加
(setq require-final-newline t)

;; 末尾空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; TAB幅
(setq-default tab-width 2)

;; インデントにタブ文字を使わない
(setq-default indent-tabs-mode nil)

;; バックアップとオートセーブを~/.emacs.d/backups/へ集める
(add-to-list 'backup-directory-alist
             (cons "." "~/.emacs/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;; shebangからはじまるファイルは実行権限付与する
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; redo+
(require 'redo+)
;; C-' にredoをわりあてる !! terminal modeだと動かない
(global-set-key (kbd "C-,") 'redo)

;; cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; CUAキーバインドをオフ
