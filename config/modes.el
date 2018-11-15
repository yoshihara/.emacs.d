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

;; scss-mode
(ensure-installed-package 'scss-mode)
(require 'scss-mode)

(defun scss-custom ()
  (setq indent-tabs-mode nil)
  (setq css-indent-offset 2)
  )

(add-hook 'scss-mode-hook
  '(lambda() (scss-custom)))
(setq scss-compile-at-save nil)

;; slim-mode
(ensure-installed-package 'slim-mode)

;; coffee-mode
(ensure-installed-package 'coffee-mode)
(require 'coffee-mode)

(setq coffee-tab-width 2)

(defun coffee-custom ()
  "coffee-mode-hook"
  (and (set (make-local-variable 'tab-width) 2)
       (set (make-local-variable 'coffee-tab-width) 2))
  )

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;; yaml-mode
(ensure-installed-package 'yaml-mode)

(provide 'modes)
