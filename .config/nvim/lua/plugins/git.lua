return {
  { "APZelos/blamer.nvim" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "│" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end)

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end)

        -- Actions
        local wk = require("which-key")
        wk.add({
          -- { "<leader>g", group = "git", icon = "" },
          { "<leader>gd", gitsigns.diffthis, desc = "Diff this" },
          { "<leader>gr", gitsigns.reset_hunk, desc = "Reset hunk" },
          { "<leader>gR", gitsigns.reset_buffer, desc = "Reset buffer" },
          { "<leader>gs", gitsigns.stage_hunk, desc = "Stage/Unstage hunk" },
          { "<leader>gS", gitsigns.stage_buffer, desc = "Stage buffer" },
          { "<leader>gp", gitsigns.preview_hunk, desc = "Preview hunk" },
          { "<leader>tb", gitsigns.toggle_current_line_blame, desc = "Current Line Blame" },
          { "<leader>td", gitsigns.preview_hunk_inline, desc = "Deleted" },
        })
      end,
    },
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
