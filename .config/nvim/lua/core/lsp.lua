local function lsp_keymaps(bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  map("gD", vim.lsp.buf.declaration, "Declaration")
  map("gd", vim.lsp.buf.definition, "Definition")
  map("K", vim.lsp.buf.hover, "Hover")
  map("gI", vim.lsp.buf.implementation, "Implementation")
  map("gr", vim.lsp.buf.references, "References")
  map("gl", vim.diagnostic.open_float, "Diagnostic: open float")
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    --TODO: .buf might need to be .bufnr?
    lsp_keymaps(args.buf)
    require("lsp_signature").on_attach({
      bind = true,
      handler_opts = { border = "rounded" },
    }, args.buf) --TODO: The border arg may be irrelevant now

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      vim.notify("No lsp client found, aborting", vim.log.levels.ERROR)
      return
    end

    if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "Inlay [H]ints" })
    end

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, args.buf)
    end
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities({}, false))
-- TODO: integrate blink

capabilities = vim.tbl_deep_extend("force", capabilities, {
  -- snippet completion
  textDocument = { completion = { completionItem = { snippetSupport = true } } },
  -- ufo folds
  foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  },
})

-- Default configuration, applies to all LSPs
vim.lsp.config("*", {
  inlay_hints = { enabled = true },
  capabilities = capabilities,
})

-- Enable all LSPs
local configs = {}

for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  local name = vim.fn.fnamemodify(v, ":t:r")
  configs[name] = true
end

vim.lsp.enable(vim.tbl_keys(configs))
