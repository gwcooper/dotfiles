require("venv_detector").setup()

require("beancount").setup({
  inlay_hints = true, -- inferred amounts
  snippets = {
    enabled = true,
    date_format = "%Y-%m-%d",
  },
})

vim.treesitter.start()
