--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                      PLUGINS: Indent_Blankline                       │
--   │                                                                      │
--   │        https://github.com/lukas-reineke/indent-blankline.nvim        │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		indentLine_enabled = 1,
		char = "│",
		filetype_exclude = {
			"help",
			"lazy",
			"alpha",
			"noice",
			"mason",
			"aerial",
			"notify",
			"lspinfo",
			"terminal",
			"neo-tree",
			"dashboard",
			"toggleterm",
			"TelescopePrompt",
			"TelescopeResults",
		},

		buftype_exclude = { "terminal" },
		show_trailing_blankline_indent = false,
		show_first_indent_level = false,
		show_current_context = true,
		show_current_context_start = true,
		space_char_blankline = " ",
	},
}
