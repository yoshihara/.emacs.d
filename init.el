(setq load-path (append
                 '("~/.emacs.d")
                 load-path))

(setq load-path (append
                 '("~/.emacs.d/imports")
                 load-path))

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


;; init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init t)
(init-loader-load "~/.emacs.d/configurations")

(require 'commands)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js-indent-level 2)
 '(package-selected-packages
   (quote
    (mozc helm magit popup open-junk-file js2-mode textile-mode rspec-mode yaml-mode coffee-mode slim-mode sass-mode scss-mode markdown-mode json-mode haml-mode git-commit dash async init-loader))))
