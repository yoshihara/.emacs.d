(let* ((size 18)
       (asciifont "Ricty")
       (jpfont "Ricty")
       (h (* size 10))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec)
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))

(ensure-installed-package 'ddskk)

(global-set-key (kbd "C-\\") 'skk-mode)

;; 辞書
(setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L") ; 一応
(setq skk-server-host "localhost") ; AquaSKK のサーバー機能を利用
(setq skk-server-portnum 1178) ; ポートは標準
(setq skk-share-private-jisyo t) ; 複数 skk 辞書を共有

;; 返り値が non-nil の時、個人辞書に取り込まない。
;; KAKUTEI-WORD を引数にしてコールされるので、不要でも引数を取る
;; 必要あり
(add-hook 'skk-search-excluding-word-pattern-function
          #'(lambda (kakutei-word)
              (and skk-abbrev-mode
                   (save-match-data
                                        ; SKK-HENKAN-KEY が "*" で終わるとき
                     (string-match "\\*$" skk-henkan-key)))))

;; 候補表示
(setq skk-show-candidates-always-pop-to-buffer t) ; 変換候補の表示位置
(setq skk-henkan-show-candidates-rows 2) ; 候補表示件数を2列に

;; 動作
(setq skk-egg-like-newline nil) ; Enterで改行しない
(setq skk-delete-implies-kakutei nil) ; ▼モードで一つ前の候補を表示
(setq skk-use-look t)
(setq skk-auto-insert-paren nil)
(setq skk-henkan-strict-okuri-precedence t) ; 送り仮名が厳密に正しい候補を優先して表示
(require 'skk-hint); ヒント
(add-hook 'skk-load-hook ; 自動的に入力モードを切り替え
          (lambda ()
            (require 'context-skk)))

;; 言語
(setq skk-japanese-message-and-error t) ; エラーを日本語に
(setq skk-show-japanese-menu t) ; メニューを日本語に

;; isearch
(add-hook 'isearch-mode-hook 'skk-isearch-mode-setup) ; isearch で skk のセットアップ
(add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup) ; isearch で skk のクリーンアップ

;; magitでコミットメッセージ入力時に新しいemacsを立ち上げないようにする
(set-variable 'with-editor-emacsclient-executable "/usr/bin/emacsclient")

(provide 'linux-miscs)
