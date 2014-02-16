(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
;; ¥の代わりにバックスラッシュを入力する
(define-key global-map [?¥] [?\\])

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

(setq default-input-method "MacOSX")
(mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" `title "あ")
(set-fontset-font "fontset-default"
                  'japanese-jisx0208
                  '("Hiragino Kaku Gothic ProN" . "iso10646-1"))
(set-cursor-color 'gray)

;; パスの設定
(let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
  (setenv "PATH" path-from-shell)
  (setq exec-path (split-string path-from-shell path-separator)))

(let ((default-directory (expand-file-name "~/.emacs.d/")))
 (add-to-list 'load-path default-directory)
 (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
     (normal-top-level-add-subdirs-to-load-path)))

;; magitでコミットメッセージ入力時に新しいemacsを立ち上げないようにする
(set-variable 'magit-emacsclient-executable "/usr/local/Cellar/emacs/24.3/bin/emacsclient")
;; (set-variable 'magit-emacsclient-executable "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient")


(setq max-lisp-eval-depth 100000000000)
(setq popwin:close-popup-window-timer-interval 0.1)

(require 'cl)
(defun clear-close-popwin-window-timer ()
  (interactive)
  (setq timer-list (remove-if 'close-popwin-timer-p timer-list)))

(defun close-popwin-timer-p (timer)
  (string= "popwin:close-popup-window-timer" (symbol-name (aref timer 5))))
