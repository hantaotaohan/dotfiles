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
            string.format("- Started in %.2fms", lazy_stats.startuptime)
                .. string.format(", With %s of %s Plugins loaded", lazy_stats.loaded, lazy_stats.count) .. string.format(" -"),
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
                        desc = 'New ',
                        key = 'e',
                        action = 'enew',
                        group = "Whitespace",
                        icon_hl = 'Normal',
                        desc_hl = 'Whitespace',
                    },
                    {
                        icon = '  ',
                        desc = "Update",
                        key = "u",
                        action = "Lazy update",
                        group = "Whitespace",
                        icon_hl = 'Normal',
                        desc_hl = 'Whitespace',
                    },
                    {
                        icon = '  ',
                        desc = "Files",
                        key = "f",
                        action = "Telescope find_files",
                        group = "Whitespace",
                        icon_hl = 'Normal',
                        desc_hl = 'Whitespace',
                    },
                    {
                        icon = '  ',
                        desc = "Colors",
                        key = "t",
                        action = "Telescope colorscheme",
                        group = "Whitespace",
                        icon_hl = 'Normal',
                        desc_hl = 'Whitespace',
                    },
                    {
                        icon = '  ',
                        desc = "Apps",
                        key = "a",
                        action = "Telescope app",
                        group = "Whitespace",
                        icon_hl = 'Normal',
                        desc_hl = 'Whitespace',
                    },
                    {
                        icon = '  ',
                        desc = "Settings",
                        key = "v",
                        action = ":e $MYVIMRC | cd %:p:h",
                        group = "Whitespace",
                        icon_hl = 'Normal',
                        desc_hl = 'Whitespace',
                    },
                    {
                        icon = '  ',
                        desc = "Quit",
                        key = "q",
                        action = "q!",
                        group = "Whitespace",
                        icon_hl = 'Normal',
                        desc_hl = 'Whitespace',
                    },
                },

                week_header = {
                    enable = false,
                },

                packages = { enable = false }, -- show how many plugins neovim loaded

                mru = { 
                    icon = "",
                    limit = 9, 
                    label = "" 
                    -- label = "Recently Files" 
                },

                project = {
                    icon = "",
                    limit = 6,
                    label = "",
                    -- label = "Recently Projects",
                    -- action = "Telescope find_files cwd=",
                    action = "Telescope projects",
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
