local gh = require("util").github_url
local setup = require("util").setup_language

vim.pack.add({
  gh("brianhuster/live-preview.nvim"),
})

setup({
  filetypes = { "markdown" },
  treesitters = { "markdown", "markdown_inline" },
  servers = { "marksman" },
  linters = { "rumdl" },
  formatters = { "rumdl" },
})
