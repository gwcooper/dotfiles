local util = require("util")

vim.pack.add({ util.github_url("mason-org/mason.nvim") })
require("mason").setup()

-- Collect names of all tools managed by Mason
local merged = {}

-- Convert dicts into a set of tools to install
for _, lst in ipairs({ _G.formatByFt, _G.lintByFt }) do
  for _, v in pairs(lst) do
    if next(v) then
      merged[v[1]] = true
    end
  end
end

-- merge all sets of tools to install
for _, item in ipairs({ _G.serverList, _G.debuggerList }) do
  util.extend_set(merged, item)
end

-- Install any tools that haven't been installed yet
local registry = require("mason-registry")
local to_install = {}
for k, _ in pairs(merged) do
  if not registry.is_installed(k) then
    table.insert(to_install, k)
  end
end

if #to_install ~= 0 then
  vim.cmd("MasonInstall " .. table.concat(to_install, " "))
end

-- User command to force reinstall all tools
vim.api.nvim_create_user_command("MasonInstallAll", function()
  vim.cmd("MasonInstall " .. table.concat(merged, " "))
end, {})

-- User command to delete all tools that aren't referenced in the config
vim.api.nvim_create_user_command("MasonUninstallUnused", function()
  local to_uninstall = {}
  local mason_registry = require("mason-registry").get_installed_package_names()
  local formatters_and_linters = {}

  for _, lst in ipairs({ _G.formatByFt, _G.lintByFt }) do
    for _, v in pairs(lst) do
      if next(v) then
        formatters_and_linters[v[1]] = true
      end
    end
  end

  for _, pkg in ipairs(mason_registry) do
    local uninstall = true
    for _, lst in ipairs({ _G.serverList, _G.debuggerList, formatters_and_linters }) do
      if lst[pkg] ~= nil then
        uninstall = false
      end
    end
    if uninstall then
      table.insert(to_uninstall, pkg)
    end
  end

  local ok, choice = util.confirm_and_uninstall_popup(to_uninstall)
  if ok and choice == 1 then
    for _, item in ipairs(to_uninstall) do
      local p = registry.get_package(item)

      p:uninstall():on("end", function()
        print("Package " .. item .. " uninstalled successfully!")
      end)
    end
  else
    print("Cancelled or selected No.")
  end
end, {})
