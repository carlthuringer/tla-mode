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
;; provide syntax highlights.  Rather, the highlights are provided by
;; tree-sitter.

;;; Code:

(defconst tla-mode-hl-patterns
  [
   [
    "ACTION"
    "ASSUME"
    "ASSUMPTION"
    "AXIOM"
    "BY"
    "CASE"
    "CHOOSE"
    "CONSTANT"
    "CONSTANTS"
    "COROLLARY"
    "DEF"
    "DEFINE"
    "DEFS"
    "DOMAIN"
    "ELSE"
    "ENABLED"
    "EXCEPT"
    "EXTENDS"
    "HAVE"
    "HIDE"
    "IF"
    "IN"
    "INSTANCE"
    "LAMBDA"
    "LEMMA"
    "LET"
    "LOCAL"
    "MODULE"
    "NEW"
    "OBVIOUS"
    "OMITTED"
    "ONLY"
    "OTHER"
    "PICK"
    "PROOF"
    "PROPOSITION"
    "PROVE"
    "QED"
    "RECURSIVE"
    "SF_"
    "STATE"
    "SUBSET"
    "SUFFICES"
    "TAKE"
    "TEMPORAL"
    "THEN"
    "THEOREM"
    "UNCHANGED"
    "UNION"
    "USE"
    "VARIABLE"
    "VARIABLES"
    "WF_"
    "WITH"
    "WITNESS"
    (def_eq)
    (set_in)
    (gets)
    (forall)
    (exists)
    (temporal_forall)
    (temporal_exists)
    (all_map_to)
    (maps_to)
    (case_box)
    (case_arrow)
    (address)
    (label_as)
    ] @keyword

   ; Literals
   (nat_number) @number
   (real_number) @number
   (binary_number (format) @keyword)
   (octal_number (format) @keyword)
   (hex_number (format) @keyword)
   (binary_number (value) @number)
   (octal_number (value) @number)
   (hex_number (value) @number)
   (string) @string
   (primitive_value_set) @type

   ; Comments
   (comment) @comment
   (block_comment) @comment
   (single_line) @comment

   ; Constants, variables, and operators
   (variable_declaration (identifier) @variable.builtin)
   (constant_declaration (identifier) @constant)
   (constant_declaration (operator_declaration name: (_) @constant))
   (recursive_declaration (identifier) @operator)
   (recursive_declaration (operator_declaration name: (_) @operator))
   (operator_definition name: (_) @operator)
   (module_definition name: (identifier) @operator)
   (function_definition name: (identifier) @function)
   (bound_prefix_op symbol: (_) @function.builtin)
   (bound_nonfix_op (prefix_op_symbol) @operator)
   (bound_infix_op symbol: (_) @function.builtin)
   (bound_nonfix_op (infix_op_symbol) @operator)
   (bound_postfix_op symbol: (_) @function.builtin)
   (bound_nonfix_op (postfix_op_symbol) @operator)

   ; Parameters
   (operator_definition parameter: (identifier) @variable.parameter)
   (operator_definition (operator_declaration name: (_) @variable.parameter))
   (module_definition parameter: (identifier) @variable.parameter)
   (module_definition (operator_declaration name: (_) @variable.parameter))
   (function_definition (quantifier_bound (identifier) @variable.parameter))
   (function_definition (quantifier_bound (tuple_of_identifiers (identifier) @variable.parameter)))
   (lambda (identifier) @variable.parameter)

   ; Delimiters
   [
    (langle_bracket)
    (rangle_bracket)
    (rangle_bracket_sub)
    "{"
    "}"
    "["
    "]"
    "]_"
    "("
    ")"
    ] @punctuation.bracket
   [
    ","
    ":"
    "."
    "!"
    (bullet_conj)
    (bullet_disj)
    ] @punctuation.delimiter

   ; Proofs
   (proof_step_id "<" @punctuation.bracket)
   (proof_step_id (level) @number)
   (proof_step_id (name) @constant)
   (proof_step_id ">" @punctuation.bracket)
   (proof_step_ref "<" @punctuation.bracket)
   (proof_step_ref (level) @number)
   (proof_step_ref (name) @constant)
   (proof_step_ref ">" @punctuation.bracket)

   ; Reference-based identifier highlighting
   (identifier_ref) @variable.reference
   ])

;;;###autoload
(define-derived-mode tla-mode prog-mode "TLA"
  "TLA mode is a major mode for editing TLA+ specifications."
  (setq font-lock-defaults `(nil))
  (setq-local tree-sitter-hl-default-patterns tla-mode-hl-patterns))

;;;###autoload
(add-to-list 'auto-mode-alist
             '("\\.tla\\'" . tla-mode))

(provide 'tla-mode)

;;; tla-mode.el ends here
