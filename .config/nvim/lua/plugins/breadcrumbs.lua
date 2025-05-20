return {
  "Lunarvim/breadcrumbs.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  config = function()
    -- local icons = require("mini.icons")
    require("nvim-navic").setup({
      enabled = true,
      -- icons = icons.kind,
      highlight = true,
      lsp = {
        auto_attach = true,
      },
      click = true,
      separator = " " .. "" .. " ",
      depth_limit = 0,
      depth_limit_indicator = "..",
      safe_output = true,
    })
    require("breadcrumbs").setup()
  end,
}

-- icons = {
--        File          = "󰈙 ",
--        Module        = " ",
--        Namespace     = "󰌗 ",
--        Package       = " ",
--        Class         = "󰌗 ",
--        Method        = "󰆧 ",
--        Property      = " ",
--        Field         = " ",
--        Constructor   = " ",
--        Enum          = "󰕘",
--        Interface     = "󰕘",
--        Function      = "󰊕 ",
--        Variable      = "󰆧 ",
--        Constant      = "󰏿 ",
--        String        = "󰀬 ",
--        Number        = "󰎠 ",
--        Boolean       = "◩ ",
--        Array         = "󰅪 ",
--        Object        = "󰅩 ",
--        Key           = "󰌋 ",
--        Null          = "󰟢 ",
--        EnumMember    = " ",
--        Struct        = "󰌗 ",
--        Event         = " ",
--        Operator      = "󰆕 ",
--        TypeParameter = "󰊄 ",
