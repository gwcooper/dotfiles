local gh = require("util").github_url
local setup = require("util").setup_language

vim.pack.add({
  gh("nvim-neotest/neotest-python"),
  gh("mfussenegger/nvim-dap-python"),
  gh("tnfru/nvim-venv-detector"),
})

-- Disable scanning for pythons I'm not going to use
-- to speed up python file loading
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0

setup({
  filetypes = { "python" },
  debuggers = { "debugpy" },
  servers = { "basedpyright", "ruff" },
  treesitters = { "python" },
})

_G.testAdapterList["neotest-python"] = { dap = { justMyCode = false } }
