local default_diagnostic_config = {
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "󰌶",
    },
  },
  -- virtual_text = {current_line = true},
  update_in_insert = false,
  underline = true,
  virtual_lines = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(default_diagnostic_config)

local wk = require("which-key")
wk.add({
  { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
  { "<leader>li", "<cmd>checkhealth vim.lsp<cr>", desc = "Info" },
  { "<leader>lj", "<cmd>lua vim.diagnostic.jump({count=1, float=true})<cr>", desc = "Next Diagnostic" },
  { "<leader>lk", "<cmd>lua vim.diagnostic.jump({count=-1, float=true})<cr>", desc = "Prev Diagnostic" },
  { "<leader>lc", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
  { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
  { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
})

vim.keymap.set("n", "<leader>lD", function()
  local new_line = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_line })
end, { desc = "Toggle diagnostic appearance" })
