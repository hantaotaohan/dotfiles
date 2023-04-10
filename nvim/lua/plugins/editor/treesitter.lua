--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                         PLUGINS: Treesitter                          │
--   │                                                                      │
--   │          https://github.com/nvim-treesitter/nvim-treesitter          │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {

	"nvim-treesitter/nvim-treesitter",
	lazy = true,
	dependencies = {
		{
			"HiPhish/nvim-ts-rainbow2",
			lazy = true,
			enbaled = true,
		},
		{
			"windwp/nvim-ts-autotag",
			lazy = true,
			enbaled = true,
		},
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			lazy = true,
			enabled = true,
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			lazy = true,
			enbaled = true,
			config = function()
				require("treesitter-context").setup({
					enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
					max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
					min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
					line_numbers = true,
					multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
					trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
					mode = "topline", -- Line used to calculate context. Choices: 'cursor', 'topline'
					separator = nil,
					zindex = 20, -- The Z-index of the context window
				})
			end,
		},
	},
	version = false,
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<Enter>", desc = "Increment selection" },
		{ "<bs>", desc = "Schrink selection", mode = "x" },
	},

	opts = {
		ensure_installed = {
			"bash",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"vim",
			"yaml",
			-- "tsx",
			-- "typescript",
		},

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},

		indent = {
			enable = true,
			disable = { "python" },
		},

		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<space><space>",
				node_incremental = "<space><space>",
				scope_incremental = "<space>s",
				node_decremental = "<space><backspace>",
			},
		},

		rainbow = {
			enable = true,
			query = {
				"rainbow-parens",
				html = "rainbow-tags",
				latex = "rainbow-blocks",
				javascript = "rainbow-tags-react",
				tsx = "rainbow-tags",
				vue = "rainbow-tags",
			},

			hlgroups = {
				"TSRainbowRed",
				"TSRainbowYellow",
				"TSRainbowBlue",
				"TSRainbowOrange",
				"TSRainbowGreen",
				"TSRainbowViolet",
				"TSRainbowCyan",
			},
		},

		autotag = {
			enable = true,
			filetypes = { "html", "xml", "javascript" },
		},
	},

	config = function(_, opts)
		for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
			-- config.install_info.url = config.install_info.url:gsub("https://github.com/", "https://hub.nuaa.cf/")
			config.install_info.url = config.install_info.url:gsub("https://github.com/", os.getenv("GITHUB"))
		end

		require("nvim-treesitter.configs").setup(opts)
	end,
}
