--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           PLUGINS: Wiki                              │
--   │                                                                      │
--   │                  https://github.com/lervag/wiki.vim                  │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	enabled = false,
	"lervag/wiki.vim",
	-- keys = {
	-- 	{ "<leader>ww", "<plug>VimwikiIndex", desc = "Open Vimwiki" },
	-- 	{ "<leader>w<leader>w", "<plug>VimwikiDiaryIndex", desc = "Open Vimwiki Diary" },
	-- 	{ "<leader>w<leader>t", "<plug>VimwikiMakeDiaryNote", desc = "Open Vimwiki Diary For Today" },
	-- },
	config = function()
		vim.g.wiki_cache_root = "~/.cache/wiki.vim/"
		vim.g.wiki_cache_persistent = 1
		vim.g.wiki_completion_enabled = 1
		vim.g.wiki_completion_case_sensitive = 1
		vim.g.wiki_filetypes = { "md" }
		vim.g.wiki_fzf_pages_force_create_key = "alt-enter"
		vim.g.wiki_fzf_pages_opts = "--preview 'cat {1}'"
		vim.g.wiki_fzf_tags_opts = "--preview 'bat --color=always {2..}'"
		vim.g.wiki_global_load = 1
		vim.g.wiki_select_method = "ui_select"
		vim.g.wiki_index_name = "index"
		vim.g.wiki_link_extension = ""
		vim.g.wiki_link_toggle_on_follow = 0
		vim.g.wiki_link_target_type = "wiki"
		vim.g.wiki_root = "~/wiki"
		vim.g.wiki_toc_title = "Contents"
		vim.g.wiki_write_on_nav = 1
		-- vim.g.wiki_viewer._ = "xdg-open"
		-- vim.g.wiki_map_text_to_link = ""

		vim.g.wiki_tag_list = {
			["output"] = "loclist",
		}

		vim.g.wiki_tag_search = {
			["output"] = "loclist",
		}

		vim.g.wiki_journal = {
			["name"] = "daily",
			["root"] = "",
			["frequency"] = "daily",
			["date_format"] = {
				["daily"] = "%Y-%m-%d",
				["weekly"] = "",
				["monthly"] = "",
			},
		}

		vim.g.wiki_export = {
			["args"] = "",
			["from_format"] = "markdown",
			["ext"] = "pdf",
			["link_ext_replace"] = false,
			["view"] = false,
			["output"] = vim.fn.fnamemodify(vim.fn.tempname(), ":h"),
		}

		vim.cmd([[
                augroup WikiSettings
                    autocmd!
                    autocmd FileType markdown highlight htmlH1 ctermbg=1 guifg=#E06C75
            ]])
	end,
}
