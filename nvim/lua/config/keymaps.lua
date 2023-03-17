local functions = require("config.function")
local Util = require("lazy.core.util")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Check Plugin                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

function Has(plugin)
	return require("lazy.core.config").plugins[plugin] ~= nil
end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Mapping function                           │
--   ╰──────────────────────────────────────────────────────────────────────╯

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
--   │                       Toggle Options Function                        │
--   ╰──────────────────────────────────────────────────────────────────────╯

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

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Toggle Alpha                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

map({ "n", "i", "v" }, "<LocalLeader>s", "<cmd>Alpha<cr>", { desc = "Alpha" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Toggle Lazy                              │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<leader>tl", "<cmd>:Lazy<cr>", { desc = "Lazy" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Toggle Options                            │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<leader>ts", function()
	Toggle("spell")
end, { desc = "Toggle Spelling" })

map("n", "<leader>tw", function()
	Toggle("wrap")
end, { desc = "Toggle Word Wrap" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                         Toggle System Tools                          │
--   ╰──────────────────────────────────────────────────────────────────────╯
map("n", "<F2>", functions.toggle_number, { desc = "Toggle Number" })
map("n", "<F3>", functions.toggle_column, { desc = "Toggle Column" })
map("n", "<F4>", functions.toggle_syntax, { desc = "Toggle Syntax" })
map("n", "<F7>", functions.toggle_quickfix, { desc = "Toggle QuickFix" })
map("n", "<F8>", functions.toggle_colorcolumn, { desc = "Toggle Colorcolumn" })
map("n", "<F9>", functions.toggle_diagnostics, { desc = "Toggle Diagnostics" })
map("n", "<F10>", "<CMD>ColorizerToggle<CR>", { desc = "Toggle Colorizer" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Disable Keymaps                            │
--   ╰──────────────────────────────────────────────────────────────────────╯

map({ "n", "v" }, "q", "<Nop>")
map({ "n", "v" }, "Q", "<Nop>")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                        Display Center Sceener                        │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "(", "(zz")
map("n", ")", ")zz")
map("n", "{", "{zz")
map("n", "}", "}zz")
map("n", "[", "[zz")
map("n", "]", "[zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "g;", "g;zz")
map("n", "g,", "g,zz")
map("n", "<C-f>", "<C-f>zz")
map("n", "<C-b>", "<C-b>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Mapping For Paste                           │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("x", "p", '"_dP', { silent = true, desc = "dont copy replaced text" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Move Selected Line                          │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("x", "J", ":move '>+1<CR>gv-gv", { silent = true })
map("x", "K", ":move '<-2<CR>gv-gv", { silent = true })

map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Delete Buffer                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

map({ "n", "i", "v", "t" }, "<LocalLeader>q", "<cmd>Sayonara<cr>", { silent = true, desc = "Delete Buffer" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                              Save File                               │
--   ╰──────────────────────────────────────────────────────────────────────╯

map({ "i", "v", "n", "s" }, "<LocalLeader>w", "<cmd>w<cr><esc>", { desc = "Save file" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Clear Search                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<Esc><Esc>", "<cmd>nohlsearch<cr>", { desc = "Escape and clear hlsearch" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                 Clear Search, Diff Update And Redraw                 │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<LocalLeader><F5>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Move To Window                            │
--   ╰──────────────────────────────────────────────────────────────────────╯

map({ "n", "i", "v" }, "<C-h>", "<Esc><C-w>h", { desc = "Go to left window" })
map({ "n", "i", "v" }, "<C-j>", "<Esc><C-w>j", { desc = "Go to lower window" })
map({ "n", "i", "v" }, "<C-k>", "<Esc><C-w>k", { desc = "Go to upper window" })
map({ "n", "i", "v" }, "<C-l>", "<Esc><C-w>l", { desc = "Go to right window" })

map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Resize Window                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Buffers Changes                            │
--   ╰──────────────────────────────────────────────────────────────────────╯

if Has("bufferline.nvim") then
	map("n", "<LocalLeader><S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
	map("n", "<LocalLeader><Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
	map("n", "<LocalLeader>1", "<cmd>BufferLineGoToBuffer 1<cr>", { desc = "Buffer To 1" })
	map("n", "<LocalLeader>2", "<cmd>BufferLineGoToBuffer 2<cr>", { desc = "Buffer To 2" })
	map("n", "<LocalLeader>3", "<cmd>BufferLineGoToBuffer 3<cr>", { desc = "Buffer To 3" })
	map("n", "<LocalLeader>4", "<cmd>BufferLineGoToBuffer 4<cr>", { desc = "Buffer To 4" })
	map("n", "<LocalLeader>5", "<cmd>BufferLineGoToBuffer 5<cr>", { desc = "Buffer To 5" })
	map("n", "<LocalLeader>6", "<cmd>BufferLineGoToBuffer 6<cr>", { desc = "Buffer To 6" })
	map("n", "<LocalLeader>7", "<cmd>BufferLineGoToBuffer 7<cr>", { desc = "Buffer To 7" })
	map("n", "<LocalLeader>8", "<cmd>BufferLineGoToBuffer 8<cr>", { desc = "Buffer To 8" })
	map("n", "<LocalLeader>9", "<cmd>BufferLineGoToBuffer 9<cr>", { desc = "Buffer To 9" })
else
	map("n", "<LocalLeader><S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
	map("n", "<LocalLeader><Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Enhanced semicolon                          │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", ";;", ";", { desc = "Escape and clear hlsearch" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Better Indenting                           │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("x", "<", "<gv")
map("x", ">", ">gv")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                               New File                               │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- quit
map("n", "<LocalLeader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Terminal Normal Mode
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Commant - Box                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

map({ "n", "v" }, "gbb", "<CMD>CBccbox<CR>")
map({ "n", "v" }, "gbv", "<CMD>CBccbox21<CR>")
map({ "n", "v" }, "gbh", "<CMD>CBline5<CR>")
map({ "n", "v" }, "gbj", "<CMD>CBline6<CR>")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                              ToggleTerm                              │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("t", "<LocalLeader>c", "<cmd>ToggleTerm<cr>", { desc = "Previous Tab" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          telescope-Projects                          │
--   ╰──────────────────────────────────────────────────────────────────────╯

map(
	"n",
	"<LocalLeader>fp",
	"<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown({hidden=true}))<cr>",
	{ desc = "Recent projects" }
)
