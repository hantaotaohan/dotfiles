--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                               asyncrun                               │
--   │                                                                      │
--   │             https://github.com/skywind3000/asyncrun.vim              │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {

	"skywind3000/asyncrun.vim",
	event = "VeryLazy",
	config = function()
		vim.g.asyncrun_open = 6
		-- vim.g.asyncrun_status = "stopped"
		vim.g.asyncrun_status = ""
		vim.g.asyncrun_rootmarks = { "pom.xml", ".git", ".svn", ".root", ".project", ".hg" }
	end,
}
