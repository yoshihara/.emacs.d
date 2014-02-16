(setq load-path (append
                 '("~/.emacs.d")
                 load-path))

(setq load-path (append
                 '("~/.emacs.d/submodules")
                 load-path))

(setq load-path (append
                 '("~/.emacs.d/imports")
                 load-path))

;; package.elの設定
(require 'package)
(setq package-user-dir "~/.emacs.d/elisp/elpa/")
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/configurations")

