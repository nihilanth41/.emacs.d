
(setq gc-cons-threshold 400000000)

;; Startup
(when window-system
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1))

;; 
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; Disable CJK coding/encoding (Chinese/Japanese/Korean characters)
(setq utf-translate-cjk-mode nil) (set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Setup package
(require 'package)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.org/packages/") t))
(package-initialize)

;; Ensure use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; From use-package README
(eval-when-compile
  (require 'use-package))

;; Load config
(org-babel-load-file (concat user-emacs-directory "config.org"))

(setq gc-cons-threshold 800000)

