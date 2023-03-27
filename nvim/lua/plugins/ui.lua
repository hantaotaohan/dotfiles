--  ══════════════════════════════════════════════════════════════════════════
--  DIRECTORY
--  ══════════════════════════════════════════════════════════════════════════

--  * Bufferline
--  * Lualine
--  * Noice
--  * Notify
--  * Indent_Blankline
--  * Dashboard
--  * Devicons
--  * Gitsigns

--  ╾────────────────────────────────────────────────────────────────────────╼

return {

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                              Bufferline                              │
	--   │                                                                      │
	--   │              https://github.com/akinsho/bufferline.nvim              │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"akinsho/bufferline.nvim",
		-- lazy = true,
		-- event = "VeryLazy",
		event = "VimEnter",
		version = "v3.*",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers", -- | "buffers" | "tabs"      |
					numbers = "none", -- | "none"    | "ordinal"   | "buffer_id" | "both" |
					close_command = "bdelete! %d", -- | string    | function    | see "Mouse actions   |
					right_mouse_command = "bdelete! %d", -- | string    | function    | see "Mouse actions   |
					left_mouse_command = "buffer %d", -- | string    | function    | see "Mouse actions   |
					middle_mouse_command = nil, -- | string    | function    | see "Mouse actions   |
					indicator = {
						icon = "▋", -- 图标指示器
						style = "icon", -- | 'icon'    | 'underline' | 'none' |
					},
					buffer_close_icon = "",
					modified_icon = "·",
					close_icon = "",
					left_trunc_marker = "",
					right_trunc_marker = "",
					max_name_length = 15,
					max_prefix_length = 15, -- 缓冲区重复数据消除时使用的前缀
					truncate_names = true, -- 是否应截断选项卡名称
					tab_size = 25,
					diagnostics = false, -- 诊断指示器 | false | "nvim_lsp" | "coc" |
					diagnostics_update_in_insert = false,
					diagnostics_indicator = function(count)
						return "(" .. count .. ")"
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "FILE EXPLORER" .. "               " .. "  󰇘  ",
							text_align = "left", -- | "left" | "center" | "right" |
							separator = true,
							padding = 0,
							highlight = "BufferLineBufferVisible",
						},
					},
					color_icons = true, -- 是否添加文件类型图标突出显示
					show_buffer_icons = true, -- 禁用缓冲区的文件类型图标
					show_buffer_close_icons = true,
					show_buffer_default_icon = true, -- 未识别的文件类型是否应显示默认图标
					show_close_icon = false,
					show_tab_indicators = false,
					show_duplicate_prefix = false, -- 是否显示重复的缓冲区前缀
					persist_buffer_sort = true, -- 自定义排序缓冲区是否应持久
					separator_style = "thin", -- | "slant" | "thick" | "thin" | { 'any', 'any' } |
					enforce_regular_tabs = true,
					always_show_bufferline = true,
					hover = {
						enabled = false,
						delay = 200,
						reveal = { "close" },
					},
					sort_by = "insert_after_current", -- | 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
					name_formatter = function(buf)
						return "  " .. buf.name
					end,
				},

				highlights = {

					fill = { fg = "#21252B", bg = "#21252B" },
					background = { fg = "#ABB2BF", bg = "#21252B" },

					close_button = { fg = "#ABB2BF", bg = "#21252B" },
					close_button_visible = { fg = "#ABB2BF", bg = "#21252B" },
					close_button_selected = { fg = "#DCDCDC", bg = "#282C34" },

					buffer_visible = { fg = "#ABB2BF", bg = "#21252B" },
					buffer_selected = { fg = "#DCDCDC", bg = "#282C34", bold = true, italic = false },

					numbers_visible = { fg = "#ABB2BF", bg = "#21252B" },
					numbers_selected = { fg = "#DCDCDC", bg = "#282C34", bold = true, italic = false },

					modified = { bg = "#21252B" },
					modified_visible = { fg = "#E2B86B", bg = "#21252B" },
					modified_selected = { fg = "#E2B86B", bg = "#282C34" },

					separator = { fg = "#181A1F", bg = "#21252B" },
					separator_visible = { fg = "#181A1F", bg = "#21252B" },
					separator_selected = { fg = "#181A1F", bg = "#282C34" },

					indicator_selected = { fg = "#61AFEF", bg = nil, sp = nil },

					offset_separator = { fg = "#ABB2BF", bg = "#ABB2BF", sp = "#ABB2BF" },
				},
			})
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Lualine                                │
	--   │                                                                      │
	--   │             https://github.com/nvim-lualine/lualine.nvim             │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{

		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			local icons = require("config.utility").icons

			local custom_onedark = require("lualine.themes.onedark")
			custom_onedark.inactive.c.bg = "#22262e"
			custom_onedark.normal.c.bg = "#22262e"
			-- custom_onedark.normal.c.fg = "#6B7078"
			custom_onedark.terminal.a.bg = "#81A1C1"

			local colors = {
				BACK_GROUND = "#1E222A",
				FONT_GROUND = "#ABB2BF",
				BLOCK_BG = "#22262e",
				BLOCK_FG = "#6f737b",
				BLOCK_BG_1 = "#2D3139",

				RED_001 = "#E06C75",
				YEL_001 = "#E7C787",
				CYN_001 = "#98C379",
				BLU_001 = "#61AFEF",
			}

			local AsyncRunStatus = require("lualine.component"):extend()

			function AsyncRunStatus:init(options)
				AsyncRunStatus.super.init(self, options)
			end

			function AsyncRunStatus:update_status()
				local async_status = vim.g.asyncrun_status
				local async_status_old = ""

				if async_status == "running" then
					async_status = "   RUNNING "
				elseif async_status == "success" then
					async_status = "   SUCCESS "
				elseif async_status == "failure" then
					async_status = "  FAILURE "
				elseif async_status == "stopped" then
					async_status = ""
				end

				if async_status ~= async_status_old then
					async_status_old = async_status
				end

				return async_status
			end

			---------------------------------------------------------------------------------

			local empty = require("lualine.component"):extend()

			function empty:draw(default_highlight)
				self.status = ""
				self.applied_separator = ""
				self:apply_highlights(default_highlight)
				self:apply_section_separators()
				return self.status
			end

			-- Put proper separators and gaps between components in sections
			local function process_sections(sections)
				for name, section in pairs(sections) do
					local left = name:sub(9, 10) < "x"
					for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
						table.insert(
							section,
							pos * 2,
							{ empty, color = { fg = colors.BACK_GROUND, bg = colors.BACK_GROUND } }
						)
					end
					for id, comp in ipairs(section) do
						if type(comp) ~= "table" then
							comp = { comp }
							section[id] = comp
						end
						comp.separator = left and { right = "" } or { left = "" }
					end
				end
				return sections
			end

			local function toggleterm_statusline()
				return "TERMINAL [" .. vim.b.toggle_number .. "]"
				-- return "TERMINAL"
			end

			local toggleterm = {
				sections = process_sections({
					lualine_a = {
						{
							toggleterm_statusline,
							color = { fg = colors.BACK_GROUND, bg = nil, gui = "bold" },
						},
					},
					lualine_b = { { "FugitiveHead", icons_enabled = true, icon = "   " } },
				}),

				inactive_sections = process_sections({
					lualine_a = {
						{
							toggleterm_statusline,
							color = { fg = colors.BLOCK_FG, bg = colors.BLOCK_BG_1, gui = "bold" },
						},
					},
					lualine_b = { { "FugitiveHead", icons_enabled = true, icon = "   " } },
				}),
				filetypes = { "toggleterm" },
			}

			local options = {

				options = {

					icons_enabled = true,
					theme = custom_onedark,

					component_separators = {},
					section_separators = { left = "", right = "" },
					-- component_separators = { left = '', right = ''},
					-- section_separators = { left = '', right = ''},

					disabled_filetypes = {
						statusline = { "lazy", "alpha" },
						winbar = { "lazy", "alpha" },
					},

					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,

					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},

				sections = process_sections({

					lualine_a = {

						{
							"mode",
							icon = " ",
							separator = nil,
							cond = nil,
							color = { fg = colors.BACK_GROUND, bg = nil, gui = "bold" },
							padding = { left = 1, right = 2 },
							fmt = nil,
							on_click = nil,
						},

						-- {
						--     'buffers',
						--     show_filename_only = true,   -- Shows shortened relative path when set to false.
						--     hide_filename_extension = false,   -- Hide filename extension when set to true.
						--     show_modified_status = true, -- Shows indicator when the buffer is modified.

						--     mode = 0, -- 0: Shows buffer name
						--     -- 1: Shows buffer index
						--     -- 2: Shows buffer name + buffer index
						--     -- 3: Shows buffer number
						--     -- 4: Shows buffer name + buffer number

						--     max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
						--     -- it can also be a function that returns
						--     -- the value of `max_length` dynamically.
						--     filetype_names = {
						--         TelescopePrompt = 'Telescope',
						--         dashboard = 'Dashboard',
						--         packer = 'Packer',
						--         fzf = 'FZF',
						--         alpha = 'Alpha'
						--     }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

						--     buffers_color = {
						--         -- Same values as the general color option can be used here.
						--         -- active = 'lualine_{section}_normal',     -- Color for active buffer.
						--         -- inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
						--     },

						--     symbols = {
						--         modified = ' ●',      -- Text to show when the buffer is modified
						--         alternate_file = '#', -- Text to show to identify the alternate file
						--         directory =  '',     -- Text to show when the buffer is a directory
						--     }
						-- }
					},

					lualine_b = {

						{
							"filename",
							padding = 2,
							file_status = true,
							newfile_status = false,
							color = { fg = colors.FONT_GROUND, bg = colors.BLOCK_BG_1 },
							path = 4,
							shorting_target = 40,
							symbols = {
								readonly = " 󰌾 ",
								modified = " · ",
								-- unnamed = " 󰑕 ",
								-- newfile = "  ",
							},
							fmt = function(str)
								if str == "" then
									return nil
								end
								local ft = vim.bo.filetype
								local nwd = require("nvim-web-devicons")
								local icon = nwd.get_icon_by_filetype(ft) or ""
								return icon .. "  " .. str
							end,
						},
					},

					lualine_c = {

						{
							"branch",
							icon = "   ",
							colored = true,
							color = { fg = colors.BLOCK_FG, bg = colors.BLOCK_BG },
						},

						{
							"diff",
							colored = false,
							-- diff_color = {
							--     added    = 'DiffAdd',
							--     modified = 'DiffChange',
							--     removed  = 'DiffDelete',
							-- },
							-- symbols = { added = "   ", modified = "   ", removed = "   " },
							-- symbols = { added = "   ", modified = "   ", removed = "   " },
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							source = nil,
							color = { fg = colors.BLOCK_FG, bg = colors.BLOCK_BG },
						},

						{
							"%R",
							cond = function()
								return vim.o.readonly
							end,
							color = { fg = colors.RED_001, bg = colors.BLOCK_BG_1 },
						},

						{
							AsyncRunStatus,
							color = { fg = colors.RED_001, bg = colors.BLOCK_BG_1 },
						},
						-- "diagnostics"
					},

					lualine_x = {

						{
							"diagnostics",
							-- sources = nil,
							padding = 2,
							sources = { "nvim_diagnostic", "coc" },
							sections = { "error", "warn", "info", "hint" },
							diagnostics_color = {
								-- Same values as the general color option can be used here.
								error = { fg = colors.RED_001, bg = colors.BLOCK_BG }, -- Changes diagnostics' error color.
								warn = { fg = colors.YEL_001, bg = colors.BLOCK_BG }, -- Changes diagnostics' warn color.
								info = { fg = colors.CYN_001, bg = colors.BLOCK_BG }, -- Changes diagnostics' info color.
								hint = { fg = colors.BLU_001, bg = colors.BLOCK_BG }, -- Changes diagnostics' hint color.
							},
							symbols = {
								error = " " .. icons.diagnostics.Error .. " ",
								warn = " " .. icons.diagnostics.Warn .. " ",
								info = " " .. icons.diagnostics.Info .. " ",
								hint = " " .. icons.diagnostics.Hint .. " ",
							},
							-- symbols = { error = "   ", warn = "   ", hint = "  ", info = "   " },
							colored = true, -- Displays diagnostics status in color if set to true.
							update_in_insert = false, -- Update diagnostics in insert mode.
							always_visible = false, -- Show diagnostics even if there are none.
							color = { fg = colors.BLOCK_BG, bg = colors.BLOCK_BG },
						},
					},

					lualine_y = {

						{
							"fileformat",
							padding = 2,
							symbols = {
								unix = "", -- e712
								dos = "", -- e70f
								mac = "", -- e711
							},
							colored = true, -- Displays diagnostics status in color if set to true.
							color = { fg = colors.FONT_GROUND, bg = colors.BLOCK_BG_1 },
						},

						{
							"filetype",
							colored = false,
							fmt = function(str)
								return "" .. str
							end,
							icons_enabled = false,
							padding = 2,
							icon_only = false,
							icon = { align = "left" },
							color = { fg = colors.FONT_GROUND, bg = colors.BLOCK_BG_1 },
						},
						{
							"encoding",
							colored = true, -- Displays diagnostics status in color if set to true.
							color = { fg = colors.FONT_GROUND, bg = colors.BLOCK_BG_1 },
							fmt = function(str)
								return "" .. string.upper(str)
							end,
						},
					},

					lualine_z = {
						{
							"location",
						},
						{
							"progress",
							icons_enabled = true,
							fmt = function()
								local cur = vim.fn.line(".")
								local total = vim.fn.line("$")
								local text = string.format("%2d%%%%", math.floor(cur / total * 100))
								text = (cur == 1 and "Top") or text
								text = (cur == total and "Bot") or text
								return text
							end,
							icon = "",
						},
					},
				}),

				inactive_sections = process_sections({

					lualine_a = {
						{
							"mode",
							colored = true,
							padding = { left = 1, right = 2 },
							icon = " ",
							-- source = nil,
							color = { fg = "#606B70", bg = "#2d3139" },
						},
					},

					lualine_b = {
						{
							"filename",
							padding = 2,
							file_status = true,
							newfile_status = false,
							-- color = { fg = colors.FONT_GROUND, bg = colors.BLOCK_BG_1 },
							path = 4,
							shorting_target = 40,
							symbols = {
								readonly = " 󰌾 ",
								modified = " · ",
								-- unnamed = " 󰑕 ",
								-- newfile = "  ",
							},
							fmt = function(str)
								if str == "" then
									return nil
								end
								local ft = vim.bo.filetype
								local nwd = require("nvim-web-devicons")
								local icon = nwd.get_icon_by_filetype(ft) or ""
								return icon .. "  " .. str
							end,
						},
					},

					lualine_c = {
						{
							"branch",
							icon = "   ",
							colored = true,
							-- source = nil,
							color = { fg = "#606B70", bg = colors.BLOCK_BG_1 },
							-- color = { fg = colors.BLOCK_BG_1, bg = colors.RED_001 }30363f
						},
					},

					lualine_x = {},
					lualine_y = {},
					lualine_z = {

						{
							"location",
							colored = true,
							color = { fg = nil, bg = "#30363f" },
						},
					},
				}),

				tabline = {},

				winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},

				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},

				extensions = { "quickfix", "neo-tree", "fugitive", "symbols-outline", "aerial", toggleterm },
			}

			require("lualine").setup(options)
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                                Noice                                 │
	--   │                                                                      │
	--   │                 https://github.com/folke/noice.nvim                  │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				enabled = true, -- enables the Noice cmdline UI

				view = "cmdline_popup",
				opts = {}, -- global options for the cmdline. See section on views

				format = {
					-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
					-- view: (default is cmdline view)
					-- opts: any options passed to the view
					-- icon_hl_group: optional hl_group for the icon
					-- title: set to anything or empty string to hide
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "[HELP]: " },
					input = {}, -- Used by input()
					-- lua = false, -- to disable a format, set to `false`
				},
			},
			messages = {
				-- NOTE: If you enable messages, then the cmdline is enabled automatically.
				-- This is a current Neovim limitation.
				enabled = true, -- enables the Noice messages UI
				view = "notify", -- default view for messages
				view_error = "notify", -- view for errors
				view_warn = "notify", -- view for warnings
				view_history = "messages", -- view for :messages
				view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
			},
			popupmenu = {
				enabled = true, -- enables the Noice popupmenu UI
				---@type 'nui'|'cmp'
				backend = "nui", -- backend to use to show regular cmdline completions

				-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
				kind_icons = {}, -- set to `false` to disable icons
			},
			-- default options for require('noice').redirect
			-- see the section on Command Redirection

			redirect = {
				view = "popup",
				filter = { event = "msg_show" },
			},
			-- You can add any custom commands below that will be available with `:Noice command`

			commands = {
				history = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {
						any = {
							{ event = "notify" },
							{ error = true },
							{ warning = true },
							{ event = "msg_show", kind = { "" } },
							{ event = "lsp", kind = "message" },
						},
					},
				},
				-- :Noice last
				last = {
					view = "popup",
					opts = { enter = true, format = "details" },
					filter = {
						any = {
							{ event = "notify" },
							{ error = true },
							{ warning = true },
							{ event = "msg_show", kind = { "" } },
							{ event = "lsp", kind = "message" },
						},
					},
					filter_opts = { count = 1 },
				},
				-- :Noice errors
				errors = {
					-- options for the message history that you get with `:Noice`
					view = "popup",
					opts = { enter = true, format = "details" },
					filter = { error = true },
					filter_opts = { reverse = true },
				},
			},
			notify = {
				-- Noice can be used as `vim.notify` so you can route any notification like other messages
				-- Notification messages have their level and other properties set.
				-- event is always "notify" and kind can be any log level as a string
				-- The default routes will forward notifications to nvim-notify
				-- Benefit of using Noice for this is the routing and consistent history view
				enabled = true,
				view = "notify",
			},
			lsp = {
				progress = {
					enabled = false,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					throttle = 1000 / 30, -- frequency to update lsp progress message
					view = "mini",
				},
				override = {
					-- override the default lsp markdown formatter with Noice
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					-- override the lsp markdown formatter with Noice
					["vim.lsp.util.stylize_markdown"] = false,
					-- override cmp documentation with Noice (needs the other options to work)
					["cmp.entry.get_documentation"] = false,
				},
				hover = {
					enabled = false,
					view = nil, -- when nil, use defaults from documentation
					opts = {}, -- merged with defaults from documentation
				},
				signature = {
					enabled = false,
					auto_open = {
						enabled = true,
						trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
						luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
						throttle = 50, -- Debounce lsp signature help request by 50ms
					},
					view = nil, -- when nil, use defaults from documentation
					opts = {}, -- merged with defaults from documentation
				},
				message = {
					-- Messages shown by lsp servers
					enabled = true,
					view = "notify",
					opts = {},
				},
				-- defaults for hover and signature help
				documentation = {
					view = "hover",
					opts = {
						lang = "markdown",
						replace = true,
						render = "plain",
						format = { "{message}" },
						win_options = { concealcursor = "n", conceallevel = 3 },
					},
				},
			},
			markdown = {
				-- hover = {
				-- 	["|(%S-)|"] = vim.cmd.help, -- vim help links
				-- 	["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
				-- },
				highlights = {
					["|%S-|"] = "@text.reference",
					["@%S+"] = "@parameter",
					["^%s*(Parameters:)"] = "@text.title",
					["^%s*(Return:)"] = "@text.title",
					["^%s*(See also:)"] = "@text.title",
					["{%S-}"] = "@parameter",
				},
			},
			health = {
				checker = true, -- Disable if you don't want health checks to run
			},
			smart_move = {
				-- noice tries to move out of the way of existing floating windows.
				enabled = true, -- you can disable this behaviour here
				-- add any filetypes here, that shouldn't trigger smart move.
				excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
			},

			presets = {
				-- you can enable a preset by setting it to true, or a table that will override the preset config
				-- you can also add custom presets that you can enable/disable with enabled=true
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = false, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},

			throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
			views = {

				cmdline_popup = {
					position = {
						row = "50%",
						col = "50%",
					},
					size = {
						width = 120,
						height = "auto",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = "65%",
						col = "50%",
					},
					size = {
						width = 120,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Noice_Normal", FloatBorder = "Noice_DiagnosticInfo" },
					},
				},
			}, ---@see section on views
			routes = {
				{
					filter = { event = "msg_show", kind = "search_count" },
					opts = { skip = true },
				},
				{
					view = "messages",
					filter = { event = "msg_show", min_height = 20 },
				},
				-- {
				-- 	filter = {
				-- 		event = "msg_show",
				-- 		kind = "confirm",
				-- 	},
				-- 	opts = { skip = true },
				-- },
			}, --- @see section on routes
			status = {}, --- @see section on statusline components
			format = {}, --- @see section on formatting
		},
		keys = {
			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>snl",
				function()
					require("noice").cmd("last")
				end,
				desc = "Noice Last Message",
			},
			{
				"<leader>snh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<leader>sna",
				function()
					require("noice").cmd("all")
				end,
				desc = "Noice All",
			},
			{
				"<c-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll forward",
				mode = { "i", "n", "s" },
			},
			{
				"<c-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true,
				expr = true,
				desc = "Scroll backward",
				mode = { "i", "n", "s" },
			},
		},
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                                Notify                                │
	--   │                                                                      │
	--   │               https://github.com/rcarriga/nvim-notify                │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
		init = function()
			-- when noice is not enabled, install notify on VeryLazy
			local Util = require("config.utility")
			if not Util.has("noice.nvim") then
				Util.on_very_lazy(function()
					vim.notify = require("notify")
				end)
			end
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Dressing                               │
	--   │                                                                      │
	--   │              https://github.com/stevearc/dressing.nvim               │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                           Indent_Blankline                           │
	--   │                                                                      │
	--   │        https://github.com/lukas-reineke/indent-blankline.nvim        │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			indentLine_enabled = 1,
			char = "│",
			filetype_exclude = {
				"help",
				"lazy",
				"alpha",
				"noice",
				"mason",
				"aerial",
				"notify",
				"lspinfo",
				"terminal",
				"neo-tree",
				"dashboard",
				"toggleterm",
				"TelescopePrompt",
				"TelescopeResults",
			},

			buftype_exclude = { "terminal" },
			show_trailing_blankline_indent = false,
			show_first_indent_level = false,
			show_current_context = true,
			show_current_context_start = true,
			space_char_blankline = " ",
		},
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                                Alpha                                 │
	--   │                                                                      │
	--   │                https://github.com/goolord/alpha-nvim                 │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"goolord/alpha-nvim",
		branch = "main",
		event = "VimEnter",
		-- dependencies = { "nvim-lua/plenary.nvim" },
		opts = function()
			vim.api.nvim_set_hl(0, "alphatitle", { fg = "#81a1c1", bg = "#282c34" })
			vim.api.nvim_set_hl(0, "alphatitle_1", { fg = "#73b8f1", bg = "#282c34" })
			vim.api.nvim_set_hl(0, "alphatitle_2", { fg = "#282c34", bg = "#73b8f1" })
			local theme = require("alpha.themes.startify")
			local if_nil = vim.F.if_nil
			local fnamemodify = vim.fn.fnamemodify
			local filereadable = vim.fn.filereadable
			local plenary_path = require("plenary.path")

			local leader = "SPC"
			local function button(sc, txt, keybind, keybind_opts)
				local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

				local opts = {
					position = "center",
					shortcut = "[" .. sc .. "]",
					cursor = 50,
					width = 50,
					align_shortcut = "right",
					-- hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
					hl_shortcut = "alphatitle",
					shrink_margin = true,
				}
				if keybind then
					keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
					opts.keymap = { "n", sc_, keybind, keybind_opts }
				end

				local function on_press()
					local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
					vim.api.nvim_feedkeys(key, "t", false)
				end

				return {
					type = "button",
					val = txt,
					on_press = on_press,
					opts = opts,
				}
			end

			local nvim_web_devicons = {
				enabled = true,
				highlight = true,
			}

			local function get_extension(fn)
				local match = fn:match("^.+(%..+)$")
				local ext = ""
				if match ~= nil then
					ext = match:sub(2)
				end
				return ext
			end

			local function icon(fn)
				local nwd = require("nvim-web-devicons")
				local ext = get_extension(fn)
				return nwd.get_icon(fn, ext, { default = true })
			end

			local function file_button(fn, sc, short_fn, autocd)
				short_fn = if_nil(short_fn, fn)
				local ico_txt
				local fb_hl = {}
				if nvim_web_devicons.enabled then
					local ico, hl = icon(fn)
					local hl_option_type = type(nvim_web_devicons.highlight)
					if hl_option_type == "boolean" then
						if hl and nvim_web_devicons.highlight then
							table.insert(fb_hl, { hl, 0, #ico })
						end
					end
					if hl_option_type == "string" then
						table.insert(fb_hl, { nvim_web_devicons.highlight, 0, #ico })
					end
					ico_txt = ico .. "  "
				else
					ico_txt = ""
				end
				local cd_cmd = (autocd and " | cd %:p:h" or "")
				local file_button_el = button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. cd_cmd .. " <CR>")
				local fn_start = short_fn:match(".*[/\\]")
				if fn_start ~= nil then
					table.insert(fb_hl, { "Comment", #ico_txt, #fn_start + #ico_txt })
				end
				file_button_el.opts.hl = fb_hl
				return file_button_el
			end

			local default_mru_ignore = { "gitcommit" }

			local mru_opts = {
				ignore = function(path, ext)
					return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
				end,
				autocd = false,
			}
			--- @param start number
			--- @param cwd string? optional
			--- @param items_number number? optional number of items to generate, default = 10
			local function mru(start, cwd, items_number, opts)
				opts = opts or mru_opts
				items_number = if_nil(items_number, 9)
				local oldfiles = {}
				for _, v in pairs(vim.v.oldfiles) do
					if #oldfiles == items_number then
						break
					end
					local cwd_cond
					if not cwd then
						cwd_cond = true
					else
						cwd_cond = vim.startswith(v, cwd)
					end
					local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
					if (filereadable(v) == 1) and cwd_cond and not ignore then
						oldfiles[#oldfiles + 1] = v
					end
				end

				local target_width = 35

				local tbl = {}
				for i, fn in ipairs(oldfiles) do
					local short_fn
					if cwd then
						short_fn = fnamemodify(fn, ":.")
					else
						short_fn = fnamemodify(fn, ":~")
					end

					if #short_fn > target_width then
						short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
						if #short_fn > target_width then
							short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
						end
					end

					local file_button_el = file_button(fn, tostring(i + start - 1), short_fn, opts.autocd)
					tbl[i] = file_button_el
				end
				return {
					type = "group",
					val = tbl,

					opts = {
						spacing = 1,
						position = "center",
					},
				}
			end
			-- Set header
			theme.header = {
				type = "text",
				val = {
					[[                                                                                  ]],
					[[  ███████╗ █████╗ ██████╗ ███████╗██████╗       ██████╗  █████╗ ███████╗██╗  ██╗  ]],
					[[  ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗      ██╔══██╗██╔══██╗██╔════╝██║  ██║  ]],
					[[  ███████╗███████║██████╔╝█████╗  ██████╔╝█████╗██║  ██║███████║███████╗███████║  ]],
					[[  ╚════██║██╔══██║██╔══██╗██╔══╝  ██╔══██╗╚════╝██║  ██║██╔══██║╚════██║██╔══██║  ]],
					[[  ███████║██║  ██║██████╔╝███████╗██║  ██║      ██████╔╝██║  ██║███████║██║  ██║  ]],
					[[  ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  ]],
					[[                                                                                  ]],
				},
				opts = {
					position = "center",
					hl = "alphatitle",
				},
			}
			theme.nvim_web_devicons.enabled = true
			theme.nvim_web_devicons.highlight = true
			theme.nvim_web_devicons.highlight = "@function"

			theme.mru = {
				type = "group",
				val = {
					{
						type = "text",
						val = " Recent Files ",
						opts = {
							-- hl = "Comment",
							position = "center",
							-- hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
							hl = {
								{ "alphatitle_1", 1, -1 },
								{ "alphatitle_2", 3, 17 },
								{ "alphatitle_1", 1, 1 },
							},
						},
					},
					{ type = "padding", val = 0 },
					mru(1),
				},
				opts = {
					spacing = 1,
					width = 50,
					position = "center",
				},
			}

			theme.buttons = {
				type = "group",
				val = {
					{
						type = "text",
						val = " Quick Links ",
						opts = {
							hl = {
								{ "alphatitle_1", 1, -1 },
								{ "alphatitle_2", 3, 17 },
								{ "alphatitle_1", 1, 1 },
							},
							position = "center",
						},
					},
					{ type = "padding", val = 0 },
					button("e", "  New File", "<cmd>ene<CR>"),
					button("t", "  Find Text", "<cmd>Telescope live_grep initial_mode=insert previewer=true<CR>"),
					-- "<cmd>lua require'telescope.builtin'.find_files(({ previewer = true, winblend = 1 }))<cr>"
					button(
						"f",
						"  Find File",
						"<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>"
					),
					button(
						"p",
						"  Find Project",
						"<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown({}))<cr>"
					),
					button(
						"o",
						"  Recent File",
						"<cmd>lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"
					),
					button("m", "  Mason Plugins", "<cmd>Mason<CR>"),
					button("u", "  Update Plugins", "<cmd>Lazy sync<CR>"),
					button("q", "  Quit", "<cmd>Smartq<cr>"),
				},
				opts = {
					spacing = 1,
					position = "center",
				},
			}

			theme.footer = {
				type = "text",
				val = "",
				opts = {
					position = "center",
					hl = "alphatitle",
				},
			}

			theme.config = {
				layout = {
					{ type = "padding", val = 2 },
					theme.header,
					{ type = "padding", val = 3 },
					theme.mru,
					{ type = "padding", val = 2 },
					theme.buttons,
					{ type = "padding", val = 3 },
					theme.footer,
				},
				opts = {
					margin = 3,
					redraw_on_resize = false,
					align_shortcut = "left",
					setup = function()
						vim.api.nvim_create_autocmd("DirChanged", {
							pattern = "*",
							callback = function()
								require("alpha").redraw()
							end,
						})
					end,
				},
			}

			return theme
		end,

		config = function(_, theme)
			vim.api.nvim_create_user_command("Smartq", function()
				if vim.fn.bufloaded(0) == 1 then
					vim.api.nvim_command("bw")
				elseif vim.fn.bufloaded(0) < 1 then
					vim.api.nvim_command("quit")
				end
			end, { nargs = 0 })

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(theme.config)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					-- vim.cmd([[set laststatus=0 showtabline=0]])
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					theme.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                             Dashboard                                │
	--   │                                                                      │
	--   │              https://github.com/glepnir/dashboard-nvim               │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{

		"glepnir/dashboard-nvim",
		event = "User LazyVimStarted",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"akinsho/bufferline.nvim",
			"nvim-lualine/lualine.nvim",
		},

		config = function()
			local function banner()
				local version = " Driven By " .. vim.split(vim.api.nvim_command_output("version"), "\n")[2]
				local ret = {

					"",
					"████████╗        ██████╗   █████╗  ███████╗ ██╗  ██╗",
					"╚══██╔══╝        ██╔══██╗ ██╔══██╗ ██╔════╝ ██║  ██║",
					"   ██║    █████╗ ██║  ██║ ███████║ ███████╗ ███████║",
					"   ██║    ╚════╝ ██║  ██║ ██╔══██║ ╚════██║ ██╔══██║",
					"   ██║           ██████╔╝ ██║  ██║ ███████║ ██║  ██║",
					"   ╚═╝           ╚═════╝  ╚═╝  ╚═╝ ╚══════╝ ╚═╝  ╚═╝",
					"",
					"",
					"",
				}
				table.insert(ret, version)
				table.insert(ret, "")
				table.insert(ret, "")
				return ret
			end
			local header = banner()

			-- generate footer info
			local lazy_stats = require("lazy").stats()
			local footer = {
				"",
				"",
				"",
				string.format("- Started in %.2fms", lazy_stats.startuptime)
					.. string.format(", With %s of %s Plugins loaded", lazy_stats.loaded, lazy_stats.count)
					.. string.format(" -"),
			}

			local function bufnumber()
				if vim.fn.bufloaded(0) == 1 then
					vim.api.nvim_command("bw")
				elseif vim.fn.bufloaded(0) < 1 then
					vim.api.nvim_command("quit")
				end
			end
			----------------------------------------------------------------------
			--                       config a hyper theme                       --
			----------------------------------------------------------------------

			local hyper = {

				theme = "hyper",
				shortcut_type = "number", --  shorcut type 'letter' or 'number'
				change_to_vcs_root = true,

				hide = {
					statusline = true, -- hide statusline default is true
					tabline = true, -- hide the tabline
					winbar = true, -- hide winbar
				},

				config = {
					disable_move = false,
					header = header,
					shortcut = {
						{
							icon = "  ",
							desc = "New ",
							key = "e",
							action = "enew",
							group = "Whitespace",
							icon_hl = "Normal",
							desc_hl = "Whitespace",
						},
						{
							icon = "  ",
							desc = "Update ",
							key = "u",
							action = "Lazy update",
							group = "Whitespace",
							icon_hl = "Normal",
							desc_hl = "Whitespace",
						},
						{
							icon = "  ",
							desc = "Mru ",
							key = "o",
							action = "lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({ previewer = false, winblend = 1 }))",
							group = "Whitespace",
							icon_hl = "Normal",
							desc_hl = "Whitespace",
						},
						{
							icon = "  ",
							desc = "Color ",
							key = "t",
							action = "lua require'telescope.builtin'.colorscheme(require('telescope.themes').get_dropdown({ previewer = false }))",
							group = "Whitespace",
							icon_hl = "Normal",
							desc_hl = "Whitespace",
						},
						{
							icon = "  ",
							desc = "Settings ",
							key = "v",
							action = ":e $MYVIMRC | cd %:p:h",
							group = "Whitespace",
							icon_hl = "Normal",
							desc_hl = "Whitespace",
						},
						{
							icon = "  ",
							desc = "Quit ",
							key = "<LocalLeader>q",
							action = bufnumber,
							group = "Whitespace",
							icon_hl = "Normal",
							desc_hl = "Whitespace",
						},
					},

					week_header = {
						enable = false,
					},

					packages = { enable = false }, -- show how many plugins neovim loaded

					mru = {
						icon = "MRU",
						limit = 9,
						label = "",
						-- label = "Recently Files"
					},

					project = {
						enable = false,
						icon = "",
						limit = 6,
						label = "",
						-- label = "Recently Projects",
						action = "Telescope find_files cwd=",
						-- action = "Telescope projects",
					},

					footer = footer,
				},
			}

			require("dashboard").setup(hyper)

			if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
				require("dashboard"):instance()
			end
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                              Devicons                                │
	--   │                                                                      │
	--   │            https://github.com/nvim-tree/nvim-web-devicons            │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{

		"nvim-tree/nvim-web-devicons",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("nvim-web-devicons").setup({
				-- your personnal icons can go here (to override)
				-- you can specify color or cterm_color instead of specifying both of them
				-- DevIcon will be appended to `name`
				override = {
					default_icon = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Default",
					},
				},
				-- globally enable different highlight colors per icon (default to true)
				-- if set to false all icons will have the default icon's color
				color_icons = true,
				-- globally enable default icons (default to false)
				-- will get overriden by `get_icons` option
				default = true,
				-- globally enable "strict" selection of icons - icon will be looked up in
				-- different tables, first by filename, and if not found by extension; this
				-- prevents cases when file doesn't have any extension but still gets some icon
				-- because its name happened to match some extension (default to false)
				strict = false,
				-- same as `override` but specifically for overrides by filename
				-- takes effect when `strict` is true
				override_by_filename = {

					[".babelrc"] = {
						icon = "ﬥ",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Babelrc",
					},
					[".bash_profile"] = {
						icon = "",
						color = "#89e051",
						cterm_color = "113",
						name = "BashProfile",
					},
					[".bashrc"] = {
						icon = "",
						color = "#89e051",
						cterm_color = "113",
						name = "Bashrc",
					},
					[".DS_Store"] = {
						icon = "",
						color = "#41535b",
						cterm_color = "59",
						name = "DsStore",
					},
					-- [".gitattributes"] = {
					--     icon = "",
					--     color = "#41535b",
					--     cterm_color = "59",
					--     name = "GitAttributes",
					-- },
					-- [".gitconfig"] = {
					--     icon = "",
					--     color = "#41535b",
					--     cterm_color = "59",
					--     name = "GitConfig",
					-- },
					-- [".gitignore"] = {
					--     icon = "",
					--     color = "#41535b",
					--     cterm_color = "59",
					--     name = "GitIgnore",
					-- },
					-- [".gitlab-ci.yml"] = {
					--     icon = "",
					--     color = "#e24329",
					--     cterm_color = "166",
					--     name = "GitlabCI",
					-- },
					-- [".gitmodules"] = {
					--     icon = "",
					--     color = "#41535b",
					--     cterm_color = "59",
					--     name = "GitModules",
					-- },
					[".gvimrc"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "Gvimrc",
					},
					[".npmignore"] = {
						icon = "",
						color = "#E8274B",
						cterm_color = "161",
						name = "NPMIgnore",
					},
					[".npmrc"] = {
						icon = "",
						color = "#E8274B",
						cterm_color = "161",
						name = "NPMrc",
					},
					[".settings.json"] = {
						icon = "",
						color = "#854CC7",
						cterm_color = "98",
						name = "SettingsJson",
					},
					[".vimrc"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "Vimrc",
					},
					[".zprofile"] = {
						icon = "",
						color = "#89e051",
						cterm_color = "113",
						name = "Zshprofile",
					},
					[".zshenv"] = {
						icon = "",
						color = "#89e051",
						cterm_color = "113",
						name = "Zshenv",
					},
					[".zshrc"] = {
						icon = "",
						color = "#89e051",
						cterm_color = "113",
						name = "Zshrc",
					},
					["Brewfile"] = {
						icon = "",
						color = "#701516",
						cterm_color = "52",
						name = "Brewfile",
					},
					["CMakeLists.txt"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "CMakeLists",
					},
					["COMMIT_EDITMSG"] = {
						icon = "",
						color = "#41535b",
						cterm_color = "59",
						name = "GitCommit",
					},
					["Containerfile"] = {
						icon = "󰡨",
						color = "#458ee6",
						cterm_color = "33",
						name = "Dockerfile",
					},
					["COPYING"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "License",
					},
					["COPYING.LESSER"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "License",
					},
					["Dockerfile"] = {
						icon = "󰡨",
						color = "#458ee6",
						cterm_color = "33",
						name = "Dockerfile",
					},
					["docker-compose.yml"] = {
						icon = "󰡨",
						color = "#458ee6",
						cterm_color = "33",
						name = "Dockerfile",
					},
					["docker-compose.yaml"] = {
						icon = "󰡨",
						color = "#458ee6",
						cterm_color = "33",
						name = "Dockerfile",
					},
					[".dockerignore"] = {
						icon = "󰡨",
						color = "#458ee6",
						cterm_color = "33",
						name = "Dockerfile",
					},
					["Gemfile$"] = {
						icon = "",
						color = "#701516",
						cterm_color = "52",
						name = "Gemfile",
					},
					["LICENSE"] = {
						icon = "",
						color = "#d0bf41",
						cterm_color = "179",
						name = "License",
					},
					["R"] = {
						icon = "ﳒ",
						color = "#358a5b",
						cterm_color = "65",
						name = "R",
					},
					["Rmd"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Rmd",
					},
					["Vagrantfile$"] = {
						icon = "",
						color = "#1563FF",
						cterm_color = "27",
						name = "Vagrantfile",
					},
					["_gvimrc"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "Gvimrc",
					},
					["_vimrc"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "Vimrc",
					},
					["package.json"] = {
						icon = "",
						color = "#e8274b",
						name = "PackageJson",
					},
					["package-lock.json"] = {
						icon = "",
						color = "#7a0d21",
						name = "PackageLockJson",
					},
					["node_modules"] = {
						icon = "",
						color = "#E8274B",
						cterm_color = "161",
						name = "NodeModules",
					},
					["favicon.ico"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Favicon",
					},
					["GNUmakefile"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Makefile",
					},
					["Makefile"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Makefile",
					},
					["makefile"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Makefile",
					},
					["mix.lock"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "MixLock",
					},
					[".env"] = {
						icon = "",
						color = "#faf743",
						cterm_color = "226",
						name = "Env",
					},
					["gruntfile"] = {
						icon = "",
						color = "#e37933",
						cterm_color = "173",
						name = "Gruntfile",
					},
					["gulpfile"] = {
						icon = "",
						color = "#cc3e44",
						cterm_color = "167",
						name = "Gulpfile",
					},
					["webpack"] = {
						icon = "ﰩ",
						color = "#519aba",
						cterm_color = "67",
						name = "Webpack",
					},
					["rakefile"] = {
						icon = "",
						color = "#701516",
						cterm_color = "52",
						name = "Rakefile",
					},
					["Procfile"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Procfile",
					},
					["dockerfile"] = {
						icon = "󰡨",
						color = "#458ee6",
						cterm_color = "33",
						name = "Dockerfile",
					},
				},

				override_by_extension = {

					["ai"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Ai",
					},
					["awk"] = {
						icon = "",
						color = "#4d5a5e",
						cterm_color = "59",
						name = "Awk",
					},
					["bash"] = {
						icon = "",
						color = "#89e051",
						cterm_color = "113",
						name = "Bash",
					},
					["bat"] = {
						icon = "",
						color = "#C1F12E",
						cterm_color = "154",
						name = "Bat",
					},
					["bmp"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Bmp",
					},
					["c"] = {
						icon = "",
						color = "#599eff",
						cterm_color = "75",
						name = "C",
					},
					["c++"] = {
						icon = "",
						color = "#f34b7d",
						cterm_color = "204",
						name = "CPlusPlus",
					},
					["cbl"] = {
						icon = "⚙",
						color = "#005ca5",
						cterm_color = "25",
						name = "Cobol",
					},
					["cc"] = {
						icon = "",
						color = "#f34b7d",
						cterm_color = "204",
						name = "CPlusPlus",
					},
					["cfg"] = {
						icon = "",
						color = "#ECECEC",
						cterm_color = "231",
						name = "Configuration",
					},
					["clj"] = {
						icon = "",
						color = "#8dc149",
						cterm_color = "107",
						name = "Clojure",
					},
					["cljc"] = {
						icon = "",
						color = "#8dc149",
						cterm_color = "107",
						name = "ClojureC",
					},
					["cljs"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "ClojureJS",
					},
					["cljd"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "ClojureDart",
					},
					["cmake"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "CMake",
					},
					["cob"] = {
						icon = "⚙",
						color = "#005ca5",
						cterm_color = "25",
						name = "Cobol",
					},
					["cobol"] = {
						icon = "⚙",
						color = "#005ca5",
						cterm_color = "25",
						name = "Cobol",
					},
					["coffee"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Coffee",
					},
					["conf"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Conf",
					},
					["config.ru"] = {
						icon = "",
						color = "#701516",
						cterm_color = "52",
						name = "ConfigRu",
					},
					["cp"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Cp",
					},
					["cpp"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Cpp",
					},
					["cpy"] = {
						icon = "⚙",
						color = "#005ca5",
						cterm_color = "25",
						name = "Cobol",
					},
					["cr"] = {
						icon = "",
						color = "#000000",
						cterm_color = "16",
						name = "Crystal",
					},
					["cs"] = {
						icon = "",
						color = "#596706",
						cterm_color = "58",
						name = "Cs",
					},
					["csh"] = {
						icon = "",
						color = "#4d5a5e",
						cterm_color = "59",
						name = "Csh",
					},
					["cson"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Cson",
					},
					["css"] = {
						icon = "",
						color = "#42a5f5",
						cterm_color = "39",
						name = "Css",
					},
					["csv"] = {
						icon = "",
						color = "#89e051",
						cterm_color = "113",
						name = "Csv",
					},
					["cxx"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Cxx",
					},
					["d"] = {
						icon = "",
						color = "#427819",
						cterm_color = "64",
						name = "D",
					},
					["dart"] = {
						icon = "",
						color = "#03589C",
						cterm_color = "25",
						name = "Dart",
					},
					["db"] = {
						icon = "",
						color = "#dad8d8",
						cterm_color = "188",
						name = "Db",
					},
					["desktop"] = {
						icon = "",
						color = "#563d7c",
						cterm_color = "60",
						name = "DesktopEntry",
					},
					["diff"] = {
						icon = "",
						color = "#41535b",
						cterm_color = "59",
						name = "Diff",
					},
					["doc"] = {
						icon = "",
						color = "#185abd",
						cterm_color = "25",
						name = "Doc",
					},
					["drl"] = {
						icon = "",
						color = "#ffafaf",
						cterm_color = "217",
						name = "Drools",
					},
					["dropbox"] = {
						icon = "",
						color = "#0061FE",
						cterm_color = "27",
						name = "Dropbox",
					},
					["dump"] = {
						icon = "",
						color = "#dad8d8",
						cterm_color = "188",
						name = "Dump",
					},
					["edn"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Edn",
					},
					["eex"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Eex",
					},
					["ejs"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Ejs",
					},
					["elm"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Elm",
					},
					["epp"] = {
						icon = "",
						color = "#FFA61A",
						name = "Epp",
					},
					["erb"] = {
						icon = "",
						color = "#701516",
						cterm_color = "52",
						name = "Erb",
					},
					["erl"] = {
						icon = "",
						color = "#B83998",
						cterm_color = "132",
						name = "Erl",
					},
					["ex"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Ex",
					},
					["exs"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Exs",
					},
					["f#"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Fsharp",
					},
					["fnl"] = {
						color = "#fff3d7",
						icon = "🌜",
						cterm_color = "230",
						name = "Fennel",
					},
					["fish"] = {
						icon = "",
						color = "#4d5a5e",
						cterm_color = "59",
						name = "Fish",
					},
					["fs"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Fs",
					},
					["fsi"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Fsi",
					},
					["fsscript"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Fsscript",
					},
					["fsx"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Fsx",
					},
					["gd"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "GDScript",
					},
					["gemspec"] = {
						icon = "",
						color = "#701516",
						cterm_color = "52",
						name = "Gemspec",
					},
					["gif"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Gif",
					},
					["git"] = {
						icon = "",
						color = "#61afef",
						cterm_color = "202",
						name = "GitLogo",
					},
					["glb"] = {
						icon = "",
						color = "#FFB13B",
						cterm_color = "215",
						name = "BinaryGLTF",
					},
					["go"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Go",
					},
					["godot"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "GodotProject",
					},
					["graphql"] = {
						icon = "",
						color = "#e535ab",
						cterm_color = "199",
						name = "GraphQL",
					},
					["gql"] = {
						icon = "",
						color = "#e535ab",
						cterm_color = "199",
						name = "GraphQL",
					},
					["h"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "H",
					},
					["haml"] = {
						icon = "",
						color = "#eaeae1",
						cterm_color = "188",
						name = "Haml",
					},
					["hbs"] = {
						icon = "",
						color = "#f0772b",
						cterm_color = "208",
						name = "Hbs",
					},
					["heex"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Heex",
					},
					["hh"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Hh",
					},
					["hpp"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Hpp",
					},
					["hrl"] = {
						icon = "",
						color = "#B83998",
						cterm_color = "132",
						name = "Hrl",
					},
					["hs"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Hs",
					},
					["htm"] = {
						icon = "",
						color = "#e34c26",
						cterm_color = "166",
						name = "Htm",
					},
					["html"] = {
						icon = "",
						color = "#e44d26",
						cterm_color = "202",
						name = "Html",
					},
					["hxx"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Hxx",
					},
					["ico"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Ico",
					},
					["import"] = {
						icon = "",
						color = "#ECECEC",
						cterm_color = "231",
						name = "ImportConfiguration",
					},
					["ini"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Ini",
					},
					["java"] = {
						icon = "",
						color = "#cc3e44",
						cterm_color = "167",
						name = "Java",
					},
					["jl"] = {
						icon = "",
						color = "#a270ba",
						cterm_color = "133",
						name = "Jl",
					},
					["jpeg"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Jpeg",
					},
					["jpg"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Jpg",
					},
					["js"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Js",
					},
					["test.js"] = {
						icon = "",
						color = "#e37933",
						cterm_color = "173",
						name = "TestJs",
					},
					["json"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Json",
					},
					["json5"] = {
						icon = "ﬥ",
						color = "#cbcb41",
						cterm_color = "185",
						name = "Json5",
					},
					["jsx"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Jsx",
					},
					["ksh"] = {
						icon = "",
						color = "#4d5a5e",
						cterm_color = "59",
						name = "Ksh",
					},
					["kt"] = {
						icon = "",
						color = "#7F52FF",
						cterm_color = "99",
						name = "Kotlin",
					},
					["kts"] = {
						icon = "",
						color = "#7F52FF",
						cterm_color = "99",
						name = "KotlinScript",
					},
					["leex"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Leex",
					},
					["less"] = {
						icon = "",
						color = "#563d7c",
						cterm_color = "60",
						name = "Less",
					},
					["lhs"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Lhs",
					},
					["license"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "License",
					},
					["lua"] = {
						icon = "",
						color = "#51a0cf",
						cterm_color = "74",
						name = "Lua",
					},
					["luau"] = {
						icon = "",
						color = "#51a0cf",
						cterm_color = "74",
						name = "Luau",
					},
					["GNUmakefile"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Makefile",
					},
					["Makefile"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Makefile",
					},
					["makefile"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Makefile",
					},
					["mk"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Makefile",
					},
					["markdown"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Markdown",
					},
					["material"] = {
						icon = "",
						color = "#B83998",
						cterm_color = "132",
						name = "Material",
					},
					["md"] = {
						icon = "",
						color = "#d19667",
						name = "Markdown",
					},
					["mdx"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Mdx",
					},
					["mint"] = {
						icon = "",
						color = "#87c095",
						cterm_color = "108",
						name = "Mint",
					},
					["mjs"] = {
						icon = "",
						color = "#f1e05a",
						cterm_color = "221",
						name = "Mjs",
					},
					["ml"] = {
						icon = "λ",
						color = "#e37933",
						cterm_color = "173",
						name = "Ml",
					},
					["mli"] = {
						icon = "λ",
						color = "#e37933",
						cterm_color = "173",
						name = "Mli",
					},
					["mo"] = {
						icon = "∞",
						color = "#9772FB",
						cterm_color = "99",
						name = "Motoko",
					},
					["mustache"] = {
						icon = "",
						color = "#e37933",
						cterm_color = "173",
						name = "Mustache",
					},
					["nim"] = {
						icon = "👑",
						color = "#f3d400",
						cterm_color = "220",
						name = "Nim",
					},
					["nix"] = {
						icon = "",
						color = "#7ebae4",
						cterm_color = "110",
						name = "Nix",
					},
					["opus"] = {
						icon = "",
						color = "#F88A02",
						cterm_color = "208",
						name = "OPUS",
					},
					["otf"] = {
						icon = "",
						color = "#ECECEC",
						cterm_color = "231",
						name = "OpenTypeFont",
					},
					["pck"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "PackedResource",
					},
					["pdf"] = {
						icon = "",
						color = "#b30b00",
						cterm_color = "124",
						name = "Pdf",
					},
					["php"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Php",
					},
					["pl"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Pl",
					},
					["pm"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Pm",
					},
					["png"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Png",
					},
					["pp"] = {
						icon = "",
						color = "#FFA61A",
						name = "Pp",
					},
					["ppt"] = {
						icon = "",
						color = "#cb4a32",
						cterm_color = "167",
						name = "Ppt",
					},
					["pro"] = {
						icon = "",
						color = "#e4b854",
						cterm_color = "179",
						name = "Prolog",
					},
					["ps1"] = {
						icon = "󰨊",
						color = "#4273ca",
						cterm_color = "69",
						name = "PsScriptfile",
					},
					["psd1"] = {
						icon = "󰨊",
						color = "#6975c4",
						cterm_color = "105",
						name = "PsManifestfile",
					},
					["psm1"] = {
						icon = "󰨊",
						color = "#6975c4",
						cterm_color = "105",
						name = "PsScriptModulefile",
					},
					["psb"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Psb",
					},
					["psd"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Psd",
					},
					["py"] = {
						icon = "",
						color = "#ffbc03",
						cterm_color = "61",
						name = "Py",
					},
					["pyc"] = {
						icon = "",
						color = "#ffe291",
						cterm_color = "67",
						name = "Pyc",
					},
					["pyd"] = {
						icon = "",
						color = "#ffe291",
						cterm_color = "67",
						name = "Pyd",
					},
					["pyo"] = {
						icon = "",
						color = "#ffe291",
						cterm_color = "67",
						name = "Pyo",
					},
					["query"] = {
						icon = "",
						color = "#90a850",
						cterm_color = "154",
						name = "Query",
					},
					["r"] = {
						icon = "ﳒ",
						color = "#358a5b",
						cterm_color = "65",
						name = "R",
					},
					["rake"] = {
						icon = "",
						color = "#701516",
						cterm_color = "52",
						name = "Rake",
					},
					["rb"] = {
						icon = "",
						color = "#701516",
						cterm_color = "52",
						name = "Rb",
					},
					["rlib"] = {
						icon = "",
						color = "#dea584",
						cterm_color = "180",
						name = "Rlib",
					},
					["rmd"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Rmd",
					},
					["rproj"] = {
						icon = "鉶",
						color = "#358a5b",
						cterm_color = "65",
						name = "Rproj",
					},
					["rs"] = {
						icon = "",
						color = "#dea584",
						cterm_color = "180",
						name = "Rs",
					},
					["rss"] = {
						icon = "",
						color = "#FB9D3B",
						cterm_color = "215",
						name = "Rss",
					},
					["sass"] = {
						icon = "",
						color = "#f55385",
						cterm_color = "204",
						name = "Sass",
					},
					["sbt"] = {
						icon = "",
						color = "#cc3e44",
						cterm_color = "167",
						name = "sbt",
					},
					["scala"] = {
						icon = "",
						color = "#cc3e44",
						cterm_color = "167",
						name = "Scala",
					},
					["scm"] = {
						icon = "ﬦ",
						color = "#000000",
						cterm_color = "16",
						name = "Scheme",
					},
					["scss"] = {
						icon = "",
						color = "#f55385",
						cterm_color = "204",
						name = "Scss",
					},
					["sh"] = {
						icon = "",
						color = "#4d5a5e",
						cterm_color = "59",
						name = "Sh",
					},
					["sig"] = {
						icon = "λ",
						color = "#e37933",
						cterm_color = "173",
						name = "Sig",
					},
					["slim"] = {
						icon = "",
						color = "#e34c26",
						cterm_color = "166",
						name = "Slim",
					},
					["sln"] = {
						icon = "",
						color = "#854CC7",
						cterm_color = "98",
						name = "Sln",
					},
					["sml"] = {
						icon = "λ",
						color = "#e37933",
						cterm_color = "173",
						name = "Sml",
					},
					["sql"] = {
						icon = "",
						color = "#dad8d8",
						cterm_color = "188",
						name = "Sql",
					},
					["sqlite"] = {
						icon = "",
						color = "#dad8d8",
						cterm_color = "188",
						name = "Sql",
					},
					["sqlite3"] = {
						icon = "",
						color = "#dad8d8",
						cterm_color = "188",
						name = "Sql",
					},
					["styl"] = {
						icon = "",
						color = "#8dc149",
						cterm_color = "107",
						name = "Styl",
					},
					["sublime"] = {
						icon = "",
						color = "#e37933",
						cterm_color = "98",
						name = "Suo",
					},
					["suo"] = {
						icon = "",
						color = "#854CC7",
						cterm_color = "98",
						name = "Suo",
					},
					["sv"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "SystemVerilog",
					},
					["svelte"] = {
						icon = "",
						color = "#ff3e00",
						cterm_color = "202",
						name = "Svelte",
					},
					["svh"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "SystemVerilog",
					},
					["svg"] = {
						icon = "ﰟ",
						color = "#FFB13B",
						cterm_color = "215",
						name = "Svg",
					},
					["swift"] = {
						icon = "",
						color = "#e37933",
						cterm_color = "173",
						name = "Swift",
					},
					["t"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Tor",
					},
					["tbc"] = {
						icon = "﯑",
						color = "#1e5cb3",
						cterm_color = "67",
						name = "Tcl",
					},
					["tcl"] = {
						icon = "﯑",
						color = "#1e5cb3",
						cterm_color = "67",
						name = "Tcl",
					},
					["terminal"] = {
						icon = "",
						color = "#31B53E",
						cterm_color = "71",
						name = "Terminal",
					},
					["tex"] = {
						icon = "ﭨ",
						color = "#3D6117",
						cterm_color = "58",
						name = "Tex",
					},
					["tf"] = {
						icon = "",
						color = "#5F43E9",
						cterm_color = "57",
						name = "Terraform",
					},
					["tfvars"] = {
						icon = "",
						color = "#5F43E9",
						cterm_color = "57",
						name = "TFVars",
					},
					["toml"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Toml",
					},
					["tres"] = {
						icon = "",
						color = "#cbcb41",
						cterm_color = "185",
						name = "TextResource",
					},
					["ts"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Ts",
					},
					["tscn"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "TextScene",
					},
					["tsx"] = {
						icon = "",
						color = "#519aba",
						cterm_color = "67",
						name = "Tsx",
					},
					["twig"] = {
						icon = "",
						color = "#8dc149",
						cterm_color = "107",
						name = "Twig",
					},
					["txt"] = {
						icon = "",
						color = "#89e051",
						cterm_color = "113",
						name = "Txt",
					},
					["v"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "Verilog",
					},
					["vala"] = {
						icon = "",
						color = "#7239b3",
						cterm_color = "5",
						name = "Vala",
					},
					["vh"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "Verilog",
					},
					["vhd"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "VHDL",
					},
					["vhdl"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "VHDL",
					},
					["vim"] = {
						icon = "",
						color = "#019833",
						cterm_color = "29",
						name = "Vim",
					},
					["vue"] = {
						icon = "﵂",
						color = "#8dc149",
						cterm_color = "107",
						name = "Vue",
					},
					["webmanifest"] = {
						icon = "",
						color = "#f1e05a",
						cterm_color = "221",
						name = "Webmanifest",
					},
					["webp"] = {
						icon = "",
						color = "#a074c4",
						cterm_color = "140",
						name = "Webp",
					},
					["webpack"] = {
						icon = "ﰩ",
						color = "#519aba",
						cterm_color = "67",
						name = "Webpack",
					},
					["xcplayground"] = {
						icon = "",
						color = "#e37933",
						cterm_color = "173",
						name = "XcPlayground",
					},
					["xls"] = {
						icon = "",
						color = "#207245",
						cterm_color = "23",
						name = "Xls",
					},
					["xml"] = {
						icon = "謹",
						color = "#e37933",
						cterm_color = "173",
						name = "Xml",
					},
					["xul"] = {
						icon = "",
						color = "#e37933",
						cterm_color = "173",
						name = "Xul",
					},
					["yaml"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Yaml",
					},
					["yml"] = {
						icon = "",
						color = "#6d8086",
						cterm_color = "66",
						name = "Yml",
					},
					["zig"] = {
						icon = "",
						color = "#f69a1b",
						cterm_color = "208",
						name = "Zig",
					},
					["zsh"] = {
						icon = "",
						color = "#89e051",
						cterm_color = "113",
						name = "Zsh",
					},
					["sol"] = {
						icon = "ﲹ",
						color = "#519aba",
						cterm_color = "67",
						name = "Solidity",
					},
					["prisma"] = {
						icon = "卑",
						color = "#ffffff",
						cterm_color = "white",
						name = "Prisma",
					},
					["lock"] = {
						icon = "",
						color = "#bbbbbb",
						cterm_color = "250",
						name = "Lock",
					},
					["log"] = {
						icon = "",
						color = "#ffffff",
						cterm_color = "white",
						name = "Log",
					},
					["wasm"] = {
						icon = "",
						color = "#5c4cdb",
						cterm_color = "99",
						name = "Wasm",
					},
				},
			})
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                 Nui                                  │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{ "MunifTanjim/nui.nvim", lazy = true },

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                              inc_rename                              │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"smjonas/inc-rename.nvim",
		config = true,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Zen_Mode                               │
	--   │                                                                      │
	--   │                https://github.com/folke/zen-mode.nvim                │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
					-- height and width can be:
					-- * an absolute number of cells when > 1
					-- * a percentage of the width / height of the editor when <= 1
					-- * a function that returns the width or the height
					width = 120, -- width of the Zen window
					height = 1, -- height of the Zen window
					-- by default, no options are changed for the Zen window
					-- uncomment any of the options below, or add other vim.wo options you want to apply
					options = {
						-- signcolumn = "no", -- disable signcolumn
						-- number = false, -- disable number column
						-- relativenumber = false, -- disable relative numbers
						-- cursorline = false, -- disable cursorline
						-- cursorcolumn = false, -- disable cursor column
						-- foldcolumn = "0", -- disable fold column
						-- list = false, -- disable whitespace characters
					},
				},
				plugins = {
					-- disable some global vim options (vim.o...)
					-- comment the lines to not apply the options
					options = {
						enabled = true,
						ruler = false, -- disables the ruler text in the cmd line area
						showcmd = false, -- disables the command in the last line of the screen
					},
					twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
					gitsigns = { enabled = false }, -- disables git signs
					tmux = { enabled = false }, -- disables the tmux statusline
					-- this will change the font size on kitty when in zen mode
					-- to make this work, you need to set the following kitty options:
					-- - allow_remote_control socket-only
					-- - listen_on unix:/tmp/kitty
					kitty = {
						enabled = false,
						font = "+4", -- font size increment
					},
					-- this will change the font size on alacritty when in zen mode
					-- requires  Alacritty Version 0.10.0 or higher
					-- uses `alacritty msg` subcommand to change font size
					alacritty = {
						enabled = false,
						font = "14", -- font size
					},
				},
				-- callback where you can add custom code when the Zen window opens
				on_open = function(win) end,
				-- callback where you can add custom code when the Zen window closes
				on_close = function() end,
			})
		end,
	},
}
