return{

    "nvim-lualine/lualine.nvim",
    event = 'VeryLazy',
    config = function()

        local custom_onedark = require'lualine.themes.onedark'
        custom_onedark.inactive.c.bg = '#21252B'
        custom_onedark.normal.c.bg = '#21252B'
        custom_onedark.normal.c.fg = '#6F737B'

        local colors = {
            BLACK_0 = '#282C34',
            BLACK_1 = '#30363f',
            BLACK_2 = '#3E4452',
            RED_001 = '#E06c75',
        }

        local AsyncRunStatus = require('lualine.component'):extend()

        function AsyncRunStatus:init(options)
            AsyncRunStatus.super.init(self, options)
        end

        function AsyncRunStatus:update_status()
            cond = vim.g.async_status
            local async_status = vim.g.asyncrun_status
            local async_status_old = ""

            if async_status == "running" then
                async_status = "  RUNNING "
            elseif async_status == "success" then
                async_status = "  SUCCESS"
            elseif async_status == "failure" then
                async_status = "  "
            elseif async_status == "stopped" then
                async_status = ""
            end

            if  (async_status ~= async_status_old) then
                async_status_old = async_status
            end

            return async_status
        end

        ---------------------------------------------------------------------------------

        local empty = require('lualine.component'):extend()

        function empty:draw(default_highlight)
            self.status = ''
            self.applied_separator = ''
            self:apply_highlights(default_highlight)
            self:apply_section_separators()
            return self.status
        end

        -- Put proper separators and gaps between components in sections
        local function process_sections(sections)
            for name, section in pairs(sections) do
                local left = name:sub(9, 10) < 'x'
                for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
                    table.insert(section, pos * 2, { empty, color = { fg = colors.BLACK_0, bg = colors.BLACK_0 } })
                end
                for id, comp in ipairs(section) do
                    if type(comp) ~= 'table' then
                        comp = { comp }
                        section[id] = comp
                    end
                    comp.separator = left and { right = '' } or { left = '' }
                end
            end
            return sections
        end

        local function toggleterm_statusline()
            -- return "TERMINAL [" .. vim.b.toggle_number .. "]"
            return "TERMINAL"
        end

        local toggleterm = {
            sections = {
                lualine_a = { toggleterm_statusline },
                lualine_b = { {'FugitiveHead', icons_enabled = true, icon = '   ' } } },
                filetypes = { 'toggleterm' }
            }

        local options = {

            options = {

                icons_enabled = true,
                theme  = custom_onedark,

                component_separators = {},
                section_separators = { left = '', right = '' },
                -- component_separators = { left = '', right = ''},
                -- section_separators = { left = '', right = ''},

                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },

                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,

                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }

            },

            sections = process_sections {

                lualine_a = {

                    {
                        'mode',
                        icon = nil,
                        separator = nil,
                        cond = nil,
                        color = { fg = '#282C34', bg = nil, gui='bold' },
                        padding = 2,
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
                        'branch',
                        icon = '   '
                    },

                    {
                        'diff',
                        colored = true,
                        diff_color = {
                            added    = 'DiffAdd',
                            modified = 'DiffChange',
                            removed  = 'DiffDelete',
                        },
                        symbols = {added = '   ', modified = '   ', removed = '   '},
                        source = nil,
                        color = { fg = colors.BLACK_1, bg = colors.BLACK_1 }
                    },

                    {
                        '%R',
                        cond = function()
                            return vim.o.readonly
                        end,
                        color = { fg = colors.RED_001, bg = colors.BLACK_1 }
                    },

                    {
                        AsyncRunStatus,
                        color = { fg = colors.RED_001, bg = colors.BLACK_1 },
                    },
                    -- "diagnostics"
                },

                lualine_c = {

                    {
                        'filename',
                        file_status = true,
                        newfile_status = false,
                        path = 2,
                        shorting_target = 40,
                        symbols = {
                            modified = '  [+]',
                            readonly = 'READONLY',
                            unnamed = '[No Name]',
                            newfile = '[New]'
                        },
                    },
                },

                lualine_x = {

                    {
                        'encoding',
                    },

                    {
                        'fileformat', 
                        padding = 2,
                        symbols = {
                            unix = '', -- e712
                            dos = '',  -- e70f
                            mac = '',  -- e711
                        }
                    },

                    {
                        'filetype',
                        colored = false,
                        padding = 2,
                        icon_only = false,
                        icon = { align = 'left' },
                    }
                },

                lualine_z = {'location'},

                lualine_y = {
                    
                    {
                        "diagnostics",
                        sources = { 'nvim_diagnostic', 'coc' },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        diagnostics_color = {
                            -- Same values as the general color option can be used here.
                            error = 'DiagnosticError', -- Changes diagnostics' error color.
                            warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
                            info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
                            hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
                        },
                        symbols = { error = "  ", warn = "   ", hint = "  ", info = "  " },
                        colored = true, -- Displays diagnostics status in color if set to true.
                        update_in_insert = false, -- Update diagnostics in insert mode.
                        always_visible = false, -- Show diagnostics even if there are none.
                        color = { fg = colors.BLACK_2, bg = colors.BLACK_2 },
                    },

                    'progress'
                },
            },

            inactive_sections = process_sections {

                lualine_a = {

                    {
                        'mode',
                        colored = true,
                        padding = 2,
                        -- source = nil,
                        color = { fg = "#606B70", bg = colors.BLACK_1 }
                        -- color = { fg = colors.BLACK_1, bg = colors.RED_001 }
                    },
                },

                lualine_b = {

                    {
                        'branch',
                        icon = '   ',
                        colored = true,
                        -- source = nil,
                        color = { fg = "#606B70", bg = colors.BLACK_1 }
                        -- color = { fg = colors.BLACK_1, bg = colors.RED_001 }
                    },
                },

                lualine_c = {'filename'},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'location'},

            },

            tabline = {},

            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },

            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },

            extensions = { 'quickfix', 'neo-tree', 'fugitive', 'symbols-outline', toggleterm },

        }

        require "lualine".setup(options)

    end

}
