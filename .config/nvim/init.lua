-------------------------------------------------------------------------------
                           -- Startup Performance --
-------------------------------------------------------------------------------

vim.defer_fn(function()
    pcall(require, "impatient")
end, 0)

-------------------------------------------------------------------------------
                            -- Gloabl Performance --
-------------------------------------------------------------------------------

require "core.options"
require "core.autocmd"

-------------------------------------------------------------------------------
                       -- Setup Packer Install Plugins --
-------------------------------------------------------------------------------

local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#23272E" })
    print "Cloning Packer ..."
    fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }
    -- fn.system { "git", "clone", "--depth", "1", "https://hub.fastgit.xyz/wbthomason/packer.nvim", install_path }
    vim.cmd "packadd packer.nvim"

    vim.cmd "set laststatus=0"
    vim.cmd "set cmdheight=0"
    vim.cmd "set showtabline=0"
    vim.cmd "set colorcolumn=0"
    vim.cmd "set nonumber"
    vim.cmd "set nocursorline"
    vim.cmd "hi NonText guifg=#282C34"

    require "plugins"
    vim.cmd "PackerSync"
end

-------------------------------------------------------------------------------
                            -- Import Key Mapping --
-------------------------------------------------------------------------------

require "core.keymaps"

-------------------------------------------------------------------------------
                           -- Import Autocommands --
-------------------------------------------------------------------------------

require "core.autocmd"

-------------------------------------------------------------------------------
                               -- LSP Install  --
-------------------------------------------------------------------------------

-- require "plugins.configs.lsp.install"
