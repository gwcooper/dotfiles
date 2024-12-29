return {
  "gaoDean/autolist.nvim",
  ft = {
    "markdown",
    "text",
    "tex",
    "typst",
    "plaintex",
    "norg",
  },
  config = function()
    local typst_patterns = {
      bullets = "-",
      numbers = "+",
    }
    require("autolist").setup({
      lists = {
        typst = {
          typst_patterns.bullets,
          typst_patterns.numbers,
        },
      },
    })

    vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
    vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
    vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
    -- vim.keymap.set("i", "<CR>", function()
    --   -- run autolist-new_bullet after the <cr> of nvim-autopairs <cr>
    --   local timeoutms = 10
    --   vim.loop.new_timer():start(
    --     timeoutms,
    --     0,
    --     vim.schedule_wrap(function()
    --       require("autolist").new_bullet()
    --     end)
    --   )
    --   return require("nvim-autopairs").autopairs_cr()
    -- end, { expr = true, noremap = true })
    vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
    vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
    vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
    vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

    -- cycle list types with dot-repeat
    vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
    vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

    -- functions to recalculate list on edit
    vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
    vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
    vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
    vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
  end,
}