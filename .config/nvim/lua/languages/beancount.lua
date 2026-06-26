local gh = require("util").github_url
local setup = require("util").setup_language

vim.pack.add({
  gh("hxueh/beancount.nvim"),
})

setup({
  filetypes = { "beancount" },
  treesitters = { "beancount" },
  completion_providers = {
    beancount = {
      name = "beancount",
      module = "beancount.completion.blink",
      score_offset = 100,
      opts = {
        trigger_characters = { ":", "#", "^", " " },
      },
    },
  },
  completion_sources = { inherit_defaults = true, "beancount" },
  servers = { "beancount-language-server" },
})
