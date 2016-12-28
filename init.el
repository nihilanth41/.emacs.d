;; Set path for custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Disable GUI menus
(when window-system
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1))

;; Disable CJK coding/encoding 
(setq utf-translate-cjk-mode nil)

;; Set UTF8 defaults
(set-language-environment 'utf-8)
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

(eval-when-compile
  (require 'use-package)
  (require 'diminish)
  (require 'bind-key))

(use-package bind-key
  :ensure t)

(use-package cyberpunk-theme
 :ensure t
 :init 
 (load-theme 'cyberpunk t))

(use-package diminish
  :ensure t)

(use-package evil
 :ensure t
 :config 
 (evil-mode t))

(use-package ido
  :init
  (ido-mode t))

(use-package magit
  :ensure t
  :bind ("C-c g" . magit-status))

(use-package paredit
  :diminish paredit-mode
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

(use-package relative-line-numbers
  :ensure t
  :config
  (global-relative-line-numbers-mode))

(use-package show-paren-mode
  :init
  (setq show-paren-delay 0.0625)
  :config
  (show-paren-mode t))

(use-package undo-tree
  :diminish undo-tree-mode)

;; Disable startup and scratch messages
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; Setup registers
(set-register ?i '(file . "~/.emacs.d/init.el"))

;; Enable column numbers in modeline
(column-number-mode)

;; Navigate split windows w/ shift+cursor keys
(windmove-default-keybindings)

;; Yes/No -> y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; Automatically follow symlinks to version controlled files
(setq vc-follow-symlinks t)

;; For steam.el (just for fun)
(use-package steam
  :ensure t
  :config
  (setq steam-username "nihilanth41"))



