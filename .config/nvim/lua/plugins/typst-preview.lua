return {
  "chomosuke/typst-preview.nvim",
  lazy = false,
  version = "0.3.*",
  build = function()
    require("typst-preview").update()
  end,
  keys = {
    { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", desc = "[T]ypist [P]review" },
  },

  -- { "kaarmu/typst.vim", ft = "typst", lazy = false },
  -- {
  --   "MrPicklePinosaur/typst-conceal.vim",
  --   ft = "typst",
  --   config = function()
  --     vim.g.typst_conceal_math = 1
  --     vim.g.typst_conceal_emoji = 1
  --   end,
  -- },
}
