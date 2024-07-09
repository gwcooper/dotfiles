return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    plugins = { spelling = true },
    defaults = {
      ["]"] = { name = "+next" },
      ["["] = { name = "+prev" },
      ["g"] = { name = "+goto" },
      ["<leader>g"] = { name = "+preview" },
      ["<leader>l"] = { name = "+code" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
      ["<leader>n"] = { name = "+neotest" },
      ["<leader>u"] = { name = "+undo" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
