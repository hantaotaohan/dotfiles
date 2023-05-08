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
						target = { "fenced_code_block" },
						hl_group = "CursorLine",
						range = function(_, node)
							-- end_row and end_col may represent block_continuation,
							-- which is not actually a part of fenced_code_block
							local start_row, start_col, end_row, end_col = node:range()

							-- Patch the above range with the end position of
							-- fenced_code_block_delimiter.
							for i = node:child_count() - 1, 2, -1 do
								local n = node:child(i)
								if n:type() == "fenced_code_block_delimiter" then
									_, _, end_row, end_col = n:range()
								end
							end
							-- Return the patched range
							return start_row, start_col, end_row, end_col
						end,
					})
				end,
			})
		end,
	},
}
