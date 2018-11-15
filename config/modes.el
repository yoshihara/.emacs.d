;; 各モードの設定を入れる

;; パッケージが入っていればなにもしない、入ってない場合は入れる
(defun ensure-installed-package(package-name)
  (when (not (package-installed-p package-name))
    (package-install package-name))
  )

;; json-mode
(ensure-installed-package 'json-mode)

;; markdown-mode
(ensure-installed-package 'markdown-mode)
(add-hook 'markdown-mode-hook
          '(lambda()
             (local-set-key (kbd "C-M-n") 'next-multiframe-window)
             (local-set-key (kbd "C-M-p") 'previous-multiframe-window)))

(provide 'modes)
