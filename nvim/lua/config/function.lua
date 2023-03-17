local cmd = vim.cmd
local fn = vim.fn
local Util = require("lazy.core.util")

local M = {}

-- check if a variable is not empty nor nil

M.isNotEmpty = function(s)
	return s ~= nil and s ~= ""
end

-------------------------------------------------------------------------------
-- Toggle QuickFix
-------------------------------------------------------------------------------

M.toggle_quickfix = function()
	local windows = fn.getwininfo()
	local qf_exists = false
	for _, win in pairs(windows) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		cmd("cclose")
		return
	end
	if M.isNotEmpty(fn.getqflist()) then
		cmd("copen")
	end
end

-------------------------------------------------------------------------------
-- Toggle ColorColumn
-------------------------------------------------------------------------------

M.toggle_colorcolumn = function()
	local value = vim.inspect(vim.opt.colorcolumn:get())
	if value == "{}" then
		vim.opt.colorcolumn = "80"
	else
		vim.opt.colorcolumn = {}
	end
end

-------------------------------------------------------------------------------
-- Toggle DiagnoStics
-------------------------------------------------------------------------------

DIAGNOSTICS_ACTIVE = true -- must be global since the toggle function is called in which.lua
M.toggle_diagnostics = function()
	DIAGNOSTICS_ACTIVE = not DIAGNOSTICS_ACTIVE
	if DIAGNOSTICS_ACTIVE then
		vim.diagnostic.show()
		Util.info("Enabled diagnostics", { title = "Diagnostics" })
	else
		vim.diagnostic.hide()
		Util.warn("Disabled diagnostics", { title = "Diagnostics" })
	end
end

-------------------------------------------------------------------------------
-- Toggle Number
-------------------------------------------------------------------------------

M.toggle_number = function()
	if
		vim.api.nvim_win_get_option(0, "relativenumber") == false
		and vim.api.nvim_win_get_option(0, "number") == false
	then
		vim.opt.number = true
	elseif
		vim.api.nvim_win_get_option(0, "relativenumber") == false
		and vim.api.nvim_win_get_option(0, "number") == true
	then
		vim.opt.relativenumber = true
	elseif
		vim.api.nvim_win_get_option(0, "relativenumber") == true
		and vim.api.nvim_win_get_option(0, "number") == true
	then
		vim.opt.number = false
	else
		vim.opt.relativenumber = false
	end
end

-------------------------------------------------------------------------------
-- Toggle NumberColumn And Sigcolumn
-------------------------------------------------------------------------------

M.toggle_column = function()
	if vim.api.nvim_win_get_option(0, "signcolumn") == "yes" then
		vim.opt.signcolumn = "no"
	else
		vim.opt.signcolumn = "yes"
	end
end

-------------------------------------------------------------------------------
-- Toggle NumberColumn And Sigcolumn
-------------------------------------------------------------------------------

local disable_ft = {
	"NvimTree",
	"guihua",
	"guihua_rust",
	"TelescopePrompt",
	"csv",
	"txt",
	"defx",
	"sidekick",
}

local syn_on = not vim.tbl_contains(disable_ft, vim.bo.filetype)

M.toggle_syntax = function()
	if syn_on then
		cmd("syntax off")
		cmd("TSToggle highlight")
	else
		cmd("syntax on")
		cmd("TSToggle highlight")
	end
end

-------------------------------------------------------------------------------
return M
