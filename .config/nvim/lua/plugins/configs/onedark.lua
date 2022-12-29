local present, onedark = pcall(require, "onedark")

if not present then
    return
end

local M = {}

M.base_30 = {
    white = "#abb2bf",
    darker_black = "#1b1f27",
    black = "#1e222a", --  nvim bg
    black2 = "#252931",
    one_bg = "#282c34", -- real bg of onedark
    one_bg2 = "#353b45",
    one_bg3 = "#373b43",
    grey = "#42464e",
    grey_fg = "#565c64",
    grey_fg2 = "#6f737b",
    light_grey = "#6f737b",
    red = "#e06c75",
    baby_pink = "#DE8C92",
    pink = "#ff75a0",
    line = "#31353d", -- for lines like vertsplit
    green = "#98c379",
    vibrant_green = "#7eca9c",
    nord_blue = "#81A1C1",
    blue = "#61afef",
    yellow = "#e7c787",
    sun = "#EBCB8B",
    purple = "#de98fd",
    dark_purple = "#c882e7",
    teal = "#519ABA",
    orange = "#fca2aa",
    cyan = "#a3b8ef",
    statusline_bg = "#22262e",
    lightbg = "#2d3139",
    pmenu_bg = "#61afef",
    folder_bg = "#61afef",
    em_folder_bg = "#535965",
    yellow_F = "#e2c08d",
    yellow_G = "#b69e7b",
    green_G = "#73c991",
    green_F = "#73c991",
}

M.base_16 = {
    base00 = "#1e222a",
    base01 = "#353b45",
    base02 = "#3e4451",
    base03 = "#545862",
    base04 = "#565c64",
    base05 = "#abb2bf",
    base06 = "#b6bdca",
    base07 = "#c8ccd4",
    base08 = "#e06c75",
    base09 = "#d19a66",
    base0A = "#e5c07b",
    base0B = "#98c379",
    base0C = "#56b6c2",
    base0D = "#61afef",
    base0E = "#c678dd",
    base0F = "#be5046",
}

local colors = M.base_30
local theme = M.base_16

