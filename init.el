(setq user-full-name "mathew tony")
(setq user-mail-address "mathew.tony.t@gmail.com")

;;; getting environment values
(setenv "PATH" (concat "/usr/local/bin:/opt/local/bin:/usr/bin:/bin" (getenv "PATH")))
(require 'cl)

;;; define the packages
(load "package")
(package-initialize)
(add-to-list 'package-archives
						              '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
						              '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-archive-enable-alist '(("melpa" deft magit)))


;;; default packages
(defvar mtony/packages '(ac-slime
                          auto-complete
                          autopair
                          deft
                          feature-mode
                          flycheck
                          js2-mode
                          gist
                          htmlize
                          magit
                          markdown-mode
                          marmalade
                          nodejs-repl
                          o-blog
                          org
                          paredit
                          restclient
                          rvm
                          scala-mode
                          smex
                          web-mode
                          writegood-mode
                          yaml-mode)
 "Default packages")

(defun mtony/packages-installed-p ()
	  (loop for pkg in mtony/packages
					        when (not (package-installed-p pkg)) do (return nil)
									        finally (return t)))

(unless (mtony/packages-installed-p)
	  (message "%s" "Refreshing package database...")
		  (package-refresh-contents)
			  (dolist (pkg mtony/packages)
					    (when (not (package-installed-p pkg))
								      (package-install pkg))))


(setq inhibit-splash-screen t
			      initial-scratch-message nil
						      initial-major-mode 'org-mode)

(tool-bar-mode -1)
(menu-bar-mode -1)


(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
	  (toggle-indicate-empty-lines))

(setq tab-width 2
			      indent-tabs-mode nil)


;; FONT setting

(setq make-backup-files nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)


(setq org-agenda-show-log t
			      org-agenda-todo-ignore-scheduled t
						      org-agenda-todo-ignore-deadlines t)

(setq org-agenda-files (list "~/extra-matt/org-emacs/personal.org"
													 "~/extra-matt/org-emacs/groupon.org"))


(setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(ido-mode t)
(setq ido-enable-flex-matching t
			      ido-use-virtual-buffers t)

(setq column-number-mode t)

(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(require 'autopair)

(require 'auto-complete-config)
(ac-config-default)

(defun untabify-buffer ()
	  (interactive)
		  (untabify (point-min) (point-max)))

(defun indent-buffer ()
	  (interactive)
		  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
	  "Perform a bunch of operations on the whitespace content of a buffer."
		  (interactive)
			  (indent-buffer)
				  (untabify-buffer)
					  (delete-trailing-whitespace))

(defun cleanup-region (beg end)
	  "Remove tmux artifacts from region."
		  (interactive "r")
			  (dolist (re '("\\\\│\·*\n" "\W*│\·*"))
					    (replace-regexp re "" nil beg end)))

(global-set-key (kbd "C-x M-t") 'cleanup-region)
(global-set-key (kbd "C-c n") 'cleanup-buffer)

(setq-default show-trailing-whitespace t)

(setq flyspell-issue-welcome-flag nil)
(if (eq system-type 'darwin)
	    (setq-default ispell-program-name "/usr/local/bin/aspell")
			  (setq-default ispell-program-name "/usr/bin/aspell"))
(setq-default ispell-list-command "list")

(add-to-list 'auto-mode-alist '("\\.zsh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.gitconfig$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

(defun js-custom ()
	  "js-mode-hook"
		  (setq js-indent-level 2))

(add-hook 'js-mode-hook 'js-custom)

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
(add-hook 'markdown-mode-hook
					          (lambda ()
											            (visual-line-mode t)
																	            (writegood-mode t)
																							            (flyspell-mode t)))
(setq markdown-command "pandoc --smart -f markdown -t html")


(if window-system
	    (load-theme 'tango-plus t)
			  (load-theme 'flatui t))

(require 'ansi-color)
(defun colorize-compilation-buffer ()
	  (toggle-read-only)
		  (ansi-color-apply-on-region (point-min) (point-max))
			  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-safe-themes
   (quote
    ("80ceeb45ccb797fe510980900eda334c777f05ee3181cb7e19cd6bb6fc7fda7c" default)))
 '(package-selected-packages
   (quote
    (tango-plus-theme yasnippet yaml-mode writegood-mode web-mode web-beautify tss tide sublime-themes solarized-theme smex scala-mode rvm restclient projectile project-explorer paredit o-blog nodejs-repl neotree minimap meacupla-theme marmalade markdown-mode magit js3-mode htmlize gist flatui-theme feature-mode deft autopair atom-one-dark-theme ac-slime ac-js2))))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
)(defun fontify-frame (frame)
(set-frame-parameter frame 'font "Consolas-24"))
;; Fontify current frame
(fontify-frame nil)
;; Fontify any future frames
(push 'fontify-frame after-make-frame-functions)
