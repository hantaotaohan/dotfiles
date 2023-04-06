--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                         PLUGINS: Comment_Box                         │
--   │                                                                      │
--   │           https://github.com/LudoPinelli/comment-box.nvim            │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"LudoPinelli/comment-box.nvim",
	event = "VeryLazy",

	config = function()
		require("comment-box").setup({

			doc_width = 80, -- width of the document
			box_width = 72, -- width of the boxes
			borders = {
				top = "─",
				bottom = "─",
				left = "│",
				right = "│",
				top_left = "╭",
				top_right = "╮",
				bottom_left = "╰",
				bottom_rsight = "╯",
			},
			line_width = 74, -- width of the lines
			line = {
				line = "─",
				line_start = "─",
				line_end = "─",
			},
			outer_blank_lines = true, -- insert a blank line above and below the box
			inner_blank_lines = false, -- insert a blank line above and below the text
			line_blank_line_above = true, -- insert a blank line above the line
			line_blank_line_below = true, -- insert a blank line below the line
		})
	end,
}
