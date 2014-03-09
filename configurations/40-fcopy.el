;; ペーストしたい先頭でfcopy-mode→範囲選択→（カットの場合はC-d）→RET
(require 'fcopy)

(global-set-key (kbd "M-C-y") 'fcopy-mode)
