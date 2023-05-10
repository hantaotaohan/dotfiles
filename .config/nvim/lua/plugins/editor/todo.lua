--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                        PLUGINS: Todo_Comments                        │
--   │                                                                      │
--   │             https://github.com/folke/todo-comments.nvim              │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"folke/todo-comments.nvim",
	lazy = true,
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Previous todo comment",
		},
		{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
		{ "<F7>", "<cmd>TodoDots<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
		{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
	},
	config = function()
		local function command(name, rhs, opts)
			opts = opts or {}
			vim.api.nvim_create_user_command(name, rhs, opts)
		end
		command("TodoDots", ("TodoTrouble cwd=%s keywords=TODO,PLUGINS"):format(vim.fn.expand("%:p:h")))
		require("todo-comments").setup({
			signs = false,
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				-- TODO = { icon = " ", color = "info" },
				-- HACK = { icon = " ", color = "warning" },
				-- WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				-- PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO", "PLUGINS" } },
				-- TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = {
				fg = "NONE", -- The gui style to use for the fg highlight group.
				bg = "BOLD", -- The gui style to use for the bg highlight group.
			},
			merge_keywords = true,
			highlight = {
				multiline = false, -- enable multine todo comments
				multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
				multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
				before = "", -- "fg" or "bg" or empty
				keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
				after = "fg", -- "fg" or "bg" or empty
				pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
				comments_only = true, -- uses treesitter to match keywords in comments only
				max_line_len = 400, -- ignore lines longer than this
				exclude = {
					"TelescopeResults",
					"query",
					"tsplayground",
					"lazy",
					"lsp-installer",
					"markdown",
					"mason",
					"txt",
					"dashboard",
					"alpha",
					"NvimTree",
					"undotree",
					"diff",
					"fugitive",
					"fugitiveblame",
					"Outline",
					"SidebarNvim",
					"packer",
					"lsp-installer",
					"TelescopePrompt",
					"help",
					"telescope",
					"lspinfo",
					"Trouble",
					"null-ls-info",
					"quickfix",
					"chadtree",
					"fzf",
					"NeogitStatus",
					"terminal",
					"console",
					"term://*",
					"Term://*",
					"toggleterm",
					"qf",
					"prompt",
					"noice",
					"",
				},
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				-- regex that will be used to match keywords.
				-- don't replace the (KEYWORDS) placeholder
				pattern = [[\b(KEYWORDS):]], -- ripgrep regex
				-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
			},
		})
	end,
}
