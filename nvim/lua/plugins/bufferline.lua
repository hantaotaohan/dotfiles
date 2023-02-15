return {

    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
        { "<Leader>]", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    },
    opts = {
        options = {
            mode = "buffers",                                                  -- | "buffers" | "tabs"      |
            numbers = "ordinal",                                               -- | "none"    | "ordinal"   | "buffer_id" | "both" |
            close_command = "bdelete! %d",                                     -- | string    | function    | see "Mouse actions   |
            right_mouse_command = "bdelete! %d",                               -- | string    | function    | see "Mouse actions   |
            left_mouse_command = "buffer %d",                                  -- | string    | function    | see "Mouse actions   |
            middle_mouse_command = nil,                                        -- | string    | function    | see "Mouse actions   |
            indicator = {
                icon = '▋',                                                    -- 图标指示器
                style = 'underline',                                           -- | 'icon'    | 'underline' | 'none' |
            },
            buffer_close_icon = '✖' ,
            modified_icon = '·',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            max_name_length = 18,
            max_prefix_length = 15,                                            -- 缓冲区重复数据消除时使用的前缀
            truncate_names = true,                                             -- 是否应截断选项卡名称
            tab_size = 18,
            diagnostics = false,                                               -- 诊断指示器 | false | "nvim_lsp" | "coc" |
            diagnostics_update_in_insert = false,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "("..count..")"
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    text_align = "center",                                     -- | "left" | "center" | "right" |
                    separator = true,
                    padding = 0, 
                    highlight = "BufferLineFill", 
                }
            },
            color_icons = true,                                                -- 是否添加文件类型图标突出显示
            show_buffer_icons = true,                                          -- 禁用缓冲区的文件类型图标
            show_buffer_close_icons = false,
            show_buffer_default_icon = true,                                   -- 未识别的文件类型是否应显示默认图标
            show_close_icon = true,
            show_tab_indicators = true,
            show_duplicate_prefix = true,                                      -- 是否显示重复的缓冲区前缀
            persist_buffer_sort = true,                                        -- 自定义排序缓冲区是否应持久
            separator_style = { '', '' },                                      -- | "slant" | "thick" | "thin" | { 'any', 'any' } |
            enforce_regular_tabs = false ,
            always_show_bufferline = true,
            hover = {
                enabled = true,
                delay = 200,
                reveal = {'close'}
            },
            sort_by ='insert_after_current',                                   -- | 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
            
            highlights = {

                fill                  = { fg = '#21252b', bg = '#21252b' },
                -- fill                  = { fg = '#606B70', bg = '#1E2227' },
                -- background            = { fg = '#606B70', bg = None },

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
        },
    },

}
