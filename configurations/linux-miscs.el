(set-fontset-font "fontset-default"
                  'japanese-jisx0208
                  '("VL ゴシック" . "iso10646-1")) ;; VL Gothicも可
(require 'ibus-setting)
(add-hook 'after-init-hook 'ibus-mode-on)
(ibus-define-common-key (kbd "C-SPC") nil)
(ibus-define-common-key (kbd "C-/") nil)
(define-key global-map (kbd "C-o") 'ibus-toggle)
