local present, toggleterm = pcall(require, "toggleterm")

if not present then
    return
end

local options = {

    -- size = function(term)
    --     if term.direction == "horizontal" then
    --         return 15
    --     elseif term.direction == "vertical" then
    --         return vim.o.columns * 0.3
    --     end
    -- end,

    shade_terminals = false,
    shading_factor = 1,
    start_in_insert = true,

}

require "toggleterm".setup(options)
