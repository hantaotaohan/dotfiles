local present, telescope = pcall(require, "telescope")

if not present then
    return
end

vim.g.theme_switcher_loaded = true

local options = {

    defaults = {

        -- path_display = { 'smart'},
        sorting_strategy = "ascending",       -- escending (default) | ascending
        selection_strategy = "reset",         -- reset (default) | follow | row | closest | none
        scroll_strategy = "cycle",            -- cycle" (default) | limit
        layout_strategy = "horizontal",       -- vertical | center | cursor
        hl_result_eol = true,

        layout_config = {
            bottom_pane = {
                height = 25,
                preview_cutoff = 120,
                prompt_position = "top"
            },
            center = {
                height = 0.4,
                preview_cutoff = 40,
                prompt_position = "top",
                width = 0.5
            },
            cursor = {
                height = 0.9,
                preview_cutoff = 40,
                width = 0.8
            },
            horizontal = {
                height = 0.8,
                preview_cutoff = 120,
                prompt_position = "top",
                width = 0.8
            },
            vertical = {
                height = 0.9,
                preview_cutoff = 40,
                prompt_position = "top",
                width = 0.8
            },
        },

        cycle_layout_list = { "horizontal", "vertical" },
        winblend = 20,
        wrap_results = false,
        prompt_prefix = "    ",
        -- prompt_prefix = "Search: ",
        selection_caret = "  ",
        -- selection_caret = " ⯈ ",
        entry_prefix = "   ",
        multi_icon = " + ",
        initial_mode = "normal",              -- insert | normal 
        border = true,

        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- borderchars = {
        --     prompt =  {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
        --     results = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
        --     preview = {'▀', '▐', '▄', '▌', '▛', '▜', '▟', '▙' },
        -- },

        dynamic_preview_title = true,
        results_title = "Results",
        prompt_title = "Prompt",

        mappings = {

            i = {
                ["<LocalLeader>q"] = { "<esc>", type = "command" },
            },

            n = {
                ["q"] = require("telescope.actions").close,
                ["<LocalLeader>q"] = require("telescope.actions").close,
            },

        },

        vimgrep_arguments = {

            "rg",
            "L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },

        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        color_devicons = false,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

        pickers = {
            buffers = {
                ignore_current_buffer = true,
                sort_mru = true,
                sort_lastused = true,
            },
        },

        require('telescope').load_extension('projects'),
        require('telescope').load_extension('vimwiki'),
        require('telescope').load_extension('fzf')

    }

}

telescope.setup(options)
