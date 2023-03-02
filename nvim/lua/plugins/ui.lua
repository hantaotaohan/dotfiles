return {

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
                "mason",
                "lspinfo",
                "terminal",
                "neo-tree",
                "dashboard",
                "TelescopePrompt",
                "TelescopeResults",
            },

            buftype_exclude = { "terminal" },
            show_trailing_blankline_indent = false,
            show_first_indent_level = false,
            show_current_context = true,
            show_current_context_start = true,
            space_char_blankline = " ",
        }
    },

    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     opts = {
    --         lsp = {
    --             override = {
    --                 ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                 ["vim.lsp.util.stylize_markdown"] = true,
    --                 ["cmp.entry.get_documentation"] = true,
    --             },
    --         },
    --         presets = {
    --             bottom_search = true,
    --             command_palette = true,
    --             long_message_to_split = true,
    --             inc_rename = false, -- enables an input dialog for inc-rename.nvim
    --             lsp_doc_border = false, -- add a border to hover docs and sign
    --         },
    --     },
    --     -- stylua: ignore
    --     keys = {
    --         { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    --         { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    --         { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    --         { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    --         { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    --         { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    --     },
    -- },
}

