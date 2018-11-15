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

;; helm
(ensure-installed-package 'helm)

(when (require 'helm-config nil t)
  (global-set-key (kbd "C-;") 'helm-mini)
  (global-set-key (kbd "M-r") 'helm-resume)
  (global-set-key (kbd "C-x g") 'helm-imenu)
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-x b") 'helm-buffers-list)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)

  (helm-mode 1)

  (when (require 'helm-git nil t)
    (global-set-key (kbd "C-x C-g") 'helm-git-find-files)
    )
  (when (require 'helm-ls-git nil t)
    ;;;
    )

  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
  ;; For find-file etc.
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "C-u") 'helm-select-action)
  ;; For helm-find-files etc.
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-find-files-map (kbd "C-u") 'helm-select-action)

  ;; Emulate `kill-line' in helm minibuffer
  (setq helm-delete-minibuffer-contents-from-point t)
  (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
    "Emulate `kill-line' in helm minibuffer"
    (kill-new (buffer-substring (point) (field-end))))
)

(provide 'misc-packages)
