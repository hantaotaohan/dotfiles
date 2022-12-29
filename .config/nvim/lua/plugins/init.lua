vim.cmd "packadd packer.nvim"

local plugins = {

    ---------------------------------------------------------------------------
    -- 加速插件 --
    ---------------------------------------------------------------------------

    {
        "lewis6991/impatient.nvim",
        disable = false,
    },

    ---------------------------------------------------------------------------
    -- 模糊搜索插件依赖项
    ---------------------------------------------------------------------------

    {
        "nvim-lua/plenary.nvim",
        disable = false,
        module = "plenary",
    },

    ---------------------------------------------------------------------------
    -- 插件管理器 --
    ---------------------------------------------------------------------------

    {
        "wbthomason/packer.nvim",
        disable = false,
        cmd = require("core.lazyload").packer_cmds,
        config = function()
            require "plugins"
        end,
    },

    ---------------------------------------------------------------------------
    -- 模糊搜索插件
    ---------------------------------------------------------------------------

    {
        "nvim-telescope/telescope.nvim",
        disable = false,
        branch = "0.1.x",
        cmd = { "Telescope", "ChangeColorScheme" },
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require "plugins.configs.telescope"
            require "core.themes"
        end,
    },

    ---------------------------------------------------------------------------
    -- 模糊搜索插件扩展 排序后端
    ---------------------------------------------------------------------------

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        disable = false,
        run = 'make'
    },

    ---------------------------------------------------------------------------
    -- 模糊搜索插件  - 扩展
    ---------------------------------------------------------------------------

    {
		"ahmedkhalf/project.nvim",
        disable = false,
        requires = { "telescope.nvim" },
        config = function()
            require "plugins.configs.other".project()
        end,
    },

    ---------------------------------------------------------------------------
    -- 颜色主题
    ---------------------------------------------------------------------------

    {
        "hantaotaohan/onedark.nvim",
        disable = false,
        config = function()
            require "plugins.configs.onedark"
        end,
    },

    ---------------------------------------------------------------------------

    {
        'shaunsingh/nord.nvim'
    },

    ---------------------------------------------------------------------------

    {
        'ellisonleao/gruvbox.nvim'
    },

    ---------------------------------------------------------------------------
    -- 标签页插件
    ---------------------------------------------------------------------------

    {
        "akinsho/bufferline.nvim",
        disable = false,
        tag = "v2.*",
        config = function()
            require "plugins.configs.bufferline"
        end,
    },

    ---------------------------------------------------------------------------
    -- 状态栏插件
    ---------------------------------------------------------------------------

    {
        "nvim-lualine/lualine.nvim",
        disable = false,
        config = function()
            require "plugins.configs.lualine"
        end,
    },

    ---------------------------------------------------------------------------
    -- 文件浏览器
    ---------------------------------------------------------------------------

    {
        "kyazdani42/nvim-tree.lua",
        disable = false,
        -- ft = "alpha",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        config = function()
            require "plugins.configs.nvimtree"
        end,
    },

    ---------------------------------------------------------------------------
    -- 文件浏览器 - 扩展
    ---------------------------------------------------------------------------

    {
        "kyazdani42/nvim-web-devicons",
        disable = false,
        module = "nvim-web-devicons",
        config = function()
            require "plugins.configs.other".devicons()
        end,
    },

    ---------------------------------------------------------------------------
    -- 标签浏览器
    ---------------------------------------------------------------------------

    {
        'simrat39/symbols-outline.nvim',
        disable = false,
        after = "nvim-lspconfig",
        config = function()
            require "plugins.configs.outline"
        end,
    },

    ---------------------------------------------------------------------------
    -- 终端插件
    ---------------------------------------------------------------------------

    {
        "akinsho/toggleterm.nvim", tag = 'v2.*',
        disable = false,
        config = function()
            require "plugins.configs.toggleterm"
        end,
    },

    ---------------------------------------------------------------------------
    -- 代码运行插件
    ---------------------------------------------------------------------------

    {
        'CRAG666/code_runner.nvim',
        disable = false,
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require "plugins.configs.runner"
        end,
    },

    ---------------------------------------------------------------------------
    -- 缩进提示插件
    ---------------------------------------------------------------------------

    {
        "lukas-reineke/indent-blankline.nvim",
        disable = false,
        opt = true,
        setup = function()
            require("core.lazyload").on_file_open "indent-blankline.nvim"
        end,
        config = function()
            require "plugins.configs.other".blankline()
        end,
    },

    ---------------------------------------------------------------------------
    -- 关闭标签页插件 --
    ---------------------------------------------------------------------------

    {
        'mhinz/vim-sayonara',
        disable = false,
    },

    ---------------------------------------------------------------------------
    -- 差异显示插件 --
    ---------------------------------------------------------------------------

    {
        'lewis6991/gitsigns.nvim',
        disable = false,
        after = "alpha-nvim",
		-- setup = function()
		-- 	require("core.lazyload").gitsigns()
		-- end,
        config = function()
            require "plugins.configs.gitsigns"
        end,
    },

    ---------------------------------------------------------------------------
    -- 滚动条插件
    ---------------------------------------------------------------------------

    {
        "petertriho/nvim-scrollbar",
        disable = false,
        after = "gitsigns.nvim",
        config = function()
            require "plugins.configs.other".scrollbar()
        end,
    },

    ---------------------------------------------------------------------------
    -- Git 插件
    ---------------------------------------------------------------------------

    {
        "tpope/vim-fugitive",
        disable = false,
    },

    ---------------------------------------------------------------------------
    -- 注释插件
    ---------------------------------------------------------------------------

    {
        "numToStr/Comment.nvim",
        disable = false,
		module = "Comment",
		keys = { "gcc", "gb" },
        config = function()
            require "plugins.configs.other".comment()
        end,
    },

    ---------------------------------------------------------------------------
    -- 美化注释插件
    ---------------------------------------------------------------------------

    {
        "LudoPinelli/comment-box.nvim",
        disable = false,
        config = function()
            require "plugins.configs.other".commentbox()
        end,
    },

    ---------------------------------------------------------------------------
    -- 快捷键提示插件
    ---------------------------------------------------------------------------

    {
        "folke/which-key.nvim",
        disable = false,
        module = "which-key",
        keys = "<leader>",
        config = function()
            require "plugins.configs.whichkey"
        end,
    },

    ---------------------------------------------------------------------------
    -- 语法渲染插件
    ---------------------------------------------------------------------------

    {
        "nvim-treesitter/nvim-treesitter",
        disable = false,
        module = "nvim-treesitter",
		setup = function()
			require("core.lazyload").on_file_open "nvim-treesitter"
		end,
		cmd = require("core.lazyload").treesitter_cmds,
        run = ":TSUpdate",
        config = function()
            require "plugins.configs.treesitter"
        end,
    },

    ---------------------------------------------------------------------------
    -- 语法渲染插件 - 扩展 - 彩虹括号
    ---------------------------------------------------------------------------

    {
        "p00f/nvim-ts-rainbow",
        setup = function()
            require("core.lazyload").on_file_open "nvim-ts-rainbow"
        end,
    },

    ---------------------------------------------------------------------------
    -- LSP
    ---------------------------------------------------------------------------

    { "williamboman/mason.nvim" },

    { 'williamboman/mason-lspconfig.nvim' },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lsp.install"
        end,
    },

    ---------------------------------------------------------------------------
    -- Load Luasnips + CMP Related In Insert Mode Only
    ---------------------------------------------------------------------------

    {
        "rafamadriz/friendly-snippets",
        disable = false,
        module = { "cmp", "cmp_nvim_lsp" },
        event = "InsertEnter",
    },

    -- {
    --     "hrsh7th/cmp-nvim-lsp",
    --     disable = false,
    --     after = "cmp_luasnip",
    -- },

    {
        "hrsh7th/nvim-cmp",
        disable = false,
        after = "friendly-snippets",
        config = function()
            require "plugins.configs.cmp"
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        disable = false,
        wants = "friendly-snippets",
        after = "nvim-cmp",
        config = function()
            require "plugins.configs.other".luasnip()
        end,
    },

    {
        "saadparwaiz1/cmp_luasnip",
        disable = false,
        after = "LuaSnip",
    },

    {
        "hrsh7th/cmp-nvim-lua",
        disable = false,
        after = "cmp_luasnip",
    },

    {
        "hrsh7th/cmp-nvim-lsp",
        disable = false,
        after = "cmp-nvim-lua",
    },

    {
        "hrsh7th/cmp-buffer",
        disable = false,
        after = "cmp-nvim-lsp",
    },

    {
        "hrsh7th/cmp-path",
        disable = false,
        after = "cmp-buffer",
    },

    ---------------------------------------------------------------------------
    -- misc plugins
    ---------------------------------------------------------------------------

    ---------------------------------------------------------------------------
    -- 自动补全括号
    ---------------------------------------------------------------------------

    {
        "windwp/nvim-autopairs",
        disable = false,
        after = "nvim-cmp",
        config = function()
            require("plugins.configs.other").autopairs()
        end,
    },

    ---------------------------------------------------------------------------
    -- 欢迎页
    ---------------------------------------------------------------------------

    {
        "goolord/alpha-nvim",
        disable = false,
        after = "onedark.nvim",
        config = function()
            require "plugins.configs.alpha".config()
        end,
    },

    ---------------------------------------------------------------------------
    -- 快速修改匹配括号
    ---------------------------------------------------------------------------

    {
        "kylechui/nvim-surround",
        disable = false,
        config = function()
            require("nvim-surround").setup()
        end,
    },

    ---------------------------------------------------------------------------
    -- 记住光标位置
    ---------------------------------------------------------------------------

    -- {
    --     "vladdoster/remember.nvim",
    --     disable = false,
    --     config = function()
    --         require "plugins.configs.remember"
    --     end,
    -- },

    ---------------------------------------------------------------------------
    -- 书签插件
    ---------------------------------------------------------------------------

    {
        "chentoast/marks.nvim",
        disable = false,
        config = function()
            require "plugins.configs.other".marks()
        end,
    },

    ---------------------------------------------------------------------------
    -- TMUX 插件
    ---------------------------------------------------------------------------

    {
        "aserowy/tmux.nvim",
        disable = false,
        config = function()
            require "plugins.configs.other".tmux()
        end,
    },

    ---------------------------------------------------------------------------
    -- 专注模式插件
    ---------------------------------------------------------------------------

    -- {
    --     "folke/zen-mode.nvim",
    --     disable = false,
    --     config = function()
    --         require "plugins.configs.other".zen-mode()
    --     end,
    -- },

    ---------------------------------------------------------------------------
    -- 颜色插件
    ---------------------------------------------------------------------------

    {
        "norcalli/nvim-colorizer.lua",
        disable = false,
        opt = true,
        setup = function()
            require("core.lazyload").on_file_open "nvim-colorizer.lua"
        end,
        config = function()
            require "plugins.configs.other".colorizer()
        end,
    },

    ---------------------------------------------------------------------------
    -- Markdown 插件
    ---------------------------------------------------------------------------

    {
        "ellisonleao/glow.nvim",
        disable = false,
        ft = {"markdown", "md"},
        event = "BufReadPost",
        config = function()
            require "plugins.configs.other".glow()
        end,
    },

    ---------------------------------------------------------------------------
    -- 折叠插件
    ---------------------------------------------------------------------------

    {
        'anuvyklack/pretty-fold.nvim',
        disable = false,
        event = "BufReadPost",
        config = function()
            require "plugins.configs.other".fold()
        end
    },

    ---------------------------------------------------------------------------
    -- 批量查找替换
    ---------------------------------------------------------------------------

    {
        'nvim-pack/nvim-spectre',
        disable = false,
        event = "BufReadPost",
        config = function()
            require "plugins.configs.other".spectre()
        end
    },

    ---------------------------------------------------------------------------
    -- 匀速滚动
    ---------------------------------------------------------------------------

    {
        'karb94/neoscroll.nvim',
        disable = true,
        event = "BufReadPost",
        config = function()
            require "plugins.configs.other".neoscroll()
        end
    },

    ---------------------------------------------------------------------------
    -- 重命名插件
    ---------------------------------------------------------------------------

    {
        'filipdutescu/renamer.nvim',
        disable = false,
        branch = 'master',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require "plugins.configs.other".renamer()
        end,
    },

    ---------------------------------------------------------------------------
    -- 多光标
    ---------------------------------------------------------------------------

    -- {
    --     'terryma/vim-multiple-cursors',
    --     disable = false,
    --     event = "BufReadPost",
    --     config = function()
    --         require "plugins.configs.multiple-cursors"
    --     end
    -- },

    ---------------------------------------------------------------------------
    -- 笔记应用
    ---------------------------------------------------------------------------

    {
        'vimwiki/vimwiki',
        disable = false,
        branch = 'dev',
        config = function()
            require "plugins.configs.vimwiki".setup()
        end
    },

    ---------------------------------------------------------------------------

    {
        'ElPiloto/telescope-vimwiki.nvim',
        disable = false,
    },

    ---------------------------------------------------------------------------

    -- {
    --     'hantaotaohan/vimwiki-sync',
    --     disable = false,
    -- },

    ---------------------------------------------------------------------------

    {
        'skywind3000/asyncrun.vim',
        disable = false,
        config = function()
            require "plugins.configs.other".asyncrun()
        end

    },

    {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    },
    ---------------------------------------------------------------------------
    -- 输入法切换
    ---------------------------------------------------------------------------

    -- {
    --     'meijieru/imtoggle.nvim',
    --     disable = false,
    --     config = function()
    --         require("imtoggle").setup()
    --     end
    -- },

    ---------------------------------------------------------------------------
    -- 中文格式化
    ---------------------------------------------------------------------------

    {
        'hotoo/pangu.vim',
        disable = false,
        ft = {'vimwiki','markdown','vimwiki.markdown'},
        config = function()
            require "plugins.configs.other".pangu()
        end
    },

    {
        'sunjon/shade.nvim',
        disable = false,
        config = function()
            require "plugins.configs.other".shade()
        end
    },
    ---------------------------------------------------------------------------
}

require("core.packer").run(plugins)
