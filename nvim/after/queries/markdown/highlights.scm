;; extends

(atx_h1_marker) @text.title.hh1
((atx_h1_marker) heading_content: (_) @text.title.h1)

(atx_h2_marker) @text.title.hh2
((atx_h2_marker) heading_content: (_) @text.title.h2)

(atx_h3_marker) @text.title.hh3
((atx_h3_marker) heading_content: (_) @text.title.h3)

(atx_h4_marker) @text.title.hh4
((atx_h4_marker) heading_content: (_) @text.title.h4)

(atx_h5_marker) @text.title.hh5
((atx_h5_marker) heading_content: (_) @text.title.h5)

(atx_h6_marker) @text.title.hh6
((atx_h6_marker) heading_content: (_) @text.title.h6)


[
  (link_title)
  (indented_code_block)
  (fenced_code_block)
] @text.literal

(pipe_table_header (pipe_table_cell) @text.title)

; (pipe_table_header "|" @punctuation.special)
; (pipe_table_row "|" @punctuation.special)
; (pipe_table_delimiter_row "|" @punctuation.special)
; (pipe_table_delimiter_cell) @punctuation.special

; Use box drawing characters for tables
(pipe_table_header ("|") @punctuation.special @conceal (#set! conceal "┃"))
(pipe_table_delimiter_row ("|") @punctuation.special @conceal (#set! conceal "┃"))
(pipe_table_delimiter_cell ("-") @punctuation.special @conceal (#set! conceal "━"))
(pipe_table_row ("|") @punctuation.special @conceal (#set! conceal "┃"))


[
  (fenced_code_block_delimiter)
] @punctuation.delimiter

(code_fence_content) @none

[
  (link_destination)
] @text.uri

[
  (link_label)
] @text.reference

[
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
  (list_marker_dot)
  (list_marker_parenthesis)
  (thematic_break)
] @punctuation.special


; (task_list_marker_unchecked) @text.todo.unchecked
; (task_list_marker_checked) @text.todo.checked

((task_list_marker_unchecked) @punctuation.special @conceal (#set! conceal ""))
((task_list_marker_checked) @punctuation.special @conceal (#set! conceal ""))

(block_quote) @text.quote

 (([(list_marker_star) (list_marker_minus)] @punctuation.special @conceal_star (#offset! @conceal_star 0 0 0 -1)) (#set! conceal "•"))

; [
;   (block_continuation)
;   (block_quote_marker)
; ] @punctuation.special

[
  (backslash_escape)
] @string.escape

([
  (info_string)
  (fenced_code_block_delimiter)
] @conceal
(#set! conceal ""))

(inline) @spell



((block_quote_marker) @conceal (#set! conceal "▍"))
((block_quote
  (paragraph (inline
    (block_continuation) @conceal (#set! conceal "▍")
  ))
))



; (list_item [
;   (list_marker_plus)
;   (list_marker_minus)
;   (list_marker_star)
;   (list_marker_dot)
;   (list_marker_parenthesis)
; ] @conceal [
;     (task_list_marker_checked)
;     (task_list_marker_unchecked)
; ](#set! conceal ""))

