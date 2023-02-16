-- VARIABLE --

local opt = vim.opt
local VIM_DATA_PATH = vim.fn.stdpath("data")

-- LEADER --

vim.g.mapleader = "\\"                                                         -- 设置Leader
vim.g.maplocalleader = ";"                                                     -- 设置LocalLeader

-- DISABLE -- 

vim.g.python_host_skip_check = 1
vim.g.python3_host_skip_check = 1

-- DISPLAY --

opt.hidden = true                                                              -- 是否隐藏缓冲区, 用于切换BUFFER
opt.showtabline = 2                                                            -- 如何显示标签栏
opt.laststatus = 2                                                             -- 是否开启最后一个窗口何时有状态行 | 0: 永不 | 1: 只有在两个窗口时 | 2: 总是显示 |
opt.display = "lastline"                                                       -- 更改文本的显示方式
opt.cursorline = true                                                          -- 是否高亮当前行
opt.colorcolumn = ""                                                           -- 是否高亮指定的列
opt.termguicolors = true                                                       -- 开启终端真色彩支持

opt.number = true                                                              -- 是否开启左边栏的绝对行号
opt.numberwidth = 3                                                            -- 显示行号的最小列数 
opt.relativenumber = true                                                      -- 是否显示左边栏的相对行号
opt.signcolumn = "yes"                                                         -- 是否显示符号列
opt.conceallevel = 3                                                           -- 隐藏粗体和斜体的 * 标记

opt.scrolloff = 4                                                              -- 要保留在上方和下方的最小屏幕行数 
opt.sidescrolloff = 8                                                          -- 要保留在左侧和右侧的最小屏幕列数

opt.wildmode = "longest:full,full"                                             -- 命令行补全完成模式
opt.winminwidth = 5                                                            -- 当不是当前窗口时, 窗口的最小宽度

opt.winblend = 20                                                              -- 浮动窗口的伪透明度
opt.pumheight = 10                                                             -- 弹出菜单中显示的最大项目数
opt.pumblend = 10                                                              -- 启用弹出菜单的伪透明度
opt.previewheight = 12                                                         -- 预览窗口的默认高

opt.wrap = false                                                               -- 是否开启自动换行
opt.list = false                                                                -- 是否显示不可见或者隐藏字符
opt.showbreak = '↳  '                                                          -- 要放在已换行行的开头的字符串
opt.listchars:append("tab:>⋅")                                                  -- 用于显示选项卡的两个或三个字符. 第三个字符是可选的
opt.listchars:append("nbsp:␣")                                                 -- 不可断空格字符要显示的字符
opt.listchars:append("eol:↲" )                                                 -- 设置隐藏字符串: 要显示在每行末尾的字符
opt.listchars:append("space:⋅")                                                -- 空格中显示的字符
opt.listchars:append("trail:⣿")                                                -- 尾随空格显示的字符
opt.listchars:append("extends:→")                                              -- 当"换行"为关闭时, 如果超出屏幕所显示的字符
opt.listchars:append("conceal:┊")                                              -- 在隐藏文本中显示的字符"conceallevel"设置为1. 省略时的空格
opt.listchars:append("precedes:←")                                             -- 显示在物理行, 当在第一列中可见的字符

opt.fillchars:append("stl: ")                                                  -- 当前窗口的状态线
opt.fillchars:append("stlnc: ")                                                -- 非当前窗口的状态线
opt.fillchars:append("wbr: ")                                                  -- 窗口栏
opt.fillchars:append("horiz:─")                                                -- 水平分隔符
opt.fillchars:append("horizup:┴")                                              -- 向上水平分隔符 
opt.fillchars:append("horizdown:┬")                                            -- 向下水平分隔符 
opt.fillchars:append("vert:│")                                                 -- 垂直分隔符: vsplit
opt.fillchars:append("vertleft:┤")                                             -- 垂直分隔符:向左
opt.fillchars:append("vertright:├")                                            -- 垂直分隔符: 向右
opt.fillchars:append("verthoriz:┼")                                            -- 垂直和水平重合
opt.fillchars:append("fold:─")                                                 -- 填充折叠文本的分隔符
opt.fillchars:append("foldopen:⯆")                                             -- 标记折叠打开
opt.fillchars:append("foldsep:│")                                              -- 展开后的折叠标记
opt.fillchars:append("foldclose:⯈")                                            -- 标记折叠关闭 
opt.fillchars:append("diff: ")                                                 -- DIFF 已删除的行标记
opt.fillchars:append("msgsep:‾")                                               -- 消息分隔符
opt.fillchars:append("eob: ")                                                  -- 缓冲区末尾的空行
-- opt.fillchars:append("lastline: ")                                             -- 包含最后一行/截断

