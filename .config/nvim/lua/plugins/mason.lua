return {
  "mason-org/mason.nvim",
  config = function()
    require("mason").setup()
    local servers = {
      -- lua
      "lua-language-server",
      -- markdown
      "marksman",
      -- python
      "basedpyright",
      "ruff",
      -- rust
      "bacon-ls",
    }
    local linters = {
      -- lua
      "luacheck",
      -- markdown
      "write-good",
      "markdownlint",
      -- rust
      "bacon",
    }
    local formatters = {
      -- lua
      "stylua",
      -- general
      "codespell",
    }
    local debuggers = {
      --python
      "debugpy",
      --rust and others
      "codelldb",
    }

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

    local ensure_installed = merge(servers, linters, formatters, debuggers)

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
    end, {})
  end,
}
