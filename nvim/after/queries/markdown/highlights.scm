;; extends

;    ╒══════════════════════════════════════════════════════════════════════╕
;                                Header and Text
;    ╘══════════════════════════════════════════════════════════════════════╛

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

;    ╒══════════════════════════════════════════════════════════════════════╕
;                                  Tables Style
;    ╘══════════════════════════════════════════════════════════════════════╛

(pipe_table_header (pipe_table_cell) @table.text.title)

; Use box drawing characters for tables
(pipe_table_header ("|") @table.spe @conceal (#set! conceal "┃"))
(pipe_table_delimiter_row ("|") @table.spe @conceal (#set! conceal "┃"))
(pipe_table_delimiter_cell ("-") @table.spe @conceal (#set! conceal "━"))
(pipe_table_row ("|") @table.spe @conceal (#set! conceal "┃"))

; Use box drawing characters for tables
; (pipe_table_header "|" @punctuation.special)
; (pipe_table_row "|" @punctuation.special)
; (pipe_table_delimiter_row "|" @punctuation.special)
; (pipe_table_delimiter_cell) @punctuation.special


;    ╒══════════════════════════════════════════════════════════════════════╕
;                                   Block Code
;    ╘══════════════════════════════════════════════════════════════════════╛

; 代码块标识符
[
  (fenced_code_block_delimiter)
] @code.delimiter 

; 代码块的内容区域
(code_fence_content) @none

;    ╒══════════════════════════════════════════════════════════════════════╕
;                                   List Style
;    ╘══════════════════════════════════════════════════════════════════════╛

[
  (list_marker_plus)
  (list_marker_minus)
  (list_marker_star)
  (list_marker_dot)
  (list_marker_parenthesis)
  (thematic_break)
] @list.marks

; (([(list_marker_star) (list_marker_minus)] @list.marks @conceal_star (#offset! @conceal_star 0 0 0 -1)) (#set! conceal "·"))

;    ╒══════════════════════════════════════════════════════════════════════╕
;                                   Task Sytle
;    ╘══════════════════════════════════════════════════════════════════════╛

((task_list_marker_unchecked) @task.checked @conceal (#set! conceal ""))
((task_list_marker_checked) @task.checked @conceal (#set! conceal ""))

; (task_list_marker_unchecked) @text.todo.unchecked
; (task_list_marker_checked) @text.todo.checked

;    ╒══════════════════════════════════════════════════════════════════════╕
;                                  Block Quote
;    ╘══════════════════════════════════════════════════════════════════════╛

; [
;   (block_continuation)
;   (block_quote_marker)
; ] @punctuation.special

(block_quote) @quote.quote

((block_quote_marker) @quote (#set! conceal "▍"))
((block_quote
  (paragraph (inline
    (block_continuation) @quote (#set! conceal "▍")
  ))
))

;    ╒══════════════════════════════════════════════════════════════════════╕
;                                    转义字符
;    ╘══════════════════════════════════════════════════════════════════════╛

(backslash_escape) @string.escape


(link_title) @text.link.title
(indented_code_block) @text.indented.code


[
  (link_destination)
] @text.uri

[
  (link_label)
] @text.reference



([
  (info_string)
  (fenced_code_block_delimiter)
] @conceal
(#set! conceal ""))

(inline) @spell




