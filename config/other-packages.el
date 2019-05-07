;; 特にモードに紐付いてないけど入れてるパッケージを書く

;; async
(ensure-installed-package 'async)

;; dash
(ensure-installed-package 'dash)

;; open-junk-file
(ensure-installed-package 'open-junk-file)

;; popup
(ensure-installed-package 'popup)

;; fuzzy（あいまい検索）

(el-get 'sync 'fuzzy)

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

;; wgrep
;; *grep* bufferで編集できるようにする
(ensure-installed-package 'wgrep)
(require 'wgrep)

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

(ensure-installed-package 'ddskk)

(global-set-key (kbd "C-\\") 'skk-mode)

;; 辞書
(setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L") ; 一応
(setq skk-server-host "localhost") ; AquaSKK のサーバー機能を利用
(setq skk-server-portnum 1178) ; ポートは標準
(setq skk-share-private-jisyo t) ; 複数 skk 辞書を共有

;; 返り値が non-nil の時、個人辞書に取り込まない。
;; KAKUTEI-WORD を引数にしてコールされるので、不要でも引数を取る
;; 必要あり
(add-hook 'skk-search-excluding-word-pattern-function
          #'(lambda (kakutei-word)
              (and skk-abbrev-mode
                   (save-match-data
                                        ; SKK-HENKAN-KEY が "*" で終わるとき
                     (string-match "\\*$" skk-henkan-key)))))

;; 候補表示
(setq skk-show-candidates-always-pop-to-buffer t) ; 変換候補の表示位置
(setq skk-henkan-show-candidates-rows 2) ; 候補表示件数を2列に

;; 動作
(setq skk-egg-like-newline t) ; Enterで改行しない
(setq skk-delete-implies-kakutei nil) ; ▼モードで一つ前の候補を表示
(setq skk-use-look t)
(setq skk-auto-insert-paren nil)
(setq skk-henkan-strict-okuri-precedence t) ; 送り仮名が厳密に正しい候補を優先して表示
(require 'skk-hint); ヒント
(add-hook 'skk-load-hook ; 自動的に入力モードを切り替え
          (lambda ()
            (require 'context-skk)))

;; 言語
(setq skk-japanese-message-and-error t) ; エラーを日本語に
(setq skk-show-japanese-menu t) ; メニューを日本語に

;; isearch
(add-hook 'isearch-mode-hook 'skk-isearch-mode-setup) ; isearch で skk のセットアップ
(add-hook 'isearch-mode-end-hook 'skk-isearch-mode-cleanup) ; isearch で skk のクリーンアップ

(provide 'other-packages)
