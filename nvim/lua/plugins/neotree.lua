return {

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
						unstaged = "",
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
				hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree in whatever position is specified in window.position
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
}
