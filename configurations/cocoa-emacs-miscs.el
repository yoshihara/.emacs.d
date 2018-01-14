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

(let ((default-directory (expand-file-name "~/.emacs.d/")))
 (add-to-list 'load-path default-directory)
 (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
     (normal-top-level-add-subdirs-to-load-path)))

(setq max-lisp-eval-depth 100000000000)
(setq popwin:close-popup-window-timer-interval 0.1)

(require 'cl)
(defun clear-close-popwin-window-timer ()
  (interactive)
  (setq timer-list (remove-if 'close-popwin-timer-p timer-list)))

(defun close-popwin-timer-p (timer)
  (string= "popwin:close-popup-window-timer" (symbol-name (aref timer 5))))

;; magitでコミットメッセージ入力時に新しいemacsを立ち上げないようにする
(set-variable 'with-editor-emacsclient-executable "/usr/local/Cellar/emacs/24.5/bin/emacsclient")
