local gh = require("util").github_url

vim.pack.add({ gh("stevearc/conform.nvim") })

require("conform").setup({
  formatters_by_ft = _G.formatByFt,
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
