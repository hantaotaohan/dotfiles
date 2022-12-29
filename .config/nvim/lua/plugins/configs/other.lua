local M = {}

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Input IMG Toggle                           │
--   │              https://github.com/keaising/im-select.nvim              │
--   ╰──────────────────────────────────────────────────────────────────────╯

-- M.imselect = function()
--
--     local present, im_select = pcall(require, "im_select")
--
--     if not present then
--         return
--     end
--
--     local options = {
--
--         -- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
--         -- For Windows, default: "1003", aka: English US Keyboard
--         -- You can use `im-select` in cli to get the IM name of you preferred
--         default_im_select  = "1033",
--
--         -- Set to 1 if you don't want restore IM status when `InsertEnter`
--         disable_auto_restore = 0,
--
--     }
--
--     im_select.setup(options)
--
-- end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Input IMG Toggle                           │
--   │              https://github.com/keaising/im-select.nvim              │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.asyncrun = function()

    vim.g.asyncrun_open = 6
    -- vim.g.asyncrun_status = "stopped"
    vim.g.asyncrun_status = ""
    vim.g.asyncrun_rootmarks = { "pom.xml", ".git", ".svn", ".root", ".project", ".hg" }

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                       Format Markdown Chinese                        │
--   │                  https://github.com/hotoo/pangu.vim                  │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.pangu = function()

    vim.g.pangu_rule_date = 1
    -- vim.cmd [[ autocmd BufLeave *.md if &ft == 'vimwiki.markdown' | PanguAll]]

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Auto Add Pairs                            │
--   │               https://github.com/windwp/nvim-autopairs               │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.autopairs = function()

    local present, autopairs = pcall(require, "nvim-autopairs")

    if not present then
        return
    end

    local options = {

        check_ts = true,

        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
        },

        disable_filetype = { "TelescopePrompt", "spectre_panel" },

        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },

    }

    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    local cmp_status_ok, cmp = pcall(require, "cmp")

    if not cmp_status_ok then
        return
    end

    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

    autopairs.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Indent Blankline                           │
