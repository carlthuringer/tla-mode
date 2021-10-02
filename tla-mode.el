;;; tla-mode.el --- Major mode for editing TLA+ files.

;; Copyright (c) 2021 Carl Thuringer
;;
;; Author: Carl Thuringer <carl@thuringer.us>
;; Keywords: languages tla
;; Homepage: https://github.com/carlthuringer/tla-mode
;; Version: 0.1.0
;; Package-Requires: ((tree-sitter "0.15.2") (tree-sitter-langs "0.10.7"))
;; SPDX-License-Identifier: GPL-3.0-or-later


;;; Commentary:
;; A major mode used for editing TLA+ files.  It does not implement
;; syntax highlighting, as that is better provided by tree-sitter.

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
