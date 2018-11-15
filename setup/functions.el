;; emacsセットアップに必要な関数の定義

;; パッケージが入っていればなにもしない、入ってない場合は入れる
(defun ensure-installed-package(package-name)
  (when (not (package-installed-p package-name))
    (package-install package-name))
  )

(provide 'functions)
