;; twittering-mode
(el-get 'sync '(twittering-mode))
(require 'epg)
(setq twittering-use-master-password t)
(setq twittering-initial-timeline-spec-string
      '(":home"))
;; アイコン表示
(setq twittering-icon-mode nil)
