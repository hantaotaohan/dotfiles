return {

    "nvim-neo-tree/neo-tree.nvim",
    lazy = true,
    version = 'v2.x',
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { '<leader>|', ':Neotree reveal filesystem float toggle=true<cr>', desc = 'Toggle file tree (float)' },
        { '<localleader>e', ':Neotree toggle<cr>', desc = 'Toggle file tree (sidebar)' },
    },
    config = function()

        local tree = require 'neo-tree'
        local highlights = require 'neo-tree.ui.highlights'
        local renderer = require 'neo-tree.ui.renderer'

        -- ascend to the parent or close it
        local function float(state)
            local node = state.tree:get_node()
            if (node.type == 'directory' or node:has_children()) and node:is_expanded() then
                state.commands.toggle_node(state)
            else
                renderer.focus_node(state, node:get_parent_id())
            end
        end

        -- toggle a node open or descend to it's first child
        local function dive(state)
            local node = state.tree:get_node()
            if node.type == 'directory' or node:has_children() then
                if not node:is_expanded() then
                    if node.type == 'directory' then
                        require 'neo-tree.sources.filesystem'.toggle_directory(state, node)
                    else
                        state.commands.toggle_node(state)
                    end
                else
                    renderer.focus_node(state, node:get_child_ids()[1])
                end
            end
        end

        tree.setup {
            add_blank_line_at_top = true,                                      -- 在顶部添加空行
            close_if_last_window = true,                                       -- 如果Neo树是选项卡中剩下的最后一个窗口，请关闭它
            close_floats_on_escape_key = true,
            popup_border_style = "NC",                                          -- "double", "none", "rounded", "shadow", "single" or "solid"
            enable_git_status = true,
            enable_diagnostics = false,
            use_libuv_filewatcher = true,
            git_status_async = true,
            git_status_async_options = {
                batch_size = 1000,
                batch_delay = 10,
                max_lines = 10000,
  
            },
            hide_root_node = false,                                            -- 隐藏根节点
            retain_hidden_root_indent = false,                                 -- 如果根节点被隐藏，则无论如何都要保留缩进
            resize_timer_interval = 500,
            sort_ase_insensitive=false,                                        --在对树中的文件和目录进行排序时使用
            sort_function=nil,                                                 --使用自定义函数对树中的文件和目录进行排序

            source_selector = {
                winbar = false, -- toggle to show selector on winbar
                statusline = false, -- toggle to show selector on statusline
                show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
                                                    -- of the top visible node when scrolled down.
                tab_labels = { -- falls back to source_name if nil
                    filesystem = "  Files ",
                    buffers =    "  Buffers ",
                    git_status = "  Git ",
                    diagnostics = " 裂Diagnostics ",
                },
                content_layout = "start", -- only with `tabs_layout` = "equal", "focus"
                tabs_layout = "equal", -- start, end, center, equal, focus
                truncation_character = "…", -- character to use when truncating the tab label
                tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
                tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
                padding = 0, -- can be int or table
                separator = { left = "▏", right= "▕" },
                separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
                show_separator_on_edge = false,
                highlight_tab = "NeoTreeTabInactive",
                highlight_tab_active = "NeoTreeTabActive",
                highlight_background = "NeoTreeTabInactive",
                highlight_separator = "NeoTreeTabSeparatorInactive",
                highlight_separator_active = "NeoTreeTabSeparatorActive",
            },

            default_component_configs = {
                container = {
                    enable_character_fade = true,
                    width = "100%",
                    right_padding = 0,
                },
                indent = {
                    indent_size = 2,
                    padding = 1, -- extra padding on left hand side
                    -- indent guides
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },

                icon = {
                    -- folder_closed = "",
                    -- folder_open = "",
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "ﰊ",
                    default = "·",
                    highlight = "NeoTreeFileIcon"
                },
                modified = {
                    symbol = "[+] ",
                    highlight = "NeoTreeModified",
                    },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                },

                git_status = {
                    symbols = {
                        -- Change type
                        added     = "✚",
                        deleted   = "✖",
                        modified  = "",
                        renamed   = "",
                        -- Status type
                        untracked = "",
                        ignored   = "",
                        unstaged  = "",
                        staged    = "",
                        conflict  = "",
                    },
                    align = "right",
                },
            },

            window = {
                position = "left",
                width = 40,
                mappings = {
                    ["<2-LeftMouse>"] = "open",
                    ["<cr>"] = "open",
                    ["S"] = "open_split",
                    ["s"] = "open_vsplit",
                    ["C"] = "close_node",
                    ["<bs>"] = "navigate_up",
                    ["."] = "set_root",
                    ["H"] = "toggle_hidden",
                    ["R"] = "refresh",
                    ["/"] = "fuzzy_finder",
                    ["f"] = "filter_on_submit",
                    ["<c-x>"] = "clear_filter",
                    ["a"] = "add",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy", -- takes text input for destination
                    ["m"] = "move", -- takes text input for destination
                    ["q"] = "close_window",
                    ["h"] = float,
                    ["l"] = dive,
                    ["<Left>"] = float,
                    ["<Right>"] = dive,
                }
            },

            nesting_rules = {
                ts = { 'js', 'js.map', 'd.ts' },
                scss = { 'css', 'min.css', 'css.map', 'min.css.map' },
            },

            filesystem = {
                follow_current_file = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
                hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree in whatever position is specified in window.position
                filtered_items = {
                    visible = true, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_by_name = {
                        ".DS_Store",
                        "thumbs.db"
                        --"node_modules"
                    },
                    never_show = { -- remains hidden even if visible is toggled to true
                    --".DS_Store",
                    --"thumbs.db"
                },
            },

            components = {

                icon = function(config, node)
                    local icon = config.default or ' '
                    local padding = config.padding or ' '
                    local highlight = config.highlight or highlights.FILE_ICON
                    local web_devicons = require 'nvim-web-devicons'
                    if node.type == 'directory' then
                        highlight = highlights.DIRECTORY_ICON
                        if node.name == 'node_modules' or node.name == '.git' or node.name == '.github' then
                            local _icon, _highlight = web_devicons.get_icon(node.name)
                            icon = _icon or icon
                            highlight = _highlight or highlight
                        elseif node:is_expanded() then
                            icon = config.folder_open or '-'
                        else
                            icon = config.folder_closed or '+'
                        end
                    elseif node.type == 'file' then
                        ---@type string
                        local name = node.name
                        local ext = node.ext
                        if ext == 'json' and name:match[[^tsconfig]] then name = 'tsconfig.json' end
                        local _icon, _highlight = web_devicons.get_icon(name, ext)
                        icon = _icon or icon
                        highlight = _highlight or highlight
                    end
                    return {
                        text = icon .. padding,
                        highlight = highlight,
                    }
                end,

            },
        },

        buffers = {
            show_unloaded = true,
            window = {
                mappings = {
                    ["bd"] = "buffer_delete",
                }
            },
        },

        git_status = {
            window = {
                position = "float",
                mappings = {
                    ["A"]  = "git_add_all",
                    ["gu"] = "git_unstage_file",
                    ["ga"] = "git_add_file",
                    ["gr"] = "git_revert_file",
                    ["gc"] = "git_commit",
                    ["gp"] = "git_push",
                    ["gg"] = "git_commit_and_push",
                }
            }
        }
    }
end
}
