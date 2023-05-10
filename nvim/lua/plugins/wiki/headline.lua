--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                              Headlines                               │
--   │                                                                      │
--   │           https://github.com/lukas-reineke/headlines.nvim            │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"lukas-reineke/headlines.nvim",
	ft = "markdown",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = function()
		require("headlines").setup({
			markdown = {
				query = vim.treesitter.query.parse(
					"markdown",
					[[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
            ]]
				),
				source_pattern_start = "^```",
				source_pattern_end = "^```$",
				-- headline_pattern = "^#+",
				headline_highlights = { "Headline1", "Headline2" },
				codeblock_highlight = "CodeBlock",
				dash_highlight = "Dash",
				dash_string = "", -- alts:  靖並   ﮆ  -
				quote_highlight = "Quote",
				quote_string = "┃",
				fat_headlines = false,
				fat_headline_upper_string = "▃",
				fat_headline_lower_string = "🬂",
			},
		})
		vim.cmd([[highlight Headline1 guibg=#282c34 guifg=#61afef]])
		vim.cmd([[highlight Headline2 guibg=#282c34 guifg=#ec057b]])
	end,
}
