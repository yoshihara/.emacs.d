(require 'popwin)
(el-get 'sync '(po-mode))

(setq display-buffer-function 'popwin:display-buffer)
;; po-mode
(push '("\\*.*\\.po\\*"
        :regexp t
        :position bottom
        :height 20)
      popwin:special-display-config)
