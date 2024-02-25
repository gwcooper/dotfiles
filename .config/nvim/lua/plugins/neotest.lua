return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-python",
    -- "nvim-neotest/neotest-plenary",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python")({
          dap = { JustMyCode = false },
          }),
        require("neotest-plenary"),
        require("neotest-vim-test")({
          ignore_file_types = { "python", "vim", "lua" },
        }),
      },
    })
  end,
  keys = {
    { "<leader>dtt", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>", desc = "test" },
    { "<leader>dts", ":lua require'neotest'.run.stop()<cr>",                  desc = "stop test" },
    { "<leader>dta", ":lua require'neotest'.run.attach()<cr>",                desc = "attach test" },
    { "<leader>dtf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", desc = "test file" },
    { "<leader>dts", ":lua require'neotest'.summary.toggle()<cr>",            desc = "test summary" },
  },
}
