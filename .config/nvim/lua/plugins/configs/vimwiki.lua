local M = {}

function M.setup()

    vim.g.vimwiki_list = {

        {

            path = "~/vimwiki/",                                      -- wiki 启动目录
            path_html = "~/vimwiki/html/",                            -- 生成 html 的目录
            name = 'VimWiki',                                         -- wiki 名称
            index = 'pages/index',                                          -- wiki 入口文件名
            syntax = "markdown",                                      -- 渲染语法
            links_space_char = "_",                                   -- 创建链接是替代空格的字符串
            ext = ".md",                                              -- 生成文件的后缀名
            diary_rel_path = 'journals/',                                 -- 日记目录
            diary_index = 'journals',                                    -- 日记入口文件名

            template_path = '$HOME/vimwiki/templates/',               -- wiki 生成 html 模板路径
            template_default = 'default',                             -- wiki 生成 html 模板文件
            template_ext = '.tpl',                                    -- wiki 生成 html 模板后缀
            template_date_format = '%Y-%m-%d',                        -- 模板日期格式
            css_file = '$HOME/vimwiki/templates/style.css',           -- wiki 生成 html 模板样式
            css_name = '$HOME/vimwiki/templates/style.css',           -- wiki 生成 html 模板样式
            html_filename_parameterization = 1,                       -- 生成 html 检查是否有对应的 markdown 文件
            custom_wiki2html = "vimwiki_markdown",

            maxhi = 1,                                                -- 突出指向不存在的文件,会变慢
            -- nested_syntaxes = { ['python'] = 'python'},               -- 内嵌语法高亮
            diary_sort = 'desc',                                      -- 对日记排序 desc asc
            diary_caption_level = 0,                                  -- 设置日记命名规则
            diary_frequency = 'daily',                                -- 创建日记频率 daily weekly monthly yearly
            diary_start_week_day = 'monday',                          -- 设置每周开始日期

            auto_export = 0,                                          -- 1 自动生成html
            auto_toc = 1,                                             -- 1 自动更新目录
            auto_tags = 1,                                            -- 1 自动更新标签
            auto_diary_index = 1,                                     -- 1 自动更新日记索引
            auto_generate_tags = 0,                                   -- 1 自动更新生成的标签
            auto_generate_links = 1,                                  -- 1 自动更新生成链接
            automatic_nested_syntaxes = 1,
            vimwiki_auto_chdir = 1

        }

    }

    vim.g.vimwiki_ext2syntax = {
        [".md"] = "markdown",
        [".markdown"] = "markdown",
        [".mdown"] = "markdown",
        [".wiki"] = "markdown"
    }

    vim.g.vimwiki_list_ignore_newline = 0
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_hl_headers = 1
    vim.g.vimwiki_hl_cb_checked = 2
    vim.g.vimwiki_folding = 'custom'                                  -- 启用折叠
    vim.g.vimwiki_html_header_numbering = 1
    vim.g.vimwiki_markdown_link_ext = 1                               -- 附加 wiki 扩展名至 Markdown 文件后
    vim.g.vimwiki_CJK_length = 1                                      -- 计算字符宽度
    vim.g.vimwiki_use_mouse = 0
    vim.g.vimwiki_conceallevel = 2                                    -- 隐藏标记
    vim.g.vimwiki_conceal_pre = 0                                     -- 隐藏内嵌头标记
    vim.g.vimwiki_list_margin = 0                                     -- 列表左侧边距 
    vim.g.diary_header = "Diary"                                      -- 日记主文件标题
    vim.g.vimwiki_toc_header = "Contents"                             -- 主文件标题
    vim.g.vimwiki_toc_link_format = 1                                 -- 目录标题显示级别
    vim.g.vimwiki_links_header_level = 6
    vim.g.vimwiki_autowriteall = 1                                    -- 自动保存
    vim.g.vimwiki_links_header = 'Generierte Links'
    vim.g.vimwiki_tags_header = 'Generierte Tags'
    vim.g.vimwiki_tags_header_level = 5
    vim.g.vimwiki_markdown_header_style = 2                           -- 生成标题后换行数量
    -- vim.g.vimwiki_listsyms = '✗○◐●✓'
    -- vim.g.vimwiki_bullet_types = {'•', '•', '→', "◉", "○", "✸", "✿" }
    vim.g.vimwiki_cycle_bullets = 1
    vim.g.vimwiki_filetypes = { 'markdown' }

    vim.cmd('filetype plugin indent on')
    -- vim.cmd[[autocmd FileType vimwiki setlocal filetype=vimwiki.markdown]]

    vim.cmd [[ autocmd FileType vimwiki.markdown syntax region VimwikiBlockquote start=/^\s*>/ end="$" ]]
    vim.cmd [[ autocmd FileType vimwiki.markdown highlight VimwikiBlockquote  cterm=bold guibg=#23272E  guifg=#545965 ]]

end

return M
