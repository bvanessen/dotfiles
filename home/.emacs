;; Customizing Emacs and XEmacs initialization
;; Setup for XEmacs backwards compatibility file
;; ____________________________________________________________________________
;; Aquamacs custom-file warning:
;; Warning: After loading this .emacs file, Aquamacs will also load
;; customizations from `custom-file' (customizations.el). Any settings there
;; will override those made here.
;; Consider moving your startup settings to the Preferences.el file, which
;; is loaded after `custom-file':
;; ~/Library/Preferences/Aquamacs Emacs/Preferences
;; _____________________________________________________________________________
(message "Testing testing")
(setq user-init-file
      (expand-file-name "init.el"
			(expand-file-name ".xemacs" "~")))
;;(setq custom-file
;;      (expand-file-name "custom.el"
;;			(expand-file-name ".xemacs" "~")))

(load-file user-init-file)

;; BVE Add support for markdown
(add-to-list 'load-path "/Users/vanessen1/Research/tools/markdown-mode.git")
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; Setup for emacs to load specific custom.el files
(cond
    ((string-match "GNU" (emacs-version))
		 (cond
;; Aquamacs
			((string-match "Aquamacs" (emacs-version))
			 (message "loading GNU Emacs customizations for Aquamacs Emacs")
			 (setq custom-file
						 (expand-file-name "custom-aquamacs.el"
						 (expand-file-name ".xemacs" "~")))
			 )
;; Default version in OS X 10.4.1
			((string-match "21.2.1" (emacs-version))
			 (message "loading GNU Emacs customizations for OS X Emacs")
			 (setq custom-file
						 (expand-file-name "custom-osx-emacs.el"
						 (expand-file-name ".xemacs" "~")))
			 )
;; Generic Emacs
			((string-match "Emacs" (emacs-version))
			 (message "loading GNU Emacs customizations for standard Emacs")
			 (setq custom-file
						 (expand-file-name "custom-emacs.el"
						 (expand-file-name ".xemacs" "~")))
			 )

			)
		 ) ; matched GNU
;; Xemacs
    ((string-match "XEmacs" (emacs-version))
		 (message "loading XEmacs customizations common for XEmacs")
		 (setq custom-file
					 (expand-file-name "custom.el"
					 (expand-file-name ".xemacs" "~")))
		 ) ; matched XEmacs
		)
(load-file custom-file)

(add-hook 'c-mode-hook
          (lambda () (add-to-list
                      'write-file-functions
                      'delete-trailing-whitespace)))
(add-hook 'c++-mode-hook
          (lambda () (add-to-list
                      'write-file-functions
                      'delete-trailing-whitespace)))
(add-hook 'python-mode-hook
          (lambda () (add-to-list
                      'write-file-functions
                      'delete-trailing-whitespace)))


(defadvice insert-register (after insert-register-move-point-to-end activate)
  "After insertion, move point to end of inserted text."
  (goto-char (region-end)))

(defun revert-all-buffers ()
  "Refresh all open buffers from their respective files."
  (interactive)
  (let* ((list (buffer-list))
         (buffer (car list)))
    (while buffer
      (let ((filename (buffer-file-name buffer)))
        ;; Revert only buffers containing files, which are not modified;
        ;; do not try to revert non-file buffers like *Messages*.
        (when filename
          (if (file-exists-p filename)
              ;; If the file exists, revert the buffer.
              (with-demoted-errors "Error: %S"
                (with-current-buffer buffer
                  (revert-buffer :ignore-auto :noconfirm)))
            ;; If the file doesn't exist, kill the buffer.
            (let (kill-buffer-query-functions) ; No query done when killing buffer
              (kill-buffer buffer)
              (message "Killed non-existing file buffer: %s" buffer))))
        (setq buffer (pop list)))))
  (message "Finished reverting non-file buffers."))

(defun er-go-to-column (column)
  (interactive "nColumn: ")
  (move-to-column column t))

(global-set-key (kbd "M-g M-c") #'er-go-to-column)

;; Switch to previous window
(global-set-key (kbd "C-x O") (lambda ()
                                (interactive)
                                (other-window -1)))

;; Enable walking through windows
(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c n") 'windmove-down)

;; Applying a macro across multiple files
;; Open ibuffer (M-x ibuffer)
;; Mark buffers as in dired mode (hit m on the appropriate line)
;; Hit W.
;; Type form, e.g. (kmacro-end-or-call-macro 1)
;; Hit RET.
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Inspired by M-x edit-kbd-macro and https://superuser.com/q/176627.
(defun my-dired-do-execute (keys &optional arg)
  "Execute a command in all marked files.
If an error occurs, execution in other files is not affected.
(Notably, this allows to run keyboard macros until there is an error.)

At the prompt, type any bound key sequence, or `\\[execute-extended-command]'
to choose a command by its name, or `\\[eval-expression]' to enter a Lisp expression.

The prefix ARG, if given, is passed on to the chosen command.
"
  (interactive
   (list (read-key-sequence (substitute-command-keys "Key sequence to execute, \
or \\[eval-expression], or \\[execute-extended-command]: "))
         current-prefix-arg))
  (when keys
    (let ((cmd (if (arrayp keys) (key-binding keys) keys))
          exp)
      (cond ((eq cmd 'execute-extended-command)
             (setq cmd (read-command "Name of command to execute: "))
             (if (string-equal cmd "")
                 (error "No command name given")))
            ((eq cmd 'eval-expression)
             (setq exp (read--expression "Eval in selected files: "))
             (setq cmd nil))
            ((null cmd)
             (error "Key sequence %s is not defined" (key-description keys))))
      (mapc (lambda (filename)
              (save-selected-window
                (find-file-other-window filename)
                (setq current-prefix-arg arg)
                (condition-case-unless-debug err
                    (if cmd
                        (call-interactively cmd)
                      (message "Result in file %s:" filename)
                      (eval-expression exp))
                  (error (message "In file %s: %S" filename err)))))
            (dired-get-marked-files)))))

(require 'package)

;; (when (or (string-match "^lassen" (system-name))
;;           (string-match "^ray" (system-name)))
;;   (setq package-user-dir "~/.emacs.d/packages-power"))

;; (unless (or (string-match "^lassen" (system-name))
;;       (string-match "^ray" (system-name)))
;;   (setq package-user-dir "~/.emacs.d/packages-x86_64"))

;;(package-initialize) ;; done in setup-packages.el

(when (>= emacs-major-version 26)
  ;; Setup Emacs as proper IDE with LSP
  (unless (or (string-match "^lassen" (system-name))
        (string-match "^ray" (system-name)))
    (add-to-list 'load-path "~/.emacs.d/config")
    (load "setup-all-things-lsp.el"))
   )
