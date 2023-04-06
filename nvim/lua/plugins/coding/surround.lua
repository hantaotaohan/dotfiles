--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                          PLUGINS: Surround                           │
--   │                                                                      │
--   │             https://github.com/echasnovski/mini.surround             │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"echasnovski/mini.surround",
	lazy = true,
	keys = function(_, keys)
		-- Populate the keys based on the user's options
		local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
		local opts = require("lazy.core.plugin").values(plugin, "opts", false)
		local mappings = {
			{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
			{ opts.mappings.delete, desc = "Delete surrounding" },
			{ opts.mappings.find, desc = "Find right surrounding" },
			{ opts.mappings.find_left, desc = "Find left surrounding" },
			{ opts.mappings.highlight, desc = "Highlight surrounding" },
			{ opts.mappings.replace, desc = "Replace surrounding" },
			{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
		}
		mappings = vim.tbl_filter(function(m)
			return m[1] and #m[1] > 0
		end, mappings)
		return vim.list_extend(mappings, keys)
	end,
	opts = {
		mappings = {
			add = "S", -- Add surrounding in Normal and Visual modes
			delete = "ds", -- Delete surrounding
			replace = "cs", -- Replace surrounding
			-- find = "gzf", -- Find surrounding (to the right)
			-- find_left = "gzF", -- Find surrounding (to the left)
			-- highlight = "gzh", -- Highlight surrounding
			-- update_n_lines = "gzn", -- Update `n_lines`
		},
	},
	config = function(_, opts)
		-- use gz mappings instead of s to prevent conflict with leap
		require("mini.surround").setup(opts)
	end,
}
