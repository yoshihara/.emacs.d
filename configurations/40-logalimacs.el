(el-get 'sync '(logalimacs))

(defun loga-with-ruby19 (command)
;; rbenvでlogalimacsを使うときは1.9をつかう
  (rbenv-use "1.9.3-p429")
  (funcall command)
  (rbenv-use-global)
)

;;; keybinds
(when (require 'logalimacs nil t)
  (global-set-key (kbd "M-g M-i")
    (lambda () (interactive) (loga-with-ruby19 'loga-interactive-command)))
  (global-set-key (kbd "M-g M-l")
    (lambda () (interactive) (loga-with-ruby19 'loga-lookup-at-manually)))
  (global-set-key (kbd "M-g M-a")
    (lambda () (interactive) (loga-with-ruby19 'loga-add)))
  (global-set-key (kbd "C-:")
    (lambda () (interactive) (loga-with-ruby19 'loga-lookup-in-popup))))

;;; 以下はお好みで設定してください(version1.0から)
;; lookupに--dictionaryオプションを利用する場合
(setq loga-use-dictionary-option t)
;; :autoがデフォルトでカーソル位置の近くにpopup
;; :maxにするとbuffer一杯までpopupをのばし行の最初から表示します
(setq loga-popup-output-type :max)
