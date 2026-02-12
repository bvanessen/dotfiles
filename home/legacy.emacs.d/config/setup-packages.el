;; Ensure all packages are available and explicitly install them if
;; not.

;; Get the package manager setup (requires emacs >= 24, but we should
;; have that.
(require 'package)

;; Install into a different location for lassen/ray since some emacs
;; code gets compiled here.
(when (or (string-match "^lassen" (system-name))
          (string-match "^ray" (system-name)))
  (setq package-user-dir "~/.emacs.d/packages-lassen"))

;; Add MELPA library
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)
(package-initialize)

;; This is the list of packages that we need.
(setq packages-we-need
      '(company
        counsel
        dap-mode
        flycheck
        ivy
        ivy-yasnippet
        lsp-ivy
        lsp-mode
        lsp-treemacs
;;        magit
        projectile
;;        swiper
        use-package
        which-key
        yasnippet
        yasnippet-snippets))

;; Loop through and install the packages
(when (cl-find-if-not #'package-installed-p packages-we-need)
  (package-refresh-contents)
  (mapc #'package-install packages-we-need))
