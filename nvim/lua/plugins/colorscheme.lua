return {

    -- ONEDARK

    { 
        "olimorris/onedarkpro.nvim",
        lazy = false,
        name = "OneDarkPro",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme onedark")

            require("onedarkpro").setup({
                colors = {},                                                   -- 覆盖默认颜色或创建自己的颜色
                filetypes = {                                                  -- 覆盖加载的文件类型突出显示组
                    javascript = true,
                    lua = true,
                    markdown = true,
                    php = true,
                    python = true,
                    ruby = true,
                    rust = true,
                    toml = true,
                    typescript = true,
                    typescriptreact = true,
                    vue = true,
                    yaml = true,
                },
                plugins = {                                                    -- 覆盖加载的插件突出显示组
                    aerial = true,
                    barbar = true,
                    copilot = true,
                    dashboard = true,
                    gitsigns = true,
                    hop = true,
                    indentline = true,
                    leap = true,
                    lsp_saga = true,
                    marks = true,
                    native_lsp = true,
                    neotest = true,
                    neo_tree = true,
                    nvim_cmp = true,
                    nvim_bqf = true,
                    nvim_dap = true,
                    nvim_dap_ui = true,
                    nvim_hlslens = true,
                    nvim_navic = true,
                    nvim_notify = true,
                    nvim_tree = true,
                    nvim_ts_rainbow = true,
                    op_nvim = true,
                    packer = true,
                    polygot = true,
                    startify = true,
                    telescope = true,
                    toggleterm = true,
                    treesitter = true,
                    trouble = true,
                    vim_ultest = true,
                    which_key = true,
                },
                semantic_tokens = {                                            -- 覆盖语义标记
                    default = {
                        ["@class"] = { fg = "${yellow}" },
                        ["@property"] = { fg = "${red}" },
                        ["@global"] = { fg = "${red}" },
                        ["@defaultLibrary"] = { fg = "${cyan}" },
                    },
                },
                highlights = {},                                               -- 覆盖默认高亮显示组或创建自己的高亮显示组
                styles = {                                                     -- 要应用粗体和斜体，请使用 “bold，italic”
                    types = "NONE",                                            -- 应用于类型的样式 
                    methods = "NONE",                                          -- 应用于方法的样式
                    numbers = "NONE",                                          -- 应用于数字的样式
                    strings = "NONE",                                          -- 应用于字符串的样式
                    comments = "NONE",                                         -- 应用于注释的样式
                    keywords = "NONE",                                         -- 应用于关键字的样式
                    constants = "NONE",                                        -- 应用于常量的样式
                    functions = "NONE",                                        -- 应用于函数的样式
                    operators = "NONE",                                        -- 应用于运算符的样式
                    variables = "NONE",                                        -- 应用于变量的样式
                    parameters = "NONE",                                       -- 应用于参数的样式
                    conditionals = "NONE",                                     -- 应用于条件的样式
                    virtual_text = "NONE",                                     -- 应用于虚拟文本的样式
                },
                options = {
                    cursorline = true,                                         --是否使用光标线突出显示？
                    transparency = false,                                      --使用透明背景？
                    terminal_colors = true,                                    --使用Neovim的主题颜色：Terminal？
                    highlight_inactive_windows = false,                        --当窗口失焦时，是否更改正常背景？
                }
            })
        end
    },
}
