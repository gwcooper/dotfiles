return {
  {
    "stevearc/oil.nvim",
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    opts = {
      float = {
        max_height = 20,
        max_width = 100,
      },
    },
    keys = {
      { "-", "<CMD>Oil --float<CR>", desc = "Open parent directory" },
    },
  },
}
