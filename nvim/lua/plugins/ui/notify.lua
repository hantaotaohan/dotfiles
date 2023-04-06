--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           PLUGINS: Notify                            │
--   │                                                                      │
--   │               https://github.com/rcarriga/nvim-notify                │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"rcarriga/nvim-notify",
	keys = {
		{
			"<leader>un",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Delete all Notifications",
		},
	},
	opts = {
		stages = "fade_in_slide_out",
		on_open = nil,
		on_close = nil,
		render = "default",
		-- timeout = 3500,
		-- max_width = 150,
		-- max_height = 25,
		background_colour = "TabLine",
		minimum_width = 50,
		icons = {
			ERROR = " ",
			WARN = " ",
			INFO = " ",
			DEBUG = " ",
			TRACE = " ",
		},
		timeout = 3500,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	},
	init = function()
		-- when noice is not enabled, install notify on VeryLazy
		local Util = require("config.utility")
		if not Util.has("noice.nvim") then
			Util.on_very_lazy(function()
				vim.notify = require("notify")
			end)
		end
	end,
}
