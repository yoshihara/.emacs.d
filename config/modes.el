;; 各モードの設定を入れる

;; json-mode
(ensure-installed-package 'json-mode)

;; slim-mode
(ensure-installed-package 'slim-mode)

;; yaml-mode
(ensure-installed-package 'yaml-mode)

;; rspec-mode
(ensure-installed-package 'rspec-mode)

;; haml-mode
(el-get 'sync '(sass-mode)) ;; haml-modeが依存している
(el-get 'sync '(haml-mode))

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

;; web-mode
(ensure-installed-package 'web-mode)
(require 'web-mode)
(setq auto-mode-alist
      (append '(
                ("\\.\\(html\\|xhtml\\|shtml\\|tpl\\|vue\\)\\'" . web-mode)
                ("\\.php\\'" . php-mode)
                )
              auto-mode-alist))

(defun web-mode-hook ()
  "Hooks for Web mode."
  ;; 変更日時の自動修正
  (setq time-stamp-line-limit -200)
  (if (not (memq 'time-stamp write-file-hooks))
      (setq write-file-hooks
            (cons 'time-stamp write-file-hooks)))
  (setq time-stamp-format " %3a %3b %02d %02H:%02M:%02S %:y %Z")
  (setq time-stamp-start "Last modified:")
  (setq time-stamp-end "$")
  ;; web-modeの設定
  (setq web-mode-markup-indent-offset 2) ;; html indent
  (setq web-mode-css-indent-offset 2)    ;; css indent
  (setq web-mode-code-indent-offset 2)   ;; script indent(js,php,etc..)
  (setq indent-tabs-mode nil)
  ;; htmlの内容をインデント
  ;; TEXTAREA等の中身をインデントすると副作用が起こったりするので
  ;; デフォルトではインデントしない
  ;;(setq web-mode-indent-style 2)
  ;; コメントのスタイル
  ;;   1:htmlのコメントスタイル(default)
  ;;   2:テンプレートエンジンのコメントスタイル
  ;;      (Ex. {# django comment #},{* smarty comment *},{{-- blade comment --}})
  (setq web-mode-comment-style 2)
  ;; 終了タグの自動補完をしない
  ;;(setq web-mode-disable-auto-pairing t)
  ;; color:#ff0000;等とした場合に指定した色をbgに表示しない
  ;;(setq web-mode-disable-css-colorization t)
  ;;css,js,php,etc..の範囲をbg色で表示
  ;; (setq web-mode-enable-block-faces t)
  ;; (custom-set-faces
  ;;  '(web-mode-server-face
  ;;    ((t (:background "grey"))))                  ; template Blockの背景色
  ;;  '(web-mode-css-face
  ;;    ((t (:background "grey18"))))                ; CSS Blockの背景色
  ;;  '(web-mode-javascript-face
  ;;    ((t (:background "grey36"))))                ; javascript Blockの背景色
  ;;  )
  ;;(setq web-mode-enable-heredoc-fontification t)
)
(add-hook 'web-mode-hook  'web-mode-hook)
;; 色の設定
(custom-set-faces
 '(web-mode-doctype-face
   ((t (:foreground "#82AE46"))))                          ; doctype
 '(web-mode-html-tag-face
   ((t (:foreground "#E6B422" :weight bold))))             ; 要素名
 '(web-mode-html-attr-name-face
   ((t (:foreground "#C97586"))))                          ; 属性名など
 '(web-mode-html-attr-value-face
   ((t (:foreground "#82AE46"))))                          ; 属性値
 '(web-mode-comment-face
   ((t (:foreground "#D9333F"))))                          ; コメント
 '(web-mode-server-comment-face
   ((t (:foreground "#D9333F"))))                          ; コメント
 '(web-mode-css-rule-face
   ((t (:foreground "#A0D8EF"))))                          ; cssのタグ
 '(web-mode-css-pseudo-class-face
   ((t (:foreground "#FF7F00"))))                          ; css 疑似クラス
 '(web-mode-css-at-rule-face
   ((t (:foreground "#FF7F00"))))                          ; cssのタグ
)

;; js2-mode
(el-get 'sync '(js2-mode))
(autoload 'js2-mode "js2" nil t)
(el-get-init 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-jsx-mode))

(add-hook 'js2-mode-hook
          #'(lambda ()
              (setq js2-basic-offset 2
                    indent-tabs-mode nil)
              ))
(setq js2-strict-missing-semi-warning nil)

;; ruby-mode
;; el-getから元々入れていたが、「invalid syntax "#"」というエラーが出るので一旦ビルドインで試す
(require 'ruby-mode)

(defun ruby-insert-end ()
  "Insert 'end'."
  (interactive)
  (insert "end")
  (ruby-indent-line))

(add-hook 'ruby-mode-hook
          (lambda ()
            ;; C-M-pとC-M-nをすでに
            ;; previous-multiframe-windowとnext-multiframe-windowに
            ;; 割り当てているが
            ;; ruby-beginning-of-blockとruby-end-of-blockが
            ;; 上書きしてしまうので無効にする。
            ;; 2012-07-11
            (define-key ruby-mode-map (kbd "C-M-p") nil)
            (define-key ruby-mode-map (kbd "C-M-n") nil)
            (define-key ruby-mode-map (kbd "C-C C-e") 'ruby-insert-end)))

;; twittering-mode
(el-get 'sync '(twittering-mode))
(setq twittering-initial-timeline-spec-string
      '(":home"))
;; アイコン表示
(setq twittering-icon-mode nil)

(defun ruby-mode-set-encoding ())

;; whitespace-mode

(require 'whitespace)
(setq whitespace-style '(face tabs tab-mark spaces space-mark lines-tail trailing space-before-tab space-after-tab::space))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\　])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(global-whitespace-mode t)

(set-face-attribute 'whitespace-trailing nil
                    :foreground "DeepPink"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :foreground "LightSkyBlue"
                    :underline nil)
(set-face-attribute 'whitespace-space nil
                    :foreground "Yellow"
                    :weight 'bold)

(provide 'modes)
