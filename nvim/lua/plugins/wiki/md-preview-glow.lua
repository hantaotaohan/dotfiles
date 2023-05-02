--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           Markdown_Preview                           │
--   │                                                                      │
--   │                                                                      │
--   │           https://github.com/0x00-ketsu/markdown-preview.nvim        │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"0x00-ketsu/markdown-preview.nvim",
	name = "mdp",
	ft = { "md", "markdown", "mkd", "mkdn", "mdwn", "mdown", "mdtxt", "mdtext", "rmd", "wiki" },
	config = function()
		require("markdown-preview").setup({
			glow = {
				-- When find executable path of `glow` failed (from PATH), use this value instead
				exec_path = "",
			},
			-- Markdown preview term
			term = {
				-- reload term when rendered markdown file changed
				reload = {
					enable = true,
					events = { "InsertLeave", "TextChanged" },
				},
				direction = "vertical", -- choices: vertical / horizontal
				keys = {
					close = { "<LocalLeader>q", "<Esc>" },
					refresh = "r",
				},
			},
		})
	end,
}
