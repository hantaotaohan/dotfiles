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

		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 1
		vim.g.mkdp_refresh_slow = 0
		vim.g.mkdp_command_for_global = 0
		vim.g.mkdp_open_to_the_world = 0
		vim.g.mkdp_open_ip = ""
		vim.g.mkdp_browser = ""
		vim.g.mkdp_echo_preview_url = 0
		vim.g.mkdp_browserfunc = ""
		vim.g.mkdp_preview_options = {
			mkit = {},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = 0,
			sync_scroll_type = "middle",
			hide_yaml_meta = 1,
			sequence_diagrams = {},
			flowchart_diagrams = {},
			content_editable = false,
			disable_filename = 0,
			toc = {},
		}

		vim.g.mkdp_markdown_css = vim.fn.expand("~/.vim/script/markdown-preview-style/onedark/onedark.css")
		vim.g.mkdp_highlight_css = vim.fn.expand("~/.vim/script/markdown-preview-style/onedark/hightdark.css")
		vim.g.mkdp_port = ""
		vim.g.mkdp_page_title = "「${name}」"
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_theme = "dark"
	end,
}
