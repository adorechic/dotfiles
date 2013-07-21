;;; anything
(require 'anything)
(setq
 ;; 候補を表示するまでの時間。デフォルトは0.5
 anything-idle-delay 0.3
 ;; タイプして再描写するまでの時間。デフォルトは0.1
 anything-input-idle-delay 0.2
 ;; 候補の最大表示数。デフォルトは50
 anything-candidate-number-limit 100
 ;; 候補が多い時に体感速度を速くする
 anything-quick-update t
 ;; 候補選択ショートカットをアルファベットに
 anything-enable-shortcuts 'alphabet)

(require 'anything-config)
;; root権限でアクションを実行するときのコマンド
;; デフォルトは"su"
(setq anything-su-or-sudo "sudo")

(require 'anything-match-plugin)

(require 'anything-complete)
;; lispシンボルの補完候補の再検索時間
(anything-lisp-complete-symbol-set-timer 150)

(require 'anything-show-completion)

(require 'descbinds-anything)
;; describe-bindingsをanythingに置き換える
(descbinds-anything-install)

;; anything-show-kill-ring -> M-y
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)
