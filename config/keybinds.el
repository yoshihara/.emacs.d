;; キーバインド
(define-key global-map (kbd "C-h") 'backward-delete-char-untabify)     ; バックスペース
(define-key global-map (kbd "M-?") 'help-for-help)     ; ヘルプ
(define-key global-map (kbd "C-z") 'undo)              ; undo
(define-key global-map (kbd "C-c C-i") 'hippie-expand) ; 補完
(define-key global-map (kbd "C-c ;") 'comment-dwim)    ; コメントアウト
(define-key global-map (kbd "M-C-g") 'grep)            ; grep
(define-key global-map (kbd "C-[ M-C-g") 'goto-line)   ; 指定行へ移動
(define-key global-map (kbd "C-x C-z") nil)            ; suspend-frameだが使わない割に誤爆するのでnilにしている

;; ウィンドウ移動
;; 次のウィンドウへ移動
(define-key global-map (kbd "C-M-n") 'next-multiframe-window)
;; 前のウィンドウへ移動
(define-key global-map (kbd "C-M-p") 'previous-multiframe-window)

;; 定義へ移動
;; C-x F -> 関数定義へ移動
;; C-x K -> キーにバインドされている関数定義へ移動
;; C-x V -> 変数定義へ移動
(find-function-setup-keys)

;;; 行
;; 行の先頭でC-kを一回押すだけで行全体を消去する
(setq kill-whole-line t)
;; 最終行に必ず一行挿入する
(setq require-final-newline t)
;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)

(provide 'keybinds)
