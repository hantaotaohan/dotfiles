return {
    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
    },

    {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        version = false, -- last release is way too old
        event = "InsertEnter",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/nvim-cmp",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local luasnip = require("luasnip")
            local function border(hl_name)
                return {
                    { "╭", hl_name },
                    { "─", hl_name },
                    { "╮", hl_name },
                    { "│", hl_name },
                    { "╯", hl_name },
                    { "─", hl_name },
                    { "╰", hl_name },
                    { "│", hl_name },
                }
            end
            local cmp = require("cmp")

            local ELLIPSIS_CHAR = "…"
            local MAX_LABEL_WIDTH = 60

            local get_ws = function(max, len)
                return (" "):rep(max - len)
            end

            return {
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = {
                        -- border = "rounded",
                        winhighlight = "Normal:CmpPmenu,CursorLine:CmpPmenuSel,Search:None",
                        border = border("CmpBorder"),
                        col_offset = -3,
                        side_padding = 0,
                        scrollbar = false,
                    },
                    documentation = {
                        -- border = "rounded",
                        winhighlight = "Normal:CmpPmenu,CursorLine:CmpPmenuSel,Search:None",
                        border = border("CmpDocBorder"),
                        max_width = 60,
                        scrollbar = false,
                    },
                },
                mapping = cmp.mapping.preset.insert({

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                            -- they way you will only jump inside the snippet region
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<C-k>"] = cmp.mapping({
                        c = function(fallback)
                            if cmp.visible() then
                                return cmp.select_prev_item()
                            end

                            fallback()
                        end,
                    }),

                    ["<C-j>"] = cmp.mapping({
                        c = function(fallback)
                            if cmp.visible() then
                                return cmp.select_next_item()
                            end

                            fallback()
                        end,
                    }),

                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    -- fields = { "abbr" },
                    format = function(_, item)
                        local content = item.abbr
                        local icons = require("config.utility").icons.kinds

                        if #content > MAX_LABEL_WIDTH then
                            item.abbr = vim.fn.strcharpart(content, 10, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
                        else
                            item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
                        end

                        if icons[item.kind] then
                            item.kind = icons[item.kind] .. " " .. item.kind
                        end
                        return item
                    end,
                },
                experimental = {
                    ghost_text = {
                        hl_group = "LspCodeLens",
                    },
                },
                -- Set configuration for specific filetype.
                cmp.setup.filetype("gitcommit", {
                    sources = cmp.config.sources({
                        { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
                    }, {
                        { name = "buffer" },
                    }),
                }),

                -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline({ "/", "?" }, {
                    formatting = {
                        format = function(_, vim_item)
                            vim_item.menu = ""
                            vim_item.kind = ""
                            return vim_item
                        end,
                    },
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = "buffer" },
                    },
                }),

                -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
                cmp.setup.cmdline(":", {
                    formatting = {
                        format = function(_, vim_item)
                            vim_item.menu = ""
                            vim_item.kind = ""
                            return vim_item
                        end,
                    },
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = "path" },
                    }, {
                        { name = "cmdline" },
                    }),
                }),
            }
        end,
    },

    { 
        "smjonas/inc-rename.nvim"
    },

    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require('Comment').setup({

                ---Add a space b/w comment and the line
                ---@type boolean|fun():boolean
                padding = true,

                ---Whether the cursor should stay at its position
                ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
                ---@type boolean
                sticky = true,

                ---Lines to be ignored while comment/uncomment.
                ---Could be a regex string or a function that returns a regex string.
                ---Example: Use '^$' to ignore empty lines
                ---@type string|fun():string
                ignore = nil,

                ---LHS of toggle mappings in NORMAL + VISUAL mode
                ---@type table
                toggler = {
                    ---Line-comment toggle keymap
                    line = "gcc",
                    ---Block-comment toggle keymap
                    block = "gbc",
                },


                ---LHS of operator-pending mappings in NORMAL + VISUAL mode
                ---@type table
                opleader = {
                    ---Line-comment keymap
                    line = "gc",
                    ---Block-comment keymap
                    block = "gb",
                },


                ---LHS of extra mappings
                ---@type table
                extra = {
                    ---Add comment on the line above
                    above = "gcO",
                    ---Add comment on the line below
                    below = "gco",
                    ---Add comment at the end of line
                    eol = "gcA",
                },

                ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
                ---NOTE: If `mappings = false` then the plugin won't create any mappings
                ---@type boolean|table
                mappings = {
                    ---Operator-pending mapping
                    ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
                    ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
                    basic = true,
                    ---Extra mapping
                    ---Includes `gco`, `gcO`, `gcA`
                    extra = false,
                    ---Extended mapping
                    ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
                    extended = false,
                },

                ---Pre-hook, called before commenting the line
                pre_hook = nil,

                ---Post-hook, called after commenting is done
                post_hook = nil,

            })
        end

    },


}
