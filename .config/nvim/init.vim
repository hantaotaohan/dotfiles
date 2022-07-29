----------------------------------------------------------------------------------------------------------------------------------

--                                                          NVIM.INIT.VIM

--                                                        Update: 2021.11.16

----------------------------------------------------------------------------------------------------------------------------------

local keymap        = vim.api.nvim_set_keymap
local opts          = {noremap  = true, silent = true}
local nopts         = {noremap  = true, silent = true}
local iopts         = {inoremap = true, silent = true}

----------------------------------------------------------------GENERAL-----------------------------------------------------------

vim.g.mapleader     = '\\'
vim.g.maplocalleader= ";"

vim.o.colorcolumn   = '80'
vim.o.background    = 'dark'
vim.o.encoding      = 'UTF-8'
vim.o.syntax        = true          
vim.o.termguicolors = true
vim.opt.cursorline  = true

vim.o.clipboard     = 'unnamedplus'

vim.o.wildignore = '.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*'
vim.o.wildignore = '*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store'
vim.o.wildignore = '**/node_modules/**,**/bower_modules/**,*/.sass-cache/*'
vim.o.wildignore = '__pycache__,*.egg-info,.pytest_cache,.mypy_cache/**'
vim.o.wildignore = '*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib'
vim.o.wildignore = '*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex'
vim.o.wildignore = '*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz'
vim.o.wildignore = '*DS_Store*,*.ipch'
vim.o.wildignore = '*.gem'
vim.o.wildignore = '*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso'
vim.o.wildignore = '*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**'
vim.o.wildignore = '*/.nx/**,*.app,*.git,.git'
vim.o.wildignore = '*.wav,*.mp3,*.ogg,*.pcm'
vim.o.wildignore = '*.mht,*.suo,*.sdf,*.jnlp'
vim.o.wildignore = '*.chm,*.epub,*.pdf,*.mobi,*.ttf'
vim.o.wildignore = '*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc'
vim.o.wildignore = '*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps'
vim.o.wildignore = '*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu'
vim.o.wildignore = '*.gba,*.sfc,*.078,*.nds,*.smd,*.smc'
vim.o.wildignore = '*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android'

---------------------------------------------------------------Directories-----------------------------------------------------------

local DATA_PATH      = '$HOME/.config/nvim '                                  -- 设置Vim主目录
vim.o.undofile       = true                                                   -- 开启撤销功能
vim.o.undodir        = 'DATA_PATH/undo//,DATA_PATH,~/tmp,/var/tmp,/tmp'       -- 设置撤销文件目录
vim.o.backupdir      = 'DATA_PATH/backup/,DATA_PATH,~/tmp,/var/tmp,/tmp'      -- 设置备份文件目录
vim.o.directory      = 'DATA_PATH/swap//,DATA_PATH,~/tmp,/var/tmp,/tmp'       -- 设置临时文件目录
vim.o.viewdir        = 'DATA_PATH/view/'                                      -- 设置视图文件目录
vim.o.viewoptions    = 'folds,cursor,curdir,slash,unix'                       -- 设置视图文件功能

vim.o.history        = 2000
vim.o.textwidth      = 80                                                     -- 换行前文字宽度最大字符
vim.o.expandtab      = true                                                   -- 将制表符扩展到空格
vim.o.tabstop        = 4                                                      -- 设置Tab键的宽度，可以更改，如：宽度为2
vim.o.shiftwidth     = 4                                                      -- 换行时自动缩进宽度，可更改（宽度同tabstop）
vim.o.softtabstop    = -1                                                     -- 自动与shiftwidth保持同步
vim.o.autoindent     = true                                                   -- 换行时候代码自动缩进
vim.o.smartindent    = true                                                   -- 启用智能对齐方式
vim.o.smarttab       = true                                                   -- 指定按一次backspace就删除shiftwidth宽度
vim.o.shiftround     = true                                                   -- 将缩进舍入为shiftwidth的倍数


vim.o.timeout        = true
vim.o.ttimeout       = true
vim.o.timeoutlen     = 500                                                    -- 映射超时
vim.o.ttimeoutlen    = 10                                                     -- 按键密码超时
vim.o.updatetime     = 400                                                    -- 空闲时间以写入交换并触发CursorHold
vim.o.redrawtime     = 2000                                                   -- 停止显示重绘的时间（以毫秒为单位）


vim.o.ignorecase     = true                                                   -- 搜索模式里忽略大小写
vim.o.smartcase      = true                                                   -- 如果搜索模式包含大写字符，不使用 'ignorecase' 选项
vim.o.infercase      = true                                                   -- 补全模式忽略大小写
vim.o.incsearch      = true                                                   -- 查找输入时动态增量显示查找结果
vim.o.wrapscan       = true                                                   -- 开启循环搜索

vim.o.complete       = '.,w,b,k'                                              -- 补全设置
vim.o.completeopt    = 'menuone,menu,longest,preview'                         -- 自动补全

vim.api.nvim_command('filetype plugin indent on')
vim.o.fileencodings  = 'utf-8,cp936,gb18030,big5,latin1'                      -- 探测即将打开的文件的字符编码
vim.o.fileencoding   = 'utf-8'                                                -- 打开文件的字符编码
vim.o.linebreak      = true                                                   -- 在breakat设定的字符上换行

vim.o.breakat        = ' \t;:,!?'
vim.o.diffopt        = 'filler,internal,algorithm:histogram,indent-heuristic' -- 更新diff配置

