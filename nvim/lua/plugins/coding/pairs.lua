--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                            PLUGINS: Pair                             │
--   │                                                                      │
--   │              https://github.com/echasnovski/mini.pairs               │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"echasnovski/mini.pairs",
	lazy = true,
	event = "InsertEnter",
	config = function(_, opts)
		require("mini.pairs").setup(opts)
	end,
}
