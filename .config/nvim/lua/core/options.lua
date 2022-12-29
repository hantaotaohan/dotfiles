-------------------------------------------------------------------------------
                          -- Shorten Function Name --
-------------------------------------------------------------------------------

local o = vim.opt
local g = vim.g

local vim_data_path = vim.fn.stdpath("data")

-- Disable default mappings for speeddating
g.speeddating_no_mappings = 1

g.python_host_skip_check = 1
g.python3_host_skip_check = 1

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
                             -- Use Filetype.lua --
-------------------------------------------------------------------------------

g.vim_version = vim.version().minor

if g.vim_version < 8 then
    g.did_load_filetypes = 0
    g.do_filetype_lua = 1
end

-------------------------------------------------------------------------------
                             -- Start Configure --
-------------------------------------------------------------------------------

-- 编码设置
g.encoding = "utf-8"
o.fileencoding = "utf-8"

-- 光标设置
o.whichwrap = ""
o.scrolloff = 2
o.sidescrolloff = 2
o.virtualedit = 'block'

-- 行号边栏设置
o.number = false
o.relativenumber = true
o.numberwidth = 3
o.signcolumn = "yes"

-- 编辑区域设置
o.list = false
o.cursorline = true
o.colorcolumn = ""
o.listchars:append("eol:↲" )
o.listchars:append("tab:·")
o.listchars:append("space:⋅")
o.listchars:append("trail:•")
o.listchars:append("extends:▸")
o.listchars:append("precedes:◂")
o.listchars:append("conceal:┊")
o.listchars:append("nbsp:␣")

-- 缩进设置
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.expandtab = true
o.smarttab = true
o.shiftround = true
o.autoindent = true
o.smartindent = true

-- 搜索设置
o.wrapscan = true
o.hlsearch = true
o.smartcase = true
o.infercase = true
o.incsearch = true
o.ignorecase = true
o.inccommand = "nosplit"
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --hidden --vimgrep --smart-case --"

-- 命令行区域设置
o.ruler = true
o.cmdheight = 1
o.laststatus = 2
o.showmode = false
o.showcmd = false
o.showmatch = true

-- 行为设置
o.regexpengine = 0
o.wrap = false
o.textwidth=79
o.title = true
o.mouse = 'a'
o.magic = true
o.history = 9000
o.modeline = true
o.autoread = true
o.winblend = 20
o.lazyredraw = true
o.visualbell = false
o.errorbells = false
o.splitbelow = true
o.splitright = true
o.startofline = true
o.breakindent = true
o.showbreak = '↳  '
o.jumpoptions = 'view'         -- jumpoptions = "stack",
o.conceallevel = 2             -- so that `` is visible in markdown files
o.iskeyword:append "_"
o.iskeyword:append "$"
o.iskeyword:append "@"
o.iskeyword:append "%"
o.iskeyword:append "#"
o.shortmess:append "c"
o.shortmess:append 'A'
o.shortmess:append 'I'
o.shortmess:append 'O'
o.shortmess:append 'T'
o.shortmess:append 'a'
o.shortmess:append 'o'
o.shortmess:append 't'
o.termguicolors = true
o.clipboard:append "unnamedplus"

-- 差异对比设置
o.diffopt:append 'vertical'
o.diffopt:append 'algorithm:patience'
o.diffopt:append 'hiddenoff'
o.diffopt:append 'indent-heuristic'
o.diffopt:append 'filler'
o.diffopt:append 'iwhite'
o.diffopt:append 'internal'

-- 标签页设置
o.hidden = true
o.showtabline = 2

-- 备份文件设置
o.backup = false
o.undofile = true
o.swapfile = false
o.undolevels = 10000
o.undodir = vim_data_path .. "/undo"
o.writebackup = false
o.viewoptions:append "cursor"
o.viewoptions:append "curdir"
o.viewoptions:append "folds"
o.viewoptions:append "slash"
o.viewoptions:append "unix"
o.sessionoptions:append "curdir"
o.sessionoptions:append "help"
o.sessionoptions:append "tabpages"
o.sessionoptions:append "winsize"
o.wildignorecase = true
o.wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
o.shada = "!,'300,<50,@100,s10,h"
o.shadafile = vim.fn.stdpath("data") .. "/shada/main.shada"

-- 设置超时时间
o.timeout = true
o.ttimeout = true
o.timeoutlen = 500
o.ttimeoutlen = 0
o.updatetime = 100
o.updatecount = 0
o.redrawtime = 1500

-- 补全设置
o.pumheight = 10
o.pumblend = 10
o.previewheight = 12
o.wildmenu = true
o.complete = ".,w,b,k"
o.completeopt = "menuone,noselect"

-- 折叠设置
o.foldlevel = 0
o.foldnestmax = 1
o.foldenable = true
o.foldcolumn = "1"
o.foldmethod = "manual"
o.foldlevelstart = 99
o.foldtext='NeatFoldText()'
o.foldopen:remove "hor"
-- o.foldclose = "all"
-- o.foldopen = "all"

vim.cmd[[
    function! NeatFoldText() 
        let line = "█  " . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . "  █" 
        let lines_count = v:foldend - v:foldstart + 1
        let lines_count_text = ' ' . printf("%10s", lines_count . ' lines') . ' '
        let foldchar = matchstr(&fillchars, 'fold:\zs.')
        let foldtextstart = strpart(" FOLDED █" . line , 0, (winwidth(0)*2)/6)
        let foldtextend = "█" . lines_count_text . repeat(foldchar, 8) . "█"
        let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
        return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
    endfunction
]]

vim.cmd [[
    vnoremap <Space> zf
    nnoremap <silent> <Space> @=(foldlevel('.')?'za' : "\<Space>")<CR>
]]

-- UI
o.display = "lastline"

o.fillchars:append("stl: ")
o.fillchars:append("stlnc: ")
o.fillchars:append("vert:┃")
o.fillchars:append("fold:█")
-- o.fillchars:append("fold:─")
o.fillchars:append("diff: ")
o.fillchars:append("msgsep:‾")
o.fillchars:append("eob: ")
o.fillchars:append("vert:┃")
o.fillchars:append("foldopen:⯆")
o.fillchars:append("foldsep:│")
o.fillchars:append("foldclose:⯈")


-------------------------------------------------------------------------------
                        -- Disable Nvim Built Plugins --
-------------------------------------------------------------------------------

local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "syntax",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-------------------------------------------------------------------------------
                      -- Disable  Third-party Languages --
-------------------------------------------------------------------------------

local default_providers = {
    "node",
    "perl",
    "ruby",
    "python3",
}

for _, provider in ipairs(default_providers) do
    vim.g["loaded_" .. provider .. "_provider"] = 0
end

