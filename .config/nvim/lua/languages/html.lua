local setup = require("util").setup_language

vim.pack.add({
  "https://forge.barrettruth.com/barrettruth/live-server.nvim",
})

setup({
  filetypes = { "html" },
  linters = { "htmlhint" },
  servers = { "html-lsp", "emmet-language-server" },
  treesitters = { "html", "html_tags" },
})
