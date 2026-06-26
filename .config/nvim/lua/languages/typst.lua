local gh = require("util").github_url
local setup = require("util").setup_language

vim.pack.add({ gh("chomosuke/typst-preview.nvim") })

setup({
  filetypes = { "typst" },
  treesitters = { "typst" },
  servers = { "tinymist" },
})
