;; extends

; change priorities of highlights
(
  (command_name) @function @nospell
  (#set! "priority" 110)
)
(
  [
    "["
    "]"
    "{"
    "}"
  ] @punctuation.bracket ; "(" ")" has no syntactical meaning in LaTeX
  (#set! "priority" 110)
)

(generic_command
  (command_name) @keyword.conditional
  (#lua-match? @keyword.conditional "^\\if[a-zA-Z@]+$")
  (#set! "priority" 120))

(generic_command
  (command_name) @keyword.conditional
  (#any-of? @keyword.conditional "\\fi" "\\else")
  (#set! "priority" 120))

; NOTE: default nvim-treesitter file doesn't support packages
((generic_command
  command: (command_name) @_name
  arg: (curly_group
    (_) @markup.strong))
  (#any-of? @_name "\\bm"))


; default math zones
[
  (displayed_equation)
  (inline_formula)
] @zone.math

(math_environment
  (begin) @zone.text
  (end) @zone.text) @zone.math

; default text zones
[
  (text_mode)
  (label_definition)
  (label_reference)
  ; treat \begin{...} and \end{...} as text zone, otherwise
  ; for example \begin{equation} would be treated as math zone
  ; (begin)
  ; (end)
] @zone.text

; default comment zones, disable spellchecking
[
  (line_comment)
  (block_comment)
  (comment_environment)
] @zone.comment @nospell


; `\SI{}{}` command from `siunitx` package (and others)
; highlight as math and disable spellchecking, but treat as text zone
(generic_command
  command: (command_name) @_name
  arg: (curly_group
        (_) @markup.math @nospell)
  (#any-of? @_name "\\SI" "\\si" "\\qq")) @zone.text

(generic_command
  command: (command_name) @_name
  arg: (curly_group
        (_) @none @nospell)
  (#any-of? @_name "\\tag" "\\parbox" "\\tikz")) @zone.text

(generic_command
  command: (command_name) @_name
  arg: (curly_group
        (_) @markup.math @nospell)
  (#any-of? @_name "\\ensuremath")) @zone.math
