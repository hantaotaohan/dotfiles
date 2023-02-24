-- This file is automatically loaded by plugins.init

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
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
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
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
    vim.opt_local.spell = true
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

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("Alpha"),
	pattern = "alpha",
    command = "set showtabline=0 laststatus=0 cmdheight=0 | autocmd BufUnload <buffer> set showtabline=2 laststatus=2 cmdheight=1"
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                Lazy                                  │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd({ "FileType","FocusLost" }, {
    group = augroup("LazyStartup"),
	pattern = "lazy",
    command = "set showtabline=0 laststatus=0 cmdheight=0 nonumber norelativenumber | autocmd BufUnload <buffer> set showtabline=2 laststatus=2 cmdheight=1"
})

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                Term                                  │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.api.nvim_create_autocmd("TermOpen", {
    group = augroup("Terminal"),
    command = "setlocal nonumber norelativenumber",
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = "lazyvim_Terminal",
    command = "startinsert",
})

vim.api.nvim_create_autocmd({ "WinEnter" , "BufWinEnter" }, {
    group = "lazyvim_Terminal",
	pattern = "term://*",
    command = "startinsert"
})