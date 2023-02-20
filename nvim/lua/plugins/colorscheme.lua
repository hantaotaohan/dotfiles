return {

    -- ONEDARK

        "olimorris/onedarkpro.nvim",
        priority = 1000,
        opts = {
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
                aerial = false,
                barbar = false,
                copilot = false,
                dashboard = false,
                gitsigns = false,
                hop = false,
                indentline = false,
                leap = false,
                lsp_saga = false,
                marks = false,
                native_lsp = false,
                neotest = false,
                neo_tree = false,
                nvim_cmp = false,
                nvim_bqf = false,
                nvim_dap = false,
                nvim_dap_ui = false,
                nvim_hlslens = false,
                nvim_navic = false,
                nvim_notify = false,
                nvim_tree = false,
                nvim_ts_rainbow = false,
                op_nvim = false,
                packer = false,
                polygot = false,
                startify = false,
                telescope = false,
                toggleterm = false,
                treesitter = false,
                trouble = false,
                vim_ultest = false,
                which_key = false,
            },
            semantic_tokens = {                                            -- 覆盖语义标记
                default = {
                    ["@class"] = { fg = "${yellow}" },
                    ["@property"] = { fg = "${red}" },
                    ["@global"] = { fg = "${red}" },
                    ["@defaultLibrary"] = { fg = "${cyan}" },
                },
            },

            highlights = {
                -- Neo-Tree
                NeoTreeNormal = { fg = nil , bg = "#21252B" },
                NeoTreeNormalNC = { fg = nil , bg = "#21252B" },
                NeoTreeSignColumn = { fg = "#21252B" , bg = "#21252B" },
                NeoTreeEndOfBuffer = { fg = "#21252B" , bg = "#21252B" },
                NeoTreeVertSplit = { fg = "#21252B" , bg = "#21252B" },
                NeoTreeStatusLin = { fg = "#21252B" , bg = "#21252B" },
                NeoTreeStatusLineNC = { fg = "#21252B" , bg = "#21252B" }, 
                NeoTreeWinSeparator = { fg = "#21252B" , bg = "#21252B" },
                BufferLineOffsetSeparator = { fg = "#21252B" , bg = "#21252B" },

                lualine_b_17 = { fg = "#21252B" , bg = "#21252B" },
                lualine_transitional_lualine_b_28_to_lualine_c_inactive = { fg = "#21252B" , bg = "#21252B" },
                lualine_transitional_lualine_c_inactive_to_lualine_c_26 = { fg = "#21252B" , bg = "#21252B" },
                lualine_transitional_lualine_c_26_to_lualine_c_inactive = { fg = "#21252B" , bg = "#21252B" },
                lualine_transitional_lualine_x_32_to_lualine_c_inactive = { fg = "#21252B" , bg = "#21252B" },
                lualine_transitional_lualine_a_normal_to_lualine_a_3 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_3_to_lualine_b_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_normal_to_lualine_b_18 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_24_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_normal_to_lualine_c_16 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_16_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_x_10_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_normal_to_lualine_x_10 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_x_12_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_normal_to_lualine_y_6 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_y_8_to_lualine_b_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_normal_to_lualine_y_8 = { fg = "#21252B" , bg = "#21252B" },
lualine_y_3 = { fg = "#21252B" , bg = "#21252B" },
lualine_y_5 = { fg = "#21252B" , bg = "#21252B" },
lualine_c_7 = { fg = "#21252B" , bg = "#21252B" },
lualine_b_9 = { fg = "#21252B" , bg = "#21252B" },
lualine_a_9 = { fg = "#21252B" , bg = "#21252B" },
lualine_x_11 = { fg = "#21252B" , bg = "#21252B" },
lualine_x_13 = { fg = "#21252B" , bg = "#21252B" },
lualine_x_15 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_command_to_lualine_a_19 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_19_to_lualine_b_command = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_command_to_lualine_b_9 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_command_to_lualine_y_21 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_y_23_to_lualine_b_command = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_command_to_lualine_y_23 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_normal_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_mode_to_lualine_a_32 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_32_to_lualine_b_branch = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_branch_to_lualine_b_28 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_inactive_to_lualine_c_30 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_30_to_lualine_c_inactive = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_x_26_to_lualine_c_inactive = { fg = "#21252B" , bg = "#21252B" },
BufferLineDevIconDefaultInactive = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_command_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_normal_to_lualine_b_10 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_16_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_normal_to_lualine_c_18 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_18_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_x_20_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_normal_to_lualine_x_20 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_x_22_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_branch_to_lualine_b_30 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_30_to_lualine_c_inactive = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_inactive_to_lualine_c_28 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_28_to_lualine_c_inactive = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_command_to_lualine_a_3 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_3_to_lualine_b_command = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_command_to_lualine_b_17 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_command_to_lualine_y_11 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_y_13_to_lualine_b_command = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_command_to_lualine_y_13 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_mode_to_lualine_a_26 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_a_26_to_lualine_b_branch = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_branch_to_lualine_b_32 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_32_to_lualine_c_inactive = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_x_28_to_lualine_c_inactive = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_b_21_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_normal_to_lualine_c_13 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_13_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_x_3_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_c_normal_to_lualine_x_3 = { fg = "#21252B" , bg = "#21252B" },
lualine_transitional_lualine_x_5_to_lualine_c_normal = { fg = "#21252B" , bg = "#21252B" },

            },  

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
        },

        config = function(_, opts)
            require("onedarkpro").setup(opts)
            vim.cmd.colorscheme("onedark")
        end
    }
