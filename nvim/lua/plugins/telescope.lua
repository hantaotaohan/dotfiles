return {

	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	version = false, -- telescope did only one release, so use HEAD for now
	keys = {
		{ "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
		--     -- { "<leader>/", Util.telescope("live_grep"), desc = "Find in Files (Grep)" },
		--     { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		--     -- { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
		--     -- find
		--     { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		--     -- { "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
		--     -- { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
		--     -- git
		--     { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
		--     { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
		--     -- search
		--     { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
		--     { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
		--     { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		--     { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
		--     { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		--     -- { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
		--     -- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
		--     { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
		--     { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
		--     { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
		--     { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
		--     { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
		--     { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
		--     { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
		--     -- { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
		--     -- { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
		--     -- { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
		--     -- {
		--     --     "<leader>ss",
		--     --     Util.telescope("lsp_document_symbols", {
		--     --         symbols = {
		--     --             "Class",
		--     --             "Function",
		--     --             "Method",
		--     --             "Constructor",
		--     --             "Interface",
		--     --             "Module",
		--     --             "Struct",
		--     --             "Trait",
		--     --             "Field",
		--     --             "Property",
		--     --         },
		--     --     }),
		--     --     desc = "Goto Symbol",
		--     -- },
		--     -- {
		--     --     "<leader>sS",
		--     --     Util.telescope("lsp_workspace_symbols", {
		--     --         symbols = {
		--     --             "Class",
		--     --             "Function",
		--     --             "Method",
		--     --             "Constructor",
		--     --             "Interface",
		--     --             "Module",
		--     --             "Struct",
		--     --             "Trait",
		--     --             "Field",
		--     --             "Property",
		--     --         },
		--     --     }),
		--     --     desc = "Goto Symbol (Workspace)",
		--     -- },
	},

	config = function()
		local putils = require("telescope.previewers.utils")

		require("telescope").setup({

			defaults = {

				-- path_display = { 'smart'},
				sorting_strategy = "ascending", -- 结果的排序方向                    | scending (default) | ascending
				selection_strategy = "reset", -- 确定每次排序迭代后光标的操作方式。| reset (default) | follow | row | closest | none
				scroll_strategy = "cycle", -- 确定如果尝试滚动经过选择器        | cycle (default) | limit
				layout_strategy = "horizontal", -- 默认布局                          | horizontal (default) | vertical | center | cursor

				layout_config = {
					bottom_pane = {
						height = 25,
						preview_cutoff = 120,
						prompt_position = "top",
					},
					center = {
						height = 0.4,
						preview_cutoff = 40,
						prompt_position = "top",
						width = 0.5,
					},
					cursor = {
						height = 0.9,
						preview_cutoff = 40,
						width = 0.8,
					},
					horizontal = {
						height = 0.8,
						preview_cutoff = 120,
						prompt_position = "top",
						width = 0.8,
					},
					vertical = {
						height = 0.9,
						preview_cutoff = 40,
						prompt_position = "top",
						width = 0.8,
					},
				},

				cycle_layout_list = { "horizontal", "vertical" }, -- 布局循环列表
				winblend = 20, -- 浮动窗口配置
				wrap_results = false, -- 自动换行搜索结果
				prompt_prefix = "    ", -- 搜索栏的搜索关键字前的字符
				selection_caret = "  ", -- 选定内容前的字符
				entry_prefix = "   ", -- 每个结果条目前面的前缀,不包括当前选择
				multi_icon = " + ", -- 多选图标
				initial_mode = "normal", -- Telescope 启动模式 | insert | normal
				border = true, -- 是否启用边框
				path_display = {
					shorten = 2, -- 缩短显示的路径名称
				},

				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

				-- borderchars = {
				--     prompt = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
				--     results = {' ', '▐', '▄', '▌', '▌', '▐', '▟', '▙' };
				--     preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' };
				-- };

				-- borderchars = {
				--     prompt =  {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
				--     results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
				--     preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
				-- },

				-- borderchars = {
				--     { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
				--     prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
				--     results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
				--     preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
				-- },

				hl_result_eol = true, -- 如果结果中所选项目的突出显示, 则更改 window始终是窗口的全宽
				dynamic_preview_title = true, -- 动态更改预览窗口的标题
				results_title = "Results", -- 定义结果窗口的默认标题, 错误的值, 可以用于完全隐藏标题
				prompt_title = "Prompt", -- 定义提示窗口的默认标题, 错误的值, 可以用于完全隐藏标题

				mappings = {

					i = {
						["<LocalLeader>q"] = { "<esc>", type = "command" },
					},

					n = {
						["?"] = require("telescope.actions.layout").toggle_preview,
						["q"] = require("telescope.actions").close,
						["<LocalLeader>q"] = require("telescope.actions").close,
						["<LocalLeader>n"] = require("telescope.actions.layout").cycle_layout_next,
					},
				},

				default_mappings = nil, -- 将允许您完全删除望远镜的所有默认热键并使用自己的热键

				history = {
					mappings = {
						i = {
							["<C-Down>"] = require("telescope.actions").cycle_history_next,
							["<C-Up>"] = require("telescope.actions").cycle_history_prev,
						},
					},
				},

				preview = {
					treesitter = false, -- 确定预览器是否执行 Treesitter 突出显示
					msg_bg_fillchar = "/", -- 用于填充不可见区域的字符
					hide_on_startup = true, -- 选择器启动时隐藏预览器。可以切换预览器使用 actions.layout.toggle_preview
				},

				vimgrep_arguments = {
					"rg",
					"L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},

				set_env = { ["COLORTERM"] = "truecolor" }, -- 为term_preview设置环境. default = nil
				color_devicons = false, -- 图标颜色
				-- file_sorter = require("telescope.sorters").get_fuzzy_file,                             --Default: require("telescope.sorters").get_fzy_sorter
				-- generic_sorter = require("telescope.sorters").get_fzy_sorter,                          -- Default: require("telescope.sorters").get_fzy_sorter
				-- prefilter_sorter = require("telescope.sorters").prefilter,                             -- Default: require("telescope.sorters").prefilter
				file_ignore_patterns = { "node_modules" }, -- 用于定义应忽略的文件
				file_previewer = require("telescope.previewers").vim_buffer_cat.new, -- Default: require("telescope.previewers").vim_buffer_cat.new
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new, -- Default: require("telescope.previewers").vim_buffer_vimgrep.new
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new, -- Default: require("telescope.previewers").vim_buffer_qflist.new
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker, -- Default: require("telescope.previewers").buffer_previewer_maker

				-- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				-- path_display = { "truncate" },

				pickers = {
					buffers = {
						ignore_current_buffer = true,
						sort_mru = true,
						sort_lastused = true,
					},
				},

				extensions = {
					-- Your extension configuration goes here:
					-- extension_name = {
					--   extension_config_key = value,
					-- }
					-- please take a look at the readme of the extension you want to configure
				},
				-- require('telescope').load_extension('projects'),
				-- require('telescope').load_extension('vimwiki'),
				-- require('telescope').load_extension('fzf')
			},
		})
	end,
}
