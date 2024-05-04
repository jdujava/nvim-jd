;; extends

; default math zones
[
  (displayed_equation)
  (inline_formula)
] @zone.math

(math_environment
  (begin) @zone.text
  (end) @zone.text) @zone.math @nospell

; extra math environments
(generic_environment
  (begin
    name: (curly_group_text
      (text) @_name)) @zone.text
  (end) @zone.text
  (#any-of? @_name "aligned")) @zone.math @nospell

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
  (#any-of? @_name "\\SI" "\\si")) @zone.text

(generic_command
  command: (command_name) @_name
  arg: (curly_group
        (_) @none @nospell)
  (#any-of? @_name "\\tag")) @zone.text
