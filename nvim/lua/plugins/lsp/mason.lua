--   ╭──────────────────────────────────────────────────────────────────────╮
--   │                                                                      │
--   │                                Mason                                 │
--   │                                                                      │
--   │              https://github.com/williamboman/mason.nvim              │
--   │                                                                      │
--   ╰──────────────────────────────────────────────────────────────────────╯

return {

	"williamboman/mason.nvim",
	cmd = "Mason",
	keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	opts = {
		ensure_installed = {
			"shfmt",
			"stylua",
			"flake8",
			"lua-language-server",
			"bash-language-server",
			"vim-language-server",
			"pyright",
			"djlint",
			"json-lsp",
		},
		github = {
			download_url_template = os.getenv("GITHUB") .. "%s/releases/download/%s/%s",
		},
		pip = {
			upgrade_pip = false,
			install_args = {
				"--index-url",
				"https://pypi.tuna.tsinghua.edu.cn/simple",
				"--trusted-host",
				"pypi.tuna.tsinghua.edu.cn",
			},
		},
	},

	config = function(_, opts)
		require("mason").setup(opts)
		local mr = require("mason-registry")
		local function ensure_installed()
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end
		if mr.refresh then
			mr.refresh(ensure_installed)
		else
			ensure_installed()
		end
	end,
}
