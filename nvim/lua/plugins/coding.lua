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

	--   ╭──────────────────────────────────────────────────────────────────────╮
	--   │                                                                      │
	--   │                               Diffview                               │
	--   │                                                                      │
	--   │               https://github.comsindrets/diffview.nvim               │
	--   │                                                                      │
	--   ╰──────────────────────────────────────────────────────────────────────╯

	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "CmdlineEnter",
		config = function()
			local actions = require("diffview.actions")
			require("diffview").setup({
				diff_binaries = false, -- Show diffs for binaries
				enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
				git_cmd = { "git" }, -- The git executable followed by default args.
				use_icons = true, -- Requires nvim-web-devicons
				icons = { -- Only applies when use_icons is true.
					folder_closed = "",
					folder_open = "",
				},
				signs = {
					fold_closed = "",
					fold_open = "",
				},
				file_panel = {
					listing_style = "tree", -- One of 'list' or 'tree'
					tree_options = { -- Only applies when listing_style is 'tree'
						flatten_dirs = true, -- Flatten dirs that only contain one single dir
						folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
					},
					win_config = { -- See ':h diffview-config-win_config'
						position = "left",
						width = 35,
					},
				},
				file_history_panel = {
					git = {
						log_options = { -- See ':h diffview-config-log_options'
							single_file = {
								diff_merges = "combined",
							},
							multi_file = {
								diff_merges = "first-parent",
							},
						},
					},
					win_config = { -- See ':h diffview-config-win_config'
						position = "bottom",
						height = 16,
					},
				},
				commit_log_panel = {
					win_config = {}, -- See ':h diffview-config-win_config'
				},
				default_args = { -- Default args prepended to the arg-list for the listed commands
					DiffviewOpen = {},
					DiffviewFileHistory = {},
				},
				hooks = {}, -- See ':h diffview-config-hooks'
				keymaps = {
					disable_defaults = false, -- Disable the default keymaps
					view = {
						-- The `view` bindings are active in the diff buffers, only when the current
						-- tabpage is a Diffview.
						["<tab>"] = actions.select_next_entry, -- Open the diff for the next file
						["<s-tab>"] = actions.select_prev_entry, -- Open the diff for the previous file
						["gf"] = actions.goto_file, -- Open the file in a new split in the previous tabpage
						["<C-w><C-f>"] = actions.goto_file_split, -- Open the file in a new split
						["<C-w>gf"] = actions.goto_file_tab, -- Open the file in a new tabpage
						["<leader>e"] = actions.focus_files, -- Bring focus to the files panel
						["<leader>b"] = actions.toggle_files, -- Toggle the files panel.
					},
					file_panel = {
						["j"] = actions.next_entry, -- Bring the cursor to the next file entry
						["<down>"] = actions.next_entry,
						["k"] = actions.prev_entry, -- Bring the cursor to the previous file entry.
						["<up>"] = actions.prev_entry,
						["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
						["o"] = actions.select_entry,
						["<2-LeftMouse>"] = actions.select_entry,
						["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
						["S"] = actions.stage_all, -- Stage all entries.
						["U"] = actions.unstage_all, -- Unstage all entries.
						["X"] = actions.restore_entry, -- Restore entry to the state on the left side.
						["R"] = actions.refresh_files, -- Update stats and entries in the file list.
						["L"] = actions.open_commit_log, -- Open the commit log panel.
						["<c-b>"] = actions.scroll_view(-0.25), -- Scroll the view up
						["<c-f>"] = actions.scroll_view(0.25), -- Scroll the view down
						["<tab>"] = actions.select_next_entry,
						["<s-tab>"] = actions.select_prev_entry,
						["gf"] = actions.goto_file,
						["<C-w><C-f>"] = actions.goto_file_split,
						["<C-w>gf"] = actions.goto_file_tab,
						["i"] = actions.listing_style, -- Toggle between 'list' and 'tree' views
						["f"] = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
						["<leader>e"] = actions.focus_files,
						["<leader>b"] = actions.toggle_files,
					},
					file_history_panel = {
						["g!"] = actions.options, -- Open the option panel
						["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
						["y"] = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
						["L"] = actions.open_commit_log,
						["zR"] = actions.open_all_folds,
						["zM"] = actions.close_all_folds,
						["j"] = actions.next_entry,
						["<down>"] = actions.next_entry,
						["k"] = actions.prev_entry,
						["<up>"] = actions.prev_entry,
						["<cr>"] = actions.select_entry,
						["o"] = actions.select_entry,
						["<2-LeftMouse>"] = actions.select_entry,
						["<c-b>"] = actions.scroll_view(-0.25),
						["<c-f>"] = actions.scroll_view(0.25),
						["<tab>"] = actions.select_next_entry,
						["<s-tab>"] = actions.select_prev_entry,
						["gf"] = actions.goto_file,
						["<C-w><C-f>"] = actions.goto_file_split,
						["<C-w>gf"] = actions.goto_file_tab,
						["<leader>e"] = actions.focus_files,
						["<leader>b"] = actions.toggle_files,
					},
					option_panel = {
						["<tab>"] = actions.select_entry,
						["q"] = actions.close,
					},
				},
			})
		end,
	},
}
