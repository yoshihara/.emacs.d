(require 'cl)

(defvar installing-package-list
  '(
    async
    dash
    git-commit
    haml-mode
    json-mode
    markdown-mode
    scss-mode
    sass-mode
    slim-mode
    coffee-mode
    yaml-mode
    rspec-mode
    textile-mode
    open-junk-file
    popup
    magit
    helm
    anzu
    auto-complete
    with-editor
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))
