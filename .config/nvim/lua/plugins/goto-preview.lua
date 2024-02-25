return {
  "rmagatti/goto-preview",
  config = function()
    require("goto-preview").setup({})
  end,
  keys = {
    {
      "<leader>gpd",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      desc = "Preview definition",
    },

    {
      "<leader>gpt",
      "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
      desc = "Preview type definition",
    },
    {
      "<leader>gpi",
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      desc = "Preview implementation",
    },
    {
      "<leader>gpD",
      "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
      desc = "Preview declaration",
    },
    {
      "<leader>gpr",
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
