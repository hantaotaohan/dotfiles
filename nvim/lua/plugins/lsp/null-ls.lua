--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                               Null_Ls                                │
--   │                                                                      │
--   │          https://github.com/jose-elias-alvarez/null-ls.nvim          │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"jose-elias-alvarez/null-ls.nvim",
	lazy = true,
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "mason.nvim" },
	opts = function()
		local nls = require("null-ls")
		return {
			sources = {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.shfmt,
				-- nls.builtins.formatting.stylua,
				-- nls.builtins.formatting.shfmt,
				-- nls.builtins.diagnostics.flake8,
			},
		}
	end,
}
