(require 'org)
(setq org-agenda-files (list "~/Dropbox/todo/todo.org" "~/Dropbox/todo/todo.org_archive"))
(setq org-default-notes-file "~/Dropbox/todo/todo.org")
(global-set-key (kbd "C-c a") `org-agenda)
(setq org-log-done '(done))
(org-remember-insinuate)
(setq org-remember-templates
      '(("Todo" ?d "** TODO %?\n   SCHEDULED: %t" nil "Today")
        ("Inbox" ?i "** TODO %?\n   %a" nil "Inbox")))
(global-set-key (kbd "C-c r") `org-remember)

;; 6分前から2分おきにお知らせする
(setq appt-display-format 'window)
(setq appt-display-duration 30)
(setq appt-display-mode-line t)
(setq appt-message-warning-time 6)
(setq appt-display-interval 3)
(display-time)
(appt-activate 1)
(org-agenda-to-appt)
;; org-agendaを開いたとき・capture後にリマインダーを登録する
(add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt)
(add-hook 'org-remember-after-finalize-hook 'org-agenda-to-appt)
(add-hook 'org-mode-hook
      (lambda() (add-hook 'before-save-hook
                  'org-agenda-to-appt t)))


(defun open-org ()
  (interactive)
  (find-file org-default-notes-file)
)

(global-set-key (kbd "C-c C-o") 'open-org)
