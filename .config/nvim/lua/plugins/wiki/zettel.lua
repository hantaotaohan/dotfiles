--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                                Zettel                                │
--   │                                                                      │
--   │               https://github.com/michal-h21/vim-zettel               │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"michal-h21/vim-zettel",
	enabled = false,
	cmd = { "VimwikiIndex", "VimwikiMakeDiaryNote" },
	config = function()
		vim.g.zettel_format = "%title"
		vim.g.zettel_link_format = "[[%title]]"
		vim.g.zettel_fzf_command = "rg --column --ignore-case --no-heading --color=always"
		vim.g.zettel_options = { disable_front_matter = 1 }
	end,
}
