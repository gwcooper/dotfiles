local gh = require("util").github_url

vim.pack.add({
  gh("antoinemadec/FixCursorHold.nvim"),
  gh("nvim-neotest/neotest"),
  gh("nvim-neotest/nvim-nio"),
})

local adapter_dict = {}

for adapter, config in pairs(_G.testAdapterList) do
  if type(config) == table then
    table.insert(adapter_dict, require(adapter)(config))
  else
    table.insert(adapter_dict, require(adapter))
  end
end

require("neotest").setup({
  adapters = adapter_dict,
})

local set = vim.keymap.set

set("n", "nt", ":lua require'neotest'.run.run()<cr>)", { desc = "Run nearest test" })
set("n", "ndt", ":lua require'neotest'.run.run({strategy = 'dap'})<cr>)", { desc = "Debug test" })
set("n", "ne", ":lua require'neotest'.run.stop()<cr>", { desc = "Stop test" })
set("n", "na", ":lua require'neotest'.run.attach()<cr>", { desc = "Attach test" })
set("n", "nf", ":lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", { desc = "Test File" })
set("n", "ns", ":lua require'neotest'.summary.toggle()<cr>", { desc = "Toggle test summary" })
set("n", "np", ":lua require'neotest'.run.run({suite = true})<cr>", { desc = "Run all tests in Project" })
