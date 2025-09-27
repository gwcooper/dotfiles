return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    float = { transparent = true },
    flavour = "macchiato",
    term_colors = true,
    transparent_background = true,
    integrations = {
      dap = true,
      dap_ui = true,
      fidget = true,
      gitsigns = true,
      grug_far = true,
      lsp_trouble = true,
      markview = true,
      mason = true,
      mini = {
        enabled = true,
        indentscope_color = "", -- catppuccin color (eg. `lavender`) Default: text
      },
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
      neotest = true,
      noice = true,
      notify = true,
      snacks = {
        enabled = true,
        indent_scope_color = "lavender", -- catppuccin color (eg. `lavender`) Default: text
      },
      treesitter = true,
      treesitter_context = true,
      which_key = false,
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
