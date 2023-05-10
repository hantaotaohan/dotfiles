--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                          PLUGINS: Nvim_Cmp                           │
--   │                                                                      │
--   │                 https://github.com/hrsh7th/nvim-cmp                  │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"hrsh7th/nvim-cmp",
	version = false, -- last release is way too old
	lazy = true,
	event = "InsertEnter",
	dependencies = {
		{ "neovim/nvim-lspconfig", lazy = true },
		{ "hrsh7th/cmp-nvim-lsp", lazy = true },
		{ "hrsh7th/cmp-buffer", lazy = true },
		{ "hrsh7th/cmp-path", lazy = true },
		{ "hrsh7th/cmp-cmdline", lazy = true },
		{ "hrsh7th/nvim-cmp", lazy = true },
		{
			"hjdivad/cmp-nvim-wikilinks",
			lazy = true,
			opts = {
				-- log_level = 'trace',
				-- log_to_file = true,
				glob_suffixes = { "*", "**/*" },
			},
		},
		{ "saadparwaiz1/cmp_luasnip", lazy = true },
		{ "smjonas/inc-rename.nvim", lazy = true },
	},
	opts = function()
		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		local luasnip = require("luasnip")

		local border = {
			{ "🭽", "FloatBorder" },
			{ "▔", "FloatBorder" },
			{ "🭾", "FloatBorder" },
			{ "▕", "FloatBorder" },
			{ "🭿", "FloatBorder" },
			{ "▁", "FloatBorder" },
			{ "🭼", "FloatBorder" },
			{ "▏", "FloatBorder" },
		}

		local cmp = require("cmp")

		local ELLIPSIS_CHAR = "…"
		local MAX_LABEL_WIDTH = 60

		local get_ws = function(max, len)
			return (" "):rep(max - len)
		end

		return {
			completion = {
				completeopt = "menu,menuone,noselect",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = {
					-- border = "rounded",
					winhighlight = "Normal:CmpPmenu,CursorLine:CmpPmenuSel,Search:None",
					border = border,
					col_offset = 0,
					side_padding = 0,
					scrollbar = false,
				},
				documentation = {
					-- border = "rounded",
					winhighlight = "Normal:CmpPmenu,CursorLine:CmpPmenuSel,Search:None",
					border = border,
					max_width = 100,
					min_width = 100,
					scrollbar = false,
				},
			},
			mapping = cmp.mapping.preset.insert({

				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- they way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				-- ["<Up>"] = cmp.mapping({
				-- 	c = function(fallback)
				-- 		if cmp.visible() then
				-- 			return cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
				-- 		end
				--
				-- 		fallback()
				-- 	end,
				-- }),
				--
				-- ["<Down>"] = cmp.mapping({
				-- 	c = function(fallback)
				-- 		if cmp.visible() then
				-- 			return cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
				-- 		end
				--
				-- 		fallback()
				-- 	end,
				-- }),

				-- ["<Down>"] = cmp.mapping.select_next_item(),
				-- ["<Up>"] = cmp.mapping.select_prev_item(),
				["<C-s>"] = cmp.config.disable,
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				-- { name = "buffer" },
				{ name = "path" },
				{ name = "wikilinks" },
				{
					name = "buffer",
					option = {
						keyword_pattern = [[\%(#[\0-9a-fA-F]\{6}\>\|-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(\%(-\|::\)\h\w*\)*\)]],
					},
				},
			}),
			formatting = {
				-- fields = { "abbr" },
				format = function(entry, item)
					local content = item.abbr
					local icons = require("config.utility").icons.kinds

					if #content > MAX_LABEL_WIDTH then
						item.abbr = vim.fn.strcharpart(content, 10, MAX_LABEL_WIDTH) .. ELLIPSIS_CHAR
					else
						item.abbr = content .. get_ws(MAX_LABEL_WIDTH, #content)
					end

					if icons[item.kind] then
						item.kind = icons[item.kind] .. " " .. item.kind
					end

					if entry.source.name == "nvim_lsp" then
						item.abbr = " " .. item.abbr
					else
						item.abbr = " " .. item.abbr
					end
					-- Source
					item.menu = ({
						buffer = "[BUF]",
						nvim_lsp = "[LSP]",
						luasnip = "[SNI]",
						latex_symbols = "[LTX]",
						wikilinks = "[WIK]",
					})[entry.source.name]
					return item
				end,
			},
			experimental = {
				ghost_text = {
					hl_group = "LspCodeLens",
				},
			},
			-- Set configuration for specific filetype.
			cmp.setup.filetype("gitcommit", {
				sources = cmp.config.sources({
					{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = "buffer" },
				}),
			}),

			-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline({ "/", "?" }, {
				formatting = {
					format = function(_, vim_item)
						vim_item.menu = ""
						vim_item.kind = ""
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			}),

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				formatting = {
					format = function(_, vim_item)
						vim_item.menu = ""
						vim_item.kind = ""
						return vim_item
					end,
				},
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			}),
		}
	end,
}
