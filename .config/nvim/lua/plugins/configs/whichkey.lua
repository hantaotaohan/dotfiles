local present, which_key = pcall(require, "which-key")

if not present then
	return
end

local options = {
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "  ", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},

	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},

	window = {
		border = "single", -- none/single/double/shadow
	},

	layout = {
		spacing = 6, -- spacing between columns
        align = "center",
	},

	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		i = { "j", "k" },
		v = { "j", "k" },
		n = { "<", ">", ";" },
	},
}

which_key.setup(options)
