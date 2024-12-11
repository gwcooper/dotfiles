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
          { "<leader>h", group = "hunks", icon = ""},
          {
            "<leader>hb",
            function()
              gitsigns.blame_line({ full = true })
            end,
            desc = "Blame line",
          },
          { "<leader>hd", gitsigns.diffthis, desc = "Diff this" },
          { "<leader>hr", gitsigns.reset_hunk, desc = "Reset hunk" },
          { "<leader>hR", gitsigns.reset_buffer, desc = "Reset buffer" },
          { "<leader>hs", gitsigns.stage_hunk, desc = "Stage hunk" },
          { "<leader>hS", gitsigns.stage_buffer, desc = "Stage buffer" },
          { "<leader>hp", gitsigns.preview_hunk, desc = "Preview hunk" },
          { "<leader>hu", gitsigns.undo_stage_hunk, desc = "Undo stage hunk" },
          { "<leader>t", group = "toggle" },
          { "<leader>tb", gitsigns.toggle_current_line_blame, desc = "Current line blame" },
          { "<leader>td", gitsigns.toggle_deleted, desc = "deleted" },
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
