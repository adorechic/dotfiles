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
