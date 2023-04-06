--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                          PLUGINS: Which_Key                          │
--   │                                                                      │
--   │               https://github.com/folke/which-key.nvim                │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"folke/which-key.nvim",
	cmd = { "WhichKey" },
	module = false,
	keys = "?",
	opts = {
		plugins = { spelling = true },
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "  ", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "single", -- none/single/double/shadow
		},
		layout = {
			spacing = 6, -- spacing between columns
			align = "center",
		},
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			i = { "j", "k", "a" },
			v = { "j", "k" },
			n = { "<", ">", ";", "a" },
		},
	},
}
