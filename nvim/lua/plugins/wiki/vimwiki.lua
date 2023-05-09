--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           PLUGINS: VimWiki                           │
--   │                                                                      │
--   │                  https://github.com/vimwiki/vimwiki                  │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"vimwiki/vimwiki",
	branch = "dev",
	ft = "vimwiki",
	keys = {
		{ "<leader>ww", "<plug>VimwikiIndex", desc = "Open Vimwiki" },
		{ "<leader>w<leader>w", "<plug>VimwikiDiaryIndex", desc = "Open Vimwiki Diary" },
		{ "<leader>w<leader>t", "<plug>VimwikiMakeDiaryNote", desc = "Open Vimwiki Diary For Today" },
	},
	init = function()
		vim.g.vimwiki_list = {
			{
				path_html = "html",
				custom_wiki2html = "/home/taotao/go/bin/vimwiki-godown",
				template_path = "$HOME/.vim/script/markdown-preview-style/onedark",
				template_default = "template_dark",
				template_ext = ".tpl",
				path = "$HOME/wiki/",
				syntax = "markdown",
				ext = ".md",
				name = "wiki",
				index = "index",
				diary_rel_path = "diary/",
				diary_index = "diary",
				maxhi = 1,
				auto_toc = 1,
				auto_tags = 1,
				auto_generate_links = 1,
				auto_generate_tags = 1,
				nested_syntaxes = {
					["python"] = "python",
					["c++"] = "cpp",
				},
			},
		}

		vim.g.vimwiki_ext2syntax = {
			[".md"] = "markdown",
			[".markdown"] = "markdown",
			[".mdown"] = "markdown",
		}

		vim.g.vimwiki_global_ext = 1
		vim.g.vimwiki_auto_chdir = 1
		vim.g.vimwiki_conceal_pre = 1
		vim.g.vimwiki_conceallevel = 2
		vim.g.vimwiki_folding = "custom"
		-- vim.g.vimwiki_filetypes = { "markdown" }
		vim.g.vimwiki_CJK_length = 1
		vim.g.vimwiki_hl_cb_checked = 2
		vim.g.vimwiki_use_mouse = 0
		vim.g.vimwiki_markdown_link_ext = 1
		vim.g.vimwiki_list_margin = 0
		vim.g.vimwiki_auto_diary_index = 1
		vim.g.vimwiki_auto_generate_links = 1
		vim.g.vimwiki_toc_header_level = 2
		vim.g.vimwiki_links_header_level = 2
		vim.g.vimwiki_diary_header = "Diary"
		vim.g.vimwiki_tags_header_level = 2
		vim.g.vimwiki_tag_format = {
			["pre"] = "tags:.*",
			["pre_mark"] = "[",
			["post_mark"] = "]",
			["sep"] = ",",
		}
		vim.g.vimwiki_valid_html_tags =
			"b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1,nav,body,aside,p,blockquote,ul,ol,li,script,pre"
	end,
	config = function()
		vim.cmd([[
		              augroup VimWikiSettings
		                  autocmd!
		                  let g:vimwiki_syntaxlocal_vars['markdown']['Link1'] = g:vimwiki_syntaxlocal_vars['default']['Link1']
                          autocmd FileType vimwiki inoremap <silent><buffer> <LocalLeader><CR> <Esc>:VimwikiReturn 2 2<CR>
		                  " autocmd FileType vimwiki.markdown syntax match MarkdownTrailingSpaces "\s\{4}.*$"
		                  " autocmd FileType vimwiki.markdown syntax region VimwikiBlockquote start=/^\s*>/ end="$"
		                  " autocmd FileType vimwiki.markdown highlight VimwikiBlockquote guifg=#6d7179 guibg=#21252B
		                  " autocmd FileType vimwiki.markdown highlight MarkdownTrailingSpaces guifg=#abb2bf guibg=#393b40
		                  " autocmd BufEnter *.md if &ft == "vimwiki.markdown" | setlocal filetype=vimwiki.markdown | endif
		                  " autocmd FileType vimwiki.markdown highlight VimwikiLink       guifg=#61afef
		                  " autocmd FileType vimwiki.markdown highlight VimwikiHeader1    guifg=#e5c07b
		                  " autocmd FileType vimwiki.markdown highlight VimwikiHeader2    guifg=#98c379
		                  " autocmd FileType vimwiki.markdown highlight VimwikiHeader3    guifg=#c678dd
		                  " autocmd FileType vimwiki.markdown highlight VimwikiHeader4    guifg=#8096BF
		                  " autocmd FileType vimwiki.markdown highlight VimwikiHeader5    guifg=#8096BF
		                  " autocmd FileType vimwiki.markdown highlight VimwikiHeader6    guifg=#8096BF
		                  " autocmd FileType vimwiki.markdown highlight VimwikiH1Folding  guifg=#e5c07b
		                  " autocmd FileType vimwiki.markdown highlight VimwikiH2Folding  guifg=#98c379
		                  " autocmd FileType vimwiki.markdown highlight VimwikiH3Folding  guifg=#c678dd
		                  " autocmd FileType vimwiki.markdown highlight VimwikiH4Folding  guifg=#8096BF
		                  " autocmd FileType vimwiki.markdown highlight VimwikiH5Folding  guifg=#8096BF
		                  " autocmd FileType vimwiki.markdown highlight VimwikiH6Folding  guifg=#8096BF
		                  " autocmd FileType vimwiki.markdown highlight VimwikiBold       guifg=#E06C75
		                  " autocmd FileType vimwiki.markdown highlight VimwikiItalic     guifg=#e5c07b  cterm=bold,italic gui=bold,italic
		          ]])

		vim.api.nvim_set_hl(0, "@text.title.h1", { fg = "#e86671" })
		vim.api.nvim_set_hl(0, "@text.title.h2", { fg = "#e5c07b" })
		vim.api.nvim_set_hl(0, "@text.title.h3", { fg = "#98c379" })
		vim.api.nvim_set_hl(0, "@text.title.h4", { fg = "#c678dd" })
		vim.api.nvim_set_hl(0, "@text.title.h5", { fg = "#8096BF" })
		vim.api.nvim_set_hl(0, "@text.title.h6", { fg = "#8096BF" })
		vim.api.nvim_set_hl(0, "@text.title.hh1", { fg = "#5c6370" })
		vim.api.nvim_set_hl(0, "@text.title.hh2", { fg = "#5c6370" })
		vim.api.nvim_set_hl(0, "@text.title.hh3", { fg = "#5c6370" })
		vim.api.nvim_set_hl(0, "@text.title.hh4", { fg = "#5c6370" })
		vim.api.nvim_set_hl(0, "@text.title.hh5", { fg = "#5c6370" })
		vim.api.nvim_set_hl(0, "@text.title.hh6", { fg = "#5c6370" })

		vim.api.nvim_set_hl(0, "@code.delimiter", { fg = "#e86671" })
		vim.api.nvim_set_hl(0, "@code.content", { fg = "#2c313c" })
		vim.api.nvim_set_hl(0, "@list.marks", { fg = "#c678dd" })
		vim.api.nvim_set_hl(0, "@task.checked", { fg = "#5c6370" })
		vim.api.nvim_set_hl(0, "@quote", { fg = "#6f737b" })
		vim.api.nvim_set_hl(0, "@quote.quote", { fg = "#6f737b" })
		vim.api.nvim_set_hl(0, "@text.link.title", { fg = "#61afef", underline = true })
		vim.api.nvim_set_hl(0, "@text.indented.code", { bg = "#282c34", fg = "#8096BF", underline = true })
		vim.api.nvim_set_hl(0, "@table.text.title", { fg = "#d19a66" })
		vim.api.nvim_set_hl(0, "@table.spe", { fg = "#5c6370" })
		vim.api.nvim_set_hl(0, "@text.strong", { fg = "#e06c75", underline = true, bold = true })
		vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#d19a66", italic = true })
		vim.api.nvim_set_hl(0, "@text.literal", { fg = "#c678dd", bg = nil })
		vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = "#e86671", bg = nil })
	end,
}
