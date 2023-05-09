--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Settings Variable                           │
--   ╰──────────────────────────────────────────────────────────────────────╯

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

--  ══════════════════════════════════════════════════════════════════════════

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Toggle Alpha                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

if Has("alpha-nvim") then
	map({ "n", "i", "v" }, "<LocalLeader>s", "<cmd>Alpha<cr>", { desc = "Alpha" })
end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Toggle Lazy                              │
--   ╰──────────────────────────────────────────────────────────────────────╯

if Has("lazy.nvim") then
	map("n", "<leader>tl", "<cmd>:Lazy<cr>", { desc = "Lazy" })
end

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

map("n", "(", "(zz", { desc = "Sentences Prev" })
map("n", ")", ")zz", { desc = "Sentences Next" })
map("n", "{", "{zz", { desc = "Paragraph Prev" })
map("n", "}", "}zz", { desc = "Paragraph Next" })
map("n", "[[", "[[zz", { noremap = true, desc = "Sections Prev" })
map("n", "]]", "]]zz", { noremap = true, desc = "Sections Next" })
map("n", "n", "nzz", { desc = "Search Next" })
map("n", "N", "Nzz", { desc = "Search Prev" })
map("n", "g;", "g;zz", { desc = "Changelist Prev" })
map("n", "g,", "g,zz", { desc = "Changelist Next" })
map("n", "<C-f>", "<C-f>zz", { desc = "Scroll Half Down" })
map("n", "<C-b>", "<C-b>zz", { desc = "Scroll Half Up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Full Down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Full Up" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Mapping For Paste                           │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("x", "p", '"_dP', { silent = true, desc = "Paste Dont Copy Replaced Text" })

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

map({ "n", "i", "v" }, "<LocalLeader>q", "<cmd>BufDel<cr>", { silent = true, desc = "Delete Buffer" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                              Save File                               │
--   ╰──────────────────────────────────────────────────────────────────────╯

map({ "i", "v", "n", "s" }, "<LocalLeader>w", "<cmd>w<cr><esc>", { desc = "Save file" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Clear Search                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<Esc><Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear hlsearch" })

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

map({ "i", "t" }, "<C-h>", "<C-\\><C-N><C-w>h")
map({ "i", "t" }, "<C-j>", "<C-\\><C-N><C-w>j")
map({ "i", "t" }, "<C-k>", "<C-\\><C-N><C-w>k")
map({ "i", "t" }, "<C-l>", "<C-\\><C-N><C-w>l")
map({ "i", "t" }, "<C-w>", "<C-\\><C-n><C-w>")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Resize Window                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Buffers Changes                            │
--   ╰──────────────────────────────────────────────────────────────────────╯

if Has("bufferline.nvim") then
	map("n", "<LocalLeader><S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
	map("n", "<LocalLeader><Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
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
	map("n", "<LocalLeader><S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
	map("n", "<LocalLeader><Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                          Enhanced semicolon                          │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("n", ";;", ";", { desc = "Next Word" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                           Better Indenting                           │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("x", "<", "<gv")
map("x", ">", ">gv")

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                               New File                               │
--   ╰──────────────────────────────────────────────────────────────────────╯

-- quit
map("n", "<LocalLeader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Terminal Normal Mode
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Normal Mode" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                            Commant - Box                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

if Has("comment-box.nvim") then
	map({ "n", "v" }, "gco", "<CMD>CBccbox<CR>")
	map({ "n", "v" }, "gcO", "<CMD>CBccbox21<CR>")
	map({ "n", "v" }, "gcl", "<CMD>CBline5<CR>")
	map({ "n", "v" }, "gcL", "<CMD>CBline6<CR>")
end

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                              ToggleTerm                              │
--   ╰──────────────────────────────────────────────────────────────────────╯

map("t", "<LocalLeader>c", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                         Telescope - Projects                         │
--   ╰──────────────────────────────────────────────────────────────────────╯

if Has("telescope.nvim") then
	map(
		"n",
		"<LocalLeader>fp",
		"<cmd>lua require('telescope').extensions.projects.projects(require('telescope.themes').get_dropdown({hidden=true}))<cr>",
		{ desc = "Projects" }
	)

	map(
		"i",
		"[[",
		"<cmd>Telescope vimwiki link<cr>",
		-- "[[<esc><cmd>lua require('telescope.builtin').live_grep({initial_mode = 'insert', previewer = true })<cr>",
		{ desc = "Live grep vimwiki file" }
	)

	map("n", "((", "<cmd>Telescope vimwiki live_grep<cr>", { desc = "Live grep vimwiki file" })
end

map("n", "qj", ":cnext<CR>", { silent = true })
map("n", "qk", ":cprev<CR>", { silent = true })

--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                             Fold Toggles                             │
--   ╰──────────────────────────────────────────────────────────────────────╯

vim.cmd([[
    vnoremap <LocalLeader><Space> zf
    nnoremap <silent> <LocalLeader><Space> @=(foldlevel('.')?'za' : "\<Space>")<CR>
]])
