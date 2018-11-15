(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
;; ¥の代わりにバックスラッシュを入力する
(define-key global-map [?¥] [?\\])

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

(setq default-input-method "MacOSX")

(let* ((size 18)
       (asciifont "Ricty")
       (jpfont "Ricty")
       (h (* size 10))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec)
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))
(set-cursor-color 'gray)

;; パスの設定
(let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
  (setenv "PATH" path-from-shell)
  (setq exec-path (split-string path-from-shell path-separator)))

;; magitでコミットメッセージ入力時に新しいemacsを立ち上げないようにする
(set-variable 'with-editor-emacsclient-executable "/usr/local/bin/emacsclient")
