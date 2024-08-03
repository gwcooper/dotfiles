return {
  "mrcjkb/rustaceanvim",
  version = "^5", -- Recommended
  ft = { "rust" },
  config = function()
    local opts = {
      hover_actions = {
        border = {
          { "🭽", "FloatBorder" },
          { "▔", "FloatBorder" },
          { "🭾", "FloatBorder" },
          { "▕", "FloatBorder" },
          { "🭿", "FloatBorder" },
          { "▁", "FloatBorder" },
          { "🭼", "FloatBorder" },
          { "▏", "FloatBorder" },
        },
      },
    }
    vim.g.rustaceanvim = function()
      return opts
    end
  end,
}
