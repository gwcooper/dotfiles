local gh = require("util").github_url
local set = vim.keymap.set

vim.pack.add({ gh("MagicDuck/grug-far.nvim") })
require("mini.pick").setup()
require("mini.extra").setup()

-- Search and pickers --
set("n", "<leader>/", "<CMD>Pick grep_live<cr>", { desc = "Project-wide grep" })
set("n", "<leader>,", "<CMD>Pick buffers<cr>", { desc = "Pick buffers" })
set("n", "<leader>:", "<CMD>Pick history<cr>", { desc = "Pick history" })
set("n", "<leader>ph", "<CMD>Pick help<cr>", { desc = "Pick help" })
set("n", "<leader>f", "<CMD>Pick files<cr>", { desc = "Pick files" })
set("n", "<leader>pc", "<CMD>Pick commands<cr>", { desc = "Pick commands" })
set("n", "<leader>pk", "<CMD>Pick keymaps<cr>", { desc = "Pick commands" })
set("n", "<leader>pm", "<CMD>Pick marks<cr>", { desc = "Pick marks" })
set("n", "<leader>pr", "<CMD>Pick resume<cr>", { desc = "Pick resume" })

-- Search and replace --
set({ "n", "v" }, "<leader>sr", function()
  local grug = require("grug-far")
  local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
  grug.open({
    transient = true,
    prefills = {
      filesFilter = ext and ext ~= "" and "*." .. ext or nil,
    },
  })
end, { desc = "Search and Replace" })
