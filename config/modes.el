;; 各モードの設定を入れる

;; パッケージが入っていればなにもしない、入ってない場合は入れる
(defun ensure-installed-package(package-name)
  (when (not (package-installed-p package-name))
    (package-install package-name))
  )

;; json-mode
(ensure-installed-package 'json-mode)

(provide 'modes)
