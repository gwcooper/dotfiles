local icons = require("core.icons")
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
      { "]", group = "next" },
      { "[", group = "prev" },
      { "g", group = "goto" },
      { "<leader>d", group = "debug" },
      { "<leader>g", group = "preview", icon = icons.ui.FindFile },
      { "<leader>l", group = "code" },
      { "<leader>f", group = "file/find" },
      { "<leader>s", group = "search" },
      { "<leader>x", group = "diagnostics/quickfix" },
      { "<leader>n", group = "neotest" },
      { "<leader>u", group = "undo", icons.ui.ChevronShortLeft },
      { "<leader>v", group = "virtualenvs", icon = "󰌠" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.add(opts.defaults)
  end,
}
