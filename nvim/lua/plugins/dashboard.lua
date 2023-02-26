return {
    
    "glepnir/dashboard-nvim",
    event = "User LazyVimStarted",
    dependencies = { 
        {
            'nvim-tree/nvim-web-devicons',
            "akinsho/bufferline.nvim",
            "nvim-lualine/lualine.nvim",
        }
    },
    config = function()

        local function banner()
            local version = " driven by " .. vim.split(vim.api.nvim_command_output("version"), "\n")[2]
            local ret = {
                "",
                "   ██████╗ ████████╗███████╗████████╗██████╗ ███████╗ █████╗ ███╗   ███╗",
                "   ██╔══██╗╚══██╔══╝██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗████╗ ████║",
                "   ██████╔╝   ██║   ███████╗   ██║   ██████╔╝█████╗  ███████║██╔████╔██║",
                "   ██╔══██╗   ██║   ╚════██║   ██║   ██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║",
                "   ██████╔╝   ██║   ███████║   ██║   ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║",
                "   ╚═════╝    ╚═╝   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝",
                "",
            }
            table.insert(ret, version)
            table.insert(ret, "")
            return ret
        end
        local header = banner()

        -- generate footer info
        local lazy_stats = require("lazy").stats()
        local footer = {
            "",
            string.format("🚀 started in %.2fms", lazy_stats.startuptime)
                .. string.format(", with %s of %s plugins loaded", lazy_stats.loaded, lazy_stats.count),
        }

        ----------------------------------------------------------------------
        --                       config a hyper theme                       --
        ----------------------------------------------------------------------
        local hyper = {
            theme = "hyper",

            hide = {
                statusline = true, -- hide statusline default is true
                tabline = true, -- hide the tabline
                winbar = true, -- hide winbar
            },

            disable_move = true,   --  defualt is false disable move keymap for hyper
            shortcut_type = "number",  --  shorcut type 'letter' or 'number'

            config = {
                header = header,
                shortcut = {
                    {
                        icon = '  ',
                        desc = 'New',
                        key = 'e',
                        action = 'enew',
                        group = "@property",
                        icon_hl = 'Statement',
                        desc_hl = 'Statement',
                    },
                    {
                        icon = '  ',
                        desc = " Update",
                        key = "u",
                        action = "Lazy update",
                        group = "@property",
                        icon_hl = 'Statement',
                        desc_hl = 'Statement',
                    },
                    {
                        icon = '  ',
                        desc = " Files",
                        key = "f",
                        action = "Telescope find_files",
                        group = "Label",
                        icon_hl = 'Statement',
                        desc_hl = 'Statement',
                    },
                    {
                        desc = " Colors",
                        group = "DashboardActionColors",
                        action = "Telescope colorscheme",
                        key = "t",
                    },
                    {
                        icon = '  ',
                        desc = "Apps",
                        key = "a",
                        action = "Telescope app",
                        group = "DiagnosticHint",
                        icon_hl = 'Statement',
                        desc_hl = 'Statement',
                    },
                    {
                        icon = '  ',
                        desc = "Settings",
                        key = "v",
                        action = ":e $MYVIMRC | cd %:p:h",
                        group = "Number",
                        icon_hl = 'Statement',
                        desc_hl = 'Statement',
                    },
                    {
                        icon = '  ',
                        desc = "Quit",
                        key = "q",
                        action = "q!",
                        group = "@macro",
                        icon_hl = 'Statement',
                        desc_hl = 'Statement',
                    },
                },

                packages = { enable = false }, -- show how many plugins neovim loaded

                project = {
                    icon = "",
                    limit = 6,
                    label = "Recently Projects",
                    action = "Telescope find_files cwd=",
                },

                mru = { 
                    icon = "",
                    limit = 9, 
                    label = "Recently Files" 
                },

                footer = footer,
            },
        }

        require("dashboard").setup(hyper)

        if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
            require("dashboard"):instance()
        end
    end,
}
























-- return {

--     'glepnir/dashboard-nvim',

--     event = 'VimEnter',
--     dependencies = { 
--         {
--             'nvim-tree/nvim-web-devicons',
--             "nvim-lualine/lualine.nvim",
--             "akinsho/bufferline.nvim"
--         }
--     },

--     config = function()
--         require('dashboard').setup {
--             theme = 'hyper' ,--  theme is doom and hyper default is hyper
--             disable_move = true,   --  defualt is false disable move keymap for hyper
--             shortcut_type = "number",  --  shorcut type 'letter' or 'number'
--             config = {
--                 header = {}, -- type is table def
--                 week_header = {
--                     enable = true,  --boolean use a week header
--                     -- concat='2',  --concat string after time string line
--                     -- append='3',  --table append after time string line
--                 },
--                 shortcut = {
--                     {
--                         icon = '  ',
--                         desc = 'New File',
--                         key = 'e',
--                         action = 'enew',
--                         group = "@property",
--                         icon_hl = 'Statement',
--                         desc_hl = 'Statement',
--                     },
--                     {
--                         icon = '  ',
--                         desc = " Update",
--                         key = "u",
--                         action = "Lazy update",
--                         group = "@property",
--                         icon_hl = 'Statement',
--                         desc_hl = 'Statement',
--                     },
--                     {
--                         icon = '  ',
--                         desc = " Files",
--                         key = "f",
--                         action = "Telescope find_files",
--                         group = "Label",
--                         icon_hl = 'Statement',
--                         desc_hl = 'Statement',
--                     },
--                     {
--                         icon = '  ',
--                         desc = "Apps",
--                         key = "a",
--                         action = "Telescope app",
--                         group = "DiagnosticHint",
--                         icon_hl = 'Statement',
--                         desc_hl = 'Statement',
--                     },
--                     {
--                         icon = '  ',
--                         desc = "Settings",
--                         key = "v",
--                         action = ":e $MYVIMRC | cd %:p:h",
--                         group = "Number",
--                         icon_hl = 'Statement',
--                         desc_hl = 'Statement',
--                     },
--                     {
--                         icon = '  ',
--                         desc = "Quit",
--                         key = "q",
--                         action = "q!",
--                         group = "@macro",
--                         icon_hl = 'Statement',
--                         desc_hl = 'Statement',
--                     },
--                 },
--                 packages = { enable = true }, -- show how many plugins neovim loaded
--                 -- limit how many projects list, action when you press key or enter it will run this action.
--                 -- action can be a functino type, e.g.
--                 -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
--                 project = { enable = true, limit = 8, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
--                 mru = { limit = 10, icon = 'your icon', label = '', },
--                 footer = {}, -- footer
--             },    --  config used for theme
--             hide = {
--                 statusline = true,   -- hide statusline default is true
--                 tabline  = true,      -- hide the tabline
--                 winbar  = true,       -- hide winbar
--             },
--             preview = {
--                 --   command       -- preview command
--                 --   file_path     -- preview file path
--                 --   file_height   -- preview file height
--                 --   file_width    -- preview file width
--             },
--         }
--     end,
-- }
