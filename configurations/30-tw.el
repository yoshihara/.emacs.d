;; twittering-mode
(el-get 'sync '(twittering-mode))
(setq twittering-use-master-password t)
(setq twittering-initial-timeline-spec-string
      '(":home"))
;; アイコン表示
(setq twittering-icon-mode nil)

(el-get 'sync '(haml-mode))

(setq coffee-tab-width 2)