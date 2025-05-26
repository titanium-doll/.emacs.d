(if (daemonp)
    (progn
      (setq default-directory "/home/lee/")))

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(set-fringe-mode 5)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org"   . "https://orgmode.org/elpa/")
			 ("elpa"  . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package dashboard
  :after (nerd-icons)
  :custom
  (dashboard-banner-logo-title "this lee's emacs config ^-^")
  (dashboard-startup-banner 'logo)

  (dashboard-footer-messages '("^w^"
			       ">~<"
			       ".,."
			       "<.<"
			       "~v~"
			       "~-~"
			       "-.-"
			       "zZz"
			       "emacs is sooo"))
  
  (dashboard-center-content            t)
  (dashboard-vertically-center-content t)
  
  (dashboard-item-names '(("Recent Files:" . "recent")
			  ("Bookmarks:"    . "bookmarks")))
  
  (dashboard-navigation-cycle t)
  (dashboard-item-shortcuts '((recents   . "t")
                              (bookmarks . "o")))
  (dashboard-items          '((recents   . 5)
			      (bookmarks . 5)))
  
  (dashboard-icon-type 'nerd-icons)
  (dashboard-display-icons-p   t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons    t)
  
  :hook (dashboard-mode . (lambda () (setq mode-line-format nil)))
  :config (dashboard-setup-startup-hook))

