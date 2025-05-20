return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  event = { "BufEnter" },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      indent = {
        enable = false,
        disable = {},
      },
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
      },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "json",
        "latex",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "ron",
        "rust",
        "toml",
        "typst",
        "vim",
        "vimdoc",
        "wgsl",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    })
  end,
}
