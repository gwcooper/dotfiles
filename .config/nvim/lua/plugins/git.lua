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
        wk.register({
          h = {
            name = "+hunks",
            b = {
              function()
                gitsigns.blame_line({ full = true })
              end,
              "Blame line",
            },
            d = { gitsigns.diffthis, "Diff this" },
            r = { gitsigns.reset_hunk, "Reset hunk" },
            R = { gitsigns.reset_buffer, "Reset buffer" },
            s = { gitsigns.stage_hunk, "Stage hunk" },
            S = { gitsigns.stage_buffer, "Stage buffer" },
            p = { gitsigns.preview_hunk, "Preview hunk" },
            u = { gitsigns.undo_stage_hunk, "Undo stage hunk" },
          },
          t = {
            name = "+toggle",
            b = { gitsigns.toggle_current_line_blame, "Current line blame" },
            d = { gitsigns.toggle_deleted, "deleted" },
          },
        }, { prefix = "<leader>" })
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
