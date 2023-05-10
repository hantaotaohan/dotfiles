--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           PLUGINS: Outline                           │
--   │                                                                      │
--   │           https://github.com/simrat39/symbols-outline.nvim           │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"simrat39/symbols-outline.nvim",
	lazy = true,
	cmd = "SymbolsOutline",
	keys = {
		{
			"<LocalLeader>t",
			"<cmdSymbolsOutline<cr>",
			desc = "Toggle Outline",
			silent = true,
		},
	},
	opts = {
		highlight_hovered_item = true,
		show_guides = true,
		auto_preview = false,
		position = "right",
		relative_width = true,
		border = "single",
		width = 25,
		auto_close = true,
		show_numbers = false,
		show_relative_numbers = false,
		show_symbol_details = true,
		preview_bg_highlight = "Pmenu",
		autofold_depth = nil,
		auto_unfold_hover = true,
		fold_markers = { "", "" },
		wrap = false,
		keymaps = {
			-- These keymaps can be a string or a table for multiple keys
			close = { "<Esc>", "<LoaclLeader>q" },
			goto_location = "<Cr>",
			focus_location = "o",
			hover_symbol = "<C-space>",
			toggle_preview = "p",
			rename_symbol = "r",
			code_actions = "a",
			fold = "h",
			unfold = "l",
			fold_all = "H",
			unfold_all = "L",
			fold_reset = "R",
		},
		lsp_blacklist = {},
		symbol_blacklist = {},
	},
}
