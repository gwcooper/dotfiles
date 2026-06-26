local add = vim.pack.add
local util = require("util")
local gh = require("util").github_url

-- Editor appearance and behaviours --
add({
  gh("chrisgrieser/nvim-origami"),
  gh("nvim-mini/mini.nvim"),
  gh("tzachar/local-highlight.nvim"),
  {
    src = gh("nvim-treesitter/nvim-treesitter"),
    version = "main",
    data = {
      run = function(_)
        vim.cmd("TSUpdate")
      end,
    },
  },
  gh("brenoprata10/nvim-highlight-colors"),
  gh("tpope/vim-sleuth"),
  gh("nvim-lua/plenary.nvim"),
  gh("folke/todo-comments.nvim"),
  gh("folke/trouble.nvim"),
})

require("local-highlight").setup({ animate = { enabled = false } })
require("mini.icons").setup()
-- require("mini.notify").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("nvim-highlight-colors").setup({})

require("nvim-treesitter").setup()
require("nvim-treesitter").install(util.create_table_from_set(_G.treeSitterInstallList))
-- Uninstall unused grammars
local installed_grammars = require("nvim-treesitter").get_installed()
local uninstall_list = {}
for _, grammar in ipairs(installed_grammars) do
  if not _G.treeSitterInstallList[grammar] then
    table.insert(uninstall_list, grammar)
  end
end

if next(uninstall_list) then
  local ok, choice = util.confirm_and_uninstall_popup(uninstall_list)
  if ok and choice == 1 then
    for _, item in ipairs(uninstall_list) do
      require("nvim-treesitter").uninstall(item)
    end
  end
end

-- Folding
vim.schedule(function()
  vim.opt.foldlevel = 99
  vim.opt.foldlevelstart = 99
  vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

  require("origami").setup({
    foldtext = {
      lineCount = {
        template = "󰘖%d", -- ↧
      },
    },
  })
end)

vim.cmd("packadd! nvim.undotree")
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nvim-undotree",
  callback = function()
    vim.cmd.wincmd("H")
    vim.api.nvim_win_set_width(0, 40)
  end,
})

-- Code --
add({
  gh("lewis6991/gitsigns.nvim"),
})

require("gitsigns").setup({
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
    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]h", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end)

    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[h", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end)

    map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
    map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
    map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage/Unstage hunk" })
    map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage/Unstage buffer" })
    map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "Toggle line current line blame" })
  end,
})

require("todo-comments").setup()
require("trouble").setup()

-- Writing
add({ gh("junegunn/goyo.vim") })
vim.keymap.set("n", "<leader>tg", "<CMD>Goyo<CR>", { desc = "Toggle Goyo writing mode" })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