--   │        https://github.com/lukas-reineke/indent-blankline.nvim        │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.blankline = function()

    local present, blankline = pcall(require, "indent_blankline")


    if not present then
        return
    end

    local options = {

        indentLine_enabled = 1,

        filetype_exclude = {
            "help",
            "terminal",
            "alpha",
            "packer",
            "lspinfo",
            "TelescopePrompt",
            "TelescopeResults",
            "mason",
            "",
        },

        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        show_current_context = true,
        show_current_context_start = true,
        space_char_blankline = " ",
    }

    vim.cmd[[ highlight IndentBlanklineContextStart guibg=#3E4452 gui=bold ]]

    blankline.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Colorizer Display                           │
--   │            https://github.com/norcalli/nvim-colorizer.lua            │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.colorizer = function()

    local present, colorizer = pcall(require, "colorizer")

    if not present then
        return
    end

    local options = {

        filetypes = {
            "*",
        },

        user_default_options = {
            RGB = true, -- #RGB hex codes
            RRGGBB = true, -- #RRGGBB hex codes
            names = false, -- "Name" codes like Blue
            RRGGBBAA = false, -- #RRGGBBAA hex codes
            rgb_fn = false, -- CSS rgb() and rgba() functions
            hsl_fn = false, -- CSS hsl() and hsla() functions
            css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
            css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
            mode = "background", -- Set the display mode.
        },

    }

    colorizer.setup(options)

    -- execute colorizer as soon as possible

    -- vim.defer_fn(function()
    --     require("colorizer").attach_to_buffer(0)
    -- end, 0)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Comment Plug                             │
--   │               https://github.com/numToStr/Comment.nvim               │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.comment = function()

    local present, comment = pcall(require, "Comment")

    if not present then
        return
    end

    local options = {

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

    }

    comment.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Comment-Box Plugin                          │
--   │           https://github.com/LudoPinelli/comment-box.nvim            │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.commentbox = function()

    local present, comment_box = pcall(require, "comment-box")

    if not present then
        return
    end

    local options = {
        doc_width = 80, -- width of the document
        box_width = 72, -- width of the boxes
        borders = { -- symbols used to draw a box
            top = "─",
            bottom = "─",
            left = "│",
            right = "│",
            top_left = "╭",
            top_right = "╮",
            bottom_left = "╰",
            bottom_rsight = "╯",
        },
        line_width = 74, -- width of the lines
        line = { -- symbols used to draw a line
            line = "─",
            line_start = "─",
            line_end = "─",
        },
        outer_blank_lines = true, -- insert a blank line above and below the box
        inner_blank_lines = false, -- insert a blank line above and below the text
        line_blank_line_above = true, -- insert a blank line above the line
        line_blank_line_below = true, -- insert a blank line below the line
    }

    comment_box.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                               LuaSnip                                │
--   │                 https://github.com/L3MON4D3/LuaSnip                  │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.luasnip = function()

    local present, luasnip = pcall(require, "luasnip")

    if not present then
        return
    end

    local options = {
        history = true,
        updateevents = "TextChanged,TextChangedI",
    }

    luasnip.config.set_config(options)

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.luasnippets_path or "" }

    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            if
                require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
                and not require("luasnip").session.jump_active
            then
                require("luasnip").unlink_current()
            end
        end,
    })

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Devicons Icons                            │
--   │           https://github.com/kyazdani42/nvim-web-devicons            │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.devicons = function()

  local present, devicons = pcall(require, "nvim-web-devicons")

  if present then

    local options = { override = require("plugins.configs.lsp.icon").devicons }

    devicons.setup(options)

  end

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Pretty Foldlevel                           │
--   │            https://github.com/anuvyklack/pretty-fold.nvim            │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.fold = function()

    local present, pretty_fold = pcall(require, "pretty-fold")

    if not present then
        return
    end

    local options = {

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

    pretty_fold.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                        Folat Preview Markdown                        │
--   │               https://github.com/ellisonleao/glow.nvim               │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.glow = function()

    local present, glow = pcall(require, "glow")

    if not present then
        return
    end

    local options = {

        -- glow_path = "", -- filled automatically with your glow bin in $PATH,
        -- glow_install_path = "~/.local/bin", -- default path for installing glow binary
        border = "shadow", -- floating window border config
        style = "dark", -- filled automatically with your current editor background, you can override using glow json style
        pager = false,
        width = 80,
    }

    glow.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                              Book Marks                              │
--   │               https://github.com/chentoast/marks.nvim                │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.marks = function()

    local present, marks = pcall(require, "marks")

    if not present then
        return
    end

    local options = {

        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = {},
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = true,
        -- how often (in ms) to redraw signs/recompute mark positions. 
        -- higher values will have better performance but may cause visual lag, 
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {
            "prompt",
            "TelescopePrompt",
            "NvimTree",
            "alpha",
        },
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
            sign = "⚑",
            virt_text = "hello world",
            -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
            -- defaults to false.
            annotate = false,
        },

        mappings = {}
    }

    marks.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                       Nvim and Tmux Navigating                       │
--   │                 https://github.com/aserowy/tmux.nvim                 │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.tmux = function()

    local present, tmux = pcall(require, "tmux")

    if not present then
        return
    end

    local options = {

        copy_sync = {
            -- enables copy sync. by default, all registers are synchronized.
            -- to control which registers are synced, see the `sync_*` options.
            enable = true,

            -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
            -- first buffer or named_buffer_name = true to ignore a named tmux
            -- buffer with name named_buffer_name :)
            ignore_buffers = { empty = false },

            -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
            -- clipboard by tmux
            redirect_to_clipboard = false,

            -- offset controls where register sync starts
            -- e.g. offset 2 lets registers 0 and 1 untouched
            register_offset = 0,

            -- overwrites vim.g.clipboard to redirect * and + to the system
            -- clipboard using tmux. If you sync your system clipboard without tmux,
            -- disable this option!
            sync_clipboard = true,

            -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
            sync_registers = true,

            -- syncs deletes with tmux clipboard as well, it is adviced to
            -- do so. Nvim does not allow syncing registers 0 and 1 without
            -- overwriting the unnamed register. Thus, ddp would not be possible.
            sync_deletes = true,

            -- syncs the unnamed register with the first buffer entry from tmux.
            sync_unnamed = true,
        },

        navigation = {
            -- cycles to opposite pane while navigating into the border
            cycle_navigation = true,

            -- enables default keybindings (C-hjkl) for normal mode
            enable_default_keybindings = true,

            -- prevents unzoom tmux when navigating beyond vim border
            persist_zoom = false,
        },

        resize = {
            -- enables default keybindings (A-hjkl) for normal mode
            enable_default_keybindings = false,

            -- sets resize steps for x axis
            resize_step_x = 1,

            -- sets resize steps for y axis
            resize_step_y = 1,
        }

    }

    tmux.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Rename Box UI                             │
