(require 're-builder)
;; C-c C-s / C-c C-r -> C-s / C-r
(define-key reb-mode-map (kbd "C-s") 'reb-next-match)
(define-key reb-mode-map (kbd "C-r") 'reb-prev-match)
;; C-c C-q -> C-g
(define-key reb-mode-map (kbd "C-g") 'reb-copy-and-quit)
(define-key reb-mode-map (kbd "C-c C-q") 'reb-copy-and-quit)
;; C-c C-i -> C-i
(define-key reb-mode-map (kbd "C-i") 'reb-change-syntax)
;; C-c C-w -> C-k: C-kは正規表現もクリアしたい
(define-key reb-mode-map (kbd "C-k") 'reb-copy-and-erase)
(define-key reb-mode-map (kbd "C-c C-k") 'reb-copy-and-erase)
;; 文字列リテラルではなく正規表現そのもの
(setq reb-re-syntax 'string)
;; 終了時に正規表現をキルリングに入れる
(defun reb-copy-and-quit ()
(interactive)
(reb-copy)
(reb-quit))
;; 現在の正規表現をキルリングに入れてから正規表現を初期化する
(defun reb-copy-and-erase ()
(interactive)
(reb-copy)
(with-current-buffer reb-target-buffer (setq reb-regexp nil))
(erase-buffer)
(reb-insert-regexp)
(forward-char -1))
(setq reb-re-syntax 'string)
(defvar reb-target-point nil)
(defun re-builder-with-point ()
"C-M-%仕様。現在位置から置換を開始するre-builder"
(interactive)
(setq reb-target-point (point))
(re-builder))
(defun re-builder-without-point ()
"元のM-x re-builder"
(interactive)
(setq reb-target-point nil)
(re-builder))
(defadvice reb-update-overlays (after with-point activate)
(when reb-target-point
(with-selected-window reb-target-window
(goto-char reb-target-point))))

;; 元ネタ http://emacs-journey.blogspot.jp/2012/06/re-builder-query-replace-this.html
(defun reb-query-replace-this-regxp (replace)
"Uses the regexp built with re-builder to query the target buffer.
This function must be run from within the re-builder buffer, not the target
buffer.

Argument REPLACE String used to replace the matched strings in the buffer. 
Subexpression references can be used (\1, \2, etc)."
(interactive "sReplace with: ")
(if (eq major-mode 'reb-mode)
(let (o (reg (reb-read-regexp)))
(select-window reb-target-window)
(save-excursion
(setq o (cl-find-if (lambda (ov) (eq (point) (overlay-end ov))) reb-overlays))
(if o (goto-char (overlay-start o)))
(query-replace-regexp reg replace)
(reb-quit)))
(error "Not in a re-builder buffer!")))

(global-set-key (kbd "C-M-%") 're-builder-with-point)
(define-key reb-mode-map (kbd "<return>") 'reb-query-replace-this-regxp)
