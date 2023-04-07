--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                            PLUGINS: Alpha                            │
--   │                                                                      │
--   │                https://github.com/goolord/alpha-nvim                 │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {
	"goolord/alpha-nvim",
	branch = "main",
	event = "VimEnter",
	lazy = true,
	-- dependencies = { "nvim-lua/plenary.nvim" },
	opts = function()
		vim.api.nvim_set_hl(0, "alphatitle", { fg = "#81a1c1", bg = "#282c34" })
		vim.api.nvim_set_hl(0, "alphatitle_1", { fg = "#73b8f1", bg = "#282c34" })
		vim.api.nvim_set_hl(0, "alphatitle_2", { fg = "#282c34", bg = "#73b8f1" })
		local theme = require("alpha.themes.startify")
		local if_nil = vim.F.if_nil
		local fnamemodify = vim.fn.fnamemodify
		local filereadable = vim.fn.filereadable
		local plenary_path = require("plenary.path")

		local leader = "SPC"
		local function button(sc, txt, keybind, keybind_opts)
			local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

			local opts = {
				position = "center",
				shortcut = "[" .. sc .. "]",
				cursor = 50,
				width = 50,
				align_shortcut = "right",
				-- hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
				hl_shortcut = "alphatitle",
				shrink_margin = true,
			}
			if keybind then
				keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
				opts.keymap = { "n", sc_, keybind, keybind_opts }
			end

			local function on_press()
				local key = vim.api.nvim_replace_termcodes(keybind .. "<Ignore>", true, false, true)
				vim.api.nvim_feedkeys(key, "t", false)
			end

			return {
				type = "button",
				val = txt,
				on_press = on_press,
				opts = opts,
			}
		end

		local nvim_web_devicons = {
			enabled = true,
			highlight = true,
		}

		local function get_extension(fn)
			local match = fn:match("^.+(%..+)$")
			local ext = ""
			if match ~= nil then
				ext = match:sub(2)
			end
			return ext
		end

		local function icon(fn)
			local nwd = require("nvim-web-devicons")
			local ext = get_extension(fn)
			return nwd.get_icon(fn, ext, { default = true })
		end

		local function file_button(fn, sc, short_fn, autocd)
			short_fn = if_nil(short_fn, fn)
			local ico_txt
			local fb_hl = {}
			if nvim_web_devicons.enabled then
				local ico, hl = icon(fn)
				local hl_option_type = type(nvim_web_devicons.highlight)
				if hl_option_type == "boolean" then
					if hl and nvim_web_devicons.highlight then
						table.insert(fb_hl, { hl, 0, #ico })
					end
				end
				if hl_option_type == "string" then
					table.insert(fb_hl, { nvim_web_devicons.highlight, 0, #ico })
				end
				ico_txt = ico .. "  "
			else
				ico_txt = ""
			end
			local cd_cmd = (autocd and " | cd %:p:h" or "")
			local file_button_el = button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. cd_cmd .. " <CR>")
			local fn_start = short_fn:match(".*[/\\]")
			if fn_start ~= nil then
				table.insert(fb_hl, { "Comment", #ico_txt, #fn_start + #ico_txt })
			end
			file_button_el.opts.hl = fb_hl
			return file_button_el
		end

		local default_mru_ignore = { "gitcommit" }

		local mru_opts = {
			ignore = function(path, ext)
				return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
			end,
			autocd = false,
		}
		--- @param start number
		--- @param cwd string? optional
		--- @param items_number number? optional number of items to generate, default = 10
		local function mru(start, cwd, items_number, opts)
			opts = opts or mru_opts
			items_number = if_nil(items_number, 9)
			local oldfiles = {}
			for _, v in pairs(vim.v.oldfiles) do
				if #oldfiles == items_number then
					break
				end
				local cwd_cond
				if not cwd then
					cwd_cond = true
				else
					cwd_cond = vim.startswith(v, cwd)
				end
				local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
				if (filereadable(v) == 1) and cwd_cond and not ignore then
					oldfiles[#oldfiles + 1] = v
				end
			end

			local target_width = 35

			local tbl = {}
			for i, fn in ipairs(oldfiles) do
				local short_fn
				if cwd then
					short_fn = fnamemodify(fn, ":.")
				else
					short_fn = fnamemodify(fn, ":~")
				end

				if #short_fn > target_width then
					short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
					if #short_fn > target_width then
						short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
					end
				end

				local file_button_el = file_button(fn, tostring(i + start - 1), short_fn, opts.autocd)
				tbl[i] = file_button_el
			end
			return {
				type = "group",
				val = tbl,

				opts = {
					spacing = 1,
					position = "center",
				},
			}
		end
		-- Set header
		theme.header = {
			type = "text",
			val = {
				[[                                                                                  ]],
				[[  ███████╗ █████╗ ██████╗ ███████╗██████╗       ██████╗  █████╗ ███████╗██╗  ██╗  ]],
				[[  ██╔════╝██╔══██╗██╔══██╗██╔════╝██╔══██╗      ██╔══██╗██╔══██╗██╔════╝██║  ██║  ]],
				[[  ███████╗███████║██████╔╝█████╗  ██████╔╝█████╗██║  ██║███████║███████╗███████║  ]],
				[[  ╚════██║██╔══██║██╔══██╗██╔══╝  ██╔══██╗╚════╝██║  ██║██╔══██║╚════██║██╔══██║  ]],
				[[  ███████║██║  ██║██████╔╝███████╗██║  ██║      ██████╔╝██║  ██║███████║██║  ██║  ]],
				[[  ╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  ]],
				[[                                                                                  ]],
			},
			opts = {
				position = "center",
				hl = "alphatitle",
			},
		}
		theme.nvim_web_devicons.enabled = true
		theme.nvim_web_devicons.highlight = true
		theme.nvim_web_devicons.highlight = "@function"

		theme.mru = {
			type = "group",
			val = {
				{
					type = "text",
					val = " Recent Files ",
					opts = {
						-- hl = "Comment",
						position = "center",
						-- hl_shortcut = { { "Operator", 0, 1 }, { "Number", 1, #sc + 1 }, { "Operator", #sc + 1, #sc + 2 } },
						hl = {
							{ "alphatitle_1", 1, -1 },
							{ "alphatitle_2", 3, 17 },
							{ "alphatitle_1", 1, 1 },
						},
					},
				},
				{ type = "padding", val = 0 },
				mru(1),
			},
			opts = {
				spacing = 1,
				width = 50,
				position = "center",
			},
		}

		theme.buttons = {
			type = "group",
			val = {
				{
					type = "text",
					val = " Quick Links ",
					opts = {
						hl = {
							{ "alphatitle_1", 1, -1 },
							{ "alphatitle_2", 3, 17 },
							{ "alphatitle_1", 1, 1 },
						},
						position = "center",
					},
				},
				{ type = "padding", val = 0 },
				button("e", "  New File", "<cmd>ene<CR>"),
				button("t", "  Find Text", "<cmd>Telescope live_grep initial_mode=insert previewer=true<CR>"),
				-- "<cmd>lua require'telescope.builtin'.find_files(({ previewer = true, winblend = 1 }))<cr>"
				button(
					"f",
					"  Find File",
					"<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>"
				),
				button(
					"p",
					"  Find Project",
					"<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown({}))<cr>"
				),
				button(
					"o",
					"  Recent File",
					"<cmd>lua require'telescope.builtin'.oldfiles(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"
				),
				button("v", "  Neovim RC", "<cmd>Neotree position=float dir=$HOME/.config/nvim<cr>"),
				button("P", "  Enter Projects", "<cmd>Neotree position=float dir=$HOME/desktop<CR>"),
				button("u", "  Update Plugins", "<cmd>Lazy sync<CR>"),
				button("q", "  Quit", "<cmd>Smartq<cr>"),
			},
			opts = {
				spacing = 1,
				position = "center",
			},
		}

		theme.footer = {
			type = "text",
			val = "",
			opts = {
				position = "center",
				hl = "alphatitle",
			},
		}

		theme.config = {
			layout = {
				{ type = "padding", val = 2 },
				theme.header,
				{ type = "padding", val = 3 },
				theme.mru,
				{ type = "padding", val = 2 },
				theme.buttons,
				{ type = "padding", val = 3 },
				theme.footer,
			},
			opts = {
				margin = 3,
				redraw_on_resize = false,
				align_shortcut = "left",
				setup = function()
					vim.api.nvim_create_autocmd("DirChanged", {
						pattern = "*",
						callback = function()
							require("alpha").redraw()
						end,
					})
				end,
			},
		}

		return theme
	end,

	config = function(_, theme)
		vim.api.nvim_create_user_command("Smartq", function()
			if vim.fn.bufloaded(0) == 1 then
				vim.api.nvim_command("bw")
			elseif vim.fn.bufloaded(0) < 1 then
				vim.api.nvim_command("quit")
			end
		end, { nargs = 0 })

		-- close Lazy and re-open when the dashboard is ready
		if vim.o.filetype == "lazy" then
			vim.cmd.close()
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					require("lazy").show()
				end,
			})
		end

		require("alpha").setup(theme.config)

		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				-- vim.cmd([[set laststatus=0 showtabline=0]])
				vim.cmd([[set laststatus=0]])
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				theme.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