opt.diffopt:append ("filler")                                                  -- 显示填充线, 以保留文本与已插入的窗口同步
opt.diffopt:append ("iwhite")                                                  -- 忽略空白量的更改
opt.diffopt:append ("internal")                                                -- 使用内部diff库
opt.diffopt:append ("vertical")                                                -- 使用垂直拆分启动差异模式
opt.diffopt:append ("hiddenoff")                                               -- 当缓冲区隐藏
opt.diffopt:append ("indent-heuristic")                                        -- 使用内部缩进启发式DIFF库
opt.diffopt:append ("algorithm:patience")                                      -- 将指定的DIFF算法与内部DIFF引擎

opt.iskeyword:append ("_")                                                     -- 关键字用于搜索和识别许多命令
opt.iskeyword:append ("$")                                                     -- 关键字用于搜索和识别许多命令
opt.iskeyword:append ("@")                                                     -- 关键字用于搜索和识别许多命令
opt.iskeyword:append ("%")                                                     -- 关键字用于搜索和识别许多命令
opt.iskeyword:append ("#")                                                     -- 关键字用于搜索和识别许多命令

opt.shortmess:append("I")                                                      -- 启动Vim时, 不要给出介绍信息
opt.shortmess:append("c")                                                      -- 不要给出完成菜单消息, 例如 "--XXX完成(YYY)", "匹配1/2"
opt.shortmess:append("S")                                                      -- 搜索时不显示搜索计数消息
-- opt.shortmess:append("W")                                                      -- 写文件时不要给出"已写"或"[w]"
-- opt.shortmess:append("f")                                                      -- 使用 "(第3页, 共5页)" 代替 "(文件3页, 第5页)
-- opt.shortmess:append("i")                                                      -- 使用 "[noeol]" 代替 "[最后一行不完整]"
-- opt.shortmess:append("l")                                                      -- 使用 "999L, 888B" 代替 "999行, 888字节"
-- opt.shortmess:append("m")                                                      -- 使用 "[+]" 代替 "[Modified]"
-- opt.shortmess:append("n")                                                      -- 使用 "[New]" instead of "[New File]"
-- opt.shortmess:append("r")                                                      -- 使用 "[RO]" instead of "[readonly]"
-- opt.shortmess:append("w")                                                      -- 使用 "[w]" 而不是 "writed"
-- opt.shortmess:append("x")                                                      -- 使用 "[dos]" 代替 "[dos format]"
-- opt.shortmess:append("a")                                                      -- 启用全部缩写功能
-- opt.shortmess:append("o")                                                      -- 屏蔽自动写入时读取文件的信息
-- opt.shortmess:append("O")                                                      -- 用于读取文件的消息将覆盖以前的消息也适用于快速修复消息
-- opt.shortmess:append("s")                                                      -- 不要给出搜索命中底部, 在顶部继续的信息
-- opt.shortmess:append("t")                                                      -- 如果信息太长, 请在开头截断文件消息为了适应命令行
-- opt.shortmess:append("T")                                                      -- 如果中间的其他消息太长, 则截断它们为了适合命令行
-- opt.shortmess:append("A")                                                      -- 当现有[ATTENTION]出现时, 找到交换文件
-- opt.shortmess:append("C")                                                      -- 扫描ins完成时不要发送消息项目, 例如"扫描标签"
-- opt.shortmess:append("q")                                                      -- 使用"录制"而不是"录制@a"
-- opt.shortmess:append("F")                                                      -- 编辑文件时不要提供文件信息


-- BEHAVIOR --

opt.backup = false                                                             -- 是否开启备份文件功能
opt.swapfile = false                                                           -- 是否开启交换文件功能
opt.undofile = true                                                            -- 是否开启持久性撤销功能
opt.undolevels = 10000                                                         -- 可撤消的最大更改数
opt.writebackup = false                                                        -- 是否开启在覆盖文件之前进行备份. 备份将在之后删除
opt.undodir = VIM_DATA_PATH .. "/undo"                                         -- 设置撤销文件目录

