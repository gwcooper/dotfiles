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
        require("rustaceanvim.neotest"),
      },
    })
  end,
  keys = {
    -- { "<leader>n", group = "Neotest" },
    { "<leader>nt", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>", desc = "test" },
    { "<leader>ns", ":lua require'neotest'.run.stop()<cr>", desc = "stop test" },
    { "<leader>na", ":lua require'neotest'.run.attach()<cr>", desc = "attach test" },
    { "<leader>nf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "test file" },
    { "<leader>ns", ":lua require'neotest'.summary.toggle()<cr>", desc = "test summary" },
    { "<leader>np", ":lua require'neotest'.run.run({suite = true})<cr>", desc = "run all tests" },
  },
}
