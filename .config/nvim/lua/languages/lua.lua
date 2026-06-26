local gh = require("util").github_url
local setup = require("util").setup_language

vim.pack.add({ gh("folke/lazydev.nvim"), gh("nvim-neotest/neotest-plenary") })

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

setup({
  filetypes = { "lua" },
  treesitters = {
    "lua",
    "luadoc",
  },
  formatters = { "stylua" },
  linters = { "luacheck" },
  servers = { "lua-language-server" },
  completion_providers = {
    lazydev = {
      name = "LazyDev",
      module = "lazydev.integrations.blink",
      -- make lazydev completions top priority (see `:h blink.cmp`)
      score_offset = 100,
    },
  },
  completion_sources = { "lazydev", inherit_defaults = true },
})

_G.testAdapterList["neotest-plenary"] = {}
