(require 'cl)

(defvar installing-package-list
  '(
    async
    dash
    git-commit
    markdown-mode
    scss-mode
    slim-mode
    coffee-mode
    yaml-mode
    rspec-mode
    open-junk-file
    popup
    magit
    helm
    anzu
    auto-complete
    with-editor
    web-mode
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))
