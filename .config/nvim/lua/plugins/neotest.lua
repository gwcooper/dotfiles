return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { JustMyCode = false },
        }),
      },
    })
  end,
  keys = {
    { "<leader>dtt", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>", desc = "test" },
    { "<leader>dts", ":lua require'neotest'.run.stop()<cr>", desc = "stop test" },
    { "<leader>dta", ":lua require'neotest'.run.attach()<cr>", desc = "attach test" },
    { "<leader>dtf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "test file" },
    { "<leader>dts", ":lua require'neotest'.summary.toggle()<cr>", desc = "test summary" },
    { "<leader>dtp", ":lua require'neotest'.run.run({suite = true})<cr>", desc = "run all tests" },
  },
}