(column-number-mode)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(dolist (mode '(org-mode-hook
		term-mode-hook
		eshell-mode-hook
		dired-mode-hook
		eww-mode-hook
		package-menu-mode-hook
		help-mode-hook
		completion-list-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(dolist (set-keys '(("C-c bm"  . buffer-menu)
		    ("C-c bn"  . next-buffer)
		    ("C-c bp"  . previous-buffer)
		    ("C-c d"   . dired-jump)
		    ("C-c pa"  . package-upgrade-all)
		    ("C-c pd"  . package-delete)
		    ("C-c pi"  . package-install)
		    ("C-c pm"  . package-show-package-list)
		    ("C-c pu"  . package-upgrade)
		    ("C-c q"   . kill-buffer-and-window)
		    ("C-c sc"  . sort-columns)
		    ("C-c sf0" . sort-fields)
		    ("C-c sf1" . sort-regexp-fields)
		    ("C-c sf2" . sort-numeric-fields)
		    ("C-c sl"  . sort-lines)
		    ("C-c sp0" . sort-paragraphs)
		    ("C-c sp1" . sort-pages)
		    ("C-c l"   . eval-buffer)
		    ("C-c n"   . display-line-numbers-mode)
		    ("C-c x"   . meow-M-x)))
  (define-key global-map (kbd (car set-keys)) (cdr set-keys)))

(use-package avy
  :custom
  (avy-keys '(?n ?l ?d ?h ?r ?t ?x ?m ?p ?c ?, ?. ?o ?u ?s ?a ?i ?e)))

(use-package meow
  :custom
  (meow-cheatsheet-physical-layout meow-cheatsheet-physical-layout-iso)
  (meow-cheatsheet-layout '((<TLDE> "`" "~")  (<AE01> "1" "!") (<AE02> "2" "@") (<AE03> "3" "#")
			    (<AE04> "4" "$")  (<AE05> "5" "%") (<AE06> "6" "^") (<AE07> "7" "&")
			    (<AE08> "8" "*")  (<AE09> "9" "(") (<AE10> "0" ")") (<AE11> "-" "_")
			    (<AE12> "=" "+")  (<AD01> "b" "B") (<AD02> "r" "R") (<AD03> "t" "T")
			    (<AD04> "y" "Y")  (<AD05> "q" "Q") (<AD06> "v" "V") (<AD07> "w" "W")
			    (<AD08> "o" "O")  (<AD09> "u" "U") (<AD10> "j" "J") (<AD11> "[" "{")
			    (<AD12> "]" "}")  (<AC01> "n" "N") (<AC02> "l" "L") (<AC03> "d" "D")
			    (<AC04> "h" "H")  (<AC05> "k" "K") (<AC06> "z" "Z") (<AC07> "s" "S")
			    (<AC08> "a" "A")  (<AC09> "i" "I") (<AC10> "e" "E") (<AC11> "/" "?")
			    (<AB01> "x" "X")  (<AB02> "m" "M") (<AB03> "p" "P") (<AB04> "f" "F")
			    (<AB05> "'" "\"") (<AB06> "g" "G") (<AB07> "c" "C") (<AB08> "," "<")
			    (<AB09> "." ">")  (<AB10> ";" ":") (<BKSL> "\\" "|")))

  (meow-char-thing-table
   '((?r . round)
     (?q . square)
     (?c . curly)
     (?a . angle)
     (?s . string)
     (?m . symbol)
     (?p . paragraph)
     (?l . line)
     (?d . defun)
     (?x . buffer)))

  :config
  (meow-thing-register
   'angle
   '(pair (";") (":"))
   '(pair (";") (":")))

  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '(";" . meow-keypad-describe-key)
   '(":" . meow-cheatsheet))

  (meow-normal-define-key
   ;; expansion
   '("0" . meow-expand-0)
   '("1" . meow-expand-1)
   '("2" . meow-expand-2)
   '("3" . meow-expand-3)
   '("4" . meow-expand-4)
   '("5" . meow-expand-5)
   '("6" . meow-expand-6)
   '("7" . meow-expand-7)
   '("8" . meow-expand-8)
   '("9" . meow-expand-9)
   '("/" . meow-reverse)

   ;; movement
   '("i" . meow-prev)
   '("a" . meow-next)
   '("s" . meow-left)
   '("e" . meow-right)

   '("<" . meow-page-up)
   '(">" . meow-page-down)

   '("v" . meow-search)
   '(";" . meow-visit)
   '("-" . negative-argument)

   ;; expansion
   '("I" . meow-prev-expand)
   '("A" . meow-next-expand)
   '("S" . meow-left-expand)
   '("E" . meow-right-expand)

   '("g" . meow-back-word)
   '("G" . meow-back-symbol)
   '("c" . meow-next-word)
   '("C" . meow-next-symbol)

   '("n" . meow-mark-word)
   '("N" . meow-mark-symbol)
   '("m" . mark-word)
   '("l" . meow-line)
   '("L" . meow-goto-line)
   '("r" . meow-block)
   '("b" . meow-join)
   '("k" . meow-grab)
   '("K" . meow-pop-grab)
   '("y" . meow-swap-grab)
   '("Y" . meow-sync-grab)
   '("j" . meow-cancel-selection)
   '("J" . meow-pop-selection)

   '("w" . meow-till)
   '("H" . meow-find)
   '("x" . avy-goto-char)

   '("(" . meow-beginning-of-thing)
   '(")" . meow-end-of-thing)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)

   ;; editing
   '("d" . meow-kill)
   '("t" . meow-change)
   '("h" . meow-delete)
   '("p" . meow-save)
   '("f" . meow-yank)
   '("F" . meow-yank-pop)
   '("R" . meow-query-replace-regexp)

   '("o" . meow-insert)
   '("O" . meow-open-above)
   '("u" . meow-append)
   '("U" . meow-open-below)

   '("z" . undo-only)
   '("Z" . undo-redo)

   '("'"  . open-line)
   '("\"" . split-line)

   '("=" . meow-indent)
   '("[" . indent-rigidly-left-to-tab-stop)
   '("]" . indent-rigidly-right-to-tab-stop)

   '("C-0" . delete-window)
   '("C-1" . delete-other-windows)
   '("C-2" . split-window-below)
   '("C-3" . split-window-right)

   ;; ignore
   '("<escape>"    . ignore)
   '("<backspace>" . ignore)
   '("<return>"    . ignore)
   '("<delete>"    . ignore))

  (meow-global-mode 1))

(set-face-attribute 'default           nil :font "Maple Mono NF" :height 150)
(set-face-attribute 'fixed-pitch       nil :font "Maple Mono NF" :height 150 :weight 'bold)
(set-face-attribute 'fixed-pitch-serif nil :font "Maple Mono NF" :height 150 :weight 'bold)
(set-face-attribute 'variable-pitch    nil :font "Maple Mono NF" :height 150)

(use-package haskell-mode)

(use-package lsp-mode
  :hook (haskell-mode . lsp)
  :commands lsp)

(use-package vertico
  :custom (vertico-cycle t)
  :init (vertico-mode))

(use-package marginalia
  :bind (:map minibuffer-local-map
	      ("M-a" . marginalia-cycle))
  :init (marginalia-mode))

(use-package company
  :init (global-company-mode))

(display-time-mode 1)

(use-package mood-line
  :config (mood-line-mode))

(defun set-reading-margins ()
  "Set sane reading margins in current buffer."
  (interactive)
  (setq left-margin-width  20)
  (setq right-margin-width 20))

(use-package nerd-icons)

(use-package ef-themes)

(use-package doom-themes
  :custom
  (doom-themes-enable-bold    t)
  (doom-themes-enable-italics t)

  :custom-face
  (font-lock-keyword-face ((nil (:slant italic))))
  (org-document-title     ((nil (:weight normal :height 1.00))))
  (org-level-1            ((nil (:weight bold   :height 1.20))))
  (org-level-2            ((nil (:weight bold   :height 1.15))))
  (org-level-3            ((nil (:weight bold   :height 1.10))))
  (org-level-4            ((nil (:weight bold   :height 1.05))))
  
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(load-theme 'doom-outrun-electric t)

(use-package solaire-mode
  :config (solaire-global-mode 1))

(use-package beacon
  :config (beacon-mode 1))

(use-package tree-sitter
  :hook (sh-mode . tree-sitter-hl-mode)
  :config (global-tree-sitter-mode 1))

(use-package tree-sitter-langs)

(use-package highlight-defined
  :custom
  (highlight-defined-function-name-face         ((nil (:inherit tree-sitter-hl-face:function))))
  (highlight-defined-builtin-function-name-face ((nil (:inherit tree-sitter-hl-face:function.builtin))))
  (highlight-defined-macro-name-face            ((nil (:inherit tree-sitter-hl-face:function.macro))))
  (highlight-defined-variable-name-face         ((nil (:inherit tree-sitter-hl-face:variable))))
  
  :hook
  (emacs-lisp-mode . highlight-defined-mode)
  (org-mode        . highlight-defined-mode))

(use-package paren-face
  :custom-face (parenthesis ((t (:inherit 'font-lock-comment-face))))
  :config (global-paren-face-mode 1))

(setq initial-major-mode 'org-mode
      initial-scratch-message nil)

(defun load-current-org-file ()
  "Tangle and load the current Org file."
  (interactive)
  (when (eq major-mode 'org-mode)
    (org-babel-load-file (buffer-file-name))))

(dolist (set-org '(("C-c c" . org-edit-src-code)
		   ("C-c i" . load-current-org-file)))
  (define-key org-mode-map (kbd (car set-org)) (cdr set-org)))

(use-package org-superstar
  :custom
  (org-hide-emphasis-markers t)
  (org-superstar-leading-bullet ?\s)
  (org-indent-mode-turns-on-hiding-stars nil)
  (org-superstar-headline-bullets-list '("❀" "❖" "✦" "✧"))
  (org-superstar-prettify-item-bullets t)
  (org-superstar-item-bullet-alist '((?* . ?•)
				     (?+ . ?→)
				     (?- . ?•)))
  :hook org-mode)

(setq org-src-preserve-indentation nil)
(setq org-edit-src-content-indentation 0)

(defun org-mode-load-functions ()
  (set-reading-margins)
  (org-indent-mode))

(add-hook 'org-mode-hook 'org-mode-load-functions)

(require 'org-tempo)
