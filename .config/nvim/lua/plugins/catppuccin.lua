return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "macchiato",
    term_colors = true,
    transparent_background = true,
    integrations = {
      blink_cmp = true,
      gitsigns = true,
      treesitter = true,
      treesitter_context = true,
      telescope = true,
      mason = true,
      navic = { enabled = true, custom_bg = "NONE" },
      nvim_surround = true,
      neogit = true,
      neotest = true,
      noice = true,
      notify = true,
      -- which_key = true,
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
      ufo = true,
      lsp_trouble = true,
    },
    styles = {
      keywords = { "italic" },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