local options = {
    -- Main options --
    style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = true, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Custom Highlights --
    colors = {
    }, -- Override default colors

    highlights = {
        -- EndOfBuffer = {bg = '$deep_dark'},
        -- TSString = {fg = '$bright_orange', bg = '#00ff00', fmt = 'bold'},
        -- TSFunction = {fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic'},
    }, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

require "onedark".setup(options)
require "onedark".load()

-- 自定义高亮
local highlight = function(group, fg, bg, attr, sp)
    fg = fg and "guifg=" .. fg or "guifg=NONE"
    bg = bg and "guibg=" .. bg or "guibg=NONE"
    attr = attr and "gui=" ..attr or "gui=NONE"
    sp = sp and "guisp=" .. sp or ""

    vim.api.nvim_command("highlight " .. group .. " ".. fg .. " " .. bg .. " ".. attr .. " " .. sp)
end

function NvimTreeHighlight()

    ------------------------------------------------------------------------------- 
    -- Nvim-tree
    ------------------------------------------------------------------------------- 

    highlight("NvimTreeSymlink"                    ,nil                   ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeNormalNC"                   ,nil                   ,colors.darker_black  ,nil                      ,nil                 )
    highlight("NvimTreeFolderName"                 ,colors.folder_bg      ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeRootFolder"                 ,colors.red            ,nil                  ,"bold"                   ,nil                 )
    highlight("NvimTreeFolderIcon"                 ,colors.folder_bg      ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeFileIcon"                   ,theme.base05          ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeEmptyFolderName"            ,colors.em_folder_bg   ,nil                  ,nil                      ,nil                 )   -- Directory
    highlight("NvimTreeOpenedFolderName"           ,colors.folder_bg      ,nil                  ,nil                      ,nil                 )   -- Directory
    highlight("NvimTreeExecFile"                   ,nil                   ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeOpenedFile"                 ,nil                   ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeSpecialFile"                ,colors.yellow         ,nil                  ,"bold"                   ,nil                 )
    highlight("NvimTreeImageFile"                  ,nil                   ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeIndentMarker"               ,colors.grey_fg        ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeWindowPicker"               ,colors.red            ,colors.black2        ,nil                      ,nil                 )
    highlight("NvimTreeLspDiagnosticsError"        ,nil                   ,nil                  ,nil                      ,nil                 )   -- DiagnosticError 
    highlight("NvimTreeLspDiagnosticsWarning"      ,nil                   ,nil                  ,nil                      ,nil                 )   -- DiagnosticWarn
    highlight("NvimTreeLspDiagnosticsInformation"  ,nil                   ,nil                  ,nil                      ,nil                 )   -- DiagnosticInfo
    highlight("NvimTreeLspDiagnosticsHint"         ,nil                   ,nil                  ,nil                      ,nil                 )   -- DiagnosticHint
    highlight("NvimTreeGitDirty"                   ,colors.yellow_G       ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeGitStaged"                  ,theme.base0E          ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeGitMerge"                   ,theme.base0C          ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeGitRenamed"                 ,theme.base0D          ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeGitNew"                     ,colors.green_G        ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeGitDeleted"                 ,colors.red            ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeGitIgnored"                 ,colors.light_grey     ,nil                  ,nil                      ,nil                 )   -- Comment

    highlight("NvimTreeNormal"                     ,nil                   ,colors.darker_black  ,nil                      ,nil                 )
    highlight("NvimTreeEndOfBuffer"                ,colors.darker_black   ,nil                  ,nil                      ,nil                 )   -- NonText
    highlight("NvimTreeCursorLine"                 ,nil                   ,colors.black2        ,nil                      ,nil                 )   -- CursorLine
    highlight("NvimTreeWinSeparator"               ,colors.darker_black   ,colors.darker_black  ,nil                      ,nil                 )   -- VertSplit
    highlight("NvimTreeVertSplit"                  ,nil                   ,nil                  ,nil                      ,nil                 )   -- VertSplit
    highlight("NvimTreeCursorColumn"               ,nil                   ,nil                  ,nil                      ,nil                 )   -- CursorColumn

    highlight("NvimTreeFileDirty"                  ,colors.yellow_F       ,nil                  ,nil                      ,nil                 )   -- NvimTreeGitDirty
    highlight("NvimTreeFileStaged"                 ,theme.base0E          ,nil                  ,nil                      ,nil                 )   -- NvimTreeGitStaged
    highlight("NvimTreeFileMerge"                  ,theme.base0C          ,nil                  ,nil                      ,nil                 )   -- NvimTreeGitMerge
    highlight("NvimTreeFileRenamed"                ,theme.base0D          ,nil                  ,nil                      ,nil                 )   -- NvimTreeGitRenamed
    highlight("NvimTreeFileNew"                    ,colors.green          ,nil                  ,nil                      ,nil                 )   -- NvimTreeGitNew
    highlight("NvimTreeFileDeleted"                ,colors.red            ,nil                  ,nil                      ,nil                 )   -- NvimTreeGitDeleted
    highlight("NvimTreeFileIgnored"                ,colors.light_grey     ,nil                  ,nil                      ,nil                 )   -- NvimTreeGitIgnored
    highlight("NvimTreeLiveFilterPrefix"           ,theme.base0E          ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeLiveFilterValue"            ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeBookmark"                   ,theme.base0E          ,nil                  ,nil                      ,nil                 )
    highlight("NvimTreeIndentMarker"               ,colors.grey_fg        ,nil                  ,nil                      ,nil                 )

    ------------------------------------------------------------------------------- 
    -- Devicons
    ------------------------------------------------------------------------------- 

    highlight("DevIconDefault"                     , colors.red           ,nil                  ,nil                      ,nil                 )
    highlight("DevIconc"                           , colors.blue          ,nil                  ,nil                      ,nil                 )
    highlight("DevIconcss"                         , colors.blue          ,nil                  ,nil                      ,nil                 )
    highlight("DevIcondeb"                         , colors.cyan          ,nil                  ,nil                      ,nil                 )
    highlight("DevIconDockerfile"                  , colors.cyan          ,nil                  ,nil                      ,nil                 )
    highlight("DevIconhtml"                        , colors.baby_pink     ,nil                  ,nil                      ,nil                 )
    highlight("DevIconjpeg"                        , colors.dark_purple   ,nil                  ,nil                      ,nil                 )
    highlight("DevIconjpg"                         , colors.dark_purple   ,nil                  ,nil                      ,nil                 )
    highlight("DevIconjs"                          , colors.sun           ,nil                  ,nil                      ,nil                 )
    highlight("DevIconkt"                          , colors.orange        ,nil                  ,nil                      ,nil                 )
    highlight("DevIconlock"                        , colors.red           ,nil                  ,nil                      ,nil                 )
    highlight("DevIconlua"                         , colors.blue          ,nil                  ,nil                      ,nil                 )
    highlight("DevIconmp3"                         , colors.white         ,nil                  ,nil                      ,nil                 )
    highlight("DevIconmp4"                         , colors.white         ,nil                  ,nil                      ,nil                 )
    highlight("DevIconout"                         , colors.white         ,nil                  ,nil                      ,nil                 )
    highlight("DevIconpng"                         , colors.dark_purple   ,nil                  ,nil                      ,nil                 )
    highlight("DevIconpy"                          , colors.cyan          ,nil                  ,nil                      ,nil                 )
    highlight("DevIcontoml"                        , colors.blue          ,nil                  ,nil                      ,nil                 )
    highlight("DevIconts"                          , colors.teal          ,nil                  ,nil                      ,nil                 )
    highlight("DevIconttf"                         , colors.white         ,nil                  ,nil                      ,nil                 )
    highlight("DevIconrb"                          , colors.pink          ,nil                  ,nil                      ,nil                 )
    highlight("DevIconrpm"                         , colors.orange        ,nil                  ,nil                      ,nil                 )
    highlight("DevIconvue"                         , colors.vibrant_green ,nil                  ,nil                      ,nil                 )
    highlight("DevIconwoff"                        , colors.white         ,nil                  ,nil                      ,nil                 )
    highlight("DevIconwoff2"                       , colors.white         ,nil                  ,nil                      ,nil                 )
    highlight("DevIconxz"                          , colors.sun           ,nil                  ,nil                      ,nil                 )
    highlight("DevIconzip"                         , colors.sun           ,nil                  ,nil                      ,nil                 )
    highlight("DevIconZig"                         , colors.orange        ,nil                  ,nil                      ,nil                 )

    ------------------------------------------------------------------------------- 
    -- TreeSitter
    ------------------------------------------------------------------------------- 

    highlight("TSAnnotation"                       ,theme.base0F          ,nil                  ,nil                      ,nil                 )
    highlight("TSAttribute"                        ,theme.base0A          ,nil                  ,nil                      ,nil                 )
    highlight("TSTagAttribute"                     ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSCharacter"                        ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSConstructor"                      ,theme.base0C          ,nil                  ,nil                      ,nil                 )
    highlight("TSConstBuiltin"                     ,theme.base09          ,nil                  ,nil                      ,nil                 )
    highlight("TSConstMacro"                       ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSError"                            ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSException"                        ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSFloat"                            ,theme.base09          ,nil                  ,nil                      ,nil                 )
    highlight("TSKeyword"                          ,theme.base0E          ,nil                  ,nil                      ,nil                 )
    highlight("TSKeywordFunction"                  ,theme.base0E          ,nil                  ,nil                      ,nil                 )
    highlight("TSKeywordReturn"                    ,theme.base0E          ,nil                  ,nil                      ,nil                 )
    highlight("TSFunction"                         ,theme.base0D          ,nil                  ,nil                      ,nil                 )
    highlight("TSFuncBuiltin"                      ,theme.base0D          ,nil                  ,nil                      ,nil                 )
    highlight("TSFuncMacro"                        ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSKeywordOperator"                  ,theme.base0E          ,nil                  ,nil                      ,nil                 )
    highlight("TSMethod"                           ,theme.base0D          ,nil                  ,nil                      ,nil                 )
    highlight("TSNamespace"                        ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSNone"                             ,theme.base05          ,nil                  ,nil                      ,nil                 )
    highlight("TSParameter"                        ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSParameterReference"               ,theme.base05          ,nil                  ,nil                      ,nil                 )
    highlight("TSPunctBracket"                     ,theme.base0F          ,nil                  ,nil                      ,nil                 )
    highlight("TSPunctDelimiter"                   ,theme.base0F          ,nil                  ,nil                      ,nil                 )
    highlight("TSPunctSpecial"                     ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSStringRegex"                      ,theme.base0C          ,nil                  ,nil                      ,nil                 )
    highlight("TSStringEscape"                     ,theme.base0C          ,nil                  ,nil                      ,nil                 )
    highlight("TSSymbol"                           ,theme.base0B          ,nil                  ,nil                      ,nil                 )
    highlight("TSTagDelimiter"                     ,theme.base0F          ,nil                  ,nil                      ,nil                 )
    highlight("TSText"                             ,theme.base05          ,nil                  ,nil                      ,nil                 )
    highlight("TSStrong"                           ,nil                   ,nil                  ,"bold"                   ,nil                 )
    highlight("TSEmphasis"                         ,theme.base09          ,nil                  ,nil                      ,nil                 )
    highlight("TSStrike"                           ,theme.base00          ,nil                  ,"strikethrough"          ,nil                 )
    highlight("TSLiteral"                          ,theme.base09          ,nil                  ,nil                      ,nil                 )
    highlight("TSURI"                              ,theme.base09          ,nil                  ,"underline"              ,nil                 )
    highlight("TSTypeBuiltin"                      ,theme.base0A          ,nil                  ,nil                      ,nil                 )
    highlight("TSVariableBuiltin"                  ,theme.base09          ,nil                  ,nil                      ,nil                 )
    highlight("TSVariable"                         ,theme.base05          ,nil                  ,nil                      ,nil                 )
    highlight("TSDefinition"                       ,nil                   ,nil                  ,"underline"              ,theme.base04        )
    highlight("TSDefinitionUsage"                  ,nil                   ,nil                  ,"underline"              ,theme.base04        )
    highlight("TSCurrentScope"                     ,nil                   ,nil                  ,"bold"                   ,nil                 )
    highlight("luaTSField"                         ,theme.base0D          ,nil                  ,nil                      ,nil                 )
    highlight("TSFieldKey"                         ,theme.base08          ,nil                  ,nil                      ,nil                 )
    highlight("TSProperty"                         ,theme.base08          ,nil                  ,nil                      ,theme.base08        )
    highlight("TSInclude"                          ,theme.base0E          ,nil                  ,nil                      ,nil                 )
    highlight("TSConditional"                      ,theme.base0E          ,nil                  ,nil                      ,nil                 )

    ------------------------------------------------------------------------------- 
    -- Syntax
    ------------------------------------------------------------------------------- 

    highlight("Boolean"                            ,theme.base09          ,nil                  ,nil                      ,nil                )
    highlight("Character"                          ,theme.base08          ,nil                  ,nil                      ,nil                )
    highlight("Conditional"                        ,theme.base0E          ,nil                  ,nil                      ,nil                )
    highlight("Constant"                           ,theme.base08          ,nil                  ,nil                      ,nil                )
    highlight("Define"                             ,theme.base0E          ,nil                  ,"none"                   ,nil                )
    highlight("Delimiter"                          ,theme.base0F          ,nil                  ,nil                      ,nil                )
    highlight("Float"                              ,theme.base09          ,nil                  ,nil                      ,nil                )
    highlight("Variable"                           ,theme.base05          ,nil                  ,nil                      ,nil                )
    highlight("Function"                           ,theme.base0D          ,nil                  ,nil                      ,nil                )
    highlight("Identifier"                         ,theme.base08          ,nil                  ,"none"                   ,nil                )
    highlight("Include"                            ,theme.base0D          ,nil                  ,nil                      ,nil                )
    highlight("Keyword"                            ,theme.base0E          ,nil                  ,nil                      ,nil                )
    highlight("Label"                              ,theme.base0A          ,nil                  ,nil                      ,nil                )
    highlight("Number"                             ,theme.base09          ,nil                  ,nil                      ,nil                )
    highlight("Operator"                           ,theme.base05          ,nil                  ,"none"                   ,nil                )
    highlight("PreProc"                            ,theme.base0A          ,nil                  ,nil                      ,nil                )
    highlight("Repeat"                             ,theme.base0A          ,nil                  ,nil                      ,nil                )
    highlight("Special"                            ,theme.base0C          ,nil                  ,nil                      ,nil                )
    highlight("SpecialChar"                        ,theme.base0F          ,nil                  ,nil                      ,nil                )
    highlight("Statement"                          ,theme.base08          ,nil                  ,nil                      ,nil                )
    highlight("StorageClass"                       ,theme.base0A          ,nil                  ,nil                      ,nil                )
    highlight("String"                             ,theme.base0B          ,nil                  ,nil                      ,nil                )
    highlight("Structure"                          ,theme.base0E          ,nil                  ,nil                      ,nil                )
    highlight("Tag"                                ,theme.base0A          ,nil                  ,nil                      ,nil                )
    highlight("Todo"                               ,theme.base0A          ,theme.base01         ,nil                      ,nil                )
    highlight("Type"                               ,theme.base0A          ,nil                  ,"none"                   ,nil                )
    highlight("Typedef"                            ,theme.base0A          ,nil                  ,nil                      ,nil                )

    ------------------------------------------------------------------------------- 
    -- IndenBlank
    ------------------------------------------------------------------------------- 

    highlight("IndentBlanklineChar"                ,colors.line           ,nil                  ,nil                      ,nil                )
    highlight("IndentBlanklineSpaceChar"           ,colors.line           ,nil                  ,nil                      ,nil                )
    highlight("IndentBlanklineContextChar"         ,colors.grey           ,nil                  ,nil                      ,nil                )
    highlight("IndentBlanklineContextStart"        ,nil                   ,colors.one_bg2       ,nil                      ,nil                )

    ------------------------------------------------------------------------------- 
    -- CMP
    ------------------------------------------------------------------------------- 

    highlight("CmPmenu"                            ,nil                   ,colors.darker_black  ,nil                      ,nil                )
    highlight("CMPPmenu"                           ,colors.darker_black   ,colors.darker_black  ,nil                      ,nil                )
    highlight("CmpBorder"                          ,colors.grey           ,nil                  ,nil                      ,nil                )
    highlight("CmpDocBorder"                       ,colors.grey           ,nil                  ,nil                      ,nil                )
    highlight("CmpItemAbbr"                        ,colors.white          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemAbbrMatch"                   ,colors.blue           ,nil                  ,"bold"                   ,nil                )
    highlight("CmpItemKindConstant"                ,theme.base09          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindFunction"                ,theme.base0D          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindIdentifier"              ,theme.base08          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindField"                   ,theme.base08          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindVariable"                ,theme.base0E          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindSnippet"                 ,colors.red            ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindText"                    ,theme.base0B          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindStructure"               ,theme.base0E          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindType"                    ,theme.base0A          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindKeyword"                 ,theme.base07          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindMethod"                  ,theme.base0D          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindConstructor"             ,colors.blue           ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindFolder"                  ,theme.base07          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindModule"                  ,theme.base0A          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindProperty"                ,theme.base08          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindUnit"                    ,theme.base0E          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindFile"                    ,theme.base07          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindColor"                   ,colors.red            ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindReference"               ,theme.base05          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindStruct"                  ,theme.base0E          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindOperator"                ,theme.base05          ,nil                  ,nil                      ,nil                )
    highlight("CmpItemKindTypeParameter"           ,theme.base08          ,nil                  ,nil                      ,nil                )

    highlight ("CMPPmenuSel"                       ,colors.one_bg         ,colors.pmenu_bg      ,nil                      ,nil                )
    highlight ("CmpItemAbbrDeprecated"             ,colors.one_bg         ,nil                  ,nil                      ,nil                )

    ------------------------------------------------------------------------------- 
    -- Whichkey
    ------------------------------------------------------------------------------- 

    highlight("WhichKey"                           ,colors.blue           ,nil                  ,nil                      ,nil                )
    highlight("WhichKeySeparator"                  ,colors.light_grey     ,nil                  ,nil                      ,nil                )
    highlight("WhichKeyDesc"                       ,colors.red            ,nil                  ,nil                      ,nil                )
    highlight("WhichKeyGroup"                      ,colors.green          ,nil                  ,nil                      ,nil                )
    highlight("WhichKeyValue"                      ,colors.green          ,nil                  ,nil                      ,nil                )

    ------------------------------------------------------------------------------- 
    -- Git
    ------------------------------------------------------------------------------- 

    highlight("DiffAdd"                            ,colors.blue           ,nil                  ,nil                      ,nil                )
    highlight("DiffAdded"                          ,colors.green          ,nil                  ,nil                      ,nil                )
    highlight("DiffChange"                         ,colors.light_grey     ,nil                  ,nil                      ,nil                )
    highlight("DiffChangeDelete"                   ,colors.red            ,nil                  ,nil                      ,nil                )
    highlight("DiffModified"                       ,colors.orange         ,nil                  ,nil                      ,nil                )
    highlight("DiffDelete"                         ,colors.red            ,nil                  ,nil                      ,nil                )
    highlight("DiffRemoved"                        ,colors.red            ,nil                  ,nil                      ,nil                )
    highlight("gitcommitOverflow"                  ,theme.base08          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitSummary"                   ,theme.base08          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitComment"                   ,theme.base03          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitUntracked"                 ,theme.base03          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitDiscarded"                 ,theme.base03          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitSelected"                  ,theme.base03          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitHeader"                    ,theme.base0E          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitSelectedType"              ,theme.base0D          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitUnmergedType"              ,theme.base0D          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitDiscardedType"             ,theme.base0D          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitBranch"                    ,theme.base09          ,nil                  ,"bold"                   ,nil                )
    highlight("gitcommitUntrackedFile"             ,theme.base0A          ,nil                  ,nil                      ,nil                )
    highlight("gitcommitUnmergedFile"              ,theme.base08          ,nil                  ,"bold"                   ,nil                )
    highlight("gitcommitDiscardedFile"             ,theme.base08          ,nil                  ,"bold"                   ,nil                )
    highlight("gitcommitSelectedFile"              ,theme.base0B          ,nil                  ,"bold"                   ,nil                )

    ------------------------------------------------------------------------------- 
    -- lualine
    ------------------------------------------------------------------------------- 

    highlight ("lualine_a_terminal"                ,"#282C34"  , "#61AFEF", "bold", "bold")

    ------------------------------------------------------------------------------- 
    -- Telescope
    ------------------------------------------------------------------------------- 

    -- 设置选择器中选定项目的突出显示
    highlight("TelescopeSelection"                 ,nil                   ,"#3E4552"            ,nil                      ,nil                )
    highlight("TelescopeSelectionCaret"            ,"#61AFEF"             ,nil                  ,nil                      ,nil                )
    highlight("TelescopeMultiSelection"            ,"#E06C75"             ,nil                  ,nil                      ,nil                )
    highlight("TelescopeMultiIcon"                 ,"#E06C75"             ,nil                  ,nil                      ,nil                )

    -- 望远镜创建的浮动窗口中的“正常”。
    highlight("TelescopeNormal"                    ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewNormal"             ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePromptNormal"              ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsNormal"             ,nil                   ,nil                  ,nil                      ,nil                )

    -- 边框高亮组
    highlight("TelescopeBorder"                    ,"#646870"             ,nil                  ,nil                      ,nil                )
    highlight("TelescopePromptBorder"              ,"#646870"             ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsBorder"             ,"#646870"             ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewBorder"             ,"#646870"             ,nil                  ,nil                      ,nil                )

    -- 标题高亮组                                                                                       
    highlight("TelescopeTitle"                     ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePromptTitle"               ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsTitle"              ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewTitle"              ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePromptCounter"             ,nil                   ,nil                  ,nil                      ,nil                )

    -- 用于突出显示您匹配的字符。
    highlight("TelescopeMatching"                  ,"#61AFEF"             ,nil                  ,nil                      ,nil                )

    -- 用于提示前缀
    highlight("TelescopePromptPrefix"              ,nil                   ,nil                  ,nil                      ,nil                )

    -- 用于在预览器中突出显示匹配的行。仅适用于 (  v_ previewer)
    highlight("TelescopePreviewLine"               ,nil                   ,"#4E5666"            ,nil                      ,nil                )
    highlight("TelescopePreviewMatch"              ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewPipe"               ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewCharDev"            ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewDirectory"          ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewBlock"              ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewLink"               ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewSocket"             ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewRead"               ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewWrite"              ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewExecute"            ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewHyphen"             ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewSticky"             ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewSize"               ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewUser"               ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewGroup"              ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewDate"               ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewMessage"            ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopePreviewMessageFillchar"    ,nil                   ,nil                  ,nil                      ,nil                )

    -- 用于选择器特定的结果突出显示
    highlight("TelescopeResultsClass"              ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsConstant"           ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsField"              ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsFunction"           ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsMethod"             ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsOperator"           ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsStruct"             ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsVariable"           ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsLineNr"             ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsIdentifier"         ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsNumber"             ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsComment"            ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsSpecialComment"     ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsFileIcon"           ,nil                   ,nil                  ,nil                      ,nil                )

    -- 用于 git status 结果高亮
    highlight("TelescopeResultsDiffChange"         ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsDiffAdd"            ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsDiffDelete"         ,nil                   ,nil                  ,nil                      ,nil                )
    highlight("TelescopeResultsDiffUntracked"      ,nil                   ,nil                  ,nil                      ,nil                )


    ------------------------------------------------------------------------------- 
    -- System
    ------------------------------------------------------------------------------- 

    highlight("Search"                             ,colors.one_bg         ,colors.red           ,nil                      ,nil                )
    highlight("IncSearch"                          ,colors.one_bg         ,colors.red           ,nil                      ,nil                )
    highlight("Folded"                             ,colors.one_bg         ,colors.grey_fg2      ,nil                      ,nil                )
    highlight("FoldColumn"                         ,colors.grey_fg        ,'#23272E'            ,nil                      ,nil                )
    highlight("NormalFloat"                        ,nil                   ,colors.darker_black  ,nil                      ,nil                )
    highlight("FloatBorder"                        ,colors.blue           ,nil                  ,nil                      ,nil                )
    highlight("NvimInternalError"                  ,colors.red            ,nil                  ,nil                      ,nil                )
    highlight("WinSeparator"                       ,colors.line           ,nil                  ,nil                      ,nil                )
    highlight("PackerPackageName"                  ,colors.red            ,nil                  ,nil                      ,nil                )
    highlight("PackerSuccess"                      ,colors.green          ,nil                  ,nil                      ,nil                )
    highlight("PackerStatusSuccess"                ,theme.base08          ,nil                  ,nil                      ,nil                )
    highlight("PackerStatusCommit"                 ,colors.blue           ,nil                  ,nil                      ,nil                )
    highlight("PackeProgress"                      ,colors.blue           ,nil                  ,nil                      ,nil                )
    highlight("PackerOutput"                       ,colors.red            ,nil                  ,nil                      ,nil                )
    highlight("PackerStatus"                       ,colors.blue           ,nil                  ,nil                      ,nil                )
    highlight("PackerHash"                         ,colors.blue           ,nil                  ,nil                      ,nil                )
    highlight("QuickFixLine"                       ,colors.one_bg         ,colors.blue          ,nil                      ,nil                )

    ------------------------------------------------------------------------------- 
    -- Scrollbar
    ------------------------------------------------------------------------------- 
    -- highlight("ScrollbarHandle                  ",         "#282C34",  "#3E4552",  nil,        nil )
    -- highlight("IncSearch                        ",         "#282C34",  "#E06C75",  nil,        nil )
    -- highlight("Folded                           ",         "#282C34",  "#80868F",  nil,        nil )
    -- highlight("FoldColumn                       ",         "#4E5666",  "#23272E",  nil,        nil )
    highlight("MarkSignHL"                         ,"#DCDCDC"             ,"#0366d6"            ,nil                      ,nil                )

    ------------------------------------------------------------------------------- 
    -- Rainbow
    ------------------------------------------------------------------------------- 

    highlight("rainbowcol1"                        ,"#Abb2bF"             ,nil                  ,nil                      ,nil                )

    ------------------------------------------------------------------------------- 
    -- VimWiki
    ------------------------------------------------------------------------------- 

    highlight("VimwikiHeader1"                     ,"#e5c07b"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiHeader2"                     ,"#98c379"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiHeader3"                     ,"#c678dd"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiHeader4"                     ,"#8096BF"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiHeader5"                     ,"#8096BF"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiHeader6"                     ,"#8096BF"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiH1Folding"                   ,"#e5c07b"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiH2Folding"                   ,"#98c379"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiH3Folding"                   ,"#c678dd"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiH4Folding"                   ,"#8096BF"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiH5Folding"                   ,"#8096BF"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiH6Folding"                   ,"#8096BF"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiLink"                        ,"#61afef"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiLink"                        ,"#61afef"             ,nil                  ,nil                      ,nil                )
    highlight("VimwikiBold"                        ,"#E06C75"             ,nil                  ,"bold"                   ,"bold"             )

    ------------------------------------------------------------------------------- 

end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "lua NvimTreeHighlight()",
})

