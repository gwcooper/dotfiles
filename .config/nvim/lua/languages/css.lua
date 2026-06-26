local setup = require("util").setup_language

setup({
  filetypes = { "css" },
  servers = { "css-lsp", "emmet-language-server" },
  treesitters = { "css" },
})
