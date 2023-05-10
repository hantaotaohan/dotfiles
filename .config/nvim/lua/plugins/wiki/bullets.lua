--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                               Bullets                                │
--   │                                                                      │
--   │                https;//github.com/dkarter/bullets.vim                │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"dkarter/bullets.vim",
	init = function() end,
	config = function()
		-- vim.g.bullets_renumber_on_change = 1
		-- vim.g.bullets_outline_levels = { "ROM", "ABC", "num", "abc", "rom", "std-", "std*", "std+" }
		vim.g.bullets_outline_levels = { "ROM", "ABC", "num", "abc", "rom", "std-" }
		vim.g.bullets_set_mappings = 0
		vim.g.bullets_custom_mappings = {
			{ "imap", "<cr>", "<Plug>(bullets-newline)" },
			{ "inoremap", "<C-cr>", "<cr>" },
			{ "nmap", "o", "<Plug>(bullets-newline)" },
			{ "vmap", "gN", "<Plug>(bullets-renumber)" },
			{ "nmap", "gN", "<Plug>(bullets-renumber)" },
			{ "nmap", "<leader>x", "<Plug>(bullets-toggle-checkbox)" },
			{ "imap", "<C-t>", "<Plug>(bullets-demote)" },
			{ "nmap", ">>", "<Plug>(bullets-demote)" },
			{ "vmap", ">", "<Plug>(bullets-demote)" },
			{ "imap", "<C-d>", "<Plug>(bullets-promote)" },
			{ "nmap", "<<", "<Plug>(bullets-promote)" },
			{ "vmap", "<", "<Plug>(bullets-promote)" },
		}
	end,
}
