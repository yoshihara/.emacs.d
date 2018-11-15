;; 特にモードに紐付いてないけど入れてるパッケージを書く

;; async
(ensure-installed-package 'async)

;; dash
(ensure-installed-package 'dash)

;; open-junk-file
(ensure-installed-package 'open-junk-file)

;; popup
(ensure-installed-package 'popup)

;; with-editor
(ensure-installed-package 'with-editor)

;; git-commit
(ensure-installed-package 'git-commit)

;; magit
(ensure-installed-package 'magit)
(require 'magit)

(defun magit-setup-diff ()
  ;; diffを表示しているときに文字単位での変更箇所も強調表示する
  ;; 'allではなくtにすると現在選択中のhunkのみ強調表示する
  ;; 2012-04-02
  (setq magit-diff-refine-hunk 'all))
(add-hook 'magit-mode-hook 'magit-setup-diff)

(defun magit-setup-push ()
  ;; pushするときに確認しない
  ;; pushするときは現在のブランチのみをpushする
  ;; 2015-08-17
  (setq magit-push-always-verify nil))
(add-hook 'magit-mode-hook 'magit-setup-push)

(provide 'misc-packages)
