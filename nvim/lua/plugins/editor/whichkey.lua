--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                          PLUGINS: Which_Key                          │
--   │                                                                      │
--   │               https://github.com/folke/which-key.nvim                │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"folke/which-key.nvim",
	lazy = true,
	-- event = "VeryLazy",
	cmd = { "WhichKey" },
	keys = {
		"<space>",
		"<Leader>",
		"<LocalLeader>",
		"g",
		"z",
		"j",
		"k",
	},
	config = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
		local wk = require("which-key")
		require("which-key").setup({
			plugins = {
				marks = false, -- shows a list of your marks on ' and `
				registers = false,
				spelling = {
					enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = false, -- adds help for operators like d, y, ...
					motions = false, -- adds help for motions
					text_objects = false, -- help for text objects triggered after entering an operator
					windows = false, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = false, -- bindings for folds, spelling and others prefixed with z
					g = false, -- bindings for prefixed with g
				},
			},

			operators = { gc = "Comments" },

			key_labels = {
				["<space>"] = "<SPC>",
				["<cr>"] = "<CR>",
				["<tab>"] = "<TAB>",
				["<leader>"] = "<Leader>",
				[";"] = "<LocalLeader>",
				["g"] = "Goto",
			},

			motions = {
				count = true,
			},

			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "   ", -- symbol used between a key and it's label
				group = "+ ", -- symbol prepended to a group
			},

			popup_mappings = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},

			window = {
				border = "none", -- none, single, double, shadow
				position = "bottom", -- bottom, top
				margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
				padding = { 1, 2, 1, 0 }, -- extra window padding [top, right, bottom, left]
				winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			},

			layout = {
				height = { min = 4, max = 25 }, -- min and max height of the columns
				width = { min = 20, max = 50 }, -- min and max width of the columns
				spacing = 3, -- spacing between columns
				align = "left", -- align columns left, center or right
			},

			ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
			hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
			show_help = false, -- show a help message in the command line for using WhichKey
			show_keys = false, -- show the currently pressed key and its label as a message in the command line
			triggers = "auto", -- automatically setup triggers

			triggers_nowait = {
				"`",
				"'",
				"g`",
				"g'",
				'"',
				"<c-r>",
				"z=",
			},

			triggers_blacklist = {
				-- list of mode / prefixes that should never be hooked by WhichKey
				i = { "j", "k" },
				v = { "j", "k" },
				-- n = { "<", ">", ";", "a" },
			},

			disable = {
				buftypes = {},
				filetypes = {},
			},
		})

		wk.register({
			["<localleader>"] = {
				f = {
					name = "+file",
					f = { "<cmd>Telescope find_files<cr>", "Find File" },
					r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
					n = { "<cmd>enew<cr>", "New File" },
				},
			},
		})

		-- method 3
		wk.register({
			["<leader>f"] = {
				name = "+file",
				f = { "<cmd>Telescope find_files<cr>", "Find File" },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
				n = { "<cmd>enew<cr>", "New File" },
			},
		})

		-- method 4
		wk.register({
			["<leader>f"] = { name = "+file" },
			["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
			["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
		})
	end,
}
