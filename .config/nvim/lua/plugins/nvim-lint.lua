return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  opts = {
    linters_by_ft = {
      lua = { "luacheck" },
      markdown = { "write_good", "markdownlint" },
    },
  },
  config = function(_, opts)
    local lint = require("lint")
    lint.linters_by_ft = opts.linters_by_ft
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    lint.linters.luacheck.args = vim.list_extend(vim.deepcopy(lint.linters.luacheck.args), {
      "--globals=vim",
    })

    vim.api.nvim_create_autocmd({ "bufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
    vim.keymap.set("n", "<leader>ll", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
