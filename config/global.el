;; emacs基本機能部分の設定

;;; 日本語環境
;; Localeに合わせた環境の設定
(set-locale-environment nil)
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;;; バックアップ
;; バックアップファイルを作らない
(setq backup-inhibited t)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;; 履歴
;; 履歴数を大きくする
(setq history-length 10000)
;; ミニバッファの履歴を保存する
(savehist-mode 1)
;; 最近開いたファイルを保存する数を増やす
(setq recentf-max-saved-items 10000)

;;; 圧縮
;; gzファイルも編集できるようにする
(auto-compression-mode t)

;;; shebangがあるファイルを保存すると実行権をつける
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;; リージョンの大文字小文字変換を有効にする
;; C-x C-u -> upcase
;; C-x C-l -> downcase
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;; kill
;; Emacs 24からクリップボードだけ使うようになっているので
;; Emacs 23のようにprimary selectionを使うように変更
;;   * killしたらprimary selectionにだけ入れる（Xの場合のみ）
;;   * yankするときはprimary selectionのものを使う
(setq x-select-enable-primary t)
(when (eq window-system 'x)
  (setq x-select-enable-clipboard nil))


;; バッファ切り替えの時にカーソル下にピリオドを含む文字列があるとpingするのを抑制
;; c.f. https://github.com/technomancy/emacs-starter-kit/issues/39
(setq ffap-machine-p-known 'reject)

;; エラー音を鳴らなくする
(setq ring-bell-function 'ignore)

(setq-default indent-tabs-mode nil)
(electric-indent-mode -1)

(provide 'global)
