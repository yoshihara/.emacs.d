(add-to-list 'load-path "~/.emacs.d/submodules/evemacs")

(require 'evemacs)

(setq evemacs-notebook-name "00-Inbox")
(global-set-key (kbd "C-c h") 'evemacs-add-message)
