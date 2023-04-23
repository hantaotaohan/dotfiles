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

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                Resize                                │
--   ╰──────────────────────────────────────────────────────────────────────╯

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Last open Buffer                           │
--   ╰──────────────────────────────────────────────────────────────────────╯

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

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                              Smart Quit                              │
--   ╰──────────────────────────────────────────────────────────────────────╯

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		-- "qf",
		-- "help",
		"man",
		-- "query",
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

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                Format                                │
--   ╰──────────────────────────────────────────────────────────────────────╯

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
		vim.wo.number = false
		vim.wo.signcolumn = "no"
		vim.wo.relativenumber = false
		vim.wo.cursorline = true
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("QuickDispla_Colory"),
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "qf" then
			vim.api.nvim_set_hl(0, "QuickFixLine", { fg = "#FFFFFF", bg = "#61AFEF" })
		else
			vim.api.nvim_set_hl(0, "QuickFixLine", { fg = "#Abb2bf", bg = "#282C34" })
		end
	end,
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	group = augroup("AutoCloseWindow"),
-- 	pattern = { "lspinfo", "lsp-installer", "null-ls-info", "help", "qf" },
-- 	callback = function()
-- 		local opts = { buffer = true, silent = true, desc = "close lspinfo popup and help,qf buffers" }
-- 		vim.keymap.set("n", "<LocalLeaderrq", function()
-- 			local ok = pcall(vim.cmd.close)
-- 			if not ok then
-- 				vim.cmd.bdelete()
-- 			end
-- 		end, opts)
-- 	end,
-- 	desc = "close lspinfo popup and help,qf buffers with q",
-- })

vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("AutoCloseLastWindow"),
	pattern = { "*" },
	callback = function()
		local wins = vim.api.nvim_list_wins()
		local target_wins = {}

		for _, win in ipairs(wins) do
			local buf = vim.api.nvim_win_get_buf(win)
			local ft = vim.api.nvim_buf_get_option(buf, "filetype")
			if ft == "qf" or ft == "help" then
				table.insert(target_wins, win)
			end
		end

		if #target_wins == #wins then
			vim.cmd([[ qa!]])
		end
	end,
	desc = "close lspinfo popup and help,qf buffers with q",
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
	group = augroup("Terminal"),
	pattern = "*",
	command = "startinsert",
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
	group = augroup("Terminal"),
	pattern = "term://*",
	command = "startinsert",
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = augroup("Terminal"),
	pattern = "*",
	command = "autocmd BufEnter * if &buftype ==# 'terminal' | startinsert! | endif",
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

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                Aerial                                │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("FileType", {
	pattern = "aerial",
	group = augroup("Aerial"),
	callback = function()
		vim.cmd([[ set signcolumn=yes ]])
	end,
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                               Bookmark                               │
--   ╰──────────────────────────────────────────────────────────────────────╯

-- 删除bookmark
vim.api.nvim_create_autocmd({ "BufRead" }, {
	pattern = "*",
	group = augroup("Bookmakr"),
	command = ":delm a-zA-Z0-9",
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Hide Cursor                              │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter", "BufHidden", "BufUnload" }, {
	group = augroup("Hide_Cursor"),
	pattern = "*",
	callback = function()
		if vim.api.nvim_buf_get_option(0, "filetype") == "neo-tree" then
			local def = vim.api.nvim_get_hl_by_name("Cursor", true)
			vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 100 }))
			vim.opt.guicursor = "a:Cursor/lCursor"
			vim.api.nvim_command("highlight CursorLine guifg=#ccdad6 guibg=#323842")
		elseif vim.api.nvim_buf_get_option(0, "filetype") == "aerial" then
			local def = vim.api.nvim_get_hl_by_name("Cursor", true)
			vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 100 }))
			vim.opt.guicursor = "a:Cursor/lCursor"
			vim.api.nvim_command("highlight CursorLine guifg=#ccdad6 guibg=#323842")
		else
			local def = vim.api.nvim_get_hl_by_name("Cursor", true)
			vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 0 }))
			vim.opt.guicursor = "a:Cursor/lCursor"
			vim.api.nvim_command("highlight CursorLine guifg=none guibg=#2C313C")
			-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
		end
	end,
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                        help in vertical split                        │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("Help"),
	pattern = "*",
	callback = function()
		vim.cmd([[ 
            if &buftype == 'help'
                wincmd L"
            end
        ]])
	end,
	once = false,
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                         Save Cursor Postion                          │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("BufWinLeave", {
	group = augroup("AutoSaveFolds"),
	pattern = "*.*",
	command = "mkview",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	group = augroup("AutoLoadFolds"),
	pattern = "*.*",
	command = "silent! loadview | normal! zM",
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("Cursor_Postion"),
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
			vim.fn.setpos(".", vim.fn.getpos("'\""))
			vim.cmd("silent! foldopen")
		end
	end,
})
