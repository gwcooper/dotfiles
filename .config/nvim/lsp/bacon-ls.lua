return {
  cmd = { "bacon-ls" },
  filetypes = { "rust" },
  root_markers = { ".bacon-locations", "Cargo.toml" },
  enabled = true,
  init_options = {
    updateOnSave = true,
    updateOnSaveWaitMillis = 1000,
    updateOnChange = false,
  },
}
