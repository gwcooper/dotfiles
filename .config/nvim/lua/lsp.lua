local gh = require("util").github_url

vim.pack.add({
  gh("j-hui/fidget.nvim"),
})

-- lsp stdout prints to bottom right of window
require("fidget").setup({
  notification = {
    window = {
      winblend = 0,
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      vim.notify("No LSP client found, aborting", vim.log.levels.ERROR)
      return
    end

    if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "[T]oggle Inlay [H]ints" })
    end
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend("force", capabilities, {
  -- snippet completion
  textDocument = { completion = { completionItem = { snippetSupport = true } } },
})

-- default config applied to all LSPs
vim.lsp.config("*", {
  inlay_hints = { enabled = true },
  capabilities = capabilities,
})

-- Set non-default global key mappings
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })

-- Enable all LSPs
local configs = {}

for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  local name = vim.fn.fnamemodify(v, ":t:r")
  configs[name] = true
end

vim.lsp.enable(vim.tbl_keys(configs))
