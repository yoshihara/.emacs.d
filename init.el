;; package.elの設定
;; https://github.com/melpa/melpa/blob/b9ff4284d6e311960a79a3d20fb0542486c7f67b/README.md
(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;; el-get
;; el-getの設定
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path
             "~/.emacs.d/el-get/recipes")
(add-to-list 'el-get-recipe-path
             "~/.emacs.d/elisp/el-get-local-recipes")

(setq el-get-recipe-path (reverse el-get-recipe-path))

;; init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init t)
(init-loader-load "~/.emacs.d/configurations")

(setq load-path (append
                 '("~/.emacs.d/setup") ;; emacsセットアップ用ファイル入れ（この後設定で読み込むファイルが依存するものはこっち）
                 load-path))

(require 'functions)

(setq load-path (append
                 '("~/.emacs.d/config") ;; emacs設定用ファイル入れ
                 load-path))

(require 'face)
(require 'commands)
(require 'builtin-packages)
(require 'modes)
(require 'other-packages)

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
    (git-commit with-editor popup dash async web-mode slim-mode scss-mode rspec-mode open-junk-file markdown-mode magit json-mode init-loader helm coffee-mode auto-complete anzu))))
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

;; package-selected-packagesにあるパッケージが入ってなかったらパッケージ情報を更新（インストールは別でやる）
;; package-selected-packagesはpackages.elでパッケージを追加・削除したときに自動更新されるリスト
(let ((not-installed (loop for x in package-selected-packages
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)))
