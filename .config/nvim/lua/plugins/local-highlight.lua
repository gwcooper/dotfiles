return {
  "tzachar/local-highlight.nvim",
  config = function()
    require("local-highlight").setup({ file_types = { "python", "lua" } })
  end,
}
