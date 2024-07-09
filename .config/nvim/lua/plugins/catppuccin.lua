return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    term_colors = true,
    transparent_background = true,
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    treesitter = true,
    harpoon = true,
    telescope = true,
    mason = true,
    noice = true,
    notify = true,
    which_key = true,
    fidget = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-macchiato")
  end,
}
