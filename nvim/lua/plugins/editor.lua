--  ══════════════════════════════════════════════════════════════════════════
--  DIRECTORY
--  ══════════════════════════════════════════════════════════════════════════

--  * NeoTree
--  * Outline
--  * ToggleTerm
--  * Spectre
--  * Telescope
--  * Project
--  * Which_Key
--  * Gitsigns
--  * Pretty_Fold
--  * Scrollbar
--  * Marks
--  * Asyncrun
--  * Sayonara
--  * Colorizer

--  ╾────────────────────────────────────────────────────────────────────────╼

local Util = require("config.utility")

return {

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               NeoTree                                │
	--   │                                                                      │
	--   │            https://github.com/nvim-neo-tree/neo-tree.nvim            │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = true,
		version = "v2.x",
		cmd = "Neotree",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},

		keys = {
			{
				"<leader>|",
				":Neotree reveal filesystem float toggle=true<cr>",
				desc = "Toggle file tree (float)",
				silent = true,
			},
			{ "<LocalLeader>e", ":Neotree toggle<cr>", desc = "Toggle file tree (sidebar)", silent = true },
		},

		config = function()
			local tree = require("neo-tree")
			local highlights = require("neo-tree.ui.highlights")
			local renderer = require("neo-tree.ui.renderer")

			-- ascend to the parent or close it
			local function float(state)
				local node = state.tree:get_node()
				if (node.type == "directory" or node:has_children()) and node:is_expanded() then
					state.commands.toggle_node(state)
				else
					renderer.focus_node(state, node:get_parent_id())
				end
			end

			-- toggle a node open or descend to it's first child
			local function dive(state)
				local node = state.tree:get_node()
				if node.type == "directory" or node:has_children() then
					if not node:is_expanded() then
						if node.type == "directory" then
							require("neo-tree.sources.filesystem").toggle_directory(state, node)
						else
							state.commands.toggle_node(state)
						end
					else
						renderer.focus_node(state, node:get_child_ids()[1])
					end
				end
			end

			require("neo-tree").setup({

				add_blank_line_at_top = true, -- Add a blank line at the top of the tree.
				close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
				close_floats_on_escape_key = true,
				use_libuv_filewatcher = true,
				-- default_source = "filesystem",
				enable_diagnostics = false,
				enable_git_status = true,
				enable_modified_markers = true, -- Show markers for files with unsaved changes.
				enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
				git_status_async = true,

				hide_root_node = false, -- Hide the root node.
				retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.

				log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
				log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
				open_files_in_last_window = false, -- false = open files in top left window
				popup_border_style = "rounded", -- "double", "none", "rounded", "shadow", "single" or "solid"
				resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content

				sort_case_insensitive = false, -- used when sorting files and directories in the tree
				sort_function = nil, -- uses a custom function for sorting files and directories in the tree
				use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
				use_default_mappings = false,

				source_selector = {
					winbar = false,
				},

				event_handlers = {

					{
						event = "file_opened",
						handler = function(file_path)
							--auto close
							require("neo-tree").close_all()
						end,
					},

					{
						event = "neo_tree_buffer_enter",
						handler = function()
							-- This effectively hides the cursor
							vim.cmd("highlight! Cursor blend=100")
						end,
					},

					{
						event = "neo_tree_buffer_leave",
						handler = function()
							-- Make this whatever your current Cursor highlight group is.
							vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
						end,
					},
				},

				default_component_configs = {

					container = {
						enable_character_fade = true,
						width = "100%",
						right_padding = 0,
					},

					diagnostics = {
						symbols = {
							hint = "H",
							info = "I",
							warn = "!",
							error = "X",
						},
						highlights = {
							hint = "DiagnosticSignHint",
							info = "DiagnosticSignInfo",
							warn = "DiagnosticSignWarn",
							error = "DiagnosticSignError",
						},
					},

					indent = {
						indent_size = 2,
						padding = 2,
						with_markers = true,
						indent_marker = "│",
						last_indent_marker = "└",
						highlight = "NeoTreeIndentMarker",
						with_expanders = nil,
						expander_collapsed = "+",
						expander_expanded = "-",
						expander_highlight = "NeoTreeExpander",
					},

					icon = {
						-- folder_closed = "",
						-- folder_open = "",
						folder_closed = "",
						folder_open = "",
						folder_empty = "ﰊ",
						default = "·",
						-- highlight = "NeoTreeFileIcon"
					},

					modified = {
						symbol = "[+] ",
						highlight = "NeoTreeModified",
					},

					name = {
						trailing_slash = false,
						use_git_status_colors = true,
						-- highlight = "NeoTreeFileName",
					},

					git_status = {
						symbols = {

							-- Change type
							added = "✚",
							deleted = "✖",
							modified = "",
							renamed = "",

							-- Status type
							untracked = "",
							ignored = "",
							unstaged = "",
							staged = "",
							conflict = "",
						},
						align = "right",
					},
				},

				window = {

					position = "left", -- left, right, top, bottom, float, current
					width = 35,
					height = 15,

					popup = {
						size = {
							height = "80%",
							width = "50%",
						},
						position = "50%", -- 50% means center it
					},

					mapping_options = {
						noremap = true,
						nowait = true,
					},

					mappings = {
						-- ["<esc>"] = "revert_preview",
						["P"] = { "toggle_preview", config = { use_float = true } },
						["S"] = "open_split",
						["s"] = "open_vsplit",
						["t"] = "open_tabnew",
						["w"] = "open_with_window_picker",
						["C"] = "close_node",
						["z"] = "close_all_nodes",
						["R"] = "refresh",
						-- ["/"] = "filter_as_you_type",
						["a"] = {
							"add",
							config = {
								show_path = "none", -- "none", "relative", "absolute"
							},
						},
						["A"] = "add_directory", -- also accepts the config.show_path option.
						["dd"] = "delete",
						["r"] = "rename",
						["yy"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["c"] = "copy", -- takes text input for destination, also accepts the config.show_path option
						["m"] = "move", -- takes text input for destination, also accepts the config.show_path option
						["<LocalLeader>q"] = "close_window",
						["?"] = "show_help",
						["<"] = "prev_source",
						[">"] = "next_source",
						["<cr>"] = "smart_open",
						["o"] = "smart_open",
						["/"] = "fuzzy_finder",
						["<Esc>"] = "clear_filter",
						["u"] = "navigate_up",
						["C"] = "set_root",
						["[c"] = "prev_git_modified",
						["]c"] = "next_git_modified",
						["h"] = float,
						["l"] = dive,
					},
				},

				nesting_rules = {
					ts = { "js", "js.map", "d.ts" },
					scss = { "css", "min.css", "css.map", "min.css.map" },
				},

				filesystem = {
					async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
					follow_current_file = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
					hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree in whatever position is specified in window.position
					force_visible_in_empty_folder = false, -- when true, hidden files will be shown if the root folder is otherwise empty
					bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root

					cwd_target = {
						sidebar = "tab", -- sidebar is when position = left or right
						current = "window", -- current is when position = current
					},

					filtered_items = {
						visible = true, -- when true, they will just be displayed differently than normal items
						show_hidden_count = false, -- when true, the number of hidden items in each folder will be shown as the last entry
						hide_dotfiles = true,
						hide_gitignored = false,
						hide_hidden = false, -- only works on Windows for hidden files/directories
						hide_by_name = {
							".DS_Store",
							"thumbs.db",
							--"node_modules",
						},
						hide_by_pattern = { -- uses glob style patterns
							--"*.meta",
							--"*/src/*/tsconfig.json"
						},
						always_show = { -- remains visible even if other settings would normally hide it
							--".gitignored",
						},
						never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
							--".DS_Store",
							--"thumbs.db"
						},
						never_show_by_pattern = { -- uses glob style patterns
							--".null-ls_*",
						},
					},

					components = {

						icon = function(config, node)
							local icon = config.default or " "
							local padding = config.padding or "  "
							local highlight = config.highlight or highlights.FILE_ICON
							local web_devicons = require("nvim-web-devicons")
							if node.type == "directory" then
								highlight = highlights.DIRECTORY_ICON
								if node.name == "node_modules" or node.name == ".git" or node.name == ".github" then
									local _icon, _highlight = web_devicons.get_icon(node.name)
									icon = _icon or icon
									highlight = _highlight or highlight
								elseif node:is_expanded() then
									icon = config.folder_open or "-"
								else
									icon = config.folder_closed or "+"
								end
							elseif node.type == "file" then
								---@type string
								local name = node.name
								local ext = node.ext
								if ext == "json" and name:match([[^tsconfig]]) then
									name = "tsconfig.json"
								end
								local _icon, _highlight = web_devicons.get_icon(name, ext)
								icon = _icon or icon
								highlight = _highlight or highlight
							end
							return {
								text = icon .. padding,
								highlight = highlight,
							}
						end,
					},

					commands = {
						smart_open = function(state)
							local node = state.tree:get_node()
							if require("neo-tree.utils").is_expandable(node) then
								state.commands["toggle_node"](state)
							else
								state.commands["open"](state)
								vim.cmd("normal! M")
							end
						end, -- instead of relying on nvim autocmd events.
					},
				},

				buffers = {
					bind_to_cwd = true,
					show_unloaded = true,
					follow_current_file = true, -- This will find and focus the file in the active buffer every time
					-- the current file is changed while the tree is open.
					group_empty_dirs = true, -- when true, empty directories will be grouped together
					window = {
						mappings = {
							["u"] = "navigate_up",
							["C"] = "set_root",
							["bd"] = "buffer_delete",
						},
					},
				},

				git_status = {
					window = {
						position = "float",
						mappings = {
							["A"] = "git_add_all",
							["gu"] = "git_unstage_file",
							["ga"] = "git_add_file",
							["gr"] = "git_revert_file",
							["gc"] = "git_commit",
							["gp"] = "git_push",
							["gg"] = "git_commit_and_push",
						},
					},
				},
			})
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Outline                                │
	--   │                                                                      │
	--   │           https://github.com/simrat39/symbols-outline.nvim           │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"simrat39/symbols-outline.nvim",
		event = "VeryLazy",
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

			keymaps = { -- These keymaps can be a string or a table for multiple keys
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
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                              ToggleTerm                              │
	--   │                                                                      │
	--   │              https://github.com/akinsho/toggleterm.nvim              │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		version = "*",
		opts = {
			shade_terminals = false,
			shading_factor = 1,
			start_in_insert = true,
		},
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Spectre                                │
	--   │                                                                      │
	--   │              https://github.com/nvim-pack/nvim-spectre               │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"windwp/nvim-spectre",
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
		opts = {
			color_devicons = true,

			open_cmd = "leftabove vnew",
			live_update = false, -- auto excute search again when you write any file in vim
			line_sep_start = "┌─────────────────────────────────────────────",
			result_padding = "│ ",
			line_sep = "└─────────────────────────────────────────────",

			highlight = {
				ui = "String",
				search = "DiffChange",
				replace = "DiffDelete",
			},

			mapping = {

				["toggle_line"] = {
					map = "t",
					cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
					desc = "toggle current item",
				},

				["enter_file"] = {
					map = "<cr>",
					cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
					desc = "goto current file",
				},

				["send_to_qf"] = {
					map = "Q",
					cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
					desc = "send all item to quickfix",
				},

				["replace_cmd"] = {
					map = "c",
					cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
					desc = "input replace vim command",
				},

				["show_option_menu"] = {
					map = "o",
					cmd = "<cmd>lua require('spectre').show_options()<CR>",
					desc = "show option",
				},

				["run_replace"] = {
					map = "R",
					cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
					desc = "replace all",
				},

				["change_view_mode"] = {
					map = "m",
					cmd = "<cmd>lua require('spectre').change_view()<CR>",
					desc = "change result view mode",
				},

				["toggle_ignore_case"] = {
					map = "I",
					cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
					desc = "toggle ignore case",
				},

				["toggle_ignore_hidden"] = {
					map = "H",
					cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
					desc = "toggle search hidden",
				},
				-- you can put your mapping here it only use normal mode
			},

			find_engine = {
				-- rg is map with finder_cmd
				["rg"] = {

					cmd = "rg",
					-- default args
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
					},

					options = {

						["ignore-case"] = {
							value = "--ignore-case",
							icon = "[I]",
							desc = "ignore case",
						},

						["hidden"] = {
							value = "--hidden",
							desc = "hidden file",
							icon = "[H]",
						},

						-- you can put any option you want here it can toggle with
						-- show_option function
					},
				},

				["ag"] = {
					cmd = "ag",

					args = {
						"--vimgrep",
						"-s",
					},

					options = {

						["ignore-case"] = {
							value = "-i",
							icon = "[I]",
							desc = "ignore case",
						},

						["hidden"] = {
							value = "--hidden",
							desc = "hidden file",
							icon = "[H]",
						},
					},
				},
			},

			replace_engine = {

				["sed"] = {
					cmd = "sed",
					args = nil,
				},

				options = {
					["ignore-case"] = {
						value = "--ignore-case",
						icon = "[I]",
						desc = "ignore case",
					},
				},
			},

			default = {

				find = {
					--pick one of item in find_engine
					cmd = "rg",
					options = { "ignore-case" },
				},

				replace = {
					--pick one of item in replace_engine
					cmd = "sed",
				},
			},

			replace_vim_cmd = "cdo",
			is_open_target_win = true, --open file on opener window
			is_insert_mode = true, -- start open panel on is_insert_mode
		},
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                              Telescope                               │
	--   │                                                                      │
	--   │           https://github.com/nvim-telescope/telescope.nvim           │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
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
							["<C-[>"] = require("telescope.actions").close,
							["<Esc>"] = require("telescope.actions").close,
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
						-- projects = {},
						-- Your extension configuration goes here:
						-- extension_name = {
						--   extension_config_key = value,
						-- }
						-- please take a look at the readme of the extension you want to configure
					},
					require("telescope").load_extension("projects"),
					-- require('telescope').load_extension('vimwiki'),
					-- require('telescope').load_extension('fzf')
				},
			})
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Project                                │
	--   │                                                                      │
	--   │              https://github.com/ahmedkhalf/project.nvim              │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{

		"ahmedkhalf/project.nvim",
		lazy = true,
		event = "VeryLazy",
		cmd = "Telescope",
		keys = { { "<LocalLeader>fp", "<Cmd>Telescope projects<CR>", desc = "Recent projects" } },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				-- Manual mode doesn't automatically change your root directory, so you have
				-- the option to manually do so using `:ProjectRoot` command.
				manual_mode = false,

				-- Methods of detecting the root directory. **"lsp"** uses the native neovim
				-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
				-- order matters: if one is not detected, the other is used as fallback. You
				-- can also delete or rearangne the detection methods.
				detection_methods = { "lsp", "pattern" },

				-- All the patterns used to detect root dir, when **"pattern"** is in
				-- detection_methods
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

				-- Table of lsp clients to ignore by name
				-- eg: { "efm", ... }
				ignore_lsp = {},

				-- Don't calculate root dir on specific directories
				-- Ex: { "~/.cargo/*", ... }
				exclude_dirs = {},

				-- Show hidden files in telescope
				show_hidden = false,

				-- When set to false, you will get a message when project.nvim changes your
				-- directory.
				silent_chdir = true,

				-- Path where project.nvim will store the project history for use in
				-- telescope
				datapath = vim.fn.stdpath("data"),
			})
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                              Which_Key                               │
	--   │                                                                      │
	--   │               https://github.com/folke/which-key.nvim                │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		cmd = "WhichKey",
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
				i = { "j", "k" },
				v = { "j", "k" },
				n = { "<", ">", ";" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			local keymaps = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			}
			if Util.has("noice.nvim") then
				keymaps["<leader>sn"] = { name = "+noice" }
			end
			wk.register(keymaps)
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Gitsigns                               │
	--   │                                                                      │
	--   │              https://github.com/lewis6991/gitsigns.nvim              │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = {
					hl = "GitSignsChange",
					text = "▎",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = {
					hl = "GitSignsDelete",
					text = "",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				topdelete = {
					hl = "GitSignsDelete",
					text = "",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "▎",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				untracked = {
					hl = "GitSignsChange",
					text = "▎",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
			},

			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},

			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`

			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
			},

			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)

			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},

			yadm = {
				enable = false,
			},

			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

                -- stylua: ignore start
                map("n", "]h", gs.next_hunk, "Next Hunk")
                map("n", "[h", gs.prev_hunk, "Prev Hunk")
                map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
                map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
                map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
                map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
                map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
                map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
                map("n", "<leader>ghd", gs.diffthis, "Diff This")
                map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                             Pretty_Fold                              │
	--   │                                                                      │
	--   │            https://github.com/anuvyklack/pretty-fold.nvim            │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"anuvyklack/pretty-fold.nvim",
		event = "VeryLazy",
		opts = {

			keep_indentation = false,
			remove_fold_markers = true,
			process_comment_signs = false,
			fill_char = "━",

			sections = {

				left = {
					"",
					function()
						return string.rep(" FOLDED ", vim.v.foldlevel)
					end,
					" ██ ",
					"content",
					"██  ",
				},

				right = {
					"  ██  ",
					"number_of_folded_lines",
					": ",
					"percentage",
					"   ",
				},
			},

			matchup_patterns = {

				{ "^%s*do$", "end" }, -- do ... end blocks
				{ "^%s*if", "end" }, -- if ... end
				{ "^%s*for", "end" }, -- for
				{ "function%s*%(", "end" }, -- 'function( or 'function (''
				{ "{", "}" },
				{ "%(", ")" }, -- % to escape lua pattern char
				{ "%[", "]" }, -- % to escape lua pattern char
			},
		},
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                              Scrollbar                               │
	--   │                                                                      │
	--   │             https://github.com/petertriho/nvim-scrollbar             │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		dependencies = {
			"lewis6991/gitsigns.nvim",
		},
		opts = {

			show = true,
			show_in_active_only = false,
			set_highlights = true,
			folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
			max_lines = false, -- disables if no. of lines in buffer exceeds this
			hide_if_all_visible = true, -- Hides handle if all lines are visible
			throttle_ms = 100,

			handle = {
				text = " ",
				color = "#414855",
				cterm = nil,
				highlight = "CursorColumn",
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
			},

			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
				"neo-tree",
				"dashboard",
				"lazzy",
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
				cursor = true,
				gitsigns = true, -- Requires gitsigns
				handle = true,
				search = false, -- Requires hlslens
				ale = false, -- Requires ALE
			},
		},
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                                Marks                                 │
	--   │                                                                      │
	--   │               https://github.com/chentoast/marks.nvim                │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {

			-- whether to map keybinds or not. default true
			default_mappings = true,
			-- which builtin marks to show. default {}
			builtin_marks = {},
			-- whether movements cycle back to the beginning/end of buffer. default true
			cyclic = true,
			-- whether the shada file is updated after modifying uppercase marks. default false
			force_write_shada = false,
			-- how often (in ms) to redraw signs/recompute mark positions.
			-- higher values will have better performance but may cause visual lag,
			-- while lower values may cause performance penalties. default 150.
			refresh_interval = 250,
			-- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
			-- marks, and bookmarks.
			-- can be either a table with all/none of the keys, or a single number, in which case
			-- the priority applies to all marks.
			-- default 10.
			sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
			-- disables mark tracking for specific filetypes. default {}
			excluded_filetypes = {
				"prompt",
				"TelescopePrompt",
				"NvimTree",
				"alpha",
			},
			-- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
			-- sign/virttext. Bookmarks can be used to group together positions and quickly move
			-- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
			-- default virt_text is "".
			bookmark_0 = {
				sign = "⚑",
				virt_text = "hello world",
				-- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
				-- defaults to false.
				annotate = false,
			},

			mappings = {},
		},
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Asyncrun                               │
	--   │                                                                      │
	--   │             https://github.com/skywind3000/asyncrun.vim              │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{

		"skywind3000/asyncrun.vim",
		event = "VeryLazy",
		config = function()
			vim.g.asyncrun_open = 6
			-- vim.g.asyncrun_status = "stopped"
			vim.g.asyncrun_status = ""
			vim.g.asyncrun_rootmarks = { "pom.xml", ".git", ".svn", ".root", ".project", ".hg" }
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Sayonara                               │
	--   │                                                                      │
	--   │                https://github.com/mhinz/vim-sayonara                 │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"mhinz/vim-sayonara",
		cmd = "Sayonara",
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                              Colorizer                               │
	--   │                                                                      │
	--   │            https://github.com/norcalli/nvim-colorizer.lua            │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		opts = {

			filetypes = {
				"*",
			},

			user_default_options = {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = false, -- "Name" codes like Blue
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				rgb_fn = false, -- CSS rgb() and rgba() functions
				hsl_fn = false, -- CSS hsl() and hsla() functions
				css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				mode = "background", -- Set the display mode.
			},
		},
	},
}
