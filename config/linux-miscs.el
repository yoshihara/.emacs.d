(set-fontset-font t 'japanese-jisx0208 (font-spec :family "IPAExGothic"))
(ensure-installed-package 'ddskk)

(global-set-key (kbd "C-o") 'skk-mode)

;; magitでコミットメッセージ入力時に新しいemacsを立ち上げないようにする
(set-variable 'with-editor-emacsclient-executable "/usr/bin/emacsclient")

(provide 'linux-miscs)