--   │             https://github.com/filipdutescu/renamer.nvim             │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.renamer = function()

    local present, renamer = pcall(require, "renamer")

    if not present then
        return
    end

    local options = {

        -- The popup title, shown if `border` is true
        title = 'Rename',

        -- The padding around the popup content
        padding = {

            top = 0,
            left = 0,
            bottom = 0,
            right = 0,

        },

        -- The minimum width of the popup
        min_width = 15,

        -- The maximum width of the popup
        max_width = 45,

        -- Whether or not to shown a border around the popup
        border = true,

        -- The characters which make up the border
        border_chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },

        -- Whether or not to highlight the current word references through LSP
        show_refs = true,

        -- Whether or not to add resulting changes to the quickfix list
        with_qf_list = true,

        -- Whether or not to enter the new name through the UI or Neovim's `input`
        -- prompt
        with_popup = true,

        -- Custom handler to be run after successfully renaming the word. Receives
        -- the LSP 'textDocument/rename' raw response as its parameter.
        handler = nil,

    }

    renamer.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Smooth Scrolling                           │
--   │               https://github.com/karb94/neoscroll.nvim               │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.neoscroll = function()

    local present, neoscroll = pcall(require, "neoscroll")

    if not present then
        return
    end

    local options = {

        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {

            '<C-u>',
            '<C-d>',
            '<C-b>',
            '<C-f>',
            '<C-y>',
            '<C-e>',
            'zt',
            'zz',
            'zb'

        },

        hide_cursor = false,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
        performance_mode = false,    -- Disable "Performance Mode" on all buffers.
    }

    neoscroll.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                      Telescope Project Plugins                       │
--   │              https://github.com/ahmedkhalf/project.nvim              │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.project = function()

    local present, project = pcall(require, "project_nvim")

    if not present then
        return
    end

    local options = {

        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "lsp", "pattern" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = false,

        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,

        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath("data"),

    }

    project.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                        Nvim Sidebar ScrollBar                        │
