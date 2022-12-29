local M = {}

M.settings = {
    Lua = {
        diagnostics = {
            globals = { "vim" },
        },
        workspace = {
            library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                [vim.fn.stdpath "config" .. "/lua"] = true,
            },
        },
        telemetry = {
            enable = false,
        },
    },
}

return M
