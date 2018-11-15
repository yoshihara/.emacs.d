;;; el-get
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
