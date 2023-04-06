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
	module = false,
	dependencies = {
		"HiPhish/nvim-ts-rainbow2",
		lazy = true,
		module = false,
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
				init_selection = "<c-space>",
				node_incremental = "<c-space>",
				scope_incremental = "<c-s>",
				node_decremental = "<c-backspace>",
			},
		},

		rainbow = {
			enable = true,
			extended_mode = false,
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
