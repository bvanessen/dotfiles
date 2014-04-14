; No info screen at startup.
(setq inhibit-startup-message t)

; Where I keep all my elisp files
(add-to-list 'load-path (expand-file-name "~/.elisp/"))

(setq require-final-newline t)
(setq inhibit-default-init t)            ; disable running annoying default fc init.
(setq default-tab-width 4)               ; 2-wide tabs
(global-set-key [?\M-g] 'goto-line)      ; use M-g as shortcut for goto-line
(global-set-key [?\M-p] 'fill-paragraph) ; use M-p for paragraph fill.
(column-number-mode t)                   ; number columns
(setq-default indent-tabs-mode nil)      ; use spaces instead of tabs
(put 'upcase-region 'disabled nil)       ; enable upcase-region

(toggle-uniquify-buffer-names)

; Comment regions or lines with M-#
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))
(global-set-key [?\M-#] 'comment-or-uncomment-region-or-line)

; strip trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; No prompt on edit version-controlled files through symlinks
(setq vc-follow-symlinks t)

;; ==== Color Setup ==========================================================
(set-background-color "black")
(set-foreground-color "white")
;(set-background-color "white")
;(set-foreground-color "black")

(set-face-background 'region "Navy")    ; navy background for selection
(transient-mark-mode 1)                 ; Show selections with

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

; fix emacs 22.1.1 not coloring comments
(set-face-foreground 'font-lock-comment-face "red")
; (set-face-foreground 'font-lock-comment-delimiter-face "red")


;; ==== Making scripts executable ============================================
;; Automatically make scripts executable if they have shebant (#!) in them
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; Automatically set the mode when you save a file that's in fundamental mode
;; This will automatically set a new file to the right mode if you added #! to it.
(defun auto-mode ()
  (when (eq (buffer-local-value 'major-mode (current-buffer)) 'fundamental-mode)
    (normal-mode)))
(add-hook 'after-save-hook 'auto-mode)


;; ==== Modes and suffixes ===================================================
(autoload 'css-mode "css-mode")
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(setq cssm-indent-function #'cssm-c-style-indenter)

(autoload 'cmake-mode "cmake-mode")
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'"         . cmake-mode))

(autoload 'yorick-mode "yorick")
(add-to-list 'auto-mode-alist '("\\.i\\'"    . yorick-mode))
(add-to-list 'auto-mode-alist '("\\.i.in\\'" . yorick-mode))

(autoload 'matlab-mode "matlab")
(add-to-list 'auto-mode-alist '("\\.m\\'" . matlab-mode))

(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode)) ; CUDA

(autoload 'gitconfig-mode "gitconfig-mode")
(add-to-list 'auto-mode-alist '("\\.gitconfig\\'" . gitconfig-mode))

(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby1.8" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby1.9" . ruby-mode))

(add-to-list 'interpreter-mode-alist '("python2.3" . python-mode))
(add-to-list 'interpreter-mode-alist '("python2.4" . python-mode))
(add-to-list 'interpreter-mode-alist '("python2.5" . python-mode))
(add-to-list 'interpreter-mode-alist '("python2.6" . python-mode))
(add-to-list 'interpreter-mode-alist '("python2.7" . python-mode))
(add-to-list 'completion-ignored-extensions ".pyc")

; view headers and c files in c++ mode
(autoload 'cpp-font-lock "cpp-font-lock")
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.I\\'" . c++-mode))

; Yacc and Lex in C mode
(add-to-list 'auto-mode-alist '("\\.y\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.l\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.yy\\'" . c-mode))
(add-to-list 'auto-mode-alist '("\\.ll\\'" . c-mode))

; Recognize Makefiles by prefix.
(add-to-list 'auto-mode-alist '("/[iI]?[mM]akefile[^/]*\\'" . makefile-mode))
(add-to-list 'auto-mode-alist '("^[Mm]ake\\..*\\'" . makefile-mode))

; R files trigger R mode
(autoload 'r-mode "~/.elisp/ess-12.09-1/lisp/ess-site")
(add-to-list 'auto-mode-alist '("\\.R\\'" . r-mode))

; Prefer Fortran 90 mode over Fortran mode
(add-to-list 'auto-mode-alist '("\\.f\\'" . f90-mode))


;; ==== Org Mode Setup =======================================================
;; (add-hook 'before-save-hook 'org-update-all-dblocks)

;; ==== C Mode Setup =========================================================
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "linux")))

(setq c-backslash-column 96)
(setq c-backslash-max-column 120)

(require 'c-header-switch)

;; c hook -- sets tabs
(defun my-c-mode-common-hook ()
  (setq-default standard-indent 2)
  (setq tab-width 2)
  (setq c-basic-offset 2)
  (set-fill-column 78)
  (c-set-offset 'innamespace 0))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; ==== Regex builder setup ===================================================
(defun reb-query-replace-this-regxp (replace)
  "Uses the regexp built with re-builder to query the target buffer.
   This function must be run from within the re-builder buffer, not the target
   buffer.

   Argument REPLACE String used to replace the matched strings in the buffer.
   Subexpression references can be used (\1, \2, etc)."
  (interactive "sReplace with: ")
  (if (eq major-mode 'reb-mode)
      (let ((reg (reb-read-regexp)))
        (select-window reb-target-window)
        (save-excursion
          (beginning-of-buffer)
          (query-replace-regexp reg replace)))
    (message "Not in a re-builder buffer!")))

(defun my-reb-hook ()
  (define-key reb-mode-map "\C-c\M-%" 'reb-query-replace-this-regxp)
  (setq reb-re-syntax 'string))
(add-hook 'reb-mode-hook 'my-reb-hook)


;; ==== Set terminal title ====================================================
(require 'xterm-frobs)
(defun my-set-xterm-title ()
  (xterm-set-window-title
   (concat (getenv "HOSTNAME") "- emacs - " (buffer-name))))

(let ((term (getenv "TERM")))
  (when (and (not window-system)
             (or (string= term "xterm")
                 (string= term "xterm-color")
                 (string= term "rxvt")))
    (require 'xterm-frobs)
    (add-hook 'window-configuration-change-hook 'my-set-xterm-title)
    (add-hook 'emacs-startup-hook 'my-set-xterm-title)))

;; ==== Variables customized from within emacs ================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rst-level-1 ((t nil)))
 '(rst-level-2 ((t nil)))
 '(rst-level-3 ((t nil)))
 '(rst-level-4 ((t nil)))
 '(rst-level-5 ((t nil)))
 '(rst-level-6 ((t nil))))
