return {
  "rmagatti/goto-preview",
  config = function()
    require("goto-preview").setup({})
  end,
  keys = {
    {
      "<leader>gd",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      desc = "Preview definition",
    },

    {
      "<leader>gt",
      "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
      desc = "Preview type definition",
    },
    {
      "<leader>gi",
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      desc = "Preview implementation",
    },
    {
      "<leader>gD",
      "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
      desc = "Preview declaration",
    },
    {
      "<leader>gr",
      "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
      desc = "Preview references",
    },
    {
      "<leader>gP",
      "<cmd>lua require('goto-preview').close_all_win()<CR>",
      desc = "Close all preview windows",
    },
  },
}
