-- Setup installer & lsp configs
local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_ok, mason_lsp = pcall(require, 'mason-lspconfig')

if not mason_ok or not mason_lsp_ok then
    return
end

-------------------------------------------------------------------------------
-- Mason --
-------------------------------------------------------------------------------

mason.setup {

    ui = {

        check_outdated_packages_on_open = true,
        border = "none",

        icons = {
            package_installed = "✓ ",
            package_pending = "➜ ",
            package_uninstalled = "✗ "
        },

        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
            cancel_installation = "<C-c>",
        },
    },

    max_concurrent_installers = 10,

    -- github = {
    --    download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
    -- },
}

-------------------------------------------------------------------------------
-- Mason Lsp Config --
-------------------------------------------------------------------------------

mason_lsp.setup {

    ensure_installed = {
        "sumneko_lua",
        "bashls",
        "pyright",
        "rome",
        "djlint",
        "json-lsp",
    },

    automatic_installation = false,
}

-------------------------------------------------------------------------------
-- Nvim Lsp Config --
-------------------------------------------------------------------------------

local present, lspconfig = pcall(require, "lspconfig")

if not present then
    return
end

local M = {}

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
    if vim.g.vim_version > 7 then
        -- nightly
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    else
        -- stable
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end

end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

lspconfig.sumneko_lua.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = require('plugins.configs.lsp.config.sumneko_lua').settings
}

lspconfig.pyright.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = require('plugins.configs.lsp.config.pyright').settings
}

lspconfig.bashls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    settings = require('plugins.configs.lsp.config.bashls').settings
}

-- lspconfig.marksman.setup {
--     on_attach = M.on_attach,
--     capabilities = M.capabilities,
-- 			settings = {
-- 				filetypes = { "markdown", "vimwiki" },
-- 			},
-- }

-- require'lspconfig'.marksman.setup{
-- 	filetypes = { "markdown", "vimwiki" },
-- }

-- require'lspconfig'.ltex.setup{
-- 	filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "vimwiki" },
-- }

-------------------------------------------------------------------------------
-- LSP UI
-------------------------------------------------------------------------------

local signs = { Error = "", Warn = "", Hint = "", Info = "" }

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })

    vim.diagnostic.config {
        virtual_text = {
            prefix = "",
        },
    signs = true,
    underline = true,
    update_in_insert = false,
    }

end

return M
