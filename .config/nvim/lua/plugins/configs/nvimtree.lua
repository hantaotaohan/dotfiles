local present, nvim_tree = pcall(require, "nvim-tree")

if not present then
    return
end

local options = {

    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = false,
    ignore_buf_on_tab_change = {},
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = true,
    reload_on_bufenter = true,
    respect_buf_cwd = true,
    on_attach = "disable", -- function(bufnr). If nil, will use the deprecated mapping strategy
    remove_keymaps = false, -- boolean (disable totally or not) or list of key (lhs)

    view = {
        adaptive_size = true,
        centralize_selection = false,
        width = 30,
        -- height = 30,
        hide_root_folder = true,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",

        mappings = {

            custom_only = true,

            list = {
                { key = {"<CR>","o"}   ,     action = "edit"               },
                { key = "O"            ,     action = "edit_no_picker"     },
                { key = "C"            ,     action = "cd"                 },
                { key = "<C-v>"        ,     action = "vsplit"             },
                { key = "<C-x>"        ,     action = "split"              },
                { key = "<C-t>"        ,     action = "tabnew"             },
                { key = "<BS>"         ,     action = "close_node"         },
                { key = "go"           ,     action = "preview"            },
                { key = "H"            ,     action = "toggle_dotfiles"    },
                { key = "R"            ,     action = "refresh"            },
                { key = "a"            ,     action = "create"             },
                { key = "d"            ,     action = "remove"             },
                { key = "D"            ,     action = "trash"              },
                { key = "r"            ,     action = "rename"             },
                { key = "<C-r>"        ,     action = "full_rename"        },
                { key = "x"            ,     action = "cut"                },
                { key = "c"            ,     action = "copy"               },
                { key = "p"            ,     action = "paste"              },
                { key = "y"            ,     action = "copy_name"          },
                { key = "Y"            ,     action = "copy_path"          },
                { key = "gy"           ,     action = "copy_absolute_path" },
                { key = "u"            ,     action = "dir_up"             },
                { key = "s"            ,     action = "system_open"        },
                { key = "/"            ,     action = "live_filter"        },
                { key = "<Esc>"        ,     action = "clear_live_filter"  },
                { key = ";q"           ,     action = "close"              },
                { key = "W"            ,     action = "collapse_all"       },
                { key = "E"            ,     action = "expand_all"         },
                { key = "S"            ,     action = "search_node"        },
                { key = "."            ,     action = "run_file_command"   },
                { key = "<C-k>"        ,     action = "toggle_file_info"   },
                { key = "g?"           ,     action = "toggle_help"        },
                { key = "m"            ,     action = "toggle_mark"        },
            },
        },

        float = {
            enable = false,
            open_win_config = {
                relative = "editor",
                border = "rounded",
                width = 30,
                height = 30,
                row = 1,
                col = 1,
            },
        },
    },

    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                none = " ",
            },
        },

        icons = {
            webdev_colors = true,
            git_placement = "signcolumn",
            padding = " ",
            -- symlink_arrow = "➛",

            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },

            glyphs = {
                default = "",
                symlink = "",
                bookmark = "▐",

                folder = {
                    -- default = "",
                    default = " ",
                    open = " ",
                    empty = " ",
                    empty_open = " ",
                    symlink = " ",
                    symlink_open = " ",
                    arrow_open = "",
                    arrow_closed = "",
                },

                git = {
                    -- unstaged = "⬝" ,
                    unstaged = "▎" ,
                    staged = "▎",
                    unmerged = "",
                    renamed = "★" ,
                    untracked = "▎",
                    deleted = "▎",
                    ignored = "◌" ,
                },
            },
        },

        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = false,
    },

    hijack_directories = {
        enable = true,
        auto_open = true,
    },

    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
    },

    ignore_ft_on_setup = {},
    system_open = {
        cmd = "",
        args = {},
    },

    diagnostics = {
        enable = false,
        show_on_dirs = false,
        debounce_delay = 50,

        icons = {
            hint = " ",
            info = " ",
            warning = " ",
            error = " ",
        },
    },

    filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
    },

    filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
    },

    git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        timeout = 400,
    },

    actions = {
        use_system_clipboard = true,

        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },

        expand_all = {
            max_folder_discovery = 300,
            exclude = {},
        },

        file_popup = {
            open_win_config = {
                col = 10,
                row = 10,
                relative = "cursor",
                border = "shadow",
                style = "minimal",
            },
        },

        open_file = {
            quit_on_open = true,
            resize_window = true,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame","lualine" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },

        remove_file = {
            close_window = true,
        },
    },

    trash = {
        cmd = "gio trash",
        require_confirm = true,
    },

    live_filter = {
        prefix = "[Search]: ",
        always_show_folders = false,
    },

    log = {
        enable = false,
        truncate = false,
        types = {
            all = false,
            config = false,
            copy_paste = false,
            dev = false,
            diagnostics = false,
            git = false,
            profile = false,
            watcher = false,
        },
    },
}

nvim_tree.setup(options)