--   │             https://github.com/petertriho/nvim-scrollbar             │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.scrollbar = function()

    local present, scrollbar = pcall(require, "scrollbar")

    if not present then
        return
    end

    local options = {

        show = true,
        show_in_active_only = false,
        set_highlights = true,
        folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
        max_lines = false, -- disables if no. of lines in buffer exceeds this

        handle = {
            text = " ",
            color = "#2d323b",
            cterm = nil,
            highlight = "CursorColumn",
            hide_if_all_visible = true, -- Hides handle if all lines are visible
        },

        marks = {

            Search = {
                text = { "█" },
                priority = 0,
                color = nil,
                cterm = nil,
                highlight = "Search",
            },

            Error = {
                text = { "█" },
                priority = 1,
                color = nil,
                cterm = nil,
                highlight = "DiagnosticVirtualTextError",
            },

            Warn = {
                text = { "█" },
                priority = 2,
                color = nil,
                cterm = nil,
                highlight = "DiagnosticVirtualTextWarn",
            },

            Info = {
                text = { "█" },
                priority = 3,
                color = nil,
                cterm = nil,
                highlight = "DiagnosticVirtualTextInfo",
            },

            Hint = {
                text = { "█" },
                priority = 4,
                color = nil,
                cterm = nil,
                highlight = "DiagnosticVirtualTextHint",
            },

            Misc = {
                text = { "█" },
                priority = 5,
                color = nil,
                cterm = nil,
                highlight = "Normal",
            },

            GitAdd = {
                color = "#3c4f2b",
                text = { "█" },
                priority = 5,
                cterm = nil,
                highlight = "CursorColumn",
            },

            GitDelete = {
                color = "#6f2735",
                text = { "█" },
                priority = 5,
                cterm = nil,
                highlight = "CursorColumn",
            },

            GitChange = {
                color = "#32575f",
                text = { "█" },
                priority = 5,
                cterm = nil,
                highlight = "CursorColumn",
            },

        },

        excluded_buftypes = {
            "terminal",
        },

        excluded_filetypes = {
            "prompt",
            "TelescopePrompt",
            "NvimTree",
            "alpha",
            "packer",
        },

        autocmd = {

            render = {
                "BufWinEnter",
                "TabEnter",
                "TermEnter",
                "WinEnter",
                "CmdwinLeave",
                "TextChanged",
                "VimResized",
                "WinScrolled",
            },

            clear = {
                "BufWinLeave",
                "TabLeave",
                "TermLeave",
                "WinLeave",
            },

        },

        handlers = {
            diagnostic = true,
            search = false, -- Requires hlslens to be loaded, will run require("scrollbar.handlers.search").setup() for you
            git = true,
        },

    }

    scrollbar.setup(options)

    local gs = require('gitsigns')
    local gitsign_hunks = require 'gitsigns.hunks'

    require('scrollbar.handlers').register('git', function(bufnr)
        local nb_lines = vim.api.nvim_buf_line_count(bufnr)

        local colors_type = {
            add = 'GitAdd',
            delete = 'GitDelete',
            change = 'GitChange',
            changedelete = 'GitChange'
        }

        local lines = {}
        local hunks = gs.get_hunks(bufnr)

        if hunks then
            for _, hunk in ipairs(hunks) do
                hunk.vend = math.min(hunk.added.start, hunk.removed.start) + hunk.added.count + hunk.removed.count
                local signs = gitsign_hunks.calc_signs(hunk, 0, nb_lines)
                for _, sign in ipairs(signs) do
                    table.insert(lines, {
                        line = sign.lnum,
                        type = colors_type[sign.type]
                    })
                end
            end
        end

        return lines

    end)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                               Zen Mode                               │
--   │                https://github.com/folke/zen-mode.nvim                │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.zenmode = function()

    local present, zenmode = pcall(require, "zen-mode")

    if not present then
        return
    end

    local options = {

        window = {

            backdrop = 1,
            height = 0.9, -- height of the Zen window
            width = 0.6,

            options = {
                signcolumn = "no", -- disable signcolumn
                number = false, -- disable number column
                relativenumber = false, -- disable relative numbers
                cursorline = false, -- disable cursorline
                cursorcolumn = false, -- disable cursor column
                foldcolumn = "0", -- disable fold column
                list = false, -- disable whitespace characters
            },

        },

        plugins = {

            gitsigns = { enabled = false }, -- disables git signs
            scrollbar = { enabled = false }, -- disables git signs
            tmux = { enabled = false },
            twilight = { enabled = true },

        },

        -- on_open = function()
        --   vim.lsp.diagnostic.disable()
        --   vim.cmd [[
        --       set foldlevel=10
        --       IndentBlanklineDisable
        --       ]]
        -- end,
        -- on_close = function()
        --   vim.lsp.diagnostic.enable()
        --   vim.cmd [[
        --       set foldlevel=5
        --       IndentBlanklineEnable
        --       ]]
        -- end,

    }


    zenmode.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                         Global Search Tools                          │
--   │              https://github.com/nvim-pack/nvim-spectre               │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.spectre = function()

    local present, spectre = pcall(require, "spectre")

    if not present then
        return
    end

    local options = {

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

    spectre.setup(options)

end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                              Dim Windows                             │
--   │                 https://github.com/sunjon/Shade.nvim                 │
--   ╰──────────────────────────────────────────────────────────────────────╯

M.shade = function()

    local present, shade = pcall(require, "shade")

    if not present then
        return
    end

    local options = {

        overlay_opacity = 50,
        opacity_step = 1,
        keys = {
            brightness_up    = '<C-Up>',
            brightness_down  = '<C-Down>',
            toggle           = '<Leader>s',
        }
    }

    shade.setup(options)

end

----------------------------------------------------------------------------
return M