opt.viewoptions:append "cursor"                                                -- 更改MKVIEW命令的效果: 光标在文件和窗口中的位置
opt.viewoptions:append "curdir"                                                -- 更改MKVIEW命令的效果: 本地当前目录
opt.viewoptions:append "folds"                                                 -- 更改MKVIEW命令的效果: 手动创建折叠. 打开/关闭折叠和局部折叠
opt.viewoptions:append "slash"                                                 -- 更改MKVIEW命令的效果: 始终启用. 在文件名中使用 "/"
opt.viewoptions:append "unix"                                                  -- 更改MKVIEW命令的效果: 始终启用. 使用“\n”行尾

opt.sessionoptions:append "buffers"                                            -- Mksession命令的效果: 隐藏和卸载缓冲区，而不仅仅是窗口中的缓冲区
opt.sessionoptions:append "curdir"                                             -- Mksession命令的效果: 当前目录
opt.sessionoptions:append "folds"                                              -- Mksession命令的效果: 手动创建折叠, 打开/关闭折叠和局部折叠
opt.sessionoptions:append "help"                                               -- Mksession命令的效果: 帮助窗口
opt.sessionoptions:append "tabpages"                                           -- Mksession命令的效果: 所有标签页
opt.sessionoptions:append "winsize"                                            -- Mksession命令的效果: 窗口大小

opt.wildignorecase = true                                                      -- 当完成文件名和目录时
opt.wildignore:append("*.jpg", "*.jpeg", "*.bmp", "*.gif", "*.png")            -- 文件模式列表。与其中一个匹配的文件 展开通配符、完成文件或 目录名
opt.wildignore:append("*.o", "*.obj", "*.exe", "*.dll", "*.so", "*.out")       -- 文件模式列表。与其中一个匹配的文件 展开通配符、完成文件或 目录名
opt.wildignore:append("*.swp", "*.swo", "*.swn")                               -- 文件模式列表。与其中一个匹配的文件 展开通配符、完成文件或 目录名
opt.wildignore:append("*/.git", "*/.hg", "*/.svn")                             -- 文件模式列表。与其中一个匹配的文件 展开通配符、完成文件或 目录名
opt.wildignore:append("tags", "*.tags")                                        -- 文件模式列表。与其中一个匹配的文件 展开通配符、完成文件或 目录名
opt.wildignore:append("*.zip", "**/tmp/**")                                    -- 文件模式列表。与其中一个匹配的文件 展开通配符、完成文件或 目录名
opt.wildignore:append("*.DS_Store,**/node_modules/**,**/bower_modules/**")     -- 文件模式列表。与其中一个匹配的文件 展开通配符、完成文件或 目录名

opt.shada = "!,'300,<50,@100,s10,h"                                            -- SHADA 文件设置
opt.shadafile = VIM_DATA_PATH .. "/shada/main.shada"                  -- SHADA 文件存放位置

opt.timeout = true                                                             -- 此选项和 "timeoutlen" 决定已接收映射的密钥序
opt.ttimeout = true                                                            -- 此选项和 "ttimeoutlen" 决定TUI已接收到密钥码序列
opt.timeoutlen = 300                                                           -- 等待映射序列完成的时间 (毫秒)
opt.ttimeoutlen = 0                                                            -- 等待键代码序列完成的时间 (毫秒)
opt.updatetime = 200                                                           -- 如果这几毫秒内没有键入任何内容自动保存
opt.updatecount = 0                                                            -- 键入多字符后, 交换文件将被写入磁盘如果为零, 则根本不会创建交换文件
opt.redrawtime = 1500                                                          -- 重新绘制显示的时间 (毫秒)

opt.textwidth=80                                                               -- 单行文本的最大宽度
opt.history = 9000                                                             -- 命令的历史记录
opt.mouse = "a"                                                                -- 是否开启鼠标模式
opt.title = true                                                               -- 是否启用窗口的标题
opt.modeline = true                                                            -- 是否开启MODELINE模式
opt.lazyredraw = true                                                          -- 是否开启懒惰重画屏幕
opt.ttyfast = true

opt.visualbell = false                                                         -- 是否开启警告声音
opt.errorbells = false                                                         -- 是否开启错误警报

opt.autoread = true                                                            -- 是否开启当检测到文件在Vim和它在Vim内部没有更改, 自动再次读取
opt.autowrite = true                                                           -- 是否开启自动保存

