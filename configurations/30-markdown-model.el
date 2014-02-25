(add-hook 'markdown-mode-hook
          '(lambda()
             (local-set-key (kbd "C-M-n") 'next-multiframe-window)
             (local-set-key (kbd "C-M-p") 'previous-multiframe-window)))
