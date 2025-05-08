;; -*- lexical-binding: t; -*-
;;; init.el — a Neovim‑style Emacs starter config

;;------------------------------------------------------------------------------
;; Basic package setup & performance tweaks
;;------------------------------------------------------------------------------

(use-package visual-fill-column
  :ensure t)

(defun my/org-mode-visual-settings ()
  "Enable visual settings for Org mode: soft wrap, centering, no line numbers."
  (visual-line-mode 1)
  (setq-local visual-fill-column-width 100
              visual-fill-column-center-text t)
  (visual-fill-column-mode 1)
  (display-line-numbers-mode 0))

(setq evil-respect-visual-line-mode t)

(defun my/org-mode-font-setup ()
  "Use a custom font for Org mode buffers only."
  (face-remap-add-relative 'default '(:family "Iosevka Aile" :height 120)))


(add-hook 'org-mode-hook #'my/org-mode-visual-settings)
(add-hook 'org-mode-hook #'my/org-mode-font-setup)

(electric-pair-mode 1)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(setq make-backup-files nil)  ;; Disable creation of backup files

;; speed up startup by increasing garbage‑collection threshold:
(setq gc-cons-threshold (* 50 1000 1000))

(set-face-attribute 'default nil
                    :family "JetBrainsMono Nerd Font"
                    :height 120)

;; initialize package sources
(require 'package)
(setq package-archives
      '(("elpa"   . "https://elpa.gnu.org/packages/")
        ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)    ;; auto‑install missing packages

;; separate customizations
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)

;;------------------------------------------------------------------------------
;; Evil (Vim emulation) & key discovery
;;------------------------------------------------------------------------------

(setq evil-want-keybinding nil)

(use-package evil
  :init
  (setq evil-want-C-u-scroll t    ;; make C‑u scroll like Vim
        evil-want-integration t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))         ;; bring Evil bindings to more modes

(use-package which-key
  :config
  (which-key-mode)                ;; show possible keybindings in popup
  (setq which-key-idle-delay 0.3))

;;------------------------------------------------------------------------------
;; UI: theme, modeline, icons
;;------------------------------------------------------------------------------

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-completion
  :hook (marginalia-mode . nerd-icons-completion-mode))

