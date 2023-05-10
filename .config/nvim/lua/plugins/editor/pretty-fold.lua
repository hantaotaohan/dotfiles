--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                         PLUGINS: Pretty_Fold                         │
--   │                                                                      │
--   │            https://github.com/anuvyklack/pretty-fold.nvim            │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"anuvyklack/pretty-fold.nvim",
	event = "VeryLazy",
	opts = {
		keep_indentation = false,
		remove_fold_markers = true,
		process_comment_signs = false,
		fill_char = "─",
		sections = {
			left = {
				"  ┃",
				function()
					return string.rep(" FOLDED ", vim.v.foldlevel)
				end,
				"┃   ",
				"content",
				-- function()
				-- 	return string.format("%30s", content)
				-- end,
				"┣",
			},
			right = {
				"┫  ",
				"number_of_folded_lines",
				": ",
				"percentage",
				"  ┃  ",
			},
		},
		matchup_patterns = {

			{ "^%s*do$", "end" }, -- do ... end blocks
			{ "^%s*if", "end" }, -- if ... end
			{ "^%s*for", "end" }, -- for
			{ "function%s*%(", "end" }, -- 'function( or 'function (''
			{ "{", "}" },
			{ "%(", ")" }, -- % to escape lua pattern char
			{ "%[", "]" }, -- % to escape lua pattern char
		},
	},
}
