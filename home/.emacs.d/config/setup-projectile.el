;; Projectile -- project-level views of projects.
(use-package projectile
  :ensure t
  :hook ((prog-mode . projectile-mode))
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)
              ("C-c p" . 'projectile-command-map)))
