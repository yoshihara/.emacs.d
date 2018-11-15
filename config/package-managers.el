;; パッケージマネージャの設定

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
;; パッケージ情報を更新（インストールは別でやる）
(package-refresh-contents)

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

(provide 'package-managers)
