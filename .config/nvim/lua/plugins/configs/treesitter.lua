local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
	return
end

-- for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
-- 	config.install_info.url = config.install_info.url:gsub("https://github.com/", "https://ghproxy.com/https://github.com/")
-- end

local options = {

	ensure_installed = { "lua", "python" },
	sync_install = false,
    auto_install = false,

	ignore_install = { "c", "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
	autopairs = { enable = true },
	autotag = {enable = true },

	-- 启用代码高亮模块
	highlight = {
		enable = true,
        disable = { "c", "rust" },
		additional_vim_regex_highlighting = false,
	},

	-- 启用增量选择模块
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<TAB>",
		},
	},

	-- 启用代码缩进模块 (=)
	indent = {
		enable = true,
	},

    textobjects = {
        enable = true
    },

	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		colors = {
            "#E06C75",
            "#E5C07B",
            "#98C379",
            "#56B6C2",
            "#61AFEF",
            "#C678DD",
        }, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
}

-- 开启 Folding 模块
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
-- vim.opt.foldlevel = 99

require("nvim-treesitter.install").prefer_git = true
require("nvim-treesitter.configs").setup(options)
