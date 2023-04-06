--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                         PLUGINS: Bufferline                          │
--   │                                                                      │
--   │              https://github.com/akinsho/bufferline.nvim              │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"akinsho/bufferline.nvim",
	lazy = true,
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
}
