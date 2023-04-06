--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           Markdown_Preview                           │
--   │                                                                      │
--   │                                                                      │
--   │           https://github.com/iamcco/markdown-preview.nvim            │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"iamcco/markdown-preview.nvim",
	ft = { "markdown", "vimwiki.makrdown", "md" },
	config = function()
		vim.cmd(":call mkdp#util#install()")
	end,
}
