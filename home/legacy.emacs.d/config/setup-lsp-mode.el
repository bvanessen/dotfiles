;;; setup-lsp-mode -- Basic configuration for lsp-mode for IDE-like behavior

(use-package lsp-mode
  :ensure t
  :init
  ;;(setq lsp-keymap-prefix "s-l")
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-clients-clangd-args '("-j=4" "-background-index" "-log=error"))
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'lsp-ivy-workspace-symbol)
  :hook ((python-mode . lsp)
         (c++-mode . lsp)
         (c-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
(use-package lsp-ivy
  :ensure t
  :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs
  :ensure t
  :commands lsp-treemacs-errors-list)
