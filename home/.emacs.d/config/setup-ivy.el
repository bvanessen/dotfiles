;;; setup-ivy -- Basic configuration for Ivy and related packages

(use-package ivy
  :ensure t
  :config
  (ivy-mode t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-use-virtual-buffers t)
  (setq ivy-wrap t)
  (setq enable-recursive-minibuffers t)
  :bind (("C-c C-r" . 'ivy-resume)))

(use-package swiper
  :ensure t
  :after (ivy)
  :bind (("C-s" . swiper)
         ("C-r" . swiper)))

(use-package counsel
  :ensure t
  :after (ivy)
  :config
  (defun find-similar-files-in-repo ()
    "This just gives counsel-git a hint at files I want to see."
    (interactive)
    (counsel-git (when buffer-file-name
                   (file-name-base buffer-file-name))))
  ;; These bindings are mostly recommendations from the author of
  ;; Ivy/Swiper/Counsel; I've made a few changes for me.
  :bind (;; Rebind a few of the common Emacs commands.
         ("M-x" . 'counsel-M-x)
         ("C-x C-f" . 'counsel-find-file)
         ;; Requires "ag" from https://github.com/ggreer/the_silver_searcher.git
         ("C-c k" . 'counsel-ag)
         ;; This can be rather slow; relies on "locate" command. If
         ;; the database is rebuilt, e.g., results can lag a bit.
         ;; ("C-c l" . 'counsel-locate)
         ;; These will do nothing if you're not in a git repo.
         ("C-c f" . 'find-similar-files-in-repo)
         ("C-c g" . 'counsel-git-grep)
         ("C-c j" . 'counsel-git)
         ;; Less useful in the day-to-day, but I don't have a reason
         ;; to remove these bindings.
         ("<f1> f" . 'counsel-describe-function)
         ("<f1> v" . 'counsel-describe-variable)
         ("<f1> l" . 'counsel-find-library)
         ("<f2> i" . 'counsel-info-lookup-symbol)
         ("<f2> u" . 'counsel-unicode-char)
         ;; Local keymap bindings.
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-add)))
