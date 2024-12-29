local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/lazydev.nvim",
    },
    {
      "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
      },
    },
  },
}

local function lsp_keymaps(bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  -- map("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration")
  -- map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition")
  -- map("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover")
  -- map("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation")
  -- map("gr", "<cmd>lua vim.lsp.buf.references()<CR>", "References")
  -- map("gl", "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic: open float")
  map("gD", vim.lsp.buf.declaration, "Declaration")
  map("gd", vim.lsp.buf.definition, "Definition")
  map("K", vim.lsp.buf.hover, "Hover")
  map("gI", vim.lsp.buf.implementation, "Implementation")
  map("gr", vim.lsp.buf.references, "References")
  map("gl", vim.diagnostic.open_float, "Diagnostic: open float")
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  require("lsp_signature").on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded",
    },
  }, bufnr)

  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    vim.keymap.set("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Inlay [H]ints" })
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

function M.config()
  local wk = require("which-key")
  wk.add({
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
    { "<leader>lc", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
  })

  local lspconfig = require("lspconfig")

  local servers = require("lsp_settings.servers")

  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "󰌶" },
        { name = "DiagnosticSignInfo", text = "" },
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
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

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
  require("lspconfig.ui.windows").default_options.border = "rounded"

  for _, server in pairs(servers) do
    local opts = {
      inlay_hints = { enabled = true },
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local require_ok, settings = pcall(require, "lsp_settings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if server == "lua_ls" then
      require("lazydev").setup({})
    end

    -- conflicts with rustaceavim
    if server ~= "rust_analyzer" then
      lspconfig[server].setup(opts)
    end
  end
end

return M
