local gh = require("util").github_url
local setup = require("util").setup_language

vim.pack.add({
  gh("nvim-neotest/neotest-jest"),
})

setup({
  filetypes = { "javascript" },
  treesitters = { "javascript", "ecma", "jsx" },
  debuggers = { "js-debug-adapter" },
})

_G.testAdapterList["neotest-jest"] = { jestCommand = "npm test --" }
