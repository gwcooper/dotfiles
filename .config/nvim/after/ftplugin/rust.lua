local bufno = vim.api.nvim_get_current_buf()

-- override mini.pairs for ' for rust files
vim.keymap.set("i", "'", "'", { buffer = bufno })

local function dot_repeat(
  callback --[[Function]]
)
  return function()
    _G.dot_repeat_callback = callback
    vim.go.operatorfunc = "v:lua.dot_repeat_callback"
    return "g@l"
  end
end

local function lsp_keymaps(bufnr)
  local map = function(keys, func, desc, opts)
    local options = { buffer = bufnr, desc = "LSP: " .. desc }
    if opts then
      options = vim.tbl_deep_extend("force", options, opts)
    end
    vim.keymap.set("n", keys, func, options)
  end

  map("gD", vim.lsp.buf.declaration, "Declaration")
  map("gd", vim.lsp.buf.definition, "Definition")
  map("K", function()
    vim.cmd.RustLsp({ "hover", "actions" })
  end, "Hover")
  map("gI", vim.lsp.buf.implementation, "Implementation")
  map("gr", vim.lsp.buf.references, "References")
  map("gl", vim.diagnostic.open_float, "Diagnostic: open float")
  map("<leader>la", function()
    vim.cmd.RustLsp("codeAction")
  end, "Code Action")
  map("<leader>ld", function()
    vim.cmd.RustLsp("openDocs")
  end, "Open docs")

  -- More comprehensive error / diagnostics
  map("<leader>lx", function()
    vim.cmd.RustLsp({ "explainError" })
  end, "Explain error")
  map("<leader>le", function()
    vim.cmd.RustLsp({ "renderDiagnostic" })
  end, "Render diagnostics")
  map(
    "<leader>mu",
    dot_repeat(function()
      vim.cmd.RustLsp({ "moveItem", "up" })
    end),
    "Move code up",
    { expr = true }
  )
  map(
    "<leader>md",
    dot_repeat(function()
      vim.cmd.RustLsp({ "moveItem", "down" })
    end),
    "Move code down",
    { expr = true }
  )
end

lsp_keymaps(bufno)
