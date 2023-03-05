return {

	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"HiPhish/nvim-ts-rainbow2",
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
			"help",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			-- "query",
			-- "regex",
			-- "tsx",
			-- "typescript",
			"vim",
			"yaml",
		},

		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},

		indent = {
			enable = true,
		},

		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<Enter>",
				node_incremental = "<Enter>",
				scope_incremental = "<nop>",
				node_decremental = "<bs>",
			},
		},

		rainbow = {
			enable = true,
			extended_mode = true,
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
