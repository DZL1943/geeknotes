; -*- coding: utf-8 -*-
;;; package --- Summary
;;; Commentary:
;;; updated: 20220125
;;; Emacs 27.2 @macbook
;;; Code:
(setq package-archives '(
                         ("gnu"   . "http://elpa.zilongshanren.com/gnu/")
                         ("melpa" . "http://elpa.zilongshanren.com/melpa/")))

(package-initialize)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/"))

(setq default-directory "~/org/")
;; (setq user-full-name "user")
;; (setq user-mail-address "user@mail.com")

(setq debug-on-error t)
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore
      visible-bell nil)
(setq help-window-select 't)
(setq initial-major-mode 'text-mode)

;; (prefer-coding-system 'cp950)
;; (prefer-coding-system 'gb2312)
;; (prefer-coding-system 'cp936)
;; (prefer-coding-system 'gb18030)
;; (prefer-coding-system 'utf-16)
;; (prefer-coding-system 'utf-8-dos)
;; (prefer-coding-system 'utf-8-unix)
;; (set-language-environment 'Chinese-GB)
;; (set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;; (set-terminal-coding-system  'utf-8)
;; (set-keyboard-coding-system  'utf-8)
;; (set-clipboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (setq locale-coding-system   'utf-8)
;; (set-file-name-coding-system 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (setq-default pathname-coding-system 'utf-8)
;; (setq default-process-coding-system '(utf-8 . utf-8))
;; (modify-coding-system-alist 'process "*" 'utf-8)
;;(add-to-list 'file-coding-system-alist '("\\.org\\'" . utf-8))

(if (version<= "26.0.50" emacs-version)
    ;; (global-display-line-numbers-mode)
    (global-linum-mode t))

;; (set-face-background 'line-number "#2D3743")
;; (set-face-foreground 'line-number-current-line "yellow")
(global-hl-line-mode t)
(setq column-number-mode t)
;; (add-hook 'window-configuration-change-hook (lambda () (ruler-mode 1)))
(setq track-eol t)
(delete-selection-mode 1)
(show-paren-mode t)
(electric-pair-mode t)
(ido-mode t)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'prog-mode-hook #'whitespace-mode)
;; (setq-default whitespace-style '(face space tabs trailing lines-tail newline empty tab-mark newline-mark))
(add-hook 'prog-mode-hook 'hs-minor-mode)
;; (setq hs-hide-comments nil)
;; (setq hs-isearch-open 'x)
(eval-after-load 'hideshow
  '(define-key hs-minor-mode-map [left-margin mouse-1] 'hs-toggle-hiding))
(global-auto-revert-mode 1)
(setq make-backup-files nil)
(setq auto-save-default nil)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
;; (setq scroll-margin 3
;;       scroll-step 1
;;       scroll-conservatively 10000)
;; (setq mouse-wheel-scroll-amout '(1 ((shift) . 1)))
;; (setq mouse-wheel-progressive-speed nil)
;; (setq mouse-wheel-follow-mouse 't)
(mouse-avoidance-mode 'animate)
(display-time-mode t)
(setq display-time-day-and-date t)
;; (setq display-time-24hr-format t)
;; (setq calendar-longitude 116)
;; (setq calendar-latitude 40)
;; (setq calendar-location-name "Beijing")
;; (setq calendar-time-zone 480)
;; (setq calendar-standard-time-zone-name "CST")
;; (setq calendar-daylight-time-zone-name "CDT")
(setq calendar-week-start-day 1)
(setq calendar-chinese-all-holidays-flag t)
(setq diary-file "~/.emacs.d/diary")
(setq view-diary-entries-initially t  ;; ?
      mark-diary-entries-in-calendar t
      mark-holidays-in-calendar t  ;; not work
      number-of-diary-entries 7)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'diary-list-entries-hook 'diary-sort-entries t)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)
(global-set-key (kbd "C-c C") 'calendar)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "ESC ESC") 'view-mode)

(global-set-key (kbd "C-c I") (lambda()(interactive)(find-file "~/.emacs.d/init.el")))
;; toggle transparency
(global-set-key (kbd "C-c 0") (lambda()(interactive)(set-frame-parameter nil 'alpha (if (equal (frame-parameter nil 'alpha) 85) 100 85))))

(if (not window-system)
    (progn
      ;; (xterm-mouse-mode 1)
      (mouse-wheel-mode 1)
      (menu-bar-mode -1)
      (global-hl-line-mode nil)
      (load-theme 'tango-dark' t))
  (progn
    (tool-bar-mode -1)
    ;; (scroll-bar-mode -1)
    (menu-bar-mode 1)
    (global-tab-line-mode 1)
    (set-face-attribute 'tab-line nil :background "#2D3743" :foreground "white" :box nil)
    (set-face-attribute 'tab-line-tab-inactive nil :background "#2D3743" :foreground "white" :box nil)
    (set-face-attribute 'tab-line-tab-current nil :background "white" :foreground "blue" :box nil)
    (when (eq system-type 'darwin)
      (set-face-attribute 'default nil :height 160)
      (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend))
    ;; (when (eq system-type 'windows-nt)
    ;;   (setq fonts '("Consolas" "微软雅黑"))
    ;;   (set-fontset-font t 'unicode "Segoe UI Emoji" nil 'prepend)
    ;;   (set-face-attribute 'default nil :font
    ;;                       (format "%s:pixelsize=%d" (car fonts) 24)))
    ;; (when (eq system-type 'gnu/linux)
    ;;   (setq fonts '("SF Mono" "Noto Sans Mono CJK SC"))
    ;;   (set-fontset-font t 'unicode "Noto Color Emoji" nil 'prepend)
    ;;   (set-face-attribute 'default nil :font
    ;;                       (format "%s:pixelsize=%d" (car fonts) 24)))
    (setq default-frame-alist '(
                                (vertical-scroll-bars . nil)
                                (tool-bar-lines . 0)
                                (menu-bar-lines . 1)
                                (mouse-wheel-frame . t)
                                (cursor-type . bar)
                                (cursor-color . "green")
                                (top . 16) (left . 140) (width . 100) (height . 40)))
    (when (eq system-type 'darwin)
      (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
      (add-to-list 'default-frame-alist '(ns-appearance . dark)))
    (load-theme 'misterioso' t)
    (set-face-attribute 'region nil :background "#6B8E23" :foreground "white")))


(with-eval-after-load 'org
  (setq org-adapt-indentation nil)
  (setq org-src-fontify-natively t)
  (setq org-startup-truncated nil)
  (setq org-startup-folded t)
  ;; (setq org-startup-numerated t)
  (setq org-startup-with-inline-images t)
  (setq org-agenda-include-diary t)
  (setq org-directory "~/org/"
        org-agenda-files '("~/org/" "~/org/journal/")
        org-default-notes-file (concat org-directory "/notes.org"))
  ;; (setq org-todo-keywords '((sequence "TODO" "DOING" "BLOCK" "|" "DONE")))
  ;; (setq org-stuck-projects '("+PROJECT/-DONE" ("TODO" "NEXT") nil ""))
  ;; (setq org-capture-templates
  ;; '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks") "* TODO %?\n  %i\n  %a")
  ;;   ("j" "Journal" entry (file+datetree "~/org/journal.org") "* %?\nEntered on %U\n  %i\n  %a")))
  (org-babel-do-load-languages 'org-babel-load-languages '((emacs-lisp . t) (shell . t) (python . t))))

(progn
  (require 'comint)
  (setq comint-process-echoes t)
  (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
  (define-key comint-mode-map (kbd "<down>") 'comint-next-input))

;;
(defvar use-package-selected-packages '(
                                        use-package
                                        which-key
                                        company smartparens rainbow-delimiters
                                        highlight-indentation
                                        flycheck
                                        format-all
                                        ;; magit
                                        ;; yasnippet
                                        ivy counsel swiper
                                        ;; evil evil-collection
                                        right-click-context drag-stuff easy-kill
                                        imenu-list
                                        smart-mode-line
                                        ;; powerline
                                        ;; sis
                                        valign
                                        ;; markdown-mode grip-mode
                                        org-journal
                                        org-brain polymode
                                        ;; org-roam
                                        ) "Packages pulled in by use-package.")

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (eval-when-compile
    (require 'use-package)
    (setq use-package-always-ensure t)
    (setq use-package-always-defer t)
    (setq use-package-always-demand nil)
    (setq use-package-expand-minimally t)
    (setq use-package-verbose t)))

(use-package auto-package-update
  :disabled t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package which-key
  :init
  (which-key-mode)
  :config
  ;; Allow C-h to trigger which-key before it is done automatically
  (setq which-key-show-early-on-C-h t)
  ;; make sure which-key doesn't show normally but refreshes quickly after it is
  ;; triggered.
  ;; (setq which-key-idle-delay 10000)
  (setq which-key-idle-secondary-delay 0.05)
  (setq which-key-popup-type 'side-window)
  (setq which-key-side-window-location '(bottom, right))
  (setq which-key-side-window-max-width 0.33)
  (setq which-key-side-window-max-height 0.25)
  (define-key help-map "\C-h" 'which-key-C-h-dispatch))

(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package flycheck
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode))

(use-package smartparens
  :init
  (add-hook 'prog-mode-hook 'smartparens-mode))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  :custom-face
  (rainbow-delimiters-base-face ((t (:inherit nil))))
  (rainbow-delimiters-depth-1-face ((t (:foreground "red"))))
  (rainbow-delimiters-depth-2-face ((t (:foreground "orange"))))
  (rainbow-delimiters-depth-3-face ((t (:foreground "forest green"))))
  (rainbow-delimiters-depth-4-face ((t (:foreground "dodger blue"))))
  (rainbow-delimiters-depth-5-face ((t (:foreground "deep pink"))))
  (rainbow-delimiters-depth-6-face ((t (:foreground "dark turquoise"))))
  (rainbow-delimiters-depth-7-face ((t (:foreground "tomato1"))))
  (rainbow-delimiters-depth-8-face ((t (:foreground "PaleVioletRed1"))))
  (rainbow-delimiters-depth-9-face ((t (:foreground "SeaGreen1")))))

(use-package ivy
  :init
  (ivy-mode t)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; enable this if you want `swiper' to use it
  ;; (setq search-default-mode #'char-fold-to-regexp)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  ;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

(use-package counsel
  :bind (("M-x" . counsel-M-x)))

(use-package swiper
  :requires (ivy counsel)
  :bind (("M-s" . counsel-grep-or-swiper)))

;; (use-package powerline
;;   :init
;;   (powerline-default-theme))
(use-package smart-mode-line
  :init
  (setq sml/no-confirm-load-theme t)
  (sml/setup))
;; (use-package evil
;;   :disabled t
;;   :init
;;   (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
;;   (setq evil-want-keybinding nil)
;;   ;; (add-hook 'prog-mode-hook 'evil-mode)
;;   :config
;;   ;; (evil-mode 1)
;;   ;; default key is C-z
;;   (setq evil-default-state 'emacs)
;;   (setq evil-emacs-state-cursor '("SkyBlue2" bar)))

;; (use-package evil-collection
;;   :after evil
;;   :config
;;   (evil-collection-init))

(use-package highlight-indentation
  :init
  ;; (add-hook 'prog-mode-hook 'highlight-indentation-mode)
  (add-hook 'prog-mode-hook 'highlight-indentation-current-column-mode)
  :config
  (set-face-background 'highlight-indentation-face "#e3e3d3")
  (set-face-background 'highlight-indentation-current-column-face "#c3b3b3"))

(use-package format-all)

(use-package imenu-list
  :init
  (global-set-key (kbd "C-'") #'imenu-list-smart-toggle)
  (setq imenu-list-position 'right)
  (setq imenu-list-size 0.2)
  (setq imenu-list-auto-resize nil)
  (setq imenu-list-focus-after-activation nil)
  (setq imenu-list-after-jump-hook nil)
  (imenu-list-minor-mode))

(use-package right-click-context
  :init
  (right-click-context-mode 1)
  :config
  (setq right-click-context-mode-lighter ""))

(use-package drag-stuff
  :init
  (drag-stuff-global-mode 1)
  :config
  (drag-stuff-define-keys))

(use-package easy-kill
  :init
  (global-set-key [remap kill-ring-save] 'easy-kill))

(use-package valign
  :if window-system
  :init
  (add-hook 'org-mode-hook #'valign-mode))

;; (use-package org-superstar
;;   :init
;;   (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

(use-package sis
  :disabled t
  ;; :hook
  ;; enable the /follow context/ and /inline region/ mode for specific buffers
  ;; (((text-mode prog-mode) . sis-context-mode)
  ;;  ((text-mode prog-mode) . sis-inline-mode))

  :config
  ;; For MacOS
  (sis-ism-lazyman-config

   ;; English input source may be: "ABC", "US" or another one.
   ;; "com.apple.keylayout.ABC"
   "com.apple.keylayout.US"

   ;; Other language input source: "rime", "sogou" or another one.
   ;; "im.rime.inputmethod.Squirrel.Rime"
   ;;  "com.sogou.inputmethod.sogou.pinyin"
   "com.apple.inputmethod.SCIM.ITABC")

  ;; enable the /cursor color/ mode
  (sis-global-cursor-color-mode t)
  ;; enable the /respect/ mode
  (sis-global-respect-mode t)
  ;; enable the /context/ mode for all buffers
  (sis-global-context-mode t)
  ;; enable the /inline english/ mode for all buffers
  (sis-global-inline-mode t)
  )

(use-package org-journal
  :init
  ;; Change default prefix key; needs to be set before loading org-journal
  (setq org-journal-prefix-key "C-c j")
  :config
  (setq org-journal-dir "~/org/journal/"
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-file-type 'monthly
        org-journal-enable-agenda-integration t
        org-journal-carryover-items ""
        org-journal-date-format "%A, %Y/%m/%d"))

(use-package org-brain
  :init
  (setq org-brain-path "~/org/brain/")
  (global-set-key (kbd "C-c b") 'org-brain-visualize)
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (bind-key "C-c b" 'org-brain-prefix-map org-mode-map)
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer)
  ;; (push '("b" "Brain" plain (function org-brain-goto-end)
  ;;         "* %i%?" :empty-lines 1)
  ;;       org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12)
  (setq org-brain-include-file-entries nil
        org-brain-file-entries-use-title nil))

;; Allows you to edit entries directly from org-brain-visualize
(use-package polymode
  :config
  (add-hook 'org-brain-visualize-mode-hook #'org-brain-polymode))

(use-package org-roam
  :disabled t
  :custom
  (org-roam-directory (file-truename "~/org/roam/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package yasnippet
  :disabled
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
  (yas-global-mode 1))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package grip-mode
  ;; :hook ((markdown-mode org-mode) . grip-mode)
  :config
  (setq grip-binary-path "/opt/homebrew/bin/grip")
  (setq grip-preview-use-webkit t))

(use-package vimrc-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode)))

(use-package lua-mode
  :config
  (setq lua-indent-level 4))


(defun use-package-autoremove ()
  "Autoremove packages not used by use-package."
  (interactive)
  (let ((package-selected-packages use-package-selected-packages))
    (package-autoremove)))

;; https://stackoverflow.com/questions/2249955/emacs-shift-tab-to-left-shift-the-block
(defun indent-region-custom(numSpaces)
  (progn
    ;; default to start and end of current line
    (setq regionStart (line-beginning-position))
    (setq regionEnd (line-end-position))
    ;; if there's a selection, use that instead of the current line
    (when (use-region-p)
      (setq regionStart (region-beginning))
      (setq regionEnd (region-end)))

    (save-excursion ; restore the position afterwards
      (goto-char regionStart) ; go to the start of region
      (setq start (line-beginning-position)) ; save the start of the line
      (goto-char regionEnd) ; go to the end of region
      (setq end (line-end-position)) ; save the end of the line

      (indent-rigidly start end numSpaces) ; indent between start and end
      (setq deactivate-mark nil) ; restore the selected region
      )))

(defun untab-region (N)
  (interactive "p")
  (indent-region-custom -4))

(defun tab-region (N)
  (interactive "p")
  (if (active-minibuffer-window)
      (minibuffer-complete)    ; tab is pressed in minibuffer window -> do completion
    (if (use-region-p)    ; tab is pressed is any other buffer -> execute with space insertion
        (indent-region-custom 4) ; region was selected, call indent-region-custom
      (insert "    ") ; else insert four spaces as expected
      )))

(defun my/hack-tab-key ()
  (interactive)
  (local-set-key (kbd "<tab>") 'tab-region)
  (local-set-key (kbd "<backtab>") 'untab-region))

;; (add-hook 'prog-mode-hook 'my/hack-tab-key)

;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("/Users/mac/org/2022-01.org" "/Users/mac/org/draft.org" "/Users/mac/org/make-money.org" "/Users/mac/org/journal/2022-01-01.org" "/Users/mac/Documents/Obsidian/org/journal/2022-01-01.org"))
 '(package-selected-packages
   '(easy-kill which-key valign use-package smartparens right-click-context rainbow-delimiters polymode org-journal org-brain markdown-mode magit highlight-indentation grip-mode format-all flycheck drag-stuff counsel company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-base-face ((t (:inherit nil))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "forest green"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "dodger blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "dark turquoise"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "tomato1"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "PaleVioletRed1"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "SeaGreen1")))))
