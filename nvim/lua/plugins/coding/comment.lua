--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           PLUGINS: Comment                           │
--   │                                                                      │
--   │               https://github.com/numToStr/Comment.nvim               │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"numToStr/Comment.nvim",
	lazy = true,
	event = "VeryLazy",
	config = function()
		require("Comment").setup({
			padding = true,
			sticky = true,
			ignore = nil,
			toggler = {
				line = "gcc",
				block = "gbc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
			extra = {
				above = "gcO",
				below = "gco",
				eol = "gcA",
			},
			mappings = {
				basic = true,
				extra = false,
				extended = false,
			},
			-- pre_hook = nil,
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			post_hook = nil,
		})
	end,
}
