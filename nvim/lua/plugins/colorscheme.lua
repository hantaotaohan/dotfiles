--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           PLUGINS: ONEDARK                           │
--   │                                                                      │
--   │               https://github.com/navarasu/onedark.nvim               │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {

	"navarasu/onedark.nvim",
	priority = 1000,

	opts = {

		-- Main options --
		style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
		transparent = false, -- Show/hide background
		term_colors = true, -- Change terminal color as per the selected theme style
		ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
		cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

		-- toggle theme style ---
		toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
		toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between

		-- Change code style ---
		-- Options are italic, bold, underline, none
		-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
		code_style = {
			comments = "none",
			keywords = "none",
			functions = "none",
			strings = "none",
			variables = "none",
			-- variables = 'italic'
		},

		-- Lualine options --
		lualine = {
			transparent = false, -- lualine center bar transparency
		},

		-- Custom Highlights --
		colors = {}, -- Override default colors

		highlights = {

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                                SYSTEM                                │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			Visual = { fg = nil, bg = "#404859" },
			Substitute = { fg = "#FFFFFF", bg = "#404859" },
			CursorLine = { fg = nil, bg = "#2C313C" },
			CursorLineNr = { fg = "#61AFEF", bg = "#2C313C" },
			CursorLineSign = { fg = nil, bg = "#2C313C" },
			CursorLineFold = { fg = nil, bg = "#2C313C" },
			Folded = { fg = "#282C34", bg = "#E7C787" },
			FoldColumn = { fg = "#515E6F", bg = "#282C34" },
			SignColumn = { fg = nil, bg = "#282C34" },
			-- VertSplit = { fg = "#3E4452", bg = "#282C34" },
			VertSplit = { fg = "#21252B", bg = "#21252B" },
			Search = { fg = "#FFFFFF", bg = "#895c9d" },
			IncSearch = { fg = "#FFFFFF", bg = "#61AFEF" },
			CurSearch = { fg = "#FFFFFF", bg = "#61AFEF" },
			-- NormalFloat = { fg = nil, bg = "#20242D" },
			BufferLineIndicatorVisible = { fg = "#21252B", bg = "#21252B" },
			BufferLineOffsetSeparator = { fg = "#21252B", bg = "#21252B" },
			DiagnosticHint = { fg = "#61AFEF", bg = "#282C34" },
			DiagnosticInfo = { fg = "#98C379", bg = "#282C34" },
			DiagnosticWarn = { fg = "#E7C787", bg = "#282C34" },
			DiagnosticError = { fg = "#E06C75", bg = "#282C34" },
			QuickFixLine = { fg = "#FFFFFF", bg = "#61AFEF", fmt = "bold" },

			DiffDelete = { fg = "#494C53", bg = "#282C34" },
			DiffAdd = { fg = nil, bg = "#273732" },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                               NEOTREE                                │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			NeoTreeNormal = { fg = nil, bg = "#21252B" },
			NeoTreeNormalNC = { fg = nil, bg = "#21252B" },
			NeoTreeRootName = { fg = "#E06C75", bg = "#21252B" },
			NeoTreeDotfile = { fg = "#5A5E64", bg = "#21252B" },
			NeoTreeVertSplit = { fg = "#21252B", bg = "#21252B" },
			NeoTreeStatusLin = { fg = "#21252B", bg = "#21252B" },
			NeoTreeStatusLine = { fg = nil, bg = "#21252B" },
			NeoTreeSignColumn = { fg = "#21252B", bg = "#21252B" },
			NeoTreeEndOfBuffer = { fg = "#21252B", bg = "#21252B" },
			NeoTreeStatusLineNC = { fg = "#21252B", bg = "#21252B" },
			NeoTreeWinSeparator = { fg = "#21252B", bg = "#21252B" },
			NeoTreeExpander = { fg = "#4D5A5E", bg = "#21252B" },
			NeoTreeIndentMarker = { fg = "#3A4646", bg = "#21252B" },
			NeoTreeDirectoryName = { fg = "#ABB2BF", bg = "#21252B" },
			-- NeoTreeGitAdded            = { fg = "#5C6370" , bg = nil       },
			NeoTreeGitConflict = { fg = "#E86671", bg = "#21252B" },
			-- NeoTreeGitDeleted          = { fg = "#5C6370" , bg = nil       },
			-- NeoTreeGitIgnored          = { fg = "#5C6370" , bg = nil       },
			-- NeoTreeGitModified         = { fg = "#5C6370" , bg = nil       },
			-- NeoTreeGitRenamed          = { fg = "#5C6370" , bg = nil       },
			-- NeoTreeGitStaged           = { fg = "#5C6370" , bg = nil       },
			NeoTreeGitUnstaged = { fg = "#E86671", bg = "#21252B" },
			NeoTreeGitUntracked = { fg = "#E86671", bg = "#21252B" },
			NeoTreeFloatBorder = { fg = "#61afef", bg = "#21252B" },
			NeoTreeFloatNormal = { fg = "#61afef", bg = "#21252B" },
			NeoTreeCursorLine = { fg = "#CCDAD6", bg = "#323842" },
			NeoTreeTabActive = { fg = "#CCDAD6", bg = "#323842" },
			NeoTreeTabInactive = { fg = "#CCDAD6", bg = "#323842" },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                                Aerial                                │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			AerialEndOfBuffer = { fg = "#21252B", bg = "#21252B" },
			AerialNormal = { fg = "#ABB2BF", bg = "#21252B" },
			AerialSignColumn = { fg = "#21252B", bg = "#21252B" },
			AerialWinSeparator = { fg = "#21252B", bg = "#21252B" },
			AerialVertSplit = { fg = "#21252B", bg = "#21252B" },
			AerialGuid2 = { fg = "#3a4646", bg = "#3a4646" },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                              DASHBOARD                               │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			DashboardHeader = { fg = "#81A1C1", bg = nil },
			DashboardFooter = { fg = "#5E768E", bg = nil, fmt = "bold" },
			DashboardProjectTitle = { fg = "#56B6C2", bg = nil },
			DashboardProjectTitleIcon = { fg = "#56B6C2", bg = nil },
			DashboardProjectIcon = { fg = "#61AFEF", bg = nil },
			DashboardMruTitle = { fg = "#56B6C2", bg = nil },
			DashboardMruIcon = { fg = "#61AFEF", bg = nil },
			DashboardFiles = { fg = "#ABB2BF", bg = nil },
			DashboardShotCutIcon = { fg = "#56B6C2", bg = nil },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                              TELESCOPE                               │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			TelescopePromptPrefix = { fg = "#61AFEF", bg = nil },
			-- 设置选择器中选定项目的突出显示
			TelescopeSelection = { fg = "#c2c5cc", bg = "#323842" },
			TelescopeSelectionCaret = { fg = "#61AFEF", bg = nil },
			TelescopeMultiSelection = { fg = "#E06C75", bg = nil },
			TelescopeMultiIcon = { fg = "#E06C75", bg = nil },
			-- 边框高亮组
			TelescopeBorder = { fg = "#3A4646", bg = nil },
			TelescopePromptBorder = { fg = "#3A4646", bg = nil },
			TelescopeResultsBorder = { fg = "#3A4646", bg = nil },
			TelescopePreviewBorder = { fg = "#3A4646", bg = nil },
			-- 用于突出显示您匹配的字符。
			TelescopeMatching = { fg = "#ECEBE0", bg = nil },
			-- 用于突出显示Tiele
			TelescopeTitle = { fg = "#ABB2BF", bg = nil },
			TelescopeNormal = { fg = "#ABB2BF", bg = nil },
			TelescopeResultsTitle = { fg = "#ABB2BF", bg = nil },

			-- TelescopePromptNormal = { fg = nil, bg = "#282C34" },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                          TELESCOPE-RAINBOW                           │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			TSRainbowRed = { fg = "#E06C75", bg = nil },
			TSRainbowYellow = { fg = "#E5C07B", bg = nil },
			TSRainbowBlue = { fg = "#61AFEF", bg = nil },
			TSRainbowOrange = { fg = "#EBD09C", bg = nil },
			TSRainbowGreen = { fg = "#98C379", bg = nil },
			TSRainbowViolet = { fg = "#C678DD", bg = nil },
			TSRainbowCyan = { fg = "#56B6C2", bg = nil },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                              NEOVIM-LSP                              │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			DiagnosticVirtualTextHint = { fg = "#61AFEF", bg = "#3B3F4C" },
			DiagnosticVirtualTextInfo = { fg = "#98C379", bg = "#3B3F4C" },
			DiagnosticVirtualTextWarn = { fg = "#E7C787", bg = "#3B3F4C" },
			DiagnosticVirtualTextError = { fg = "#E06C75", bg = "#3B3F4C" },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                                 CMP                                  │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			CmPmenu = { fg = nil, bg = "#20242D" },
			CMPPmenu = { fg = nil, bg = "#20242D" },
			CmpBorder = { fg = "#181a1f", bg = "#20242D" },
			CmpDocBorder = { fg = "#181a1f", bg = "#20242D" },
			CMPPmenuSel = { fg = "#FFFFFF", bg = "#61AFEF" },
			CmpItemAbbrDeprecated = { fg = "#61AFEF", bg = nil },
			CmpItemAbbr = { fg = "#ABB2BF", bg = nil },
			CmpItemAbbrMatch = { fg = "#C678DD", bg = nil },
			CmpItemKindConstant = { fg = "#d19a66", bg = nil },
			CmpItemKindFunction = { fg = "#61afef", bg = nil },
			CmpItemKindIdentifier = { fg = "#e06c75", bg = nil },
			CmpItemKindField = { fg = "#e06c75", bg = nil },
			CmpItemKindVariable = { fg = "#c678dd", bg = nil },
			CmpItemKindSnippet = { fg = "#e06c75", bg = nil },
			CmpItemKindText = { fg = "#98c379", bg = nil },
			CmpItemKindStructure = { fg = "#c678dd", bg = nil },
			CmpItemKindType = { fg = "#e5c07b", bg = nil },
			CmpItemKindKeyword = { fg = "#c8ccd4", bg = nil },
			CmpItemKindMethod = { fg = "#61afef", bg = nil },
			CmpItemKindConstructor = { fg = "#61afef", bg = nil },
			CmpItemKindFolder = { fg = "#c8ccd4", bg = nil },
			CmpItemKindModule = { fg = "#e5c07b", bg = nil },
			CmpItemKindProperty = { fg = "#e06c75", bg = nil },
			CmpItemKindUnit = { fg = "#c678dd", bg = nil },
			CmpItemKindFile = { fg = "#c8ccd4", bg = nil },
			CmpItemKindColor = { fg = "#e06c75", bg = nil },
			CmpItemKindReference = { fg = "#abb2bf", bg = nil },
			CmpItemKindStruct = { fg = "#c678dd", bg = nil },
			CmpItemKindOperator = { fg = "#abb2bf", bg = nil },
			CmpItemKindTypeParameter = { fg = "#e06c75", bg = nil },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                               DEVICONS                               │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			-- DevIconDefault = { fg = "#E06C75", bg = nil },
			DevIconc = { fg = "#61AFEF", bg = nil },
			DevIconcss = { fg = "#61AFEF", bg = nil },
			DevIcondeb = { fg = "#56B6C2", bg = nil },
			DevIconDockerfile = { fg = "#56B6C2", bg = nil },
			DevIconhtml = { fg = "#db91df", bg = nil },
			DevIconjpeg = { fg = "#C678DD", bg = nil },
			DevIconjpg = { fg = "#C678DD", bg = nil },
			DevIconjs = { fg = "#EBD09C", bg = nil },
			DevIconkt = { fg = "#E0AF68", bg = nil },
			DevIconlock = { fg = "#E06C75", bg = nil },
			DevIconlua = { fg = "#61AFEF", bg = nil },
			DevIconmp3 = { fg = "#ABB2BF", bg = nil },
			DevIconmp4 = { fg = "#ABB2BF", bg = nil },
			DevIconout = { fg = "#ABB2BF", bg = nil },
			DevIconpng = { fg = "#C678DD", bg = nil },
			DevIconpy = { fg = "#56B6C2", bg = nil },
			DevIcontoml = { fg = "#61AFEF", bg = nil },
			DevIconts = { fg = "#61AFEF", bg = nil },
			DevIconttf = { fg = "#ABB2BF", bg = nil },
			DevIconrb = { fg = "#db91df", bg = nil },
			DevIconrpm = { fg = "#E0AF68", bg = nil },
			DevIconvue = { fg = "#98C379", bg = nil },
			DevIconwoff = { fg = "#ABB2BF", bg = nil },
			DevIconwoff2 = { fg = "#ABB2BF", bg = nil },
			DevIconxz = { fg = "#EBD09C", bg = nil },
			DevIconzip = { fg = "#E0AF68", bg = nil },
			DevIconZig = { fg = "#E0AF68", bg = nil },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                              TREESITTER                              │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			["@annotation"] = { fg = "#be5046" },
			["@attribute"] = { fg = "#e5c07b" },
			["@character"] = { fg = "#98c379" },
			["@constructor"] = { fg = "#56b6c2" },
			["@constant.builtin"] = { fg = "#d19a66" },
			["@constant.macro"] = { fg = "#98c379" },
			["@error"] = { fg = "#98c379" },
			["@exception"] = { fg = "#98c379" },
			["@float"] = { fg = "#d19a66" },
			["@keyword"] = { fg = "#c678dd" },
			["@keyword.function"] = { fg = "#c678dd" },
			["@keyword.return"] = { fg = "#c678dd" },
			["@function"] = { fg = "#61afef" },
			["@function.builtin"] = { fg = "#61afef" },
			["@function.macro"] = { fg = "#98c379" },
			["@keyword.operator"] = { fg = "#c678dd" },
			["@method"] = { fg = "#61afef" },
			["@namespace"] = { fg = "#98c379" },
			["@none"] = { fg = "#abb2bf" },
			["@parameter"] = { fg = "#98c379" },
			["@reference"] = { fg = "#abb2bf" },
			["@punctuation.bracket"] = { fg = "#be5046" },
			["@punctuation.delimiter"] = { fg = "#be5046" },
			["@punctuation.special"] = { fg = "#98c379" },
			["@string.regex"] = { fg = "#56b6c2" },
			["@string.escape"] = { fg = "#56b6c2" },
			["@symbol"] = { fg = "#98c379" },
			["@tag"] = { fg = "#98c379" },
			["@tag.attribute"] = { fg = "#98c379" },
			["@tag.delimiter"] = { fg = "#be5046" },
			["@text"] = { fg = "#abb2bf" },
			["@text.strong"] = { fg = "#e06c75", fmt = "underline" },
			["@text.emphasis"] = { fg = "#d19a66" },
			["@text.strike"] = { fg = "#565c64", fmt = "strikethrough" },
			["@text.literal"] = { fg = "#d19a66" },
			["@text.uri"] = { fg = "#d19a66", fmt = "underline" },
			["@type.builtin"] = { fg = "#e5c07b" },
			["@variable"] = { fg = "#abb2bf" },
			["@variable.builtin"] = { fg = "#d19a66" },
			["@conceal"] = { fg = "#61afef", bg = nil },
			["conceal"] = { fg = "#282C34", bg = "#282C34" },
			["ConcealBrackets"] = { fg = "#61afef", bg = nil },
			-- variable.global
			["@definition"] = { sp = "#565c64", fmt = "underline" },
			TSDefinitionUsage = { sp = "#565c64", fmt = "underline" },
			["@scope"] = { fmt = "bold" },
			["@field"] = { fg = "#98c379" },
			-- ["@field.key"] = { fg = "#61afef", },
			["@property"] = { fg = "#98c379" },
			["@include"] = { fg = "#c678dd" },
			["@conditional"] = { fg = "#c678dd" },

			-- TSAnnotation = { fg = "#be5046", bg = nil, nil },
			-- TSAttribute = { fg = "#e5c07b", bg = nil, nil },
			-- TSTagAttribute = { fg = "#e06c75", bg = nil, nil },
			-- TSCharacter = { fg = "#e06c75", bg = nil, nil },
			-- TSConstructor = { fg = "#56b6c2", bg = nil, nil },
			-- TSConstBuiltin = { fg = "#d19a66", bg = nil, nil },
			-- TSConstMacro = { fg = "#e06c75", bg = nil, nil },
			-- TSError = { fg = "#e06c75", bg = nil, nil },
			-- TSException = { fg = "#e06c75", bg = nil, nil },
			-- TSFloat = { fg = "#d19a66", bg = nil, nil },
			-- TSKeyword = { fg = "#c678dd", bg = nil, nil },
			-- TSKeywordFunction = { fg = "#c678dd", bg = nil, nil },
			-- TSKeywordReturn = { fg = "#c678dd", bg = nil, nil },
			-- TSFunction = { fg = "#61afef", bg = nil, nil },
			-- TSFuncBuiltin = { fg = "#61afef", bg = nil, nil },
			-- TSFuncMacro = { fg = "#e06c75", bg = nil, nil },
			-- TSKeywordOperator = { fg = "#c678dd", bg = nil, nil },
			-- TSMethod = { fg = "#61afef", bg = nil, nil },
			-- TSNamespace = { fg = "#e06c75", bg = nil, nil },
			-- TSNone = { fg = "#abb2bf", bg = nil, nil },
			-- TSParameter = { fg = "#e06c75", bg = nil, nil },
			-- TSParameterReference = { fg = "#abb2bf", bg = nil, nil },
			-- TSPunctBracket = { fg = "#be5046", bg = nil, nil },
			-- TSPunctDelimiter = { fg = "#be5046", bg = nil, nil },
			-- TSPunctSpecial = { fg = "#e06c75", bg = nil, nil },
			-- TSStringRegex = { fg = "#56b6c2", bg = nil, nil },
			-- TSStringEscape = { fg = "#56b6c2", bg = nil, nil },
			-- TSSymbol = { fg = "#98c379", bg = nil, nil },
			-- TSTagDelimiter = { fg = "#be5046", bg = nil, nil },
			-- TSText = { fg = "#abb2bf", bg = nil, nil },
			-- TSStrong = { fg = nil, bg = nil, fmt = "bold" },
			-- TSEmphasis = { fg = "#d19a66", bg = nil, nil },
			-- TSStrike = { fg = "base00", bg = nil, fmt = "strikethrough" },
			-- TSLiteral = { fg = "#d19a66", bg = nil, nil },
			-- TSURI = { fg = "#d19a66", bg = nil, fmt = "underline" },
			-- TSTypeBuiltin = { fg = "#e5c07b", bg = nil, nil },
			-- TSVariableBuiltin = { fg = "#d19a66", bg = nil, nil },
			-- TSVariable = { fg = "#abb2bf", bg = nil, nil },
			-- TSDefinition = { fg = nil, bg = nil, fmt = "underline" },
			-- TSCurrentScope = { fg = nil, bg = nil, fmt = "bold" },
			-- luaTSField = { fg = "#61afef", bg = nil, nil },
			-- TSFieldKey = { fg = "#e06c75", bg = nil, nil },
			-- TSProperty = { fg = "#e06c75", bg = nil, nil },
			-- TSInclude = { fg = "#c678dd", bg = nil, nil },
			-- TSConditional = { fg = "#c678dd", bg = nil, nil },

			TreesitterContextBottom = { fg = nil, bg = nil, fmt = "bold" },
			TreesitterContext = { fg = nil, bg = nil, fmt = "bold" },
			TreesitterContextLineNumbe = { fg = "#5c6370", bg = nil, fmt = "bold" },
			TreesitterContextLineNumber = { fg = "#5c6370", bg = nil, fmt = "bold" },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                             INDENTBLANK                              │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			IndentBlanklineChar = { fg = "#3A4646", bg = nil }, -- 缩进字符的突出显示
			IndentBlanklineSpaceChar = { fg = "#24acf2", bg = nil }, -- 空格字符的突出显示
			IndentBlanklineContextChar = { fg = "#757d98", bg = nil }, -- 空行上空格字符的突出显示
			IndentBlanklineContextStart = { fg = nil, bg = "#515A6B", fmt = "bold" }, -- 当前上下文第一行的高亮显示

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                                NOTIFY                                │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			NotifyERRORBorder = { fg = "#e06c75" },
			NotifyERRORIcon = { fg = "#e06c75" },
			NotifyERRORTitle = { fg = "#e06c75" },
			NotifyWARNBorder = { fg = "#fca2aa" },
			NotifyWARNIcon = { fg = "#fca2aa" },
			NotifyWARNTitle = { fg = "#fca2aa" },
			NotifyINFOBorder = { fg = "#98c379" },
			NotifyINFOIcon = { fg = "#98c379" },
			NotifyINFOTitle = { fg = "#98c379" },
			NotifyDEBUGBorder = { fg = "#42464e" },
			NotifyDEBUGIcon = { fg = "#42464e" },
			NotifyDEBUGTitle = { fg = "#42464e" },
			NotifyTRACEBorder = { fg = "#de98fd" },
			NotifyTRACEIcon = { fg = "#de98fd" },
			NotifyTRACETitle = { fg = "#de98fd" },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                                NOICE                                 │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			NoiceCursor = { bg = "#ABB2BF" },

			NoiceCmdlinePopupBorder = { fg = "#81A1C1" },
			NoiceCmdlinePopupBorderCmdline = { fg = "#81A1C1" },
			NoiceCmdlinePopupBorderInput = { fg = "#81A1C1" },
			NoiceCmdlineIcon = { fg = "#81A1C1" },
			NoicePopupmenuBorder = { fg = "#81A1C1" },
			NoicePopupBorder = { fg = "#81A1C1" },

			NoiceCmdlineIconIncRename = { fg = "#E06C75" },
			NoiceCmdlinePopupBorderIncRename = { fg = "#E06C75" },

			Noice_DiagnosticInfo = { fg = "#81A1C1" },
			Noice_Normal = { bg = "#282c34" },
			NoicePopupmenuSelected = { fg = "#E9FBFE", bg = "#5CA4E0" },

			NoiceScrollbar = { bg = "#282C34" },

			NoiceSplit = { bg = "#282C34" },

			--   ╭──────────────────────────────────────────────────────────────────────╮
			--   │                              which-key                               │
			--   ╰──────────────────────────────────────────────────────────────────────╯

			WhichKeyFloat = { bg = "#21252B" },
		},

		-- Plugins Config --
		diagnostics = {
			darker = true, -- darker colors for diagnostic
			undercurl = true, -- use undercurl instead of underline for diagnostics
			background = true, -- use background color for virtual text
		},
	},

	config = function(_, opts)
		require("onedark").setup(opts)
		require("onedark").load()
	end,
}
