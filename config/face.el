;; faceの設定を入れる

;;; 現在の関数名をウィンドウ上部に表示する
(which-function-mode 1)

;; カラーの設定
 (setq default-frame-alist
       (append
        '((background-color . "#274444")
          (foreground-color . "khaki")
          )
        default-frame-alist))
(setq initial-frame-alist default-frame-alist)
(cond (window-system
       (setq x-select-enable-clipboard t)
))

;; diffの表示方法を変更
(defun diff-mode-setup-faces ()
  ;; 追加された行は緑で表示
  (set-face-attribute 'diff-added nil
                      :foreground "white" :background "dark green")
  ;; 削除された行は赤で表示
  (set-face-attribute 'diff-removed nil
                      :foreground "white" :background "dark red")
  ;; 文字単位での変更箇所は色を反転して強調
  (set-face-attribute 'diff-refine-change nil
                      :foreground nil :background nil
                      :weight 'bold :inverse-video t))
(add-hook 'diff-mode-hook 'diff-mode-setup-faces)

;; diffを表示したらすぐに文字単位での強調表示も行う
(defun diff-mode-refine-automatically ()
  (diff-auto-refine-mode t))
(add-hook 'diff-mode-hook 'diff-mode-refine-automatically)

;; ediffを1ウィンドウで実行
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのオプション
(setq diff-switches '("-u" "-p" "-N"))

;;; 画像
;; 画像ファイルを表示
(auto-image-file-mode t)

;;; バー
;; メニューバーを消す
(menu-bar-mode -1)
;; ツールバーを消す
;; (tool-bar-mode -1)

;;; カーソル
;; カーソルの点滅を止める
(blink-cursor-mode 0)

;;; eval
;; evalした結果を全部表示
(setq eval-expression-print-length nil)

;;; 括弧
;; 対応する括弧を光らせる
(show-paren-mode 1)
;; ウィンドウ内に収まらないときだけ括弧内も光らせる
(setq show-paren-style 'mixed)

;;; 位置
;; 現在行を目立たせる
(global-hl-line-mode)
;; カーソルの位置が何文字目かを表示する
(column-number-mode t)
;; カーソルの位置が何行目かを表示する
(line-number-mode t)
;; カーソルの場所を保存する
(require 'saveplace)
(setq-default save-place t)

;;; バッファ名
;; ファイル名が重複していたらディレクトリ名を追加する。
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(provide 'face)
