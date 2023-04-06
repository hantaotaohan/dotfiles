--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                          PLUGINS: Scrollbar                          │
--   │                                                                      │
--   │             https://github.com/petertriho/nvim-scrollbar             │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"petertriho/nvim-scrollbar",
	lazy = true,
	event = { "InsertEnter", "CursorMoved" },
	dependencies = {
		"lewis6991/gitsigns.nvim",
	},
	opts = {
		show = true,
		show_in_active_only = true,
		set_highlights = true,
		folds = false, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
		max_lines = false, -- disables if no. of lines in buffer exceeds this
		hide_if_all_visible = true, -- Hides handle if all lines are visible
		throttle_ms = 100,
		handle = {
			text = " ",
			color = "#414855",
			cterm = nil,
			highlight = "CursorColumn",
			hide_if_all_visible = true,
		},
		marks = {
			Cursor = {
				text = "─",
				priority = 0,
				gui = nil,
				color = "#61AFEF",
				cterm = nil,
				color_nr = nil, -- cterm
				highlight = "Normal",
			},
			Search = {
				text = { "█" },
				priority = 0,
				color = nil,
				cterm = nil,
				highlight = "Search",
			},
			Error = {
				text = { "█" },
				priority = 1,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticVirtualTextError",
			},
			Warn = {
				text = { "█" },
				priority = 2,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticVirtualTextWarn",
			},
			Info = {
				text = { "█" },
				priority = 3,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticVirtualTextInfo",
			},
			Hint = {
				text = { "█" },
				priority = 4,
				color = nil,
				cterm = nil,
				highlight = "DiagnosticVirtualTextHint",
			},
			Misc = {
				text = { "█" },
				priority = 5,
				color = nil,
				cterm = nil,
				highlight = "Normal",
			},
			GitAdd = {
				text = "█",
				priority = 7,
				gui = nil,
				color = "#3c4f2b",
				cterm = nil,
				color_nr = nil, -- cterm
				highlight = "GitSignsAdd",
			},
			GitChange = {
				text = "█",
				priority = 7,
				gui = nil,
				color = "#32575f",
				cterm = nil,
				color_nr = nil, -- cterm
				highlight = "GitSignsChange",
			},
			GitDelete = {
				text = "█",
				priority = 7,
				gui = nil,
				color = "#6f2735",
				cterm = nil,
				color_nr = nil, -- cterm
				highlight = "GitSignsDelete",
			},
		},
		excluded_buftypes = {
			"terminal",
			"TelescopeResults",
			"query",
			"tsplayground",
			"lazy",
			"lsp-installer",
			-- "markdown",
			"mason",
			"txt",
			"dashboard",
			"alpha",
			"NvimTree",
			"undotree",
			"diff",
			"fugitive",
			"fugitiveblame",
			"Outline",
			"SidebarNvim",
			"packer",
			"lsp-installer",
			"TelescopePrompt",
			"help",
			"telescope",
			"lspinfo",
			"Trouble",
			"null-ls-info",
			"quickfix",
			"chadtree",
			"fzf",
			"NeogitStatus",
			"terminal",
			"console",
			"term://*",
			"Term://*",
			"toggleterm",
			"qf",
			"prompt",
			"noice",
			-- "",
		},
		excluded_filetypes = {
			"terminal",
			"nofile",
			"prompt",
			"TelescopePrompt",
			"neo-tree",
			"dashboard",
			"alpha",
			"aerial",
			"mason",
			"lazy",
			"noice",
			"Notify",
		},
		autocmd = {
			render = {
				"BufWinEnter",
				"TabEnter",
				"TermEnter",
				"WinEnter",
				"CmdwinLeave",
				"TextChanged",
				"VimResized",
				"WinScrolled",
			},
			clear = {
				"BufWinLeave",
				"TabLeave",
				"TermLeave",
				"WinLeave",
			},
		},
		handlers = {
			diagnostic = false,
			search = false, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
			cursor = false,
			gitsigns = false, -- Requires gitsigns
			handle = true,
			ale = false, -- Requires ALE
		},
	},
}
