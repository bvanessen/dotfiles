;; yasnippet -- quickly insert snippets and templates
(use-package yasnippet
  :ensure t
  :hook ((lsp-mode . yas-minor-mode))
  :config (yas-reload-all))
(use-package yasnippet-snippets
  :ensure t)
