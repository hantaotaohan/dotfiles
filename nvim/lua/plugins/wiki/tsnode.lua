return {
	{
		"atusy/tsnode-marker.nvim",
		enabled = true,
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("tsnode-marker-markdown", {}),
				pattern = "markdown",
				callback = function(ctx)
					require("tsnode-marker").set_automark(ctx.buf, {
						target = { "fenced_code_block", "code_fence_content" }, -- list of target node types
						hl_group = "CursorLine", -- highlight group
					})
				end,
			})
		end,
	},
}
