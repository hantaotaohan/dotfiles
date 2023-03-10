--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                               VimWiki                                │
--   │                                                                      │
--   │                  https://github.com/vimwiki/vimwiki                  │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	{
		"vimwiki/vimwiki",
		branch = "dev",
		ft = "vimwiki",
		keys = {
			{ "<leader>ww", "<plug>VimwikiIndex", desc = "Open Vimwiki" },
			{ "<leader>w<leader>w", "<plug>VimwikiDiaryIndex", desc = "Open Vimwiki diary" },
		},
		init = function()
			vim.g.vimwiki_list = {
				{
					path = "$HOME/vimwiki/",
					syntax = "markdown",
					ext = ".md",
					name = "wiki",
					index = "index",
					diary_rel_path = "Diary/",
					diary_index = "Diary",
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
			vim.g.vimwiki_filetypes = { "markdown" }
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
				"b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1,nav,body,aside,p,blockquote,ul,ol,li"
		end,
		config = function()
			vim.cmd([[
                augroup VimWikiSettings
                    autocmd!
                    let g:vimwiki_syntaxlocal_vars['markdown']['Link1'] = g:vimwiki_syntaxlocal_vars['default']['Link1']
                    autocmd FileType vimwiki.markdown highlight MarkdownTrailingSpaces ctermbg=green guibg=green
                    autocmd FileType vimwiki.markdown syntax match MarkdownTrailingSpaces "\s\{4}.*$"
                    autocmd FileType vimwiki.markdown syntax region VimwikiBlockquote start=/^\s*>/ end="$"
                    autocmd FileType vimwiki.markdown highlight VimwikiBlockquote guifg=#545965 guibg=#23272E
                    autocmd BufEnter *.md if &ft == "vimwiki.markdown" | setlocal filetype=vimwiki.markdown | endif
                    autocmd FileType vimwiki.markdown highlight VimwikiLink       guifg=#61afef
                    autocmd FileType vimwiki.markdown highlight VimwikiHeader1    guifg=#e5c07b
                    autocmd FileType vimwiki.markdown highlight VimwikiHeader2    guifg=#98c379
                    autocmd FileType vimwiki.markdown highlight VimwikiHeader3    guifg=#c678dd
                    autocmd FileType vimwiki.markdown highlight VimwikiHeader4    guifg=#8096BF
                    autocmd FileType vimwiki.markdown highlight VimwikiHeader5    guifg=#8096BF
                    autocmd FileType vimwiki.markdown highlight VimwikiHeader6    guifg=#8096BF
                    autocmd FileType vimwiki.markdown highlight VimwikiH1Folding  guifg=#e5c07b
                    autocmd FileType vimwiki.markdown highlight VimwikiH2Folding  guifg=#98c379
                    autocmd FileType vimwiki.markdown highlight VimwikiH3Folding  guifg=#c678dd
                    autocmd FileType vimwiki.markdown highlight VimwikiH4Folding  guifg=#8096BF
                    autocmd FileType vimwiki.markdown highlight VimwikiH5Folding  guifg=#8096BF
                    autocmd FileType vimwiki.markdown highlight VimwikiH6Folding  guifg=#8096BF
                    autocmd FileType vimwiki.markdown highlight VimwikiBold       guifg=#E06C75
            ]])
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                                Zettel                                │
	--   │                                                                      │
	--   │               https://github.com/michal-h21/vim-zettel               │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"michal-h21/vim-zettel",
		cmd = { "VimwikiIndex", "VimwikiMakeDiaryNote" },
		config = function()
			vim.g.zettel_format = "%title"
			vim.g.zettel_link_format = "[[%title]]"
			vim.g.zettel_fzf_command = "rg --column --ignore-case --no-heading --color=always"
			vim.g.zettel_options = { disable_front_matter = 1 }
		end,
	},
}
