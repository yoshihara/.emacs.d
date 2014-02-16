;; http://d.hatena.ne.jp/kitokitoki/20100612/p1
(add-to-list 'load-path "~/.emacs.d/imports/scratch-log")
(require 'scratch-log)

(setq sl-scratch-log-file "~/scratch-log/log.txt")
(setq sl-prev-scratch-string-file "~/scratch-log/prev.txt")
;; nil なら emacs 起動時に，最後に終了したときの スクラッチバッファの内容を復元しない。初期値は t です。
(setq sl-restore-scratch-p t)
;; nil なら スクラッチバッファを削除できるままにする。初期値は t です。
;; (setq sl-prohibit-kill-scratch-buffer-p nil)
