--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           PLUGINS: Lualine                           │
--   │                                                                      │
--   │             https://github.com/nvim-lualine/lualine.nvim             │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {

	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	-- lazy = true,
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
					statusline = { "alpha" },
					winbar = { "alpha" },
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
						cond = AsyncRunStatus,
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
}
