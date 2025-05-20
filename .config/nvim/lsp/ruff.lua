return {
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
  settings = {},
  on_attach = function(client, bufnr)
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end,
  init_options = {
    settings = {
      args = { "--select", "ALL", "--ignore", "D100", "--ignore", "D103", "--ignore", "ANN" },
    },
  },
}
