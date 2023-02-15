require("config.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"                   -- 设置插件安装目录

if not vim.loop.fs_stat(lazypath) then                                         -- 如果在插件目录未找到你设置的目录那么下载lazy.nvim插件管理器
    vim.fn.system({ "git", "clone", os.getenv("GITHUB") .. "folke/lazy.nvim.git", lazypath })
end

vim.opt.rtp:prepend(vim.env.LAZY or lazypath)                                  -- 加载插件安装目录

require("lazy").setup({
    defaults = {
        lazy = false,                                                          -- 此插件是否启用懒加载
        version = false,                                                       -- 启用此功能后,尝试安装最新最稳定版本
    },
    spec = {
        { import = "plugins" },                                                -- 导入 plugins 文件夹
    },
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",                  -- 运行更新后的生成的 lock 文件的位置
    concurrency = nil,                                                         -- 安装插件的并行数量
    git = {
        timeout = 120,                                                         -- 杀死耗时 2 分钟的进程
        url_format = os.getenv("GITHUB") .. "%s.git",                          -- 设置自定义插件下载地址
        filter = true,                                                         -- 大量增加下载量
    },
    install = {
        missing = true,                                                        -- 启动时安装确实的插件
        colorscheme = { "onedark" },                                           -- 在启动过程中启动安装时，尝试加载其中一种配色方案
    },
    ui = {
        size = { width = 0.8, height = 0.8 },                                  -- 值的数字大于1: 绝对值, 小于1: 百分比 
        wrap = true,                                                           -- 是否换行
        border = "none",                                                       -- 边框样式
        icons = {
            cmd = " ",
            config = "",
            event = "",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "鈴 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            source = " ",
            start = "",
            task = "✔ ",
            list = {
                "●",
                "➜",
                "★",
                "‒",
            },
        },
        browser = nil,                                                         -- 自定义浏览器, nil选择默认浏览器
        throttle = 20,                                                         -- 渲染频率
        custom_keys = {
            -- 打开终端显示插件路径
            ["<localleader>t"] = function(plugin)
                require("lazy.util").float_term(nil, {
                    cwd = plugin.dir,
                })
            end,
        },
    },
    diff = {
        cmd = "git",                                                           -- 显示差异
    },
    checker = { enabled = false },                                             -- 自动检查插件更新
    change_detection = {
        enabled = true,                                                        -- 自动检查配置文件更改并重新加载ui
        notify = true,                                                         -- 发现更改时获取通知
    },
    performance = {
        rtp = {
            -- 禁用插件列表
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "2html_plugin",
                "getscript",
                "getscriptPlugin",
                "logipat",
                "netrw",
                "netrwSettings",
                "netrwFileHandlers",
                "tar",
                "rrhelper",
                "spellfile_plugin",
                "vimball",
                "vimballPlugin",
                "zip",
                "rplugin",
                "syntax",
                "synmenu",
                "optwin",
                "compiler",
                "bugreport",
                "ftplugin",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "node_provider",
                "perl_provider",
                "python3_provider",
                "ruby_provider",
            },
        },
    },
})

vim.g.loaded_python3_provider = 0                                              -- 屏蔽 PYTHON3
vim.g.loaded_ruby_provider = 0                                                 -- 屏蔽 RUBY
vim.g.loaded_perl_provider = 0                                                 -- 屏蔽 PERL
vim.g.loaded_node_provider = 0                                                 -- 屏蔽 NODE
