(require 'cl)

(defvar installing-package-list
  '(
    git-commit
    magit
    helm
    anzu
    auto-complete
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (dolist (pkg not-installed)
        (package-install pkg))))
