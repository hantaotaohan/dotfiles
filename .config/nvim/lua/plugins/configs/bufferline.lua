local present, bufferline = pcall(require, "bufferline")

if not present then
    return
end

local options = {

    options = {

        numbers = "ordinal", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
        close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
        -- NOTE: this plugin is designed with this icon in mind,
        -- and so changing this is NOT recommended, this is intended
        -- as an escape hatch for people who cannot bear it for whatever reason

		indicator = {
			icon = '▋', -- this should be omitted if indicator style is not 'icon'
			style = 'icon' -- | 'underline' | 'none',
		},

        color_icons = false,
        buffer_close_icon = "✖ ",
        modified_icon = "⬥ ",
        close_icon = "",
		left_trunc_marker = '',
		right_trunc_marker = '',

        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        tab_size = 18,

        diagnostics = false, -- | "nvim_lsp" | "coc",
        diagnostics_update_in_insert = false,

        offsets = { { filetype = "NvimTree", text = "NvimTree", padding = 1, highlight = "BufferLineFill", text_align = "center"  }},

        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,

        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist

        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = { '', '' }, -- slant | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = true,
        always_show_bufferline = true,

    },

    highlights = {

        -- fill                  = { fg = '#606B70', bg = '#1E2227' },
        -- background            = { fg = '#606B70', bg = None },

        fill                  = {  bg = '#1E2227' },
        -- background            = {  bg = nil },

        -- close_button          = { fg = '#606B70', bg = '#1E2227' },
        -- close_button_visible  = { fg = '#606B70', bg = '#1E2227' },
        -- close_button_selected = { fg = '#DCDCDC', bg = '#23272E' },



        buffer_visible        = { fg = '#606B70', bg = '#1E2227' },
        buffer_selected       = { fg = '#DCDCDC', bg = '#23272E', bold = true, italic = false },

        numbers_visible       = { fg = '#606B70', bg = '#1E2227' },
        numbers_selected      = { fg = '#DCDCDC', bg = '#23272E', bold = true, italic = false },
        -- 
        --
        modified              = { fg = '#E2B86B'},
        modified_visible      = { fg = '#E2B86B', bg = '#1E2227' },
        modified_selected     = { fg = '#E2B86B', bg = '#23272E' },
        --
        --            separator             = { bg = '#23272E' },
        --            separator_visible     = { fg = '#606B70', bg = '#1E2227' },
        --            separator_selected    = { fg = '#DCDCDC', bg = '#23272E' },

        -- indicator_visible     = { fg = '#61AFEF', bg = '#1E2227' },
        indicator_selected    = { fg = '#61AFEF', bg = '#23272E' },

    },
}

bufferline.setup(options)
