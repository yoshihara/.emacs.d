;; emacsセットアップ用の設定

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;; package.elが自動生成する設定の書き込み場所を指定して読み込み
(setq custom-file (expand-file-name "config/auto-generated-customs.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

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
