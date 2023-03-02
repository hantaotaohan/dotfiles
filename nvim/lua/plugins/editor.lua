return {

    {
        "windwp/nvim-spectre",
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
        opts = {
            color_devicons = true,

            open_cmd = 'leftabove vnew',
            live_update = false, -- auto excute search again when you write any file in vim
            line_sep_start = '┌─────────────────────────────────────────────',
            result_padding = '│ ',
            line_sep       = '└─────────────────────────────────────────────',

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

        }
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add          = {hl = 'GitSignsAdd'   , text = "▎", numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
                change       = {hl = 'GitSignsChange', text = "▎", numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                delete       = {hl = 'GitSignsDelete', text = "", numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                topdelete    = {hl = 'GitSignsDelete', text = "", numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
                changedelete = {hl = 'GitSignsChange', text = "▎", numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
                untracked    = {hl = 'GitSignsChange', text = "▎", numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
            },

            signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`

            watch_gitdir = {
                interval = 1000,
                follow_files = true
            },

            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`

            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },

            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)

            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },

            yadm = {
                enable = false
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

    {
        "anuvyklack/pretty-fold.nvim",
        event = "VeryLazy",
        opts = {

            keep_indentation = false,
            remove_fold_markers = true,
            process_comment_signs = false,
            fill_char = '━',

            sections = {

                left = {
                    '', function() return string.rep(' FOLDED ' , vim.v.foldlevel) end, ' ██ ', 'content', '██  '
                },

                right = {
                    '  ██  ', 'number_of_folded_lines', ': ', 'percentage', '   ',
                }

            },

            matchup_patterns = {

                { '^%s*do$', 'end' }, -- do ... end blocks
                { '^%s*if', 'end' },  -- if ... end
                { '^%s*for', 'end' }, -- for
                { 'function%s*%(', 'end' }, -- 'function( or 'function (''
                {  '{', '}' },
                { '%(', ')' }, -- % to escape lua pattern char
                { '%[', ']' }, -- % to escape lua pattern char

            },
        }
    },

    {
        'akinsho/toggleterm.nvim', 
        event = "VeryLazy",
        version = "*",
        opts = {
            shade_terminals = false,
            shading_factor = 1,
            start_in_insert = true,
        }
    },

    {
        "simrat39/symbols-outline.nvim",
        event = "VeryLazy",
        opts = {

            highlight_hovered_item = true,
            show_guides = true,
            auto_preview = false,
            position = 'right',
            relative_width = true,
            border = 'single',
            width = 25,
            auto_close = true,
            show_numbers = false,
            show_relative_numbers = false,
            show_symbol_details = true,
            preview_bg_highlight = 'Pmenu',
            autofold_depth = nil,
            auto_unfold_hover = true,
            fold_markers = { '', '' },
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
            fold_reset = "R",},

            lsp_blacklist = {},
            symbol_blacklist = {},

        }

    },
}

