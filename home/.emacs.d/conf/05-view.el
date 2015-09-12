;; カーソル位置をハイライト表示
(setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)

;; 行番号を表示
(global-linum-mode t)

;;;; mode line
;; カラム番号
(column-number-mode t)

;; ファイルサイズ
(size-indication-mode t)

;; 時計
(setq display-time-day-and-date t) ; 曜日・月・日を表示
(display-time-mode t)

;; リージョン内の行数と文字数（範囲指定時）
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines,%d chars "
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
      ;;(count-lines-region (region-beginning) (region-end)) ;; これだとエコーエリアがチラつく
    ""))

(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))

;; paren-mode: 対応する括弧を強調して表示する
(setq show-paren-delay 0) ; 表示までの秒数。初期値は0.125
(show-paren-mode t) ; 有効化
;; parenのスタイル: expressionは括弧内も強調表示
(setq show-paren-style 'expression)
;; フェイスを変更する
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; diffの表示
; 追加された行は緑で表示
(set-face-attribute 'diff-added nil
                    :foreground "white" :background "dark green")
; 削除された行は赤で表示
(set-face-attribute 'diff-removed nil
                    :foreground "white" :background "dark red")
