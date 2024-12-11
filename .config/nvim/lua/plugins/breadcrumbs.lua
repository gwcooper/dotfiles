local M = {
  "LunarVim/breadcrumbs.nvim",
  dependencies = { "SmiteshP/nvim-navic" },
}

function M.config()
  local icons = require("mini.icons")
  require("nvim-navic").setup({
    icons = icons.kind,
    highlight = true,
    lsp = {
      auto_attach = true,
    },
    click = true,
    separator = " " .. "" .. " ",
    depth_limit = 0,
    depth_limit_indicator = "..",
  })
  require("breadcrumbs").setup()
end

return M
