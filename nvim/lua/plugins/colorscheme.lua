return {

    -- ONEDARK

    "navarasu/onedark.nvim",
    priority = 1000,

    opts = {

        -- Main options --
        style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = false,  -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        -- toggle theme style ---
        toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
        toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

        -- Change code style ---
        -- Options are italic, bold, underline, none
        -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
        code_style = {
            comments = 'none',
            keywords = 'none',
            functions = 'none',
            strings = 'none',
            variables = 'none'
            -- variables = 'italic'
        },

        -- Lualine options --
        lualine = {
            transparent = false, -- lualine center bar transparency
        },

        -- Custom Highlights --
        colors = {}, -- Override default colors

        highlights = {

            CursorLine                 = { fg = nil       , bg = "#2C313C" },
            CursorLineNr               = { fg = "#61AFEF" , bg = "#2C313C" },
            CursorLineSign             = { fg = nil       , bg = "#2C313C" },
            CursorLineFold             = { fg = nil       , bg = "#2C313C" },
            CursorLineFold             = { fg = "#E0AF68" , bg = "#2C313C" }, 
            Folded                     = { fg = "#282C34" , bg = "#E0AF68" },
            FoldColumn                 = { fg = "#515E6F" , bg = "#282C34" },
            SignColumn                 = { fg = nil       , bg = "#282C34" },
            VertSplit                  = { fg = "#3E4452" , bg = "#282C34" }, 
            Search                     = { fg = "#21252B" , bg = "#C678DD" },
            IncSearch                  = { fg = "#21252B" , bg = "#E06C75" },

            BufferLineIndicatorVisible = { fg = "#21252B" , bg = "#21252B" }, 
            BufferLineOffsetSeparator  = { fg = "#21252B" , bg = "#21252B" },

            NeoTreeNormal              = { fg = nil       , bg = "#21252B" },
            NeoTreeNormalNC            = { fg = nil       , bg = "#21252B" },
            NeoTreeRootName            = { fg = "#E06C75" , bg = nil       },
            NeoTreeDotfile             = { fg = "#5A5E64" , bg = nil       },
            NeoTreeVertSplit           = { fg = "#21252B" , bg = "#21252B" },
            NeoTreeStatusLin           = { fg = "#21252B" , bg = "#21252B" },
            NeoTreeStatusLine          = { fg = nil       , bg = "#21252B" },
            NeoTreeSignColumn          = { fg = "#21252B" , bg = "#21252B" },
            NeoTreeEndOfBuffer         = { fg = "#21252B" , bg = "#21252B" },
            NeoTreeStatusLineNC        = { fg = "#21252B" , bg = "#21252B" }, 
            NeoTreeWinSeparator        = { fg = "#21252B" , bg = "#21252B" },
            NeoTreeExpander            = { fg = "#4D5A5E" , bg = nil       },
            NeoTreeIndentMarker        = { fg = "#3A4646" , bg = nil       },
            NeoTreeDirectoryName       = { fg = "#ABB2BF" , bg = nil       },
            -- NeoTreeGitAdded            = { fg = "#5C6370" , bg = nil       },
            -- NeoTreeGitConflict         = { fg = "#5C6370" , bg = nil       },
            -- NeoTreeGitDeleted          = { fg = "#5C6370" , bg = nil       },
            -- NeoTreeGitIgnored          = { fg = "#5C6370" , bg = nil       },
            -- NeoTreeGitModified         = { fg = "#5C6370" , bg = nil       },
            -- NeoTreeGitRenamed          = { fg = "#5C6370" , bg = nil       },
            -- NeoTreeGitStaged           = { fg = "#5C6370" , bg = nil       },
            -- NeoTreeGitUntracked        = { fg = "#E86671" , bg = nil       },

            TSRainbowRed               = { fg = "#E06C75" , bg = nil       },
            TSRainbowYellow            = { fg = "#E5C07B" , bg = nil       },
            TSRainbowBlue              = { fg = "#61AFEF" , bg = nil       },
            TSRainbowOrange            = { fg = "#EBD09C" , bg = nil       },
            TSRainbowGreen             = { fg = "#98C379" , bg = nil       },
            TSRainbowViolet            = { fg = "#C678DD" , bg = nil       },
            TSRainbowCyan              = { fg = "#56B6C2" , bg = nil       },

        },

        -- Plugins Config --
        diagnostics = {
            darker = true, -- darker colors for diagnostic
            undercurl = true,   -- use undercurl instead of underline for diagnostics
            background = true,    -- use background color for virtual text
        },
    },

    config = function(_, opts)
        require("onedark").setup(opts)
        require('onedark').load()
    end,
}


