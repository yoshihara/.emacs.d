(el-get 'sync '(logalimacs))

;;; keybinds
(when (require 'logalimacs nil t)
  (global-set-key (kbd "M-g M-i") 'loga-interactive-command)
  (global-set-key (kbd "M-g M-l") 'loga-lookup-at-manually)
  (global-set-key (kbd "M-g M-a") 'loga-add)
  (global-set-key (kbd "C-:")     'loga-lookup-in-popup))

;;; 以下はお好みで設定してください(version1.0から)
;; lookupに--dictionaryオプションを利用する場合
(setq loga-use-dictionary-option t)
;; :autoがデフォルトでカーソル位置の近くにpopup
;; :maxにするとbuffer一杯までpopupをのばし行の最初から表示します
(setq loga-popup-output-type :max)
