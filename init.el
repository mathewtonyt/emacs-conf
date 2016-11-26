(require 'package)
(add-to-list 'package-archives
    '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(package-initialize)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (auto-complete-mode)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (projectile-global-mode)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  (company-mode +1))

  (defun setup-js-mode ()
    (interactive)
    (projectile-global-mode)
    (yas-global-mode)
    (flymake-mode)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (recentf-mode)
    (auto-complete-mode)
    (eldoc-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

;; format options
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))
;; see https://github.com/Microsoft/TypeScript/blob/cc58e2d7eb144f0b2ff89e6a6685fb4deaa24fde/src/server/protocol.d.ts#L421-473 for the full list available options

(add-hook 'typescript-mode-hook #'setup-tide-mode)
(add-hook 'js2-mode-hook #'setup-js-mode)
(setq js2-highlight-level 3)

;; --------- FORMATTING STARTS------------------
(require 'web-beautify) ;; Not necessary if using ELPA package

(eval-after-load 'js2-mode
		 '(add-hook 'js2-mode-hook
				 (lambda ()
						 (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))
(eval-after-load 'json-mode
		'(add-hook 'json-mode-hook
				(lambda ()
			     (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(eval-after-load 'sgml-mode
		'(add-hook 'html-mode-hook
				(lambda ()
					(add-hook 'before-save-hook 'web-beautify-html-buffer t t))))

(eval-after-load 'web-mode
			'(add-hook 'web-mode-hook
				(lambda ()
					(add-hook 'before-save-hook 'web-beautify-html-buffer t t))))

(eval-after-load 'css-mode
				'(add-hook 'css-mode-hook
					(lambda ()
						(add-hook 'before-save-hook 'web-beautify-css-buffer t t))))
;; --------- FORMATTING ENDS------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes (quote (wilson)))
 '(custom-safe-themes
   (quote
    ("96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "15348febfa2266c4def59a08ef2846f6032c0797f001d7b9148f30ace0d08bcf" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" default)))
 '(fci-rule-color "#f1c40f")
 '(hl-paren-background-colors (quote ("#2492db" "#95a5a6" nil)))
 '(hl-paren-colors (quote ("#ecf0f1" "#ecf0f1" "#c0392b")))
 '(linum-format " %7i ")
 '(sml/active-background-color "#34495e")
 '(sml/active-foreground-color "#ecf0f1")
 '(sml/inactive-background-color "#dfe4ea")
 '(sml/inactive-foreground-color "#34495e")
 '(vc-annotate-background "#ecf0f1")
 '(vc-annotate-color-map
   (quote
    ((30 . "#e74c3c")
     (60 . "#c0392b")
     (90 . "#e67e22")
     (120 . "#d35400")
     (150 . "#f1c40f")
     (180 . "#d98c10")
     (210 . "#2ecc71")
     (240 . "#27ae60")
     (270 . "#1abc9c")
     (300 . "#16a085")
     (330 . "#2492db")
     (360 . "#0a74b9"))))
 '(vc-annotate-very-old-color "#0a74b9"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
(defun fontify-frame (frame)
	(set-frame-parameter frame 'font "Consolas-24"))
;; Fontify current frame
(fontify-frame nil)
;; Fontify any future frames
(push 'fontify-frame after-make-frame-functions)
