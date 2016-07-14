(setq load-path (append
                 '("~/.emacs.d")
                 load-path))

(setq load-path (append
                 '("~/.emacs.d/submodules")
                 load-path))

(setq load-path (append
                 '("~/.emacs.d/imports")
                 load-path))

;; package.elの設定
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line


;; init-loader
(require 'init-loader)
(setq init-loader-show-log-after-init t)
(init-loader-load "~/.emacs.d/configurations")

(defun chomp (str)
  (replace-regexp-in-string "[\n\r]+$" "" str))

;;; git
(defun git-project-p ()
  (string=
   (chomp
    (shell-command-to-string "git rev-parse --is-inside-work-tree"))
   "true"))

(defun git-root-directory ()
  (cond ((git-project-p)
         (chomp
          (shell-command-to-string "git rev-parse --show-toplevel")))
        (t
         "")))
(defun git-grep (grep-dir command-args)
  (interactive
   (let ((root (concat (git-root-directory) "/")))
     (list
      (read-file-name
       "Directory for git grep: " root root t)
      (read-shell-command
            "Run git-grep (like this): "
            (format "PAGER='' git grep -I -n -i -e %s"
                    "")
            'git-grep-history))))
  (let ((grep-use-null-device nil)
        (command
         (format (concat
                  "cd %s && "
                  "%s")
                 grep-dir
                 command-args)))
    (grep command)))
