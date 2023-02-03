;; Flycheck -- On-the-fly error checking.
;;
;; For C++, this reports compiler warnings. It will do various
;; semantic and syntax checking for other languages, too. If you don't
;; turn it off in various modes, it will annoy you to no end about
;; whatever 'documentation' is. Apparently it's something that's never
;; quite good enough, even if you do have it in there.

(use-package flycheck
  :ensure t
  :init
  (defun tom-set-cxx17 ()
    (setq flycheck-clang-language-standard "c++17")
    (setq flycheck-gcc-language-standard "c++17"))
  :hook ((prog-mode . flycheck-mode)
         (c-common-mode . tom-set-cxx17))
  :config
  ;; Turn off for certain things.
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (when (not (display-graphic-p))
    (setq flycheck-indication-mode nil)))

;; There are issues with company mode and flycheck in terminal mode.
;; This is outlined at:
;; https://github.com/abingham/emacs-ycmd
