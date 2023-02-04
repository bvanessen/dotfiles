;; Define a function that will allow you to pre- or post- pend variables
;; to your load path

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defun prepend-path ( my-path )
  (setq load-path (cons (expand-file-name my-path) load-path)))  
(defun append-path ( my-path )
  (setq load-path (append load-path (list (expand-file-name my-path)))))
;; Look first in the directory ~/elisp for elisp files
(prepend-path "~/elisp")

;; Load verilog mode only when needed
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;; Any files that end in .v should be in verilog mode
(setq auto-mode-alist (cons  '("\\.v\\'" . verilog-mode) auto-mode-alist))
;; VeriNice Support - Any file that ends in .rv should be in verilog mode
(setq auto-mode-alist (cons  '("\\.rv\\'" . verilog-mode) auto-mode-alist))
;; Sue behavioral verilog Support - Any file that ends in .vb should be in verilog mode
(setq auto-mode-alist (cons  '("\\.vb\\'" . verilog-mode) auto-mode-alist))
;; Sue netlisting verilog Support - Any file that ends in .vh should be in verilog mode
(setq auto-mode-alist (cons  '("\\.vh\\'" . verilog-mode) auto-mode-alist))
;; Any files in verilog mode should have their keywords colorized
(add-hook 'verilog-mode-hook '(lambda () (font-lock-mode 1)))

;; Load TCL mode only when needed
;;(autoload 'verilog-mode "tcl-mode" "TCL mode" t )
;; Any files that end in .sue should be in TCL mode
;;(setq auto-mode-alist (cons  '("\\.sue\\'" . tcl-mode) auto-mode-alist))


;; Load specman mode only when needed
;; (autoload 'specman-mode "specman-mode" "Specman mode" t )
;; Any files that end in .e, .e3, et cetera should be in specman mode
;; (setq auto-mode-alist 
;;       (append (list 
;; 	       (cons "\\.e\\'" 'specman-mode)
;;	       (cons "\\.e3\\'" 'specman-mode)
;;	       (cons "\\.load\\'" 'specman-mode)
;;	       (cons "\\.ecom\\'" 'specman-mode)
;;	       (cons "\\.etst\\'" 'specman-mode))
;;	      auto-mode-alist))
;; Any files in specman mode should have their keywords colorized
;; (add-hook 'specman-mode-hook '(lambda () (font-lock-mode 1)))

;; Set up cc-mode
;;(setq load-path (cons "/Users/vanessen/elisp/cc-mode-5.28" load-path))
;;(require 'cc-mode)

;;(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
;;(autoload 'c-mode    "cc-mode" "C Editing Mode" t)
;;(autoload 'objc-mode "cc-mode" "Objective-C Editing Mode" t)
;;(autoload 'java-mode "cc-mode" "Java Editing Mode" t)

;; Example of how to setup a random file extension to pick a mode
;;(setq auto-mode-alist
;;  (append
;;    '(("\\.dna$"    . c++-mode)
;;      ("\\.skn$"    . c++-mode)
;;      ("\\.bdl$"    . c++-mode)
;;      ("\\.gen$"    . c++-mode)
;;      ("\\.h$"      . c++-mode)
;;     ) auto-mode-alist))

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; Enable wheelmouse support by default
(cond
;    ((string-match "GNU Emacs 21.3.1" (emacs-version))
;    (mwheel-install) ; Emacs
;		 ) ; matched GNU
    ((string-match "XEmacs" (emacs-version))
     (mwheel-install) ; XEmacs
		 ) ; matched XEmacs
)

;;
;; Brian's Stuff
;;
;;(setq-default tab-width 2)
(setq-default tab-width 8)
;;(setq-default tab-width 4)
(global-set-key "\C-cg" 'goto-line)

;; don't use tab character, use spaces
(setq-default indent-tabs-mode nil)
(setq tab-stop-list '(4 8 12 16))

(setq-default sml-indent-level 2)

;; Define a function to convert dos buffers to unix
(defun dos-to-unix ()
 "Convert a DOS buffer to Unix format."
 (interactive)
 (beginning-of-buffer)
 (replace-string "\r\n" "\n"))

;; Turn on Auto Fill mode automatically in Text mode and related modes
(add-hook 'text-mode-hook
  '(lambda () (auto-fill-mode 1)))

;; Set extension for Bluespec files to load Haskell mode
(setq auto-mode-alist
  (append
    '(("\\.bs$"    . haskell-mode)
     ) auto-mode-alist))

;; Load id-utils hooks (Use C-x ` to execute next-error command)
(autoload 'gid "id-utils" "Interface to ID Utils" t)

;; Cecil and Diesel modes from UW WASP group
;; (setq load-path (cons (expand-file-name "~/elisp") load-path))
;;(autoload 'cecil-mode "cecil-mode" "Cecil mode" t)
;;(autoload 'diesel-mode "diesel-mode" "Diesel mode" t)
;;(setq auto-mode-alist (cons '("\\.cecil$" . cecil-mode) auto-mode-alist))
;;(setq auto-mode-alist (cons '("\\.diesel$" . diesel-mode) auto-mode-alist))

;; Set up cscope
;;(setq load-path (cons "/Users/vanessen/elisp/xcscope" load-path))
;;(require 'xcscope)

;; Aquamacs customizations
;; Taken from http://www.emacswiki.org/cgi-bin/wiki/CustomizeAquamacs
;; Sets the command key as Meta
;; (setq mac-command-modifier 'meta)
;; Use the alt key in addition to esc as the meta key
(setq mac-option-modifier 'meta)
;; Ensure that emacs gets the alt key and produces a meta
(setq mac-pass-option-to-system nil)

;; Define the font-lock-keywords variable to avoid a possible bug in Aquamacs
;; 0.9.5b
;; This variable is already defined in XEmacs land
(setq font-lock-keywords nil)

;; Setup Macah files to use c syntax highlighting
(setq auto-mode-alist (append '(("\\.macah$"    . c-mode)) auto-mode-alist))

;; Setup Flyspell to auto load as a minor mode for tex editing
;;(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;; (setq flyspell-doublon-as-error-flag nil)

;; Set extension for CUDA files to load C mode
(setq auto-mode-alist
  (append
    '(("\\.cu$"    . c-mode)
     ) auto-mode-alist))
