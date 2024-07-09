local check_file_size = function()
  return vim.api.nvim_buf_line_count(0) > 100000
end

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
      highlight = {
        enable = true,
        use_languagetree = true,
        disable = check_file_size,
      },
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "json",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
      },
      -- incremental_selection = {
      -- 	enable = true,
      -- 	keymaps = {
      -- 		init_selection = "gnn",
      -- 		node_incremental = "grn",
      -- 		scope_incremental = "grc",
      -- 		node_decremental = "grm",
      -- },
      -- },
    })
  end,
}
