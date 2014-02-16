(add-to-list 'load-path "~/.emacs.d/imports/simplenote")

(defun simplenote ()
  (interactive)
  (require 'simplenote)
  (setq simplenote-email "km.091004@gmail.com")
  (with-temp-buffer
    (insert-file-contents "~/.simplenote.gpg")
    (setq simplenote-password (buffer-string))
  )
  (simplenote-setup)
  (simplenote-browse)
)
