return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup()

    local ensure_installed = {
      -- python
      -- "black",
      "mypy",
      "ruff",
      "debugpy",
      --terraform
      "tflint",
      --lua
      "stylua",
      "luacheck",
      --shell
      "shfmt",
      --markdown
      "mdformat",
      "write-good",
      "markdownlint",
    }

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
    end, {})
  end,
}
