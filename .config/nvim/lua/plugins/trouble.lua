return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    -- { "<leader>x", group = "Trouble" },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "Diagnostics",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>ls",
      "<cmd>Trouble symbols toggle focus=true<cr>",
      desc = "Symbols",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List",
    },
  },
}
