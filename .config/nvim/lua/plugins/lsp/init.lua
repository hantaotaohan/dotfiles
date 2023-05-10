vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guifg=#000000 guibg=#20242D]])
vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=#000000 guibg=#20242D]])

return {
	{ import = "plugins.lsp.lspconfig" },
	{ import = "plugins.lsp.null-ls" },
	{ import = "plugins.lsp.mason" },
}
