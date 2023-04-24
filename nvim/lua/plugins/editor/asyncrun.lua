--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                          PLUGINS: Asyncrun                           │
--   │                                                                      │
--   │             https://github.com/skywind3000/asyncrun.vim              │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"skywind3000/asyncrun.vim",
	-- cmd = { "AsyncRun", "AsyncStop", "AsyncReset" },
	keys = {
		{ "<LocalLeader>rr", "RunCode_Quick", "RunCode_Quick" },
		{ "<LocalLeader>re", "RunCode_Term", "RunCode_Term" },
	},
	config = function()
		vim.g.asyncrun_open = 6
		vim.g.asyncrun_trim = 0
		vim.g.asyncrun_save = 1
		-- vim.g.asyncrun_status = "stopped"
		vim.g.asyncrun_status = ""
		vim.g.asyncrun_rootmarks = { "pom.xml", ".git", ".svn", ".root", ".project", ".hg" }

		function RunCode_Quick()
			local filetype = vim.o.filetype
			if filetype == "lua" then
				vim.cmd([[ AsyncRun -mode=1 -strip -cwd=$(VIM_FILEDIR) lua "$(VIM_FILEPATH)" ]])
				vim.cmd([[wincmd p]])
			elseif filetype == "sh" then
				vim.cmd([[ AsyncRun -mode=1 -strip -cwd=$(VIM_FILEDIR) bash "$(VIM_FILEPATH)" ]])
				vim.cmd([[wincmd p]])
			elseif filetype == "python" then
				vim.api.nvim_command('AsyncRun -mode=1 -cwd=$(VIM_FILEDIR) python3 "$(VIM_FILEPATH)"')
				vim.cmd([[wincmd p]])
			elseif filetype == "markdown" or filetype == "vimwiki.markdown" then
				vim.api.nvim_command("MarkdownPreviewToggle")
			end
		end

		function RunCode_Term()
			local filetype = vim.o.filetype
			if filetype == "lua" then
				vim.cmd([[ AsyncRun -mode=term -strip -listed=0 -rows=20 -cwd=$(VIM_FILEDIR) lua "$(VIM_FILEPATH)" ]])
			elseif filetype == "sh" then
				vim.cmd([[ AsyncRun -mode=term -strip -listed=0 -rows=20 -cwd=$(VIM_FILEDIR) bash "$(VIM_FILEPATH)" ]])
			elseif filetype == "python" then
				vim.api.nvim_command(
					'AsyncRun -mode=term -strip -listed=0 -rows=20 -cwd=$(VIM_FILEDIR) python3 "$(VIM_FILEPATH)"'
				)
			elseif filetype == "markdown" or filetype == "vimwiki.markdown" then
				vim.api.nvim_command("MarkdownPreviewToggle")
			end
		end

		vim.keymap.set("n", "<LocalLeader>rr", RunCode_Quick, { noremap = true, silent = true })
		vim.keymap.set("n", "<LocalLeader>re", RunCode_Term, { noremap = true, silent = true })
	end,
}
