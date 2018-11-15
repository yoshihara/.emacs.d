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

;; anzu
(ensure-installed-package 'anzu)

(global-anzu-mode 1)
(define-key global-map (kbd "M-%")   'anzu-query-replace)

;; auto-complete
(ensure-installed-package 'auto-complete)

(require 'auto-complete-config)
(defvar ac-dictionary-directories  "~/.emacs.d/elisp/auto-complete/dict" )
(ac-config-default)
;; カスタマイズ
(setq ac-auto-start 2)  ;; n文字以上の単語の時に補完を開始
(setq ac-delay 0.05)  ;; n秒後に補完開始
(setq ac-use-fuzzy t)  ;; 曖昧マッチ有効
(setq ac-use-comphist t)  ;; 補完推測機能有効
(setq ac-auto-show-menu 0.05)  ;; n秒後に補完メニューを表示
(setq ac-quick-help-delay 0.5)  ;; n秒後にクイックヘルプを表示
(setq ac-ignore-case nil)  ;; 大文字・小文字を区別する

;; auto-complete の候補に日本語を含む単語が含まれないようにする
;; http://d.hatena.ne.jp/IMAKADO/20090813/1250130343
(defadvice ac-word-candidates (after remove-word-contain-japanese activate)
  (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
    (setq ad-return-value
          (remove-if contain-japanese ad-return-value))))

;; re-builder
(require 're-builder)
;; C-c C-s / C-c C-r -> C-s / C-r
(define-key reb-mode-map (kbd "C-s") 'reb-next-match)
(define-key reb-mode-map (kbd "C-r") 'reb-prev-match)
;; C-c C-q -> C-g
(define-key reb-mode-map (kbd "C-g") 'reb-copy-and-quit)
(define-key reb-mode-map (kbd "C-c C-q") 'reb-copy-and-quit)
;; C-c C-i -> C-i
(define-key reb-mode-map (kbd "C-i") 'reb-change-syntax)
;; C-c C-w -> C-k: C-kは正規表現もクリアしたい
(define-key reb-mode-map (kbd "C-k") 'reb-copy-and-erase)
(define-key reb-mode-map (kbd "C-c C-k") 'reb-copy-and-erase)
;; 文字列リテラルではなく正規表現そのもの
(setq reb-re-syntax 'string)
;; 終了時に正規表現をキルリングに入れる
(defun reb-copy-and-quit ()
  (interactive)
  (reb-copy)
  (reb-quit))
;; 現在の正規表現をキルリングに入れてから正規表現を初期化する
(defun reb-copy-and-erase ()
  (interactive)
  (reb-copy)
  (with-current-buffer reb-target-buffer (setq reb-regexp nil))
  (erase-buffer)
  (reb-insert-regexp)
  (forward-char -1))
(setq reb-re-syntax 'string)
(defvar reb-target-point nil)
(defun re-builder-with-point ()
  "C-M-%仕様。現在位置から置換を開始するre-builder"
  (interactive)
  (setq reb-target-point (point))
  (re-builder))
(defun re-builder-without-point ()
  "元のM-x re-builder"
  (interactive)
  (setq reb-target-point nil)
  (re-builder))
(defadvice reb-update-overlays (after with-point activate)
  (when reb-target-point
    (with-selected-window reb-target-window
      (goto-char reb-target-point))))

;; 元ネタ http://emacs-journey.blogspot.jp/2012/06/re-builder-query-replace-this.html
(defun reb-query-replace-this-regxp (replace)
  "Uses the regexp built with re-builder to query the target buffer.
This function must be run from within the re-builder buffer, not the target
buffer.

Argument REPLACE String used to replace the matched strings in the buffer. 
Subexpression references can be used (\1, \2, etc)."
  (interactive "sReplace with: ")
  (if (eq major-mode 'reb-mode)
      (let (o (reg (reb-read-regexp)))
        (select-window reb-target-window)
        (save-excursion
          (setq o (cl-find-if (lambda (ov) (eq (point) (overlay-end ov))) reb-overlays))
          (if o (goto-char (overlay-start o)))
          (query-replace-regexp reg replace)
          (reb-quit)))
    (error "Not in a re-builder buffer!")))

(global-set-key (kbd "C-M-%") 're-builder-with-point)
(define-key reb-mode-map (kbd "<return>") 'reb-query-replace-this-regxp)

(provide 'other-packages)
