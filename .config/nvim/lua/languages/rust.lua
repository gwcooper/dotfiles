local gh = require("util").github_url
local setup = require("util").setup_language

vim.pack.add({
  gh("Saecki/crates.nvim"),
  {
    src = gh("mrcjkb/rustaceanvim"),
    version = vim.version.range("^9"),
  },
})

setup({
  filetypes = { "rust" },
  treesitters = { "rust", "ron" },
  debuggers = { "codelldb" },
  servers = { "bacon", "bacon-ls" },
})

_G.testAdapterList["rustaceanvim.neotest"] = {}

-- debug settings
local function dap_settings()
  local package_path = vim.fn.exepath("codelldb")
  local codelldb = package_path .. "/extension/adapter/codelldb"
  local library_path = package_path .. "/extension/lldb/lib/liblldb.dylib"
  local uname = io.popen("uname"):read("*l")
  if uname == "Linux" then
    library_path = package_path .. "/extension/lldb/lib/liblldb.so"
  end

  return require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path)
end

vim.g.rustaceanvim = {
  tools = { float_win_config = { border = "rounded" } },
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
        },
        -- leave up to bacon-ls
        checkOnSave = false,
        diagnostics = { enable = false },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
        files = {
          excludeDirs = {
            ".direnv",
            ".git",
            ".github",
            ".gitlab",
            "bin",
            "node_modules",
            "target",
            "venv",
            ".venv",
          },
        },
      },
    },
  },
  dap = dap_settings(),
}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "Cargo.toml",
  callback = function()
    require("crates").setup({})
  end,
  once = true,
})
