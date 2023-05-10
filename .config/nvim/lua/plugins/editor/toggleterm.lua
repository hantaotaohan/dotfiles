--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                         PLUGINS: ToggleTerm                          │
--   │                                                                      │
--   │              https://github.com/akinsho/toggleterm.nvim              │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"akinsho/toggleterm.nvim",
	cmd = { "ToggleTerm", "TermExec" },
	event = { "CmdwinEnter", "CmdlineEnter" },
	keys = {
		{
			"<LocalLeader>c",
			":ToggleTerm<cr>",
			desc = "Toggle Terminal",
			silent = true,
		},
	},
	config = function()
		require("toggleterm").setup({
			function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			highlights = {
				-- highlights which map to a highlight group name and a table of it's values
				Normal = {
					-- guibg = "<VALUE-HERE>",
				},
				NormalFloat = {
					-- link = "Normal",
				},
				FloatBorder = {
					guifg = "#80a0c1",
					guibg = "#282C34",
				},
			},
			open_mapping = [[<c-\>]],
			autochdir = true,
			shade_terminals = false,
			shading_factor = 1,
			start_in_insert = true,
			hide_numbers = true,
			direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float',
			terminal_mappings = false,
			close_on_exit = true,
			auto_scroll = true,
			shade_filetypes = {},
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			persist_size = true,
			persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
			shell = vim.o.shell, -- change the default shell

			float_opts = {
				-- The border key is *almost* the same as 'nvim_open_win'
				-- see :h nvim_open_win for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				border = "single", -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
				-- like `size`, width and height can be a number or function which is passed the current terminal
				width = 230,
				height = 40,
				winblend = 3,
			},
		})
	end,
}