(use-package doom-themes
  :config
  (load-theme 'doom-one-light t))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

;;(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/doom-moonfly-theme")

;;(load-theme 'doom-moonfly t)

;;(load-theme 'doom-1337 t)

;; UI cleanup
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)
(setq visible-bell t)  ;; no beeping


;;------------------------------------------------------------------------------
;; Project management & file‑tree
;;------------------------------------------------------------------------------
;;; ----- Dired -----

(defun dw/dired-mode-hook ()
  (interactive)
  (dired-hide-details-mode 1)
  (hl-line-mode 1))

(use-package dired
  :ensure nil ; built-in
  :commands (dired dired-jump)
  :custom
  (dired-listing-switches "-alh --group-directories-first")
  (dired-dwim-target t) ; smart copy/move target
  (dired-auto-revert-buffer t)
  :config
  (put 'dired-find-alternate-file 'disabled nil) ; reuse dired buffers
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))
  (define-key dired-mode-map (kbd "h") 'dired-up-directory)
  (define-key dired-mode-map (kbd "l") 'dired-find-file))

(use-package dired
  :ensure nil
  :after evil
  :hook (dired-mode . (lambda () (evil-normalize-keymaps)))
  :config
  (evil-define-key 'normal dired-mode-map
    (kbd "h") 'dired-up-directory
    (kbd "l") 'dired-find-file
    (kbd "gg") 'beginning-of-buffer
    (kbd "G") 'end-of-buffer
    (kbd "q") 'quit-window
    (kbd "TAB") 'dired-hide-subdir
    (kbd "za") 'dired-hide-subdir
    (kbd "gr") 'revert-buffer))

(use-package projectile
  :config
  (projectile-mode 1)                     ;; Enable Projectile for project management
  (setq projectile-completion-system 'ivy)  ;; Use Ivy for completion in Projectile commands
  :bind-keymap
  ("C-c p" . projectile-command-map))    ;; Bind Projectile commands to C-c p

;;------------------------------------------------------------------------------
;; Completion & minibuffer enhancement
;;------------------------------------------------------------------------------

(use-package vertico
  :config
  (vertico-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)))

(use-package consult
  :after vertico
  :config
  (consult-customize
   consult-ripgrep :preview-key "C-.") ;; example: live preview with C-.
  )

;; optionally: YASnippet for snippets
(use-package yasnippet
  :config
  (yas-global-mode 1))

;; LSP
;; Tree-sitter grammars

(setq treesit-language-source-alist
 '((bash "https://github.com/tree-sitter/tree-sitter-bash")
   (cmake "https://github.com/uyha/tree-sitter-cmake")
   (css "https://github.com/tree-sitter/tree-sitter-css")
   (elisp "https://github.com/Wilfred/tree-sitter-elisp")
   (go "https://github.com/tree-sitter/tree-sitter-go")
   (gomod "https://github.com/camdencheek/tree-sitter-go-mod")
   (dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile")
   (html "https://github.com/tree-sitter/tree-sitter-html")
   (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
   (json "https://github.com/tree-sitter/tree-sitter-json")
   (make "https://github.com/alemuller/tree-sitter-make")
   (markdown "https://github.com/ikatyang/tree-sitter-markdown")
   (python "https://github.com/tree-sitter/tree-sitter-python")
   (toml "https://github.com/tree-sitter/tree-sitter-toml")
   (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
   (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
   (yaml "https://github.com/ikatyang/tree-sitter-yaml")))


(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-completion-provider :capf))

;; Initialize and configure Ivy for efficient completion
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)                         ;; Use Swiper for search (C-s)
         ("C-x b" . ivy-switch-buffer)            ;; Switch between buffers using Ivy (C-x b)
         ("M-x" . counsel-M-x)                    ;; Use Counsel for M-x commands (M-x)
         ("C-x C-f" . counsel-find-file))         ;; Use Counsel for finding files (C-x C-f)
  :config
  ;; Enable Ivy globally for completion
  (ivy-mode 1)                                   
  ;; Customize Ivy behavior and appearance
  (setq ivy-use-virtual-buffers t                 ;; Enable virtual buffers (e.g., for Dired)
        ivy-count-format "(%d/%d) "               ;; Format for counting items
        ivy-initial-inputs-alist nil))            ;; Disable default initial input for some commands

;; Enable Ivy-rich for a prettier and more informative display of completions
(use-package ivy-rich
  :after ivy
  :config
  (ivy-rich-mode 1))  ;; Enable Ivy-rich mode for enhanced display of candidates

(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package go-mode
  :ensure t
  :hook (go-mode . lsp-deferred)) ;; this enables LSP in Go files

(use-package csharp-mode
  :mode "\\.cs\\'"
  :hook (csharp-mode . lsp-deferred))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-doc-show-with-mouse t
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover t))


;; Enable company-mode for completion
(use-package company
  :ensure t
  :hook
  (after-init . global-company-mode))  ;; Enable company-mode globally

(setq company-backends '(company-capf))

(use-package company-box
  :ensure t
  :after company
  :hook (company-mode . company-box-mode))

(use-package company-quickhelp
  :ensure t
  :config
  (company-quickhelp-mode 1))

(use-package copilot
  :ensure t
  :hook (prog-mode . copilot-mode)
  :config
  (define-key copilot-mode-map (kbd "TAB") #'copilot-accept-completion)
  (define-key copilot-mode-map (kbd "M-[") #'copilot-previous-completion)
  (define-key copilot-mode-map (kbd "M-]") #'copilot-next-completion)
  (define-key copilot-mode-map (kbd "C-c C-c") #'copilot-clear-overlay)
  (add-to-list 'copilot-indentation-alist '(prog-mode . 4))
  (add-to-list 'copilot-indentation-alist '(org-mode . 4))
  (add-to-list 'copilot-indentation-alist '(text-mode . 4))
  (add-to-list 'copilot-indentation-alist '(closure-mode . 4))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode . 4)))

;; DAP
(use-package dap-mode
  :ensure t
  :after lsp-mode
  :config
  (dap-auto-configure-mode)
  (require 'dap-netcore)
  (require 'dap-dlv-go))

;;(setq dap-launch-debug-path (concat (projectile-project-root) ".vscode/launch.json"))


;;------------------------------------------------------------------------------
;; Git: Magit
;;------------------------------------------------------------------------------

(use-package magit
  :commands (magit-status)
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;;------------------------------------------------------------------------------
;; Org‑mode (notes, todo, agendas)
;;------------------------------------------------------------------------------

(use-package org
  :config
  (setq org-startup-indented t
        org-hide-leading-stars t
        org-directory "~/Documents/org/"
        org-default-notes-file (expand-file-name "inbox.org" org-directory)
        org-agenda-files (append
                          (list (expand-file-name "inbox.org" org-directory))
                          (directory-files-recursively (expand-file-name "notes/" org-directory) "\\.org$"))
        org-refile-targets '((org-agenda-files :maxlevel . 3))
        org-log-done 'time))

(setq org-capture-templates
      '(("t" "Todo" entry (file "~/Documents/org/inbox.org")
         "* TODO %^{Task}\nCaptured: %U\n%?")
        ("m" "Meeting" entry (file "~/Documents/org/inbox.org")
         "* %^{Meeting Title}  :meeting:\nCaptured: %U\n%?")
        ("i" "Idea" entry (file "~/Documents/org/inbox.org")
         "* %^{Idea Title}  :idea:\nCaptured: %U\n%?")
        ("k" "Knowledge" entry (file "~/Documents/org/inbox.org")
         "* %^{Topic}  :knowledge:\nCaptured: %U\n%?")
        ("n" "Note" entry (file "~/Documents/org/inbox.org")
         "* %^{Note Title}\nCaptured: %U\n%?")))

(require 'epg)

(defvar my/diary-directory "~/Documents/org/journal/"
  "Directory where encrypted diary entries are stored.")

(defun my/diary-file-name ()
  (expand-file-name (format-time-string "%Y-%m-%d.org.gpg") my/diary-directory))

(defun my/secure-diary-entry-epg ()
  "Open today's encrypted diary entry, decrypting with EPG.
Encrypts on save using symmetric encryption."
  (interactive)
  (let* ((file (my/diary-file-name)))
    (make-directory my/diary-directory t)
    (if (file-exists-p file)
        ;; Decrypt and open
        (find-file file)
      ;; New file — create with heading and save encrypted
      (let ((buffer (find-file file)))
        (insert (format "# %s\n\n" (format-time-string "%A, %Y-%m-%d")))
        (save-buffer)
        buffer))))

;;------------------------------------------------------------------------------
;; Misc: copy/paste with system, auto‑reload, etc.
;;------------------------------------------------------------------------------

;; use system clipboard
(setq select-enable-clipboard t
      select-enable-primary t)

;; auto‑reload changed files
(global-auto-revert-mode 1)

(use-package vterm
  :ensure t)
(with-eval-after-load 'vterm
  (define-key vterm-mode-map (kbd "C-c C-c") #'vterm-send-C-c))

(defun my/toggle-vterm ()
  "Toggle a vterm buffer in a horizontal split at the bottom."
  (interactive)
  (let* ((buf-name "*vterm*")
         (buf (get-buffer buf-name)))
    (if (and buf (get-buffer-window buf))
        ;; If visible, delete the window
        (delete-window (get-buffer-window buf))
      ;; Else, show in a horizontal split at bottom
      (let ((window (split-window-vertically -15)))
        (select-window window)
        (if buf
            (switch-to-buffer buf)
          (vterm))))))

(global-set-key (kbd "C-`") 'my/toggle-vterm)

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))


(use-package general
  :config
  (general-create-definer my/leader
    :states '(normal visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
(my/leader
  "f"  '(:which-key "file")
  "ff" '(counsel-fzf :which-key "find file")
  "fr" '(counsel-recentf :which-key "recent files")
  "fc" '(lambda () (interactive)
          (let ((default-directory user-emacs-directory))
            (counsel-find-file)))
  "b"  '(:which-key "buffer")
  "bb" '(counsel-switch-buffer :which-key "switch buffer")
  "k"  '(:which-key "kill")
  "kb" '(kill-buffer :which-key "kill buffer")
  "p"  '(:which-key "project")
  "pp" '(projectile-switch-project :which-key "switch project")
  "g"  '(:which-key "git")
  "gs" '(magit-status :which-key "status")
  "e"  '(:which-key "dired")
  "ee" '(dired-jump :which-key "dired jump")
  "o"  '(:which-key "org")
  "oa" '(org-agenda :which-key "agenda")
  "oc" '(org-capture :which-key "capture")
  "ol" '(org-store-link :which-key "store link")
  "oj" '(lambda () (interactive) (org-capture nil "n")) ;; fast note capture
  "or" '(org-refile :which-key "refile entry")
  "of" '(lambda () (interactive)
         (let ((default-directory "~/Documents/org"))
            (counsel-rg "" default-directory))))
  )

(with-eval-after-load 'evil
  (with-eval-after-load 'go-mode
    (general-def
      :states '(normal)
      :keymaps 'go-mode-map
      "g d" #'lsp-find-definition
      "g r" #'lsp-find-references
      "g i" #'lsp-find-implementation
      "g t" #'lsp-find-type-definition)))


;;------------------------------------------------------------------------------
;; Final touches
;;------------------------------------------------------------------------------

;; restore GC threshold after startup
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 2 1000 1000))))

(use-package which-key
  :config
  (which-key-mode))

(provide 'init)
;;; init.el ends here
