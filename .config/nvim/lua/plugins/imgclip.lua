return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  ft = {"markdown", "md", "typst", "typ", "rtf" },
  keys = {
    { "<leader>P", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
