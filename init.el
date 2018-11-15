;; emacsセットアップ用の設定
(setq load-path (append
                 '("~/.emacs.d/setup") ;; emacsセットアップ用ファイル入れ（この後設定で読み込むファイルが依存するものはこっち）
                 load-path))

(require 'functions)

;; 基本的な部分やビルトインパッケージを使った設定
(setq load-path (append
                 '("~/.emacs.d/config") ;; emacs設定用ファイル入れ
                 load-path))

(require 'global)
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

;; 自動で生成される設定

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
