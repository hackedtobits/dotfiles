;;; init.el --- Benjamin Shayne's Emacs init file

;; Set my email address
(setq
 user-mail-address "shayne@hackedtobits.com"
 user-full-name "Benjamin Shayne")

;; Backup files in one place.
(setq
 backup-directory-alist
 '(("." . "~/.emacs.d/backups/"))
 auto-save-file-name-transforms
 `(("." ,temporary-file-directory t))   ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)                     ; use versioned backups

;; Package Management
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; Keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
;; update the package metadata is the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

;; Visual (and other ) Tweaks
(setq-default
 inhibit-startup-screen t               ; Skip the startup screens
 initial-scratch-message nil
 blink-cursor-alist '((t . hollow))   ; Cursor blinks solid and hollow
 frame-title-format '(buffer-file-name "%f" "%b") ; I know it's Emacs show something useful
 show-paren-style 'expression        ; Highlight parenthesis
 show-trailing-whitespace t          ; Show trailing whitespace
 column-number-mode t                ; Display line and column numbers
 line-number-mode t
 tab-width 4                            ; Set tab stops
 indent-tabs-mode nil                   ; Use spaces only, no tabs
 tab-always-indent 'complete
 initial-major-mode 'text-mode          ; Text mode, not Elisp
 comment-column 55
 comment-fill-column 70
 mode-line-format '(" %+ "             ; Simplify the mode line
                    (:propertize "%b" face mode-line-buffer-id)
                    ":%l:%c %[" mode-name "%]"
                    (-2 "%n")
                    (visual-line-mode " W")
                    (auto-fill-function " F")
                    (overwrite-mode " O"))
 ispell-program-name "aspell")          ; Use aspell to spell check

;; Small hints when using TAB for completion
(custom-set-variables
 '(icomplete-mode t))

;; Using single space after dots to define the end of sentences
(setq sentence-end-double-space nil)

;; save cursor position between sessions
(require 'saveplace)
(setq-default save-place t)

;; make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)
