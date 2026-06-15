;;; mlua-mode.el --- Major mode for mLua  -*- lexical-binding: t; -*-

;; Copyright (C) 2026  Shen, Jen-Chieh

;; Author: Shen, Jen-Chieh <jcs090218@gmail.com>
;; Maintainer: Shen, Jen-Chieh <jcs090218@gmail.com>
;; URL: https://github.com/MSW-cmty/mlua-mode
;; Version: 0.1.0
;; Package-Requires: ((emacs "26.1") (lua-mode ))
;; Keywords: languages

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Major mode for mLua.
;;

;;; Code:

(defvar mlua-mode-hook nil)

(defconst mlua-keywords
  '("break" "continue" "do" "else" "elseif" "end"
    "for" "function" "goto" "if" "in"
    "local" "not" "or" "repeat" "return"
    "then" "until" "while"

    ;; mLua additions
    "script" "method" "property" "member"
    "extends" "override" "handler"
    "constructor" "operator" "emitter"
    "static" "readonly"))

(defconst mlua-constants
  '("true" "false" "nil" "_G"))

(defconst mlua-font-lock-keywords
  `(
    ;; Keywords
    (,(regexp-opt mlua-keywords 'symbols)
     . font-lock-keyword-face)

    ;; Constants
    (,(regexp-opt mlua-constants 'symbols)
     . font-lock-constant-face)

    ;; script Foo
    ("\\_<script\\_>\\s-+\\([A-Za-z0-9_]+\\(?:<[^>]+>\\)?\\)"
     1 font-lock-type-face)

    ;; extends Base
    ("\\_<extends\\_>\\s-+\\([A-Za-z0-9_]+\\(?:<[^>]+>\\)?\\)"
     1 font-lock-type-face)

    ;; property Type name
    ("\\_<property\\_>\\s-+\\([A-Za-z0-9_<>]+\\)\\s-+\\([A-Za-z0-9_]+\\)"
     (1 font-lock-type-face)
     (2 font-lock-variable-name-face))

    ;; member foo
    ("\\_<member\\_>\\s-+\\([A-Za-z0-9_]+\\)"
     1 font-lock-variable-name-face)

    ;; function names
    ("\\_<function\\_>\\s-+\\([A-Za-z0-9_:.]+\\)"
     1 font-lock-function-name-face)

    ;; method declarations
    ("\\_<method\\_>\\s-+.*?\\([A-Za-z0-9_]+\\)\\s-*("
     1 font-lock-function-name-face)

    ;; operator declarations
    ("\\_<operator\\_>\\s-+.*?\\([A-Za-z0-9_]+\\)\\s-*("
     1 font-lock-function-name-face)

    ;; handler declarations
    ("\\_<handler\\_>\\s-+\\([A-Za-z0-9_]+\\)"
     1 font-lock-function-name-face)

    ;; constructor declarations
    ("\\_<constructor\\_>\\s-+\\([A-Za-z0-9_]+\\)"
     1 font-lock-function-name-face)

    ;; emitter declarations
    ("\\_<emitter\\_>\\s-+\\([A-Za-z0-9_]+\\)"
     1 font-lock-function-name-face)

    ;; @attributes
    ("@[A-Za-z_][A-Za-z0-9_]*"
     . font-lock-preprocessor-face)

    ;; --- @param foo
    ("---@\\([A-Za-z_][A-Za-z0-9_]*\\)"
     1 font-lock-builtin-face)

    ;; parameter names in annotations
    ("---@param\\s-+\\([A-Za-z_][A-Za-z0-9_]*\\)"
     1 font-lock-variable-name-face)

    ;; type names in annotations
    ("---@\\(?:param\\|return\\|type\\)\\s-+.*?\\([A-Za-z_][A-Za-z0-9_<>.*]*\\)"
     1 font-lock-type-face)

    ;; labels ::foo::
    ("::\\([A-Za-z_][A-Za-z0-9_]*\\)::"
     1 font-lock-constant-face)

    ;; goto foo
    ("\\_<goto\\_>\\s-+\\([A-Za-z_][A-Za-z0-9_]*\\)"
     1 font-lock-constant-face)
    ))

;;;###autoload
(define-derived-mode mlua-mode lua-mode "mLua"
  "Major mode for mLua."
  (font-lock-add-keywords nil mlua-font-lock-keywords))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.mlua\\'" . mlua-mode))

(provide 'mlua-mode)
;;; mlua-mode.el ends here
