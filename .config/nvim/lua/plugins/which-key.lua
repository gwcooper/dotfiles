return {
  "folke/which-key.nvim",
  dependencies = {
    { "echasnovski/mini.icons", version = false },
  },
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    defaults = {
      -- { "]", group = "next" },
      -- { "[", group = "prev" },
      -- { "g", group = "goto" },
      -- { mode = { "n" }, "<leader>b", group = "pencil"}, 
      -- { "<leader>d", group = "debug" },
      -- { "<leader>g", group = "preview"}, 
      -- { "<leader>l", group = "code" },
      -- { "<leader>f", group = "file/find" },
      -- { "<leader>s", group = "search" },
      -- { "<leader>t", group = "toggle" },
      -- { "<leader>x", group = "diagnostics/quickfix" },
      -- { "<leader>n", group = "neotest" },
      -- { "<leader>u", group = "undo"},
      -- { "<leader>v", group = "virtualenvs", icon = "󰌠" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add(opts.defaults)
  end,
}
