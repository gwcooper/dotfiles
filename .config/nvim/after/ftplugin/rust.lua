local bufno = vim.api.nvim_get_current_buf()

local function lsp_keymaps(bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  map("gD", vim.lsp.buf.declaration, "Declaration")
  map("gd", vim.lsp.buf.definition, "Definition")
  map("K", function()
    vim.cmd.RustLsp({ "hover", "actions" })
  end, "Hover")
  map("gI", vim.lsp.buf.implementation, "Implementation")
  map("gr", vim.lsp.buf.references, "References")
  map("gl", vim.diagnostic.open_float, "Diagnostic: open float")
  -- map("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration")
  -- map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition")
  -- map("K", "<cmd>lua vim.cmd.RustLsp({ 'hover', 'actions' })<CR>", "Hover")
  -- map("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation")
  -- map("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "References")
  -- map("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic: open float")
end

lsp_keymaps(bufno)
