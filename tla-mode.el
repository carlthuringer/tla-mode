;;; tla-mode.el --- Major mode for editing TLA+ files.
;;; Commentary:
;; A major mode used for editing TLA+ files.  It does not implement
;; syntax highlighting, as that is better provided by tree-sitter.

;; This module is derived from the work of trailblazers,
;; https://github.com/ratish-punnoose/tla-mode. Thank you for your
;; efforts.

;; The module attempts to implement a simpler major mode that does not
;; provide syntax highlights. Rather, the highlights are provided by
;; tree-sitter.

;;; Code:

;;;###autoload
(define-derived-mode tla-mode prog-mode "TLA"
  "TLA mode is a major mode for editing TLA+ specifications."
  (setq font-lock-defaults `(()))
  )

;;;###autoload
(add-to-list 'auto-mode-alist
             '("\\.tla\\'" . tla-mode))

(provide 'tla-mode)

;;; tla-mode.el ends here
