--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                           PLUGINS: LuaSnip                           │
--   │                                                                      │
--   │                 https://github.com/L3MON4D3/LuaSnip                  │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	build = (not jit.os:find("Windows"))
			and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
		or nil,
	dependencies = {
		"rafamadriz/friendly-snippets",
		lazy = true,
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local i = ls.insert_node
		local f = ls.function_node
		local fmt = require("luasnip.extras.fmt").fmt

		local replace = function(index, char)
			return f(function(arg)
				return string.rep(char, string.len(arg[1][1]))
			end, { index })
		end

		local parse_comments = function()
			local iter = vim.gsplit(vim.o.comments, ",", true)
			local comments = { single = {}, triple = {}, other = {} }

			local split = function(cs)
				local flags, text = string.match(cs or "", "^([^:]*):([^:]*)$")
				return flags or "", text or ""
			end

			while true do
				local cs = iter()
				if not cs then
					break
				end
				local flags, text = split(cs)

				if #flags == 0 then
					-- Parse the single line comment string.
					table.insert(comments.other, 1, { start = text, mid = text, stop = text, indent = "" })
				elseif flags:match("s") and not flags:match("O") then
					-- Parse 3 part comment string, but ignore those with the O flag
					local ctriple = {}
					local indent = ""

					if string.match(flags:sub(-1), "%d+") then
						indent = string.rep(" ", flags:sub(-1))
					end
					ctriple.start = text

					cs = iter()
					flags, text = split(cs)
					assert(vim.startswith(flags, "m"), "Expected middle comment format of triple")
					ctriple.mid = text

					cs = iter()
					flags, text = split(cs)
					assert(vim.startswith(flags, "e"), "Expected end comment format of triple")
					ctriple.stop = text
					ctriple.indent = indent

					table.insert(comments.triple, 1, ctriple)
				elseif flags:match("b") then
					if #text == 1 then
						table.insert(comments.single, 1, { start = text, mid = text, stop = text, indent = "" })
					end
				end
			end

			return comments
		end

		local comment_format = function()
			if vim.o.commentstring:match("%%s$") then
				-- Remove last two characters
				local cf
				cf = vim.trim(vim.o.commentstring:sub(1, -3))
				return { start = cf, mid = cf, stop = cf, indent = "" }
			end

			local comments = parse_comments()
			if not vim.tbl_isempty(comments.single) then
				return comments.single[1]
			end

			if not vim.tbl_isempty(comments.other) then
				return comments.other[1]
			end

			return comments.triple[1]
		end

		local comment = function(part)
			return f(function()
				if vim.o.filetype == "" then
					return ""
				end

				local cf = comment_format()
				local c
				if part == "mid" then
					c = cf.indent .. cf[part]
				else
					c = cf[part]
				end

				if c ~= "" then
					c = c .. " "
				end

				return c
			end, {})
		end

		local fill = function(char, padding, part)
			return f(function()
				local clen = string.len(comment_format()[part])
				return string.rep(char, vim.bo.textwidth - padding - clen)
			end)
		end

		local center = function(index, char, padding, part, side)
			return f(function(arg)
				local cf = comment_format()
				local clen
				if part == "mid" then
					clen = string.len(cf.indent .. cf[part])
				else
					clen = string.len(cf[part])
				end
				local text = string.len(arg[1][1])
				local count = vim.bo.textwidth - padding - text - clen
				if count % 2 == 1 and side == "left" then
					count = (count + 1) / 2
				else
					count = count / 2
				end
				return string.rep(char, count)
			end, { index })
		end

		-- ------------------------------------------------------------------------
		-- | Wide Boxes
		-- ------------------------------------------------------------------------

		require("luasnip").add_snippets("all", {
			-- https://github.com/L3MON4D3/LuaSnip/wiki/Cool-Snippets#box-comment-like-ultisnips
			s(
				"box",
				fmt(
					[[
                            {comment_start}┌───{filler}───┐
                            {comment_mid}│   {left_center}{insert}{right_center}   │
                            {comment_stop}└───{filler}───┘
                        ]],
					{
						comment_start = comment("start"),
						comment_mid = comment("mid"),
						comment_stop = comment("stop"),
						filler = fill("─", 9, "start"),
						left_center = center(1, " ", 9, "mid", "left"),
						insert = i(1),
						right_center = center(1, " ", 9, "mid", "right"),
					}
				)
			),
			s(
				"bbox",
				fmt(
					[[
                            {comment_start}┌───{filler}───┐
                            {comment_mid}│   {space_filler}   │
                            {comment_mid}│   {left_center}{insert}{right_center}   │
                            {comment_mid}│   {space_filler}   │
                            {comment_stop}└───{filler}───┘
                        ]],
					{
						comment_start = comment("start"),
						comment_mid = comment("mid"),
						comment_stop = comment("stop"),
						filler = fill("─", 9, "start"),
						space_filler = fill(" ", 9, "start"),
						left_center = center(1, " ", 9, "mid", "left"),
						insert = i(1),
						right_center = center(1, " ", 9, "mid", "right"),
					}
				)
			),

			s(
				"sbox",
				fmt(
					[[
                            {3}┌───{2}───┐
                            {4}│   {1}   │
                            {5}└───{2}───┘
                        ]],
					{
						i(1),
						replace(1, "─"),
						comment("start"),
						comment("mid"),
						comment("stop"),
					}
				)
			),
		})
	end,
	opts = {
		history = true,
		delete_check_events = "TextChanged",
	},
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
        },
}
