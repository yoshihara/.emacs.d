(require 'cl)

(defvar installing-package-list
  '(
    async
    dash
    git-commit
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
    (dolist (pkg not-installed)
        (package-install pkg))))
