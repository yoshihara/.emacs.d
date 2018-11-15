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

;;; shebangがあるファイルを保存すると実行権をつける。
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;; リージョンの大文字小文字変換を有効にする。
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

(setq-default indent-tabs-mode nil)
(electric-indent-mode -1)

;; emacsセットアップ用の設定
(setq load-path (append
                 '("~/.emacs.d/setup") ;; emacsセットアップ用ファイル入れ（この後設定で読み込むファイルが依存するものはこっち）
                 load-path))

(require 'functions)

;; 基本的な部分やビルトインパッケージを使った設定
(setq load-path (append
                 '("~/.emacs.d/config") ;; emacs設定用ファイル入れ
                 load-path))

(require 'face)
(require 'keybinds)
(require 'commands)
(require 'builtin-packages)

;; パッケージインストール＆それらを使った定義など

(require 'package-managers)

(require 'modes)
(require 'other-packages)

;; OSごとの設定

(if (eq system-type 'darwin)
  (require 'cocoa-emacs-miscs) ; macosのとき
  (require 'linux-miscs) ; それ以外（linux）
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (git-commit with-editor popup dash async web-mode slim-mode scss-mode rspec-mode open-junk-file markdown-mode magit json-mode helm coffee-mode auto-complete anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-comment-face ((t (:foreground "#D9333F"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-pseudo-class-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-rule-face ((t (:foreground "#A0D8EF"))))
 '(web-mode-doctype-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-server-comment-face ((t (:foreground "#D9333F")))))
