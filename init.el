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
;; (org-babel-load-file (concat user-emacs-directory "config.org"))
(use-package evil
 :ensure t
 :config 
 (evil-mode t))

(use-package paredit
  :ensure t
  :init
  (add-hook 'emacs-lisp-mode-hook (lambda () (paredit-mode +1)))
  (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
  (add-hook 'lisp-mode-hook (lambda () (paredit-mode +1))))

(use-package rcirc
 :config
 (progn
    ;; Quit/part messages
    (setq rcirc-id-string "")
    (rcirc-track-minor-mode)
    (use-package rcirc-color :ensure t)
    (add-hook 'rcirc-mode-hook
          (lambda ()
                (setq rcirc-omit-mode nil)
                (rcirc-omit-mode)
                (set (make-local-variable 'scroll-conservatively) 8192)))
    (defun-rcirc-command q (arg)
    "/q alias for /query"
    (rcirc-cmd-query arg))
    ;; (setq rcirc-authinfo '(("freenode" nickserv "zrr" "<PASSWORD>")))
    (setq rcirc-default-nick "zrr")
    (setq rcirc-default-user-name "zrr")
    (setq rcirc-default-full-name "zrr")
    (setq rcirc-omit-responses '("JOIN" "PART" "QUIT" "NICK" "AWAY"))
    (setq rcirc-server-alist
        '(("irc.freenode.net"
            :channels ("#emacs"))))
    (global-set-key (kbd "C-c I") 'rcirc)))

(set-register ?i '(file . "~/.emacs.d/init.el"))
(set-register ?o '(file . "~/.emacs.d/config.org"))

(column-number-mode)

;; Navigate split windows w/ cursor keys
(windmove-default-keybindings)

(use-package cyberpunk-theme
 :ensure t
 :init 
 (load-theme 'cyberpunk t))

(setq gc-cons-threshold 800000)