vim.o.mouse          = 'a'                                                    -- 启用鼠标
vim.o.hidden         = true                                                   -- 针对buffer不保存即可切换
vim.o.shortmess      = 'aoOTI'                                                -- 避免文字信息提示
vim.o.scrolloff      = 6                                                      -- 光标上下两侧最少保留的屏幕行数
vim.o.sidescrolloff  = 6                                                      -- 光标左右两侧最少保留的屏幕行数
vim.o.number         = true                                                   -- 显示行号
vim.o.showcmd        = true                                                   -- 显示命令
vim.o.showtabline    = 2                                                      -- 永远显示标签页
vim.o.laststatus     = 2                                                      -- 启用状态栏信息
vim.o.helpheight     = 12                                                     -- 帮助文件最小高度
vim.o.previewheight  = 12                                                     -- 预览窗口高度
vim.o.pumheight      = 15                                                     -- 弹出窗口高度
vim.o.cmdheight      = 1                                                      -- 设置命令行的高度为2，默认为1
vim.o.cursorline     = true                                                   -- 突出显示当前行
vim.o.helplang       = 'cn'                                                   -- 帮助文件语言
vim.o.showmatch      = true                                                   -- 匹配模式,括号匹配
vim.o.hlsearch       = true                                                   -- 高亮搜索的关键字
vim.o.matchtime      = 2                                                      -- 显示括号匹配的时间
vim.o.writebackup    = true                                                   -- 保存文件前建立备份，保存成功后删除该备份
vim.o.autoread       = true                                                   -- 当文件在外部被修改，自动更新该文件
vim.o.autochdir      = true                                                   -- 自动切换目录 
vim.o.ambiwidth      = 'single'                                               -- 设置为双字宽显示默认值double
vim.o.wildmenu       = true                                                   -- 允许下方显示目录
vim.o.lazyredraw     = true                                                   -- 延迟绘制（提升性能）
vim.o.ttyfast        = true                                                   -- 刷新更快
vim.o.formatoptions  = 'j'                                                    -- 合并两行中文时，不在中间加空格
vim.o.fileformats    = 'unix,dos,mac'                                         -- 文件换行符，默认使用 unix 换行符
vim.o.tags           = './.tags;,.tags'                                       -- 设置Tags


---------------------------------------------------------------Fold-Setting-----------------------------------------------------------
vim.o.foldenable     = true
vim.o.foldmethod     = 'manual'                                             -- 启用手动折叠zf
vim.o.foldlevel      = 0                                                    -- 设置折层所有内容
vim.o.foldclose      = 'all'                                                -- 设置为折叠自动关闭
vim.o.foldopen       = 'all'                                                -- 设置为折叠自动打开
vim.o.foldnestmax    = 1                                                    -- 设置 indent 和 syntax 方法的最大折叠嵌套层数


---------------------------------------------------------------Terminal-----------------------------------------------------------

vim.g.terminal_color_0  = "#282c34"
vim.g.terminal_color_1  = "#e06c75"
vim.g.terminal_color_2  = "#98c379"
vim.g.terminal_color_3  = "#d19a66"
vim.g.terminal_color_4  = "#61afef"
vim.g.terminal_color_5  = "#c678dd"
vim.g.terminal_color_6  = "#56b6c2"
vim.g.terminal_color_7  = "#dcdfe4"
vim.g.terminal_color_8  = "#282c34"
vim.g.terminal_color_9  = "#e06c75"
vim.g.terminal_color_10 = "#98c379"
vim.g.terminal_color_11 = "#e5c07b"
vim.g.terminal_color_12 = "#61afef"
vim.g.terminal_color_13 = "#c678dd"
vim.g.terminal_color_14 = "#56b6c2"
vim.g.terminal_color_15 = "#dcdfe4"

---------------------------------------------------------------Mapping-----------------------------------------------------------

keymap('n', 'q', '<nop>', opts)
keymap('v', 'q', '<nop>', opts)

keymap('n', 'n', 'nzz', opts)
keymap('n', 'N', 'Nzz', opts)

keymap('n', '{', '{zz', opts)
keymap('n', '}', '}zz', opts)

keymap('n', '(', '(zz', opts)
keymap('n', ')', ')zz', opts)

keymap('n', '[[', '[[zz', opts)
keymap('n', ']]', ']]zz', opts)

keymap('n', '<C-u>', '<C-u>zz', opts)
keymap('n', '<C-d>', '<C-d>zz', opts)

keymap('n', '<C-b>', '<C-b>zz', opts)
keymap('n', '<C-f>', '<C-f>zz', opts)

keymap('n', '<ESC><ESC>', ':nohlsearch', opts)

keymap('n', 'Y', 'y$', opts)


keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)

keymap('i', '<C-h>', '<C-w>h', opts)
keymap('i', '<C-l>', '<C-w>l', opts)
keymap('i', '<C-j>', '<C-w>j', opts)
keymap('i', '<C-k>', '<C-w>k', opts)

keymap('t', '<C-h>', '<C-w><C-h>', opts)
keymap('t', '<C-l>', '<C-w><C-l>', opts)
keymap('t', '<C-j>', '<C-w><C-j>', opts)
keymap('t', '<C-k>', '<C-w><C-k>', opts)

---------------------------------------------------------------Plug-----------------------------------------------------------

-- Installed packer if it's missing
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- TODO Improve this
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path, })
  vim.cmd("autocmd VimEnter * PackerSync")
end

return require("packer").startup({
  function(use)
    -- Packer (needed to manage packer packages to manage packages to manage...)
    use('wbthomason/packer.nvim')
    use('navarasu/onedark.nvim')
    require('onedark').setup { style = 'darker' }
    require('onedark').load()
end
})
