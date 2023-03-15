-- This file is automatically loaded by plugins.init

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Yank highlight                            │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("YankHeight"),
	callback = function()
		vim.highlight.on_yank({ higroup = "lualine_a_visual", timeout = 100 })
	end,
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                               AsyncRun                               │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("BufLeave", {
	group = augroup("Asyncrun"),
	pattern = "*",
	command = "let g:asyncrun_status='stopped'",
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"qf",
		"help",
		"man",
		"query",
		"notify",
		"prompt",
		"nofile",
		"lspinfo",
		"neo-tree",
		"terminal",
		-- "dashboard",
		"toggleterm",
		"startuptime",
		"tsplayground",
		"spectre_panel",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "<LocalLeader>q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = false
	end,
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                               Quickfix                               │
--   ╰──────────────────────────────────────────────────────────────────────╯

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("QuickDisplay"),
	pattern = "qf",
	callback = function()
		vim.opt_local.buflisted = false
	end,
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                Alpha                                 │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("User", {
	group = augroup("Alpha"),
	pattern = "AlphaReady",
	command = "set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2",
	-- command = "set showtabline=0 cursorline | autocmd BufUnload <buffer> set showtabline=2",
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                Lazy                                  │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("LazyStartup"),
	pattern = "lazy",
	command = "set showtabline=0 laststatus=0 cmdheight=0 nonumber norelativenumber",
})

vim.api.nvim_create_autocmd("BufUnload", {
	group = augroup("LazyStartup"),
	pattern = "lazy",
	command = "set showtabline=2 laststatus=2 cmdheight=1",
})
--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                Term                                  │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup("Terminal"),
	pattern = "*",
	command = "setlocal nonumber norelativenumber",
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = "Terminal",
	pattern = "*",
	command = "startinsert",
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	group = "Terminal",
	pattern = "term://*",
	command = "startinsert",
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                              Commenting                              │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("Format-Comment"),
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove("a")
		vim.opt_local.formatoptions:remove("l")
		vim.opt_local.formatoptions:remove("m")
		vim.opt_local.formatoptions:remove("M")
		vim.opt_local.formatoptions:remove("t")
		vim.opt_local.formatoptions:remove("c")
		vim.opt_local.formatoptions:remove("r")
		vim.opt_local.formatoptions:remove("o")
		vim.opt_local.wrap = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "aerial",
	group = augroup("Aerial"),
	callback = function()
		vim.cmd([[ set signcolumn=yes ]])
	end,
})

-- vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter", "BufHidden", "BufUnload" }, {
-- 	group = augroup("Sidebar"),
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.api.nvim_buf_get_option(0, "buftype") == "nofile" then
-- 			local def = vim.api.nvim_get_hl_by_name("Cursor", true)
-- 			vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 100 }))
-- 			vim.opt.guicursor = "a:Cursor/lCursor"
-- 			vim.api.nvim_command("highlight CursorLine guifg=#ccdad6 guibg=#2c313a")
-- 		else
-- 			local def = vim.api.nvim_get_hl_by_name("Cursor", true)
-- 			vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 0 }))
-- 			vim.opt.guicursor = "a:Cursor/lCursor"
-- 			vim.api.nvim_command("highlight CursorLine guifg=none guibg=#2C313C")
-- 			-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
-- 		end
-- 	end,
-- })

-- 删除bookmark
vim.api.nvim_create_autocmd({ "BufRead" }, { command = ":delm a-zA-Z0-9" })

-- set winbar=ﾠ
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = augroup("Sidebar"),
	pattern = "*",
	callback = function()
		local def = vim.api.nvim_get_hl_by_name("Cursor", true)
		vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 0 }))
		vim.api.nvim_set_hl(0, "Cursor", { fg = "#282c34" })
		vim.opt.guicursor = "a:Cursor/lCursor"
		-- vim.opt.guicursor = "n-v-c-sm:block-WindowsTerminalCursorBg"
		-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
	end,
})

-- vim.cmd([[
-- set guicursor+=n-v-c-sm:block-WindowsTerminalCursorBg
-- ]])
