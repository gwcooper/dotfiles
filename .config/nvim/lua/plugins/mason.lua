return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()

    local servers = require("lsp_settings.servers")
    local linters = {
      -- python
      "mypy",
      -- terraform
      "tflint",
      -- lua
      "luacheck",
      --markdown
      "write-good",
      "markdownlint",
    }

    local formatters = {
      -- python
      "ruff",
      -- lua
      "stylua",
      -- shell
      "shfmt",
      -- general
      "codespell",
    }

    local debuggers = {
      --python
      "debugpy",
    }

    -- install language servers
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    -- install everything else
    local function merge(...)
      local result = {}
      -- For each source table
      for _, t in ipairs({ ... }) do
        -- For each pair in t
        for _, v in pairs(t) do
          table.insert(result, v)
        end
      end
      return result
    end

    local ensure_installed = merge(linters, formatters, debuggers)

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
    end, {})
  end,
}
