(set-fontset-font t 'japanese-jisx0208 (font-spec :family "IPAExGothic"))
(require 'mozc)
(setq default-input-method "japanese-mozc")

(global-set-key (kbd "C-o") 'toggle-input-method)
;; magitでコミットメッセージ入力時に新しいemacsを立ち上げないようにする
(set-variable 'with-editor-emacsclient-executable "/usr/bin/emacsclient")
