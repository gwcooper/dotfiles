return {
  {
    "folke/zen-mode.nvim",
  },
  opts = {
    plugins = {
      options = {
        ruler = false,
        showcmd = false,
        laststatus = 0,
      },
      wezterm = {
        enabled = true,
        -- can be either an absolute font size or the number of incremental steps
        font = "+2", -- (10% increase per step)
      },
    },
  },
  { "folke/twilight.nvim", opts = {} },
}
