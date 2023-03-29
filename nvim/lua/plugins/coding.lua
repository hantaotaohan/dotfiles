--  ══════════════════════════════════════════════════════════════════════════
--  DIRECTORY
--  ══════════════════════════════════════════════════════════════════════════

--  * LuaSnip
--  * Friendly_Snippets
--  * Nvim_Cmp
--  * Pair
--  * Align
--  * Surround
--  * Comment
--  * Comment_Box

--  ╾────────────────────────────────────────────────────────────────────────╼

return {

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                           PLUGINS: LuaSnip                           │
	--   │                                                                      │
	--   │                 https://github.com/L3MON4D3/LuaSnip                  │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows"))
				and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
			or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
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
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                      PLUGINS: Friendly_Snippets                      │
	--   │                                                                      │
	--   │           https://github.com/rafamadriz/friendly-snippets            │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	-- {
	-- 	"rafamadriz/friendly-snippets",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("luasnip.loaders.from_vscode").lazy_load()
	-- 	end,
	-- },

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                          PLUGINS: Nvim_Cmp                           │
	--   │                                                                      │
	--   │                 https://github.com/hrsh7th/nvim-cmp                  │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			{
				"hjdivad/cmp-nvim-wikilinks",
				opts = {
					-- log_level = 'trace',
					-- log_to_file = true,
					glob_suffixes = { "*", "**/*" },
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"smjonas/inc-rename.nvim",
		},
		opts = function()
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                            PLUGINS: Pair                             │
	--   │                                                                      │
	--   │              https://github.com/echasnovski/mini.pairs               │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                            PLUGINS: Align                            │
	--   │                                                                      │
	--   │              https://github.com/echasnovski/mini.align               │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{ "echasnovski/mini.align", version = false },

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                          PLUGINS: Surround                           │
	--   │                                                                      │
	--   │             https://github.com/echasnovski/mini.surround             │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"echasnovski/mini.surround",
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
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                           PLUGINS: Comment                           │
	--   │                                                                      │
	--   │               https://github.com/numToStr/Comment.nvim               │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"numToStr/Comment.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("Comment").setup({

				padding = true,

				sticky = true,

				ignore = nil,

				toggler = {
					line = "gcc",
					block = "gbc",
				},

				opleader = {
					line = "gc",
					block = "gb",
				},

				extra = {
					above = "gcO",
					below = "gco",
					eol = "gcA",
				},

				mappings = {
					basic = true,
					extra = false,
					extended = false,
				},

				pre_hook = nil,

				post_hook = nil,
			})
		end,
	},

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                         PLUGINS: Comment_Box                         │
	--   │                                                                      │
	--   │           https://github.com/LudoPinelli/comment-box.nvim            │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"LudoPinelli/comment-box.nvim",
		event = "VeryLazy",

		config = function()
			require("comment-box").setup({

				doc_width = 80, -- width of the document
				box_width = 72, -- width of the boxes
				borders = {
					top = "─",
					bottom = "─",
					left = "│",
					right = "│",
					top_left = "╭",
					top_right = "╮",
					bottom_left = "╰",
					bottom_rsight = "╯",
				},
				line_width = 74, -- width of the lines
				line = {
					line = "─",
					line_start = "─",
					line_end = "─",
				},
				outer_blank_lines = true, -- insert a blank line above and below the box
				inner_blank_lines = false, -- insert a blank line above and below the text
				line_blank_line_above = true, -- insert a blank line above the line
				line_blank_line_below = true, -- insert a blank line below the line
			})
		end,
	},
}
