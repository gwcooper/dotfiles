-- local function lsp_keymaps(bufnr)
--   local opts = { noremap = true, silent = true }
--   local keymap = vim.api.nvim_buf_set_keymap
--   keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
--   keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
--   keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
--   keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--   keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--   keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
-- end
--
return {
  on_attach = function(client, bufnr)
    -- lsp_keymaps(bufnr)
    -- require("lsp_signature").on_attach({
    --   bind = true, -- This is mandatory, otherwise border config won't get registered.
    --   handler_opts = {
    --     border = "rounded",
    --   },
    -- }, bufnr)
    --
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false

    --   if client.supports_method("textDocument/inlayHint") then
    --     vim.lsp.inlay_hint.enable(bufnr, true)
    --   end
  end,
  init_options = {
    settings = {
      args = { "--select", "ALL", "--ignore", "D100", "--ignore", "ANN" },
    },
  },
}
