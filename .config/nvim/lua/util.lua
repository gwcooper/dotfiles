local M = { path = {} }

M.github_url = function(x)
  return "https://github.com/" .. x
end

M.merge_tables = function(...)
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

M.extend_unique_table = function(primary, extender)
  -- Extender list might be empty
  if #extender == 0 then
    return
  end
  -- Primary list might be empty
  if #primary == 0 then
    local itemSet = {}
    for _, item in ipairs(extender) do
      itemSet[item] = true
    end
    for key, _ in pairs(itemSet) do
      table.insert(primary, key)
    end
    return
  end
  -- O(1) lookup for duplicates
  local itemSet = {}
  for _, ev in ipairs(primary) do
    itemSet[ev] = true
  end
  -- Extend if value not in primary
  for _, v in ipairs(extender) do
    if not itemSet[v] then
      table.insert(primary, v)
      itemSet[v] = true
    end
  end
end

M.create_set_from_table = function(t)
  local set = {}
  for _, v in ipairs(t) do
    set[v] = true
  end
  return set
end

M.create_table_from_set = function(set)
  local t = {}
  for key, _ in pairs(set) do
    table.insert(t, key)
  end
  return t
end

M.extend_set = function(primary, extender)
  if next(extender) == nil then
    return
  end
  for key, _ in pairs(extender) do
    primary[key] = true
  end
end

-- Applies a language_config table to all relevant global lists
-- which are in turn utilised by plugins, installers etc.
--- @class languageConfig table
--- @field filetypes table @Filetypes to which this config will be applied
--- @field treesitters table @Treesitter grammars to be installed
--- @field debuggers table @Debuggers to install / use
--- @field formatters table @Formatters to install / use
--- @field linters table @Linters to install / use
--- @field servers table @LSPs to install. Usage depends on a config file in lsp/
--- @field completion_providers table @Completion providers to use for insert completion
--- @field completion_sources table @Completion sources to use for insert completion
M.setup_language = function(languageConfig)
  -- Extend linters and formatter
  for _, filetype in ipairs(languageConfig.filetypes or {}) do
    if languageConfig.linters and next(languageConfig.linters) then
      _G.lintByFt[filetype] = languageConfig.linters
    end
    if languageConfig.formatters and next(languageConfig.formatters) then
      _G.formatByFt[filetype] = languageConfig.formatters
    end
    if languageConfig.completion_sources and next(languageConfig.completion_sources) then
      _G.completionSources[filetype] = languageConfig.completion_sources
    end
  end

  M.extend_set(_G.debuggerList, M.create_set_from_table(languageConfig.debuggers or {}))
  M.extend_set(_G.serverList, M.create_set_from_table(languageConfig.servers or {}))
  M.extend_set(_G.treeSitterInstallList, M.create_set_from_table(languageConfig.treesitters or {}))

  if languageConfig.completion_providers and next(languageConfig.completion_providers) then
    for provider, settings in pairs(languageConfig.completion_providers) do
      _G.completionProviders[provider] = settings
    end
  end
end

M.confirm_and_uninstall_popup = function(to_uninstall)
  local str_list = "The following packages will be deleted:"
  for _, item in ipairs(to_uninstall) do
    str_list = str_list .. "\n" .. item
  end

  str_list = str_list .. "\n\n" .. "Proceed?"

  -- Wraps in pcall to elegantly handle Ctrl-C aborts
  local ok, choice = pcall(vim.fn.confirm, str_list, "&Yes\n&No", 2)
  return ok, choice
end

return M
