(require 'cl)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(defvar installing-package-list
  '(
    markdown-mode
    scss-mode
    coffee-mode
    yaml-mode
    open-junk-file
    magit
    textile-mode
    helm
    anzu
    ;; helm-recentf
    ;; helm-show-kill-ring
    ;; helm-ag
    ;; helm-ls-git
    ;; helm-git
    ;; helm-imenu
    auto-complete

    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))