opt.tabstop = 4                                                                -- 空格制表符的数量
opt.shiftwidth = 4                                                             -- 用于缩进的每个步骤的空格数
opt.softtabstop = 4                                                            -- 在插入模式下按Tab键所实际得到的字符
opt.smarttab = true                                                            -- 是否开启根据文件中其他地方的缩进空格个数来确定一个tab是多少个空格
opt.expandtab = true                                                           -- 是否开启使用空格而不是制表符
opt.shiftround = true                                                          -- 是否开启将缩进舍入为ShiftWidth的倍数
opt.autoindent = true                                                          -- 是否开启自动缩进
opt.smartindent = true                                                         -- 是否自动插入缩进
opt.breakindent = true                                                         -- 是否每一条换行线都将在视觉上继续缩进

opt.magic = true                                                               -- 更改可用于搜索模式的特殊字符
opt.wrapscan = true                                                            -- 是否开启搜索完毕后重头开始搜索
opt.hlsearch = true                                                            -- 高亮搜索结果
opt.smartcase = true                                                           -- 是否开启搜索时忽略大小写
opt.infercase = true                                                           -- 是否开启在插入模式下完成关键字时大小写识别
opt.incsearch = true                                                           -- 键入搜索命令时, 显示模式键入时的位置到目前为止
opt.ignorecase = true                                                          -- 是否开启在所有搜索中设置大小写字符敏感
opt.inccommand = "nosplit"                                                     -- 是否开启预览增量更改或替换

opt.grepformat = "%f:%l:%c:%m"                                                 -- GREP命令输出的格式
opt.grepprg = "rg --hidden --vimgrep --smart-case --"                          -- 全局或本地到缓冲全局本地用于GREP命令的程序

opt.ruler = true                                                               -- 是否显示光标位置的行号和列号
opt.cmdheight = 1                                                              -- 用于命令行的屏幕行数
opt.showcmd = false                                                            -- 是否~在屏幕的最后一行显示(部分)命令
opt.showmode = false                                                           -- 是否在左下角显示输入模式
opt.showmatch = true                                                           -- 是否开启插入括号后，短暂跳转到匹配的括号

opt.regexpengine = 0                                                           -- REGEXP 引擎

opt.jumpoptions = 'view'                                                       -- 更改JumpList行为
opt.virtualedit = 'all'                                                        -- 可视化编辑模式加强
opt.whichwrap = ""                                                             -- 设置光标是否可以跨行
opt.startofline = true                                                         -- 是否开启光标移动到第一个非空白行
opt.encoding = "utf-8"                                                         -- 设置字符串的编码
opt.fileencoding = "utf-8"                                                     -- 设置当前缓冲区的文件内容编码
-- opt.clipboard = "unnamedplus"                                                  -- 同步系统剪贴板
opt.confirm = true                                                             -- 是否在在退出修改后的缓冲区之前确认保存更改
opt.formatoptions = "jcroqlnt"                                                 -- 文档格式化设置
opt.joinspaces = false                                                         -- 合并上下两行时不加入空格

opt.spelllang = { "en" }                                                       -- 是否开启拼写检查
opt.splitbelow = true                                                          -- 将新窗口置于当前窗口下方
opt.splitright = true                                                          -- 将新窗口置于当前窗口右方
opt.undolevels = 10000                                                         -- 可撤消的最大更改数

opt.wildmenu = true                                                            -- 当 "wildmenu" 打开时, 命令行完成以增强的模式
opt.complete = ".,w,b,k"                                                       -- 补全文档库模式
opt.completeopt = "menu,menuone,noselect"                                      -- 插入模式时的补全范围设置

opt.foldenable = true                                                          -- 是否开启折叠功能
opt.foldlevel = 0                                                              -- 设置折叠级别: 具有较高级别的折叠将被关闭
opt.foldnestmax = 1                                                            -- 设置 "缩进" 和 "语法" 的最大折叠嵌套方法. 这样可以避免创建过多的折叠
opt.foldcolumn = "1"                                                           -- 何时以及如何绘制折叠列.
opt.foldmethod = "manual"                                                      -- 用于当前窗口的折叠类型
opt.foldlevelstart = 99                                                        -- 打开文件时, 始终关闭所有折叠
opt.foldopen:remove "hor"                                                      -- 自动打开折叠的行为

-- OTHER --

if vim.fn.has("nvim-0.9.0") == 1 then
  opt.splitkeep = "screen"                                                     -- 该选项的值决定了打开时的滚动行为
  opt.shortmess:append { C = true }                                            -- 扫描ins完成shm-C时不要发送消息项目, 例如"扫描标签"
end
