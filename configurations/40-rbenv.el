(add-to-list 'load-path "~/.emacs.d/imports/rbenv")

(require 'rbenv)
(global-rbenv-mode)
(rbenv-use-global)
(setq rbenv-show-active-ruby-in-modeline nil)
