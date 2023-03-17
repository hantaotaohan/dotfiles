-- This file is automatically loaded by lazyvim.plugins.config

local fun = require("config.function")
local Util = require("config.utility")

---@param plugin string
function Has(plugin)
	return require("lazy.core.config").plugins[plugin] ~= nil
end

---@param silent boolean?
function Toggle(option, silent, values)
	if values then
		if vim.opt_local[option]:get() == values[1] then
			vim.opt_local[option] = values[2]
		else
			vim.opt_local[option] = values[1]
		end
		return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
	end
	vim.opt_local[option] = not vim.opt_local[option]:get()
	if not silent then
		if vim.opt_local[option]:get() then
			Util.info("Enabled " .. option, { title = "Option" })
		else
			Util.warn("Disabled " .. option, { title = "Option" })
		end
	end
end

local enabled = true
function Toggle_diagnostics()
	enabled = not enabled
	if enabled then
		vim.diagnostic.enable()
		Util.info("Enabled diagnostics", { title = "Diagnostics" })
	else
		vim.diagnostic.disable()
		Util.warn("Disabled diagnostics", { title = "Diagnostics" })
	end
end
-- local Util = require("util")

local function map(mode, lhs, rhs, opts)
	local keys = require("lazy.core.handler").handlers.keys
	---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	if not keys.active[keys.parse({ lhs, mode = mode }).id] then
		opts = opts or {}
		opts.silent = opts.silent ~= true
		vim.keymap.set(mode, lhs, rhs, opts)
	end
end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Disable Keymaps                            │
--   ╰──────────────────────────────────────────────────────────────────────╯

map({ "n", "v" }, "q", "<Nop>")
map({ "n", "v" }, "Q", "<Nop>")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Display Sceener                            │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "(", "(zz")
map("n", ")", ")zz")
map("n", "{", "{zz")
map("n", "}", "}zz")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Mapping for paste                           │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("x", "p", '"_dP')

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Move Selected Line                          │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("x", "J", ":move '>+1<CR>gv-gv", { silent = true })
map("x", "K", ":move '<-2<CR>gv-gv", { silent = true })

-- better up/down
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- delete buffer
map({ "n", "i", "v", "t" }, "<LocalLeader>q", "<cmd>Sayonara<cr>", { silent = true }, { desc = "Delete Buffer" })

-- save file
map({ "i", "v", "n", "s" }, "<LocalLeader>w", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Move to window using the <ctrl> hjkl keys
map({ "n", "i", "v" }, "<C-h>", "<Esc><C-w>h", { desc = "Go to left window" })
map({ "n", "i", "v" }, "<C-j>", "<Esc><C-w>j", { desc = "Go to lower window" })
map({ "n", "i", "v" }, "<C-k>", "<Esc><C-w>k", { desc = "Go to upper window" })
map({ "n", "i", "v" }, "<C-l>", "<Esc><C-w>l", { desc = "Go to right window" })

map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- buffers
if Has("bufferline.nvim") then
	map("n", "<LocalLeader><Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
	map("n", "<LocalLeader><Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

-- Clear search with <esc>
map("n", "<Esc><Esc>", "<cmd>nohlsearch<cr>", { desc = "Escape and clear hlsearch" })
map("n", ";;", ";", { desc = "Escape and clear hlsearch" })

map({ "n", "i", "v" }, "<LocalLeader>s", "<cmd>Alpha<cr>", { desc = "Return DashBoard" })
-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- stylua: ignore start

-- toggle options
map("n", "<leader>us", function() Toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function() Toggle("relativenumber", true) toggle("number") end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Toggle_diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- floating terminal
map("n", "<leader>ft", function() float_term(nil, { cwd = Util.get_root() }) end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() float_term() end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", {desc = "Enter Normal Mode"})

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })


--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                         Toggle System Tools                          │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<F3>", "<CMD>lua fun.toggle_number()<CR>")
map("n", "<F4>", "<CMD>lua fun.toggle_column()<CR>")
map("n", "<F5>", "<CMD>lua fun.toggle_syntax()<CR>")
map("n", "<F6>", "<CMD>ScrollbarToggle<CR>")
map("n", "<F7>", "<CMD>lua fun.toggle_qf()<CR>")
map("n", "<F8>", "<CMD>lua fun.toggle_colorcolumn()<CR>")
map("n", "<F9>", "<CMD>lua fun.toggle_diagnostics()<CR>")
map("n", "<F10>", "<CMD>ColorizerToggle<CR>" )


--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Commant - Box                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

map( {"n", "v"}, "gbb", "<CMD>CBccbox<CR>" )
map( {"n", "v"}, "gbv", "<CMD>CBccbox21<CR>")
map( {"n", "v"}, "gbh", "<CMD>CBline5<CR>" )
map( {"n", "v"}, "gbj", "<CMD>CBline6<CR>" )



map("t", "<LocalLeader>c", "<cmd>ToggleTerm<cr>", { desc = "Previous Tab" })

map("n", "<LocalLeader>fp",  "<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown({hidden=true}))<cr>", {desc = "Recent projects" }) -- find projects
