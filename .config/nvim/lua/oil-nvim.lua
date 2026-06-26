local gh = require("util").github_url

vim.pack.add({
  gh("stevearc/oil.nvim"),
  gh("refractalize/oil-git-status.nvim"),
})

require("oil").setup({
  win_options = { signcolumn = "yes:2" },
  float = { max_height = 20, max_width = 100 },
})

require("oil-git-status").setup({
  show_ignored = true, -- show files that match gitignore with !!
  symbols = { -- customize the symbols that appear in the git status columns
    index = {
      ["!"] = "!",
      ["?"] = "?",
      ["A"] = "A",
      ["C"] = "C",
      ["D"] = "D",
      ["M"] = "M",
      ["R"] = "R",
      ["T"] = "T",
      ["U"] = "U",
      [" "] = " ",
    },
    working_tree = {
      ["!"] = "!",
      ["?"] = "?",
      ["A"] = "A",
      ["C"] = "C",
      ["D"] = "D",
      ["M"] = "M",
      ["R"] = "R",
      ["T"] = "T",
      ["U"] = "U",
      [" "] = " ",
    },
  },
})
