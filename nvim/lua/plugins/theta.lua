  return{
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local theme = require("alpha.themes.theta")
      local dashboard = require("alpha.themes.dashboard")

      -- Set header
      local header = {
        type = "text",
        val = {
          [[                                                     ]],
          [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
          [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
          [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
          [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
          [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
          [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
          [[                                                     ]],
        },
        opts = {
          position = "center",
          hl = "Type",
        },
      }
      local buttons = {
        type = "group",
        val = {
          { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
          { type = "padding", val = 1 },
          dashboard.button("e", "  New file", "<cmd>ene<CR>"),
          dashboard.button("SPC s f f", "  Find file"),
          dashboard.button("SPC s g g", "  Live grep"),
          dashboard.button("U", "  Update plugins", "<cmd>Lazy sync<CR>"),
          dashboard.button("q", "  Quit", "<cmd>qa<CR>"),
        },
        position = "center",
      }
      theme.header.val = header.val
      theme.header.opts = header.opts
      theme.buttons.val = buttons.val
      alpha.setup(theme.config)
      vim.cmd([[
            autocmd FileType alpha setlocal nofoldenable
        ]])
    end,
  }
