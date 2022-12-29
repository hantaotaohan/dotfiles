local M = {}

M.config = function()

    local present, alpha = pcall(require, "alpha")

    if not present then
        return
    end

    local function button(sc, txt, keybind)
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<Localleader>")
        local opts = {
            position = "center",
            text = txt,
            shortcut = sc,
            cursor = 5,
            width = 36,
            align_shortcut = "right",
            hl = "AlphaButtons",
        }

        if keybind then
            opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
        end

        return {
            type = "button",
            val = txt,
            on_press = function()
                local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
                vim.api.nvim_feedkeys(key, "normal", false)
            end,
            opts = opts,
        }
    end

    -- dynamic header padding
    local fn = vim.fn
    local marginTopPercent = 0.3
    local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

    local options = {

        header = {
            type = "text",
            val = {
                [[                                              ]],
                [[    _____                 _____               ]],
                [[   |_   _|_ _  ___       |_   _|_ _  ___      ]],
                [[     | |/ _` |/ _ \        | |/ _` |/ _ \     ]],
                [[     | | (_| | (_) |  _    | | (_| | (_) |    ]],
                [[     |_|\__,_|\___/  (_)   |_|\__,_|\___/     ]],
                [[                                              ]],
            },

            opts = {
                position = "center",
                hl = "AlphaHeader",
            },
        },

        buttons = {
            type = "group",

            val = {

                button("f", "  Find File  ", ":Telescope find_files<CR>"),
                button("o", "  Recent File  ", ":Telescope oldfiles<CR>"),
                button("w", "  Find Word  ", ":Telescope live_grep<CR>"),
                button("m", "  Bookmarks  ", ":Telescope marks<CR>"),
                button("h", "  Themes  ", ":ChangeColorScheme<CR>"),

                button("e", "  New File  ", ":ene <BAR> startinsert <CR><Esc>"),
                button("v", "  Nvim Init  ", ":e $MYVIMRC | :cd %:p:h <CR>"),
                button("q", "  Quit Nvim  ", ":qa<CR>"),

                -- button("SPC e e", "  New File  ", ":ene <BAR> startinsert <CR>"),
                -- button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
                -- button("SPC f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
                -- button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
                -- button("SPC b m", "  Bookmarks  ", ":Telescope marks<CR>"),
                -- button("SPC t h", "  Themes  ", ":Telescope themes<CR>"),
                -- button("SPC e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
                -- button("SPC q q", "  Quit Nvim  ", ":qa<CR>"),
            },

            opts = {
                spacing = 1,
            },
        },

        headerPaddingTop = { type = "padding", val = headerPadding },
        headerPaddingBottom = { type = "padding", val = 2 },
    }

    alpha.setup {
        layout = {
            options.headerPaddingTop,
            options.header,
            options.headerPaddingBottom,
            options.buttons,
        },
        opts = {position = "center"},
    }

end

return M

-- ╾────────────────────────────────────────────────────────────────────────╼

-- local M = {}
--
-- M.config = function()
--
--     local alpha = require "alpha"
--     local startify = require "alpha.themes.startify"
--
--     startify.section.header.val = {
--
--         [[                                              ]],
--         [[    _____                 _____               ]],
--         [[   |_   _|_ _  ___       |_   _|_ _  ___      ]],
--         [[     | |/ _` |/ _ \        | |/ _` |/ _ \     ]],
--         [[     | | (_| | (_) |  _    | | (_| | (_) |    ]],
--         [[     |_|\__,_|\___/  (_)   |_|\__,_|\___/     ]],
--         [[                                              ]],
--
--     }
--
--     startify.section.top_buttons.val = {
--
--         startify.button("e", "New file", ":enew<CR>"),
--
--         { type = "padding", val = 1 },
--
--         startify.button("f", "  Find File  ", ":Telescope find_files<CR>"),
--         startify.button("o", "  Recent File  ", ":Telescope oldfiles<CR>"),
--         startify.button("w", "  Find Word  ", ":Telescope live_grep<CR>"),
--         startify.button("m", "  Bookmarks  ", ":Telescope marks<CR>"),
--         startify.button("h", "  Themes  ", ":ChangeColorScheme<CR>"),
--
--         startify.button("e", "  New File  ", ":ene <BAR> startinsert <CR><Esc>"),
--         startify.button("v", "  Nvim Init  ", ":e $MYVIMRC | :cd %:p:h <CR>"),
--         startify.button("q", "  Quit Nvim  ", ":qa<CR>"),
--
--     }
--
--     startify.section.bottom_buttons.val = {
--         {type = "padding", val = 1},
--         {type = "text", val = " Recent Files", opts = { position = 'left', hl = "SpecialComment" } },
--         {type = "padding", val = 1},
--         {type = "group", val = function() return { startify.mru(1, false, 20) } end, opts = { position = 'right' } },
--         {type = "padding", val = 1},
--         startify.button("q", "Quit", ":quitall<CR>"),
--     }
--
--     startify.nvim_web_devicons.enabled = false
-- 	-- startify.nvim_web_devicons.highlight = false
-- 	-- startify.nvim_web_devicons.highlight = 'Keyword'
--
--     startify.opts = {
--
--         layout = {
--             { type = "padding", val = 2 },
--             startify.section.header,
--             { type = "padding", val = 2 },
--             -- startify.section.top_buttons,
--             startify.section.bottom_buttons,
--             -- startify.section.mru,
--             { type = "padding", val = 1 },
--         },
--
--         opts = {
--             margin = 10,
--             -- width = 50,
--             position = "center",
--         },
--
--     }
--
--     alpha.setup(require("alpha.themes.startify").opts)
--
-- end
--
-- return M
