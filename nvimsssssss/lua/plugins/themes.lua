return {

    -- ONEDARK

    { 
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme onedark")
            require("onedarkpro").setup({
                options = {
                    transparency = false,
                    highlight_inactive_windows = true,
                }
            })        
        end,
    },

}
