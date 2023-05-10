--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                            PLUGINS: Noice                            │
--   │                                                                      │
--   │                 https://github.com/folke/noice.nvim                  │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"folke/noice.nvim",
	-- lazy = true,
	dependencies = { "MunifTanjim/nui.nvim", lazy = true },
	event = "VeryLazy",
	opts = {
		cmdline = {
			enabled = true, -- enables the Noice cmdline UI

			view = "cmdline_popup",
			opts = {}, -- global options for the cmdline. See section on views

			format = {
				-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
				-- view: (default is cmdline view)
				-- opts: any options passed to the view
				-- icon_hl_group: optional hl_group for the icon
				-- title: set to anything or empty string to hide
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = "  ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = "  ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "[HELP]: " },
				input = {}, -- Used by input()
				-- lua = false, -- to disable a format, set to `false`
			},
		},
		messages = {
			-- This is a current Neovim limitation.
			enabled = true, -- enables the Noice messages UI
			view = "notify", -- default view for messages
			view_error = "notify", -- view for errors
			view_warn = "notify", -- view for warnings
			view_history = "messages", -- view for :messages
			view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
		},
		popupmenu = {
			enabled = true, -- enables the Noice popupmenu UI
			---@type 'nui'|'cmp'
			backend = "nui", -- backend to use to show regular cmdline completions

			-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
			kind_icons = {}, -- set to `false` to disable icons
		},
		-- default options for require('noice').redirect
		-- see the section on Command Redirection

		redirect = {
			view = "popup",
			filter = { event = "msg_show" },
		},
		-- You can add any custom commands below that will be available with `:Noice command`

		commands = {
			history = {
				-- options for the message history that you get with `:Noice`
				view = "split",
				opts = { enter = true, format = "details" },
				filter = {
					any = {
						{ event = "notify" },
						{ error = true },
						{ warning = true },
						{ event = "msg_show", kind = { "" } },
						{ event = "lsp", kind = "message" },
					},
				},
			},
			-- :Noice last
			last = {
				view = "popup",
				opts = { enter = true, format = "details" },
				filter = {
					any = {
						{ event = "notify" },
						{ error = true },
						{ warning = true },
						{ event = "msg_show", kind = { "" } },
						{ event = "lsp", kind = "message" },
					},
				},
				filter_opts = { count = 1 },
			},
			-- :Noice errors
			errors = {
				-- options for the message history that you get with `:Noice`
				view = "popup",
				opts = { enter = true, format = "details" },
				filter = { error = true },
				filter_opts = { reverse = true },
			},
		},
		notify = {
			-- Noice can be used as `vim.notify` so you can route any notification like other messages
			-- Notification messages have their level and other properties set.
			-- event is always "notify" and kind can be any log level as a string
			-- The default routes will forward notifications to nvim-notify
			-- Benefit of using Noice for this is the routing and consistent history view
			enabled = true,
			view = "notify",
		},
		lsp = {
			progress = {
				enabled = false,
				format = "lsp_progress",
				format_done = "lsp_progress_done",
				throttle = 1000 / 30, -- frequency to update lsp progress message
				view = "mini",
			},
			override = {
				-- override the default lsp markdown formatter with Noice
				["vim.lsp.util.convert_input_to_markdown_lines"] = false,
				-- override the lsp markdown formatter with Noice
				["vim.lsp.util.stylize_markdown"] = false,
				-- override cmp documentation with Noice (needs the other options to work)
				["cmp.entry.get_documentation"] = false,
			},
			hover = {
				enabled = false,
				view = nil, -- when nil, use defaults from documentation
				opts = {}, -- merged with defaults from documentation
			},
			signature = {
				enabled = false,
				auto_open = {
					enabled = true,
					trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
					luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
					throttle = 50, -- Debounce lsp signature help request by 50ms
				},
				view = nil, -- when nil, use defaults from documentation
				opts = {}, -- merged with defaults from documentation
			},
			message = {
				-- Messages shown by lsp servers
				enabled = true,
				view = "notify",
				opts = {},
			},
			-- defaults for hover and signature help
			documentation = {
				view = "hover",
				opts = {
					lang = "markdown",
					replace = true,
					render = "plain",
					format = { "{message}" },
					win_options = { concealcursor = "n", conceallevel = 3 },
				},
			},
		},
		markdown = {
			-- hover = {
			-- 	["|(%S-)|"] = vim.cmd.help, -- vim help links
			-- 	["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
			-- },
			highlights = {
				["|%S-|"] = "@text.reference",
				["@%S+"] = "@parameter",
				["^%s*(Parameters:)"] = "@text.title",
				["^%s*(Return:)"] = "@text.title",
				["^%s*(See also:)"] = "@text.title",
				["{%S-}"] = "@parameter",
			},
		},
		health = {
			checker = true, -- Disable if you don't want health checks to run
		},
		smart_move = {
			-- noice tries to move out of the way of existing floating windows.
			enabled = true, -- you can disable this behaviour here
			-- add any filetypes here, that shouldn't trigger smart move.
			excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
		},

		presets = {
			-- you can enable a preset by setting it to true, or a table that will override the preset config
			-- you can also add custom presets that you can enable/disable with enabled=true
			bottom_search = false, -- use a classic bottom cmdline for search
			command_palette = false, -- position the cmdline and popupmenu together
			long_message_to_split = false, -- long messages will be sent to a split
			inc_rename = true, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},

		throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
		views = {

			cmdline_popup = {
				position = {
					row = "50%",
					col = "50%",
				},
				size = {
					width = 120,
					height = "auto",
				},
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = "65%",
					col = "50%",
				},
				size = {
					width = 120,
					height = 10,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = { Normal = "Noice_Normal", FloatBorder = "Noice_DiagnosticInfo" },
				},
			},
		}, ---@see section on views
		routes = {
			{
				filter = { event = "msg_show", kind = "search_count" },
				opts = { skip = true },
			},
			{
				view = "messages",
				filter = { event = "msg_show", min_height = 20 },
			},
			-- {
			-- 	filter = {
			-- 		event = "msg_show",
			-- 		kind = "confirm",
			-- 	},
			-- 	opts = { skip = true },
			-- },
		}, --- @see section on routes
		status = {}, --- @see section on statusline components
		format = {}, --- @see section on formatting
	},
	keys = {
		{
			"<S-Enter>",
			function()
				require("noice").redirect(vim.fn.getcmdline())
			end,
			mode = "c",
			desc = "Redirect Cmdline",
		},
		{
			"<leader>snl",
			function()
				require("noice").cmd("last")
			end,
			desc = "Noice Last Message",
		},
		{
			"<leader>snh",
			function()
				require("noice").cmd("history")
			end,
			desc = "Noice History",
		},
		{
			"<leader>sna",
			function()
				require("noice").cmd("all")
			end,
			desc = "Noice All",
		},
		{
			"<c-f>",
			function()
				if not require("noice.lsp").scroll(4) then
					return "<c-f>"
				end
			end,
			silent = true,
			expr = true,
			desc = "Scroll forward",
			mode = { "i", "n", "s" },
		},
		{
			"<c-b>",
			function()
				if not require("noice.lsp").scroll(-4) then
					return "<c-b>"
				end
			end,
			silent = true,
			expr = true,
			desc = "Scroll backward",
			mode = { "i", "n", "s" },
		},
	},
}
