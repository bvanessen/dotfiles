;; Company -- "Complete anything" autocompletion.
(use-package company
  :ensure t
  :bind (:map company-active-map
         ("C-n" . company-select-next)
         ("C-p" . company-select-previous))
  :config
  ;; Zero delay when pressing tab
  (setq company-idle-delay 0.3)
  :hook ((lsp-mode . company-mode))
  ;; Appy company to every mode
  ;;(global-company-mode)
  )



;; Remove unused backends
;;
;; IDK if these matter any more; I observe no difference having
;; commented them out. But it also costs me nothing to leave them here
;; just in case.

;; (setq company-backends (delete 'company-semantic company-backends))
;; (setq company-backends (delete 'company-eclim company-backends))
;; (setq company-backends (delete 'company-xcode company-backends))
;; (setq company-backends (delete 'company-clang company-backends))
;; (setq company-backends (delete 'company-bbdb company-backends))
;; (setq company-backends (delete 'company-oddmuse company-backends))
